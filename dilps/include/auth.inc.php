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

if( isset( $_REQUEST['auth'] ))
{
	$auth = $_REQUEST['auth'];
}

if( isset( $_REQUEST['logout'] ))
{
	if ($_REQUEST['logout'] == 1)
	{
		killSession();
	}
}

$logins = new userList();
$user = new $config['userClass']($config['authdomain'] );

$logins->add( $user );

if( isset( $_SESSION["login"] ))
{
	// echo "Session - ";
	$logins->setData( $_SESSION["login" ] );
}

$valid_login = false;
$is_admin = false;

if( !$logins->isLoggedIn())
{
	// echo "not logged in - ";

	if( isset( $auth['domain'] ) && strlen( $auth['domain'] ) > 0 
		&& isset( $auth['uid'] ) && strlen( $auth['uid'] ) > 0 
		&& isset( $auth['pwd'] ) && strlen( $auth['pwd'] ) > 0 )
	{
		if( $logins->login( $auth['domain'], $auth['uid'], $auth['pwd'] ))
      	{
        	$_login = $logins->getUID( $config['authdomain'] );
        	
         	// echo "login ok - ";
         	
         	$_SESSION["login"] = $logins->getData();
            $valid_login = true;
      	}
      	else
      	{
        	// echo "invalid login - ";
        	
        	$valid_login = false;
        	$txt = "{$auth['domain']}: {$auth['uid']}: falsches Passwort oder techn. Problem";
      	}
	}
}
else
{
	$_login = $logins->getUID( $config['authdomain'] );
	
	// echo "logged in - $_login";
	
	$valid_login = true;
}
?>