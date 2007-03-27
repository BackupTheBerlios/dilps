<?php

class DilpsAcquisitionAJAX
{   
    protected $db, $db_prefix;
    
    function __construct( $db, $db_prefix )
    {
		global $_SESSION;

		$this->db = $db;
		$this->db_prefix = $db_prefix;
    }
    
    public function getCompletions( $field, $sQuery, $num )
    {
		$rows = array();
		$sQuery{0} = strtoupper( $sQuery{0} );
		
		$sQuery = utf8_decode(urldecode($sQuery));
		
		$sql = 	"SELECT DISTINCT $field FROM {$this->db_prefix}main WHERE $field LIKE ".$this->db->qstr("{$sQuery}%")." LIMIT 0,$num"
				." UNION "
				."SELECT DISTINCT $field FROM {$this->db_prefix}data WHERE $field LIKE ".$this->db->qstr("{$sQuery}%")." LIMIT 0,$num";
				
		$rs = $this->db->Execute( $sql );
		
		if( !$rs ) {
			return array($this->db->ErrorMsg());
		}
		
		// debugging - show sql in autocomplete box
		// $rows[] = array($sql, $sql);
		
		foreach( $rs as $row )
		{
		    $fld = utf8_encode( $row[$field] );
		    $rows[] = array($fld, $fld);
		}
		return $rows;
    }    
}
?>