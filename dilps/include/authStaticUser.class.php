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

include('users.inc.php');


class authStaticUser extends authUser
{
	var $uid;
	var $users;

   function authStaticUser($domain)
   {
		global $theUser;
      	authUser::authUser( $domain );
      /*
		$this->users = array();
		$this->users['john'] = array( 'password'=>'doe',
										  'groups'=>array( 'archivmaster' ));
		*/

      	$this->users = $theUser;
   }

   function isLoggedIn()
   {
      return (strlen( $this->uid ) > 1);
   }

   function login( $uid, $pwd, $ip=0 )
   {
		if( !array_key_exists( $uid, $this->users )) return false;
		if( $this->users[$uid]['password'] != $pwd ) return false;
		$this->uid = $uid;
		sess_log( LOG_LOGIN, 0, "uid=$uid", 1 );
		return true;
   }

   function logout()
   {
      unset( $this->uid );
   }

   function getData()
   {
      $retval = authUser::getData();
      $retval["uid"] = $this->uid;
      return $retval;
   }

   function setData( $data )
   {
      authUser::setData( $data );
      $this->uid = $data["uid"];
   }

   function getGroups()
   {
      if( !$this->isLoggedIn()) return array();
      return $this->users[$this->uid]['groups'];
   }

   function getUID()
   {
      return $this->uid;
   }
}


?>
