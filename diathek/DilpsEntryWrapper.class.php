<?php

include_once( 'session.inc.php' );
ini_set('magic_quotes_runtime',0);

class DilpsEntryWrapper
{   
    protected $db, $db_prefix;
    
    private $barcode, $type, $title, $dating, $material, $technique, $format, $institution, $literature, $page, $figure, $table, $name, $location, $commentary;
    
    function __construct( $db, $db_prefix, $barcode )
    {
		global $_SESSION;
		$this->db = $db;
		$this->db_prefix = $db_prefix;

		$this->type = '';
    	$this->title = '';
    	$this->dating = '';
    	$this->material = '';
    	$this->technique = '';
    	$this->format = '';
    	$this->institution = '';
    	$this->literature = '';
    	$this->page = '';
    	$this->figure = '';
    	$this->tableno = '';
    	$this->name =  '';
    	$this->location = '';
    	$this->commentary = '';
    	
    	// correct unintentional 'ß'
    	
    	$schrank 	= substr($barcode,1,2);
    	$lade		= substr($barcode,4,2);
    	$reihe		= substr($barcode,7,2);	
    	$bildno		= substr($barcode,10,3);
    	
    	$this->barcode = 'A'.$schrank.'-'.$lade.'-'.$reihe.'-'.$bildno;
    }
    
    public function setType( $type )
    {
    	$this->type = $type;
    }
    
    public function setTitle( $title )
    {
    	$this->title = $title;
    }
    
    public function setDating( $dating)
    {
    	$this->dating = $dating;
    }
    
    public function setMaterial( $material )
    {
    	$this->material = $material;
    }
    
    public function setTechnique( $technique )
    {
    	$this->technique = $technique;
    }
    
    public function setFormat ( $format )
    {
    	$this->format = $format;
    }
    
    public function setInstitution( $institution )
    {
    	$this->institution = $institution;
    }
    
    public function setLiterature( $literature )
    {
    	$this->literature = $literature;
    }
    
    public function setPage( $page )
    {
    	$this->page = $page;
    }
    
    public function setFigure( $figure )
    {
    	$this->figure = $figure;
    }
    
    public function setTableno( $tableno )
    {
    	$this->tableno = $tableno;
    }
    
    public function setName( $name )
    {
    	$this->name = $name;
    }
    
    public function setLocation( $location )
    {
    	$this->location = $location;
    }
    
    public function setCommentary( $commentary )
    {
    	$this->commentary = $commentary;
    }
    
    public function getBarcode()
    {
    	return (trim($this->barcode));
    }
    
    public function getType()
    {
    	return (trim($this->type));
    }
    
    public function getTitle()
    {
    	return (trim($this->title));
    }
    
    public function getDating()
    {
    	return (trim($this->dating));
    }
    
    public function getMaterial()
    {
    	return (trim($this->material));
    }
    
    public function getTechnique()
    {
    	return (trim($this->technique));
    }
    
    public function getFormat()
    {
    	return (trim($this->format));
    }
    
    public function getInstitution()
    {
    	return (trim($this->institution));
    }
    
    public function getLiterature()
    {
    	return (trim($this->literature));
    }
    
    public function getPage()
    {
    	return (trim($this->page));
    }
    
    public function getFigure()
    {
    	return (trim($this->figure));
    }
    
    public function getTableNo()
    {
    	return (trim($this->tableno));
    }
    
    public function getName()
    {
    	return (trim($this->name));
    }
    
    public function getLocation()
    {
    	return (trim($this->location));
    }
    
    public function getCommentary()
    {
    	return (trim($this->commentary));
    }
    
    public function createIfNotExists()
    {
    	$db = $this->db;
    	
    	$sql = 	"INSERT IGNORE INTO {$this->db_prefix}data (`barcode`) VALUES ( "
    			.$db->qstr($this->getBarcode())." )";
    			
		$rs = $this->db->Execute( $sql );
		
		if( !$rs ) {
			return array($this->db->ErrorMsg());
		}
		
		return 'Datensatz erfolgreich angelegt';
    }
    
    public function updateDB()
    {
    	$db = $this->db;
    	
    	// $db->debug = true;
    	
    	$sql = 	"UPDATE {$this->db_prefix}data SET "
    			."type =".$db->qstr($this->getType()).", "
    			."title =".$db->qstr($this->getTitle()).", "
    			."dating =".$db->qstr($this->getDating()).", "
    			."material =".$db->qstr($this->getMaterial()).", "
    			."technique =".$db->qstr($this->getTechnique()).", "
    			."format =".$db->qstr($this->getFormat()).", "
    			."institution =".$db->qstr($this->getInstitution()).", "
    			."literature =".$db->qstr($this->getLiterature()).", "
    			."page =".$db->qstr($this->getPage()).", "
    			."figure =".$db->qstr($this->getFigure()).", "
    			."tableno =".$db->qstr($this->getTableNo()).", "
    			."name =".$db->qstr($this->getName()).", "
    			."location =".$db->qstr($this->getLocation()).", "
    			."commentary =".$db->qstr($this->getCommentary())." "
    			."WHERE barcode = ".$db->qstr($this->getBarcode());
    			
		$rs = $this->db->Execute( $sql );
		
		if( !$rs ) {
			return $this->db->ErrorMsg();
		}
		
		return 'Datensatz erfolgreich gespeichert';
    }
    
    public function loadFromDbOrSession()
    {
    	global $_SESSION;
    	
    	/*
    	print_r($_REQUEST);
    	echo "\n<br>\n";
    	print_r($_SESSION);
    	*/
    	
    	$db = $this->db;
    	
    	// $db->debug = true;
    	
    	$sql = 	" SELECT type, title, dating, material, technique, format, institution, "
    			."literature, page, figure, tableno, name, location, commentary "
    			."FROM {$this->db_prefix}data "
    			."WHERE barcode = ".$db->qstr($this->getBarcode());
    			
		$rs = $this->db->Execute( $sql );
		
		if( !$rs ) {
			return array($this->db->ErrorMsg());
		}
		
		if (!empty($rs->fields["type"]))
		{
			$this->setType($rs->fields["type"]);
		}
		elseif (!empty($_SESSION["type"]))
		{
			$this->setType($_SESSION["type"]);
		}
		
		if (!empty($rs->fields["title"]))
		{
			$this->setTitle($rs->fields["title"]);
		}
		elseif (!empty($_SESSION["title"]))
		{
			$this->setTitle($_SESSION["title"]);
		}
		
		if (!empty($rs->fields["dating"]))
		{
			$this->setDating($rs->fields["dating"]);
		}
		elseif (!empty($_SESSION["dating"]))
		{
			$this->setDating($_SESSION["dating"]);
		}
		
		if (!empty($rs->fields["material"]))
		{
			$this->setMaterial($rs->fields["material"]);
		}
		elseif (!empty($_SESSION["material"]))
		{
			$this->setMaterial($_SESSION["material"]);
		}
		
		if (!empty($rs->fields["technique"]))
		{
			$this->setTechnique($rs->fields["technique"]);
		}
		elseif (!empty($_SESSION["technique"]))
		{
			$this->setTechnique($_SESSION["technique"]);
		}
		
		if (!empty($rs->fields["format"]))
		{
			$this->setFormat($rs->fields["format"]);
		}
		elseif (!empty($_SESSION["format"]))
		{
			$this->setFormat($_SESSION["format"]);
		}
		
		if (!empty($rs->fields["institution"]))
		{
			$this->setInstitution($rs->fields["institution"]);
		}
		elseif (!empty($_SESSION["institution"]))
		{
			$this->setInstitution($_SESSION["institution"]);
		}
		
		if (!empty($rs->fields["literature"]))
		{
			$this->setLiterature($rs->fields["literature"]);
		}
		elseif (!empty($_SESSION["literature"]))
		{
			$this->setLiterature($_SESSION["literature"]);
		}
		
		if (!empty($rs->fields["page"]))
		{
			$this->setPage($rs->fields["page"]);
		}
		elseif (!empty($_SESSION["page"]))
		{
			$this->setPage($_SESSION["page"]);
		}
		
		if (!empty($rs->fields["figure"]))
		{
			$this->setFigure($rs->fields["figure"]);
		}
		elseif (!empty($_SESSION["figure"]))
		{
			$this->setFigure($_SESSION["figure"]);
		}
		
		if (!empty($rs->fields["tableno"]))
		{
			$this->setTableNo($rs->fields["tableno"]);
		}
		elseif (!empty($_SESSION["tableno"]))
		{
			$this->setTableNo($_SESSION["tableno"]);
		}
		
		if (!empty($rs->fields["name"]))
		{
			$this->setName($rs->fields["name"]);
		}
		elseif (!empty($_SESSION["name"]))
		{
			$this->setName($_SESSION["name"]);
		}
		
		if (!empty($rs->fields["location"]))
		{
			$this->setLocation($rs->fields["location"]);
		}
		elseif (!empty($_SESSION["location"]))
		{
			$this->setLocation($_SESSION["location"]);
		}
		
		if (!empty($rs->fields["commentary"]))
		{
			$this->setCommentary($rs->fields["commentary"]);
		}
		elseif (!empty($_SESSION["commentary"]))
		{
			$this->setCommentary($_SESSION["commentary"]);
		}
		
		return true;
    }
    
}
?>