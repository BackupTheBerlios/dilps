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


class authLDAP2307User extends authUser
{
   var $uid, $basedn, $host, $port;
   var $groups;

   function authLDAP2307User($domain, $basedn="", $host="", $port=0)
   {
      authUser::authUser( $domain );
      $this->basedn = $basedn;
      $this->host = $host;
      $this->port = $port;
      $this->groups = array();
   }

   function isLoggedIn()
   {
      return (strlen( $this->uid ) > 1);
   }

   function login( $uid, $pwd, $ip=0 )
   {
	$this->groups = array();
	$this->uid = $uid;
	if( !($ds = ldap_connect($this->host))) return false;
	if( !($r = @ldap_bind( $ds, "uid=$uid,{$this->basedn}",$pwd )))
	{
		ldap_unbind( $ds );
		sess_log( LOG_LOGIN, 0, "uid=$uid,{$this->basedn}", 0 );
		return false;
	}

	$filter = "(&(objectclass=posixGroup)(memberuid=$uid))";
	$retvals = array( "cn" );
	$sr = ldap_search( $ds, $this->basedn, $filter, $retvals );
	$entries = ldap_get_entries( $ds, $sr );
        $this->groups = array();
	for( $i = 0; $i < $entries["count"]; $i++ )
	{
		for( $j = 0; $j < $entries[$i]["cn"]["count"]; $j++ )
		{
			$this->groups[] = $entries[$i]["cn"][$j];
		}
	}
	ldap_free_result( $sr );
	ldap_unbind( $ds );
//	print_r( $this->groups );
	sess_log( LOG_LOGIN, 0, "uid=$uid,{$this->basedn}", 1 );
	return true;
   }

   function logout()
   {
      $this->groups = array();
      unset( $this->uid );
   }

   function getData()
   {
      $retval = authUser::getData();
      $retval["uid"] = $this->uid;
      $retval["host"] = $this->host;
      $retval["port"] = $this->port;
      $retval["basedn"] = $this->basedn;
      $retval["groups"] = $this->groups;
      return $retval;
   }

   function setData( $data )
   {
      authUser::setData( $data );
      $this->uid = $data["uid"];
      $this->host = $data["host"];
      $this->port = $data["port"];
      $this->basedn = $data["basedn"];
      $this->groups = $data["groups"];
   }

   function getGroups()
   {
      if( !$this->isLoggedIn()) return array();
      return $this->groups;
   }

   function getInfo()
   {
      return $this->basedn;
   }
   
   function getUID()
   {
      return $this->uid;
   }
}


?>
