{*
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
*}

<!-- ============================================
BEGIN head.tpl
============================================ -->

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
{if $config.utf8 eq "true"}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/liste.conf.utf8"}
{else}
	{config_load file="`$config.skinBase``$config.skin`/`$config.language`/liste.conf"}
{/if}

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
  <meta name="robots" content="index,follow">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="cache-control" content="no-cache">
  <meta name="keywords" content="Bilddatenbanksystem, Bilddatenbank, Diathek, digitalisiert">
  {if $config.utf8 eq 'true'}
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  {else}
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  {/if}
  <meta http-equiv="Content-Script-Type" content="text/javascript">
  <meta http-equiv="Content-Style-Type" content="text/css">
  <meta name="author" content="jrgen enge, thorsten wbbena, fabian thommen">
  <meta name="date" content="2006-01-23">
  <link rel="shortcut icon" href="favicon.ico">
  <title>. : {#title#|escape:"htmlall"} : .</title>
  {if $config.soapresults }
      <script src="prototype.js" type="text/javascript"></script>
      <script src="FieldUpdater.js" type="text/javascript"></script>
      {if $config.debug }
        <script src="debug.js" type="text/javascript"></script>
      {/if}
  {/if}
  <script src="dilps.lib.js" type="text/javascript"></script>
    <script type="text/javascript" src="include/ajax.inc.php?client=all"></script>
  <link rel="stylesheet" type="text/css" href="{$config.includedir_relative}css.php">
</head>

<!-- ============================================
END head.tpl
============================================ -->
