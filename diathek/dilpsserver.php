<?php

// include_once( 'session.inc.php' );
include('db.inc.php');
include_once( 'DilpsAcquisitionServer.class.php' );

$server = new DilpsAcquisitionServer( $db );
$server->handleRequest();

?>