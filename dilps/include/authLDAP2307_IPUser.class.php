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

/* 
 * @author: brian@mediagonal.ch
*/


class authLDAP2307_IPUser extends authLDAP2307User
{
    
   function login( $uid, $pwd, $ip = 0 )
   {
        if (strcasecmp($uid, 'dilps') == 0 && strcasecmp($pwd, 'dilps') == 0) {
            
            $this->groups = array();
            $this->uid = $uid;
            
            return $this->login_by_ip();
            
        } else {
            
            return authLDAP2307User::login($uid, $pwd, $ip);
        }
   }
   
    // try to login by matching the requesting ip address against the accepted ip-logon ranges
    function login_by_ip() {
        global $db, $db_prefix;
       
        
        $requesting_ip = $_SERVER['REMOTE_ADDR'];
        
        $sql = "select ip_range, usergroups from {$db_prefix}ipaccess where username = ".$db->qstr($this->uid);
        
        $res = $db->GetAll($sql);
        if ($res === false || empty($res)) {
            sess_log( LOG_LOGIN, 0, "uid=$this->uid,$requesting_ip", 0 );
            return false;
        }
        
        foreach ($res as $row) {
            if ($this->_checkIPorRange($requesting_ip, $row['ip_range'])) {
                
                if ($row['usergroups'] != '') {
                    $groups = explode(',', $row['usergroups']);
                    foreach ($groups as $group) {
                        $this->groups[] = trim($group);
                    }
                }
                
                sess_log( LOG_LOGIN, 0, "uid=$this->uid,$requesting_ip", 1 );    
                return true;
            }
        }
        
        // no matching ip found
        sess_log( LOG_LOGIN, 0, "uid=$uid,$requesting_ip", 0 );
        return false;
    }
    
    /*
    * @access private
    */
    function _checkIPorRange ($actual_ip, $allowed_ip) {
        if (ereg("-",$allowed_ip)) {  
            // Range
            $ar = explode("-",$allowed_ip);
            $long_ip = ip2long($actual_ip);
            if ( ($long_ip >= ip2long($ar[0])) && ($long_ip <= ip2long($ar[1])) ) {
                return TRUE;
            }
        } else {
            // Single IP
            if ($actual_ip == $allowed_ip) {
                return TRUE;
            }
        }
        return FALSE;
    }
    	
/*
create table 
ng_ipaccess (
    id int(12) auto_increment primary key, 
    username varchar(40) not null default '',
    ip_range varchar(40) not null default '0.0.0.0',
    comment varchar(120) not null default '',
    usergroups varchar(255) not null default '');
*/
}


?>
