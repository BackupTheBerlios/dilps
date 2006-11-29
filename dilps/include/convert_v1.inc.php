<?php
/*
   +----------------------------------------------------------------------+
   | DILPS - Distributed Image Library System                             |
   +----------------------------------------------------------------------+
   | Copyright (c) 2002-2004 Juergen Enge                                 |
   | juergen@info-age.net                                                 |
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

ini_set( 'zend.ze1_compatibility_mode', 'On' );

// header( "Content-type: text/plain" );

include( $config['includepath'].'thesauri/soundex_fr.php' );

function migrate_insert_img( $collectionid, $baseid, $imageid, &$db, $db_prefix, &$db2 )
{
	$sql = "SELECT * FROM bild WHERE bildid=$imageid";
	$bild = $db2->GetRow( $sql );
	
	if( $bild )
	{
		$sql = "REPLACE INTO `{$db_prefix}img` (`collectionid`".
									", `imageid`".
									", `img_baseid`".
									", `filename`".
									", `width`".
									", `height`".
									", `xres`".
									", `yres`".
									", `size`".
									", `magick`".
									", `insert_date`".
									", `modify_date`)".
				" VALUES ( $collectionid, $imageid".
				", ".$db->qstr($baseid).
				", ".$db->qstr(stripslashes($bild['filename'])).
				", ".intval($bild['width']).
				", ".intval($bild['height']).
				", ".intval($bild['xres']).
				", ".intval($bild['yres']).
				", ".intval($bild['size']).
				", ".$db->qstr(stripslashes($bild['magick'])).
				", ".$db->qstr(stripslashes($bild['insert_date'])).
				", ".$db->qstr(stripslashes($bild['modify_date'])).
				");";
		echo "$sql\n<br>\n";
		$db->Execute( $sql );
	}
}

function migrate_insert_meta( $collectionid, $baseid, $fields, &$db, $db_prefix, &$db2 )
{
	$name = preg_replace( "/([kK]\\.[[:space:]]*[aA])\\.?/", "", trim(stripslashes($fields['name'])));
	
	// print_r($fields);

	if (strlen($name) > 0 and strlen($fields['vorname']) > 0) {
		$artistname = $name.", ".trim(stripslashes($fields['vorname']));
	}
	else {
		$artistname = '';
	}
	
	$artistid = false;	
	
	if ($artistname != '')	
	{
		$artistid 	= migrate_get_or_set_artistid($artistname, $db, $db_prefix);
	}
	
	// echo ("Name: $artistname, ID: $artistid \n<br>\n");
	
	$locationid 	= false;
	$locationname 	= trim(stripslashes($fields['stadt']));
	
	if ($locationname != '')
	{
		$locationid = migrate_get_or_set_locationid($locationname, $collectionid.':'.$fields['bildid'], $db, $db_prefix);
	}
	
	// echo ("Ort: $locationname, ID: $locationid \n<br>\n");
	

	$sql = 	"REPLACE INTO `{$db_prefix}meta` ".
			"(`collectionid`".
			", `imageid`".
			", `type`".
			", `status`".
			", `addition`".
			", `title`".
			", `dating`".
			", `material`".
			", `technique`".
			", `format`".
			", `institution`".
			", `literature`".
			", `page`".
			", `figure`".
			", `table`".
			", `isbn`".
			", `keyword`".
			", `insert_date`".
			", `modify_date`".
			", `name1id`".
			", `locationid`".
			", `exp_prometheus`".
			", `exp_sid`".
			", `exp_unimedia`".
			", `metacreator`".
			", `name1`".
			", `location`".
			", `locationsounds`".
			", `name1sounds`".
			" ) VALUES (".
			intval($collectionid).
			", ".$fields['bildid'].
			", 'image'".
			", 'new'".
			", ".$db->qstr(trim(stripslashes($fields['zusatz']))).
			", ".$db->qstr(trim(stripslashes($fields['titel']))).
			", ".$db->qstr(trim(stripslashes($fields['datierung']))).
			", ".$db->qstr(trim(stripslashes($fields['material']))).
			", ".$db->qstr(trim(stripslashes($fields['technik']))).
			", ".$db->qstr(trim(stripslashes($fields['format']))).
			", ".$db->qstr(trim(stripslashes($fields['institution']))).
			", ".$db->qstr(trim(stripslashes($fields['literatur']))).
			", ".$db->qstr(trim(stripslashes($fields['seite']))).
			", ".$db->qstr(trim(stripslashes($fields['abbildung']))).
			", ".$db->qstr(trim(stripslashes($fields['tafel']))).
			", ".$db->qstr(trim(stripslashes($fields['isbn']))).
			", ".$db->qstr(trim(stripslashes($fields['stichworte']))).
			", ".$db->qstr(trim(stripslashes($fields['insert_date']))).
			", ".$db->qstr(trim(stripslashes($fields['modify_date']))).

			/* Name1ID - from get_or_set_artistid - Name2ID is always empty when importing*/

			", ".(($artistid !== false) ? intval($artistid) : 0).
			
			/* LocationID - erhalten aus get_or_set_locationid */
			
			", ".(($locationid !== false) ? intval($locationid) : 0).

			/* Export alle auf 0 */

			", 0, 0, 0".

			/* Creator auf 'dilps-import' setzen */

			", 'dilps-import'".

			", ".$db->qstr($artistname).
			", ".$db->qstr($locationname).

			/* Locationsounds */
			", ".(($locationname != '') ? $db->qstr(migrate_get_sounds_string($locationname)) : '').
			
			/* Name1sounds */
			", ".(($artistname != '') ? $db->qstr(migrate_get_sounds_string($artistname)) : '').

			");";

	echo "$sql\n<br>\n";
	$db->Execute( $sql );

    dating( $db, stripslashes($fields['datierung']), $datelist );
	if( count( $datelist ))
	{
	   foreach( $datelist as $date )
	   {
	   		$sql = "REPLACE INTO {$db_prefix}dating(collectionid,imageid,`from`,`to`) VALUES({$collectionid},{$fields['bildid']},{$date['from']},{$date['to']})";
	   		echo "$sql\n";
	   		$db->Execute( $sql );
	   }
	}

 	migrate_insert_img( $collectionid, $baseid, $fields['bildid'], $db, $db_prefix, $db2);
}


function migrate_insert_group( $groupid, $name, $owner, $parentid, &$db, $db_prefix )
{
	$sql = "REPLACE INTO `".$db_prefix."group` ("
				."`groupid`"
				.", `name`"
				.", `owner`"
				.", `parentid`)"
				." VALUES ( "
				.$db->qstr($groupid).", "
				.$db->qstr($name).", "
				.$db->qstr($owner).", "
				.$db->qstr($parentid).				
				");";
				
		echo "$sql\n<br>\n";
		$db->Execute( $sql );
}

function migrate_insert_into_group( $groupid, $collectionid, $imageid, &$db, $db_prefix )
{
	$sql = "REPLACE INTO `".$db_prefix."img_group` ("
				."`groupid`"
				.", `collectionid`"
				.", `imageid`)"
				." VALUES ( "
				.$db->qstr($groupid).", "
				.$db->qstr($collectionid).", "
				.$db->qstr($imageid).
				");";
				
		echo "$sql\n<br>\n";
		$db->Execute( $sql );
}

 function migrate_get_sounds_string($string) {
 	
 	$sounds 	= array();
    $pattern 	= "[[:space:],]+";
	
    $string = strtoupper($string);
    $sounds_string = '.';
    
    $words = split($pattern, $string);
	if (!empty($words)) {
    	foreach ($words as $word) {
        	$sound = trim(soundex2($word));
        	if ($sound != '') {
            	$sounds_string .= $sound .'.';
			}
		}
	}
            
	return $sounds_string;
}

/**
 *	get or set location id for the specified location name
 *
 *	this functions searches the database for an entry with the specified name,
 *  if there is any, its 'locationid' is returned, otherwise a new entry is
 *  created and its 'locationid' returned alike.
 *  if this fails, 'false' is returned
 *
 *	@access		public
 *	@param 		string	$location_name
 *	@param 		object	$db
 *	@param 		string	$db_prefix
 *	@return		int
 *
 */

function migrate_get_or_set_locationid($location_name, $sourceid,  $db, $db_prefix)
{
    $sql = "SELECT id FROM ".$db_prefix."location WHERE location=".$db->qstr($location_name);
    echo ($sql."\n<br>\n");
	$location_id  = $db->GetOne( $sql );
	
	if(!$location_id)
	{
		$sql = "INSERT INTO ".$db_prefix."location (`src`, `source_id`, `location`, `sounds`) VALUES ("
				.$db->qstr('dilps').","
				.$db->qstr($sourceid).","
				.$db->qstr($location_name).","
				.$db->qstr(migrate_get_sounds_string($location_name)).")";
		echo ($sql."\n<br>\n");
		
		$rs = $db->Execute($sql);
		
		if (!$rs)
		{
			return false;
		}
		else 
		{
			$sql = "SELECT id FROM ".$db_prefix."location WHERE location=".$db->qstr($location_name);
			echo ($sql."\n<br>\n");
			
			$location_id  = $db->GetOne( $sql );
			
			if (!$location_id)
			{
				return false;
			}
		}
	}
	
	return $location_id;
}


/**
 *	get or set artist id for the specified artist name
 *
 *	this functions searches the database for an entry with the specified name,
 *  if there is any, its 'artistid' is returned, otherwise a new entry is
 *  created and its 'artistid' returned alike.
 *  if this fails, 'false' is returned
 *
 *	@access		public
 *	@param 		string	$artist_name
 *	@param 		object	$db
 *	@param 		string	$db_prefix
 *	@return		int
 *
 */

function migrate_get_or_set_artistid($artist_name, $db, $db_prefix)
{
    $sql = "SELECT id FROM ".$db_prefix."artist WHERE name=".$db->qstr($artist_name);
    echo ($sql."\n<br>\n");
    
	$artist_id  = $db->GetOne( $sql );
	
	if(!$artist_id)
	{
		$sql = "INSERT INTO ".$db_prefix."artist (`src`, `name`, `preferred_name_id`, `sounds`) VALUES ("
				.$db->qstr('dilps').","
				.$db->qstr($artist_name).","
				.$db->qstr(0).","
				.$db->qstr(migrate_get_sounds_string($artist_name)).")";
				
		echo ($sql."\n<br>\n");		
		$rs = $db->Execute($sql);
		
		if (!$rs)
		{
			return false;
		}
		else 
		{
			$sql = "SELECT id FROM ".$db_prefix."artist WHERE name=".$db->qstr($artist_name);
			echo ($sql."\n<br>\n");
			$artist_id  = $db->GetOne( $sql );
			
			if (!$artist_id)
			{
				return false;
			}
		}
	}
	
	return $artist_id;
}


?>
