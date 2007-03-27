<?php
include_once( 'config.inc.php' );
include( 'adodb/adodb.inc.php' );
ini_set('magic_quotes_runtime',0);

$db = NewADOConnection( 'mysql' );
$res = $db->PConnect( $db_host, $db_user, $db_pwd, $db_db );

// $db->debug = true;

$ADODB_FETCH_MODE = ADODB_FETCH_ASSOC;

?>
