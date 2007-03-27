<?php

include_once( 'session.inc.php' );
// include('db.inc.php');
include_once( 'DilpsAcquisitionServer.class.php' );

global $db, $db_prefix;

$server = new DilpsAcquisitionServer( $db, $db_prefix );
$server->handleRequest();

?>
