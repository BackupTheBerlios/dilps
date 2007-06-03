<?php
/*
   +----------------------------------------------------------------------+
   | DILPS - Distributed Image Library System                             |
   +----------------------------------------------------------------------+
   | Copyright (c) 2002-2004 David Weiß									  |
   | studium@dwhome.de													  |
   | http://www.dilps.net                                                 |
   +----------------------------------------------------------------------+
   | This source file is subject to the GNU General Public License as     |
   | published by the Free Software Foundation; either version 2 of the   |
   | License, or (at your option) any later version.                      |
   |                                                                      |
   | Distributed Playout Infrastructure is distributed in the hope that   |
   | it will be useful,but WITHOUT ANY WARRANTY; without even the implied |
   | warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.     |
   | See the GNU General Public License for more details.                 |
   |                                                                      |
   | You should have received a copy of the GNU General Public License    |
   | along with this program; if not, write to the Free Software          |
   | Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA            |
   | 02111-1307, USA                                                      |
   +----------------------------------------------------------------------+
*/

/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.find_isbn.php
 * Type:     function
 * Name:     find_isbn
 * Purpose:  find books in different libraries and copy data
 * -------------------------------------------------------------
 */
global $config;

function smarty_function_find_isbn($params, &$smarty)
{
	function filter_array($theHaystack, $info) {
		if(is_array($theHaystack)) {
			for($k=0;$k<=count($theHaystack);$k++) {
				if(substr_count($theHaystack[$k][0], '245')>0 && substr_count($theHaystack[$k][0], 'a')>0 ) {
					if($info=='title') {
						return $theHaystack[$k][1]." ".substr($theHaystack[$k+1][1],0,strlen($theHaystack[$k+1][1])-1);
					} elseif($info=='author') {
						return $theHaystack[$k+2][1];
					}
				}
			}
		} else {
			//$array=$explode(" / ", $theHaystack);
			$parts = explode("/", $theHaystack);
			
			if($info=='title') {
				return $parts[0];
			} elseif($info=='author') {
				return substr($parts[1],0,strpos($parts[1],'-'));
			}
		}
		
		return "";
	}
	
	$isbninfo = array();
	
	if (empty($params['var'])) {
	  $smarty->trigger_error("assign: missing 'var' parameter");
	  return;
	}
	
	if (empty($params['info'])) {
		$smarty->trigger_error("assign: missing 'info' parameter");
		return;
	} else {
		$info = $params['info'];
	}

	if (empty($params['isbn'])) {
		$smarty->trigger_error("assign: missing 'isbn' parameter");
		return;
	} else {
		$isbn = $params['isbn'];
	}

	$name=array("HeBIS", "Deutsche Nationalbibliothek", "GILS", "Libraray of Congress");
	$host=array("tolk.hebis.de:20212/hebis", "z3950.dbf.ddb.de:210/iltis", "bagel.indexdata.dk/gils", "z3950.loc.gov:7090/voyager");
	$user=array("3950", "gast", "", "");
	$passwd=array("Z3950", "gast", "", "");
	$syntax=array("usmarc", "sutrs", "usmarc", "usmarc");

	$query="@attr 1=7 ".$isbn;  
	$found=false;
	$i=0;$j=0;

	while ($found==false && $i<=3) {
	  
	   $id[$i] = yaz_connect($host[$i],array("user" => $user[$i], "password"=> $passwd[$i]));
	   
	   yaz_syntax($id[$i], $syntax[$i]);
	   yaz_range($id[$i], 1, 1);
	   yaz_search($id[$i], "rpn", $query);
	   yaz_wait();
	   
	   $error = yaz_error($id[$i]);
	   $hits = yaz_hits($id[$i]);

	   if (!empty($error) | $hits==0) {
		   $i++;
		   if(!empty($error)) {$j++;}
	   } else {
		   $found=true;
		   if($i==1) {
			$rec = yaz_record($id[$i], 1, "string");
		   }else {
			$rec = yaz_record($id[$i], 1, "array");
		   }
			
		   //var_dump($rec);
		   
		   //echo "<table>";
		   //echo "<tr><td valign='top'><b>Titel: </b></td><td>".filter_array($rec, 'title')."</td></tr>";
		   //echo "<tr><td valign='top'><b>Autor: </b></td><td> ".filter_array($rec, 'author')."</td></tr>";
		   //echo "</table>";
		   
		   $isbninfo['title']=filter_array($rec, 'title');
		   $isbninfo['author']=filter_array($rec, 'author');
		   
		}
	   
	}
	
	
	 if(empty($isbninfo['title']) | $found==false) {
		$isbninfo['title']="Es wurden keine Einträge gefunden.";
		$isbninfo['author']="Es wurden keine Einträge gefunden.";
		if($j==4) {
			$isbninfo['title']="Es konnte keine Verbindung hergestellt werden.";
			$isbninfo['author']="Es konnte keine Verbindung hergestellt werden.";
		}
	 }
	 
	 //var_dump($isbninfo);
		   
	 $smarty->assign($params['var'], $isbninfo);

}
?>