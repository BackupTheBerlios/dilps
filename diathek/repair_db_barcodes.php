<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">

<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="cache-control" content="no-cache">
	<meta name="keywords" content="Bilddatenbanksystem, Bilddatenbank, Diathek, digitalisiert">
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<meta http-equiv="Content-Script-Type" content="text/javascript">
	<meta http-equiv="Content-Style-Type" content="text/css">
	<meta name="author" content="jrgen enge, thorsten wbbena">
	<meta name="date" content="2003-01-23">
	<link rel="shortcut icon" href="favicon.ico">
	<title>. : DILPS : .</title>
	<link rel="stylesheet" type="text/css" href="resource/dilps.css">
</head>

<?php
	include_once( 'session.inc.php' );
?>
	
<table class="header" style="width: 100%;">
	<!-- heading line -->
	<tr>
		<td colspan="3">
			<div id="line_2" style="text-align: center;"> 
				<b>Reperatur defekter Datensätze (<a class="heading" href="index.php?PHPSESSID=<?php echo session_id()?>"><b>Zur&uuml;ck zur Hauptseite</b></a>)</b>
			</div>
		</td>
	</tr>
	<!-- heading line end -->
	
	<tr>
		<td colspan="3" style="height: 40px;">
			&nbsp;
		</td>
	</tr>
	
	<!-- content -->
	<tr>
		<td style="text-align: center; width: 100%">
			<!-- show corrected entries -->
			
			<?php
				
				global $db, $db_prefix;
				
				// $db->debug = true;
				
				$sql 	= 	"SELECT * FROM {$db_prefix}data WHERE barcode LIKE '%ß%'";
				$rs		=	$db->Execute($sql);
				
				while (!$rs->EOF)
				{
					$barcode 	= $rs->fields['barcode'];
					
					$schrank 	= substr($barcode,1,2);
					$lade		= substr($barcode,4,2);
					$reihe		= substr($barcode,7,2);	
					$bildno		= substr($barcode,10,3);
    	
    				$correctedBarcode = 'A'.$schrank.'-'.$lade.'-'.$reihe.'-'.$bildno;
					
					$sql2 	= 	"SELECT * FROM {$db_prefix}data WHERE barcode = ".$db->qstr($correctedBarcode);
					$rs2	=	$db->Execute($sql2);
					
					if ($rs2 !== false)
					{
						echo ("Duplikat: ".$correctedBarcode." &ndash; ");
						
						$sql3 	= 	"DELETE FROM {$db_prefix}data WHERE barcode = ".$db->qstr($correctedBarcode);
						$rs3	=	$db->Execute($sql3);
						
						if ($rs3 !== false)	{
							echo ("korrekt entfernt\n<br>\n");
							
							$sql4 	= 	"UPDATE {$db_prefix}data SET barcode = ".$db->qstr($correctedBarcode)." WHERE barcode=".$db->qstr($barcode);
							$rs4	=	$db->Execute($sql4);
							
							echo ("Originaldatensatz: ".$barcode." &ndash; ");
							
							if ($rs4 !== false)	{
								echo ("korrekt aktualisiert\n<br>\n");
							}
							else {
								echo ("Fehler beim Aktualisieren\n<br>\n");
							}
						}
						else {
							echo ("Fehler beim Entfernen\n<br>\n");
						}
					}
					
					$rs->MoveNext();
					
				}
    	
				/*
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
    			*/
			
			?>
			<!-- show coreected entries - end -->
		</td>
	</tr>
	<!-- content end -->
	
	<tr>
		<td colspan="3" style="height: 50px;">
			&nbsp;
		</td>
	</tr>
</table>

<!-- content end -->
<div id="line_1" style="text-align: center; vertical-align: middle; margin-top: 3px;"> 
	<span style="font-size: 0.9em;"><a class="heading" href="index.php?PHPSESSID=<?php echo session_id()?>"><b>Zur&uuml;ck zur Hauptseite</b></a></span>
</div>
		
</body>
</html>
