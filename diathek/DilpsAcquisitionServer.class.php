<?php

require_once 'HTML/AJAX/Server.php';

require_once( 'DilpsAcquisitionAJAX.class.php' );

class DilpsAcquisitionServer extends HTML_AJAX_Server {
        // this flag must be set for your init methods to be used
        var $initMethods = true;
        var $db, $db_prefix;

        function __construct( $db, $db_prefix )
        {
           $this->db = $db;
           $this->db_prefix = $db_prefix;
           
           parent::HTML_AJAX_Server();
        }

        // init method for my hello world class
        function initDilpsAcquisitionAJAX() {
                $dilpsAcquisitionAJAX = new DilpsAcquisitionAJAX( $this->db, $this->db_prefix);
                $this->registerClass($dilpsAcquisitionAJAX);
        }
}

?>
