<?php

class DilpsAcquisitionAJAX
{   
    protected $db;
    
    function __construct( $db )
    {
	global $_SESSION;
	
	$this->db = $db;
    }
    
    public function getContents( $field, $sQuery, $num )
    {
	$rows = array();
	$sQuery{0} = strtoupper( $sQuery{0} );
	$sql = "SELECT DISTINCT $field FROM acqu_main WHERE $field LIKE ".$this->db->qstr("{$sQuery}%")." LIMIT 0,$num";
	$rs = $this->db->Execute( $sql );
	if( !$rs ) return array($this->db->ErrorMsg());
	foreach( $rs as $row )
	{
	    $fld = utf8_encode( $row[$field] );
	    $rows[] = array($fld, $fld);
	}
	return $rows;
    }
    
}
?>