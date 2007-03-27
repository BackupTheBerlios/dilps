<?php

if( !isset( $_REQUEST['filename'] ))
{
	header( "Content-type: image/jpeg\n\n" );
	readfile( 'resource/empty.jpg' );
	exit;
}
$id = $_REQUEST['id'];

header( "Content-type: image/jpeg\n\n" ); 

if (file_exists($_REQUEST['filename']))
{
	readfile( $_REQUEST['filename'] );	
}
else 
{
	readfile( 'empty.jpg' );
}

?>
