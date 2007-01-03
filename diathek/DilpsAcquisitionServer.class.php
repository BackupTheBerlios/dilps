<?php

require_once 'HTML/AJAX/Server.php';

require_once( 'DilpsAcquisitionAJAX.class.php' );

class DilpsAcquisitionServer extends HTML_AJAX_Server {
        // this flag must be set for your init methods to be used
        var $initMethods = true;
        var $db;

        function __construct( $db )
        {
           $this->db = $db;
           parent::HTML_AJAX_Server();
        }

        // init method for my hello world class
        function initDilpsAcquisitionAJAX() {
                $dilpsAcquisitionAJAX = new DilpsAcquisitionAJAX( $this->db );
                $this->registerClass($dilpsAcquisitionAJAX);
        }
}

?>
