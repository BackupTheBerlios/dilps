<?php

include_once( 'session.inc.php' );
ini_set('magic_quotes_runtime',0);

global $cfg_basedir, $cfg_convert, $cfg_resolutions;

class DilpsBarcodeAndFileChecker
{   
    private $barcode, $filename;
    
    private $schrank, $lade, $reihe, $bildno;
    
    private $basedir;
    private $convert;
    
    private $resolutions;
    
    function __construct( $barcode )
    {
    	$this->barcode = $barcode;
    	
    	$this->basedir		= $GLOBALS['cfg_basedir'];
    	$this->convert 		= $GLOBALS['cfg_convert'];
    	$this->resolutions	= $GLOBALS['cfg_resolutions'];
    }
    
    public function hasFile()
    {
    	if (strlen($this->filename) < 2)
    	{
    		$this->decodeBarcode();
    		
    	}
    	
    	return (file_exists($this->filename));
    }
    
    public function hasWebcamImage($side = 'fs')
    {
    	return (file_exists($this->getWebcamImageFilename($side)));
    }
    
    public function getWebcamImageFilename($side)
    {
    	if (strlen($this->filename) < 2)
    	{
    		$this->decodeBarcode();
    	}
    	
    	$webcamImageFile = $this->basedir.'/webcam/A'.$this->schrank.'-'.$this->lade.'-'.$this->reihe.'-'.$this->bildno.'_'.$side.'.jpg';
    		
		if (file_exists($webcamImageFile))
		{
			return ($webcamImageFile);
		}
		else 
		{
			return false;
		}
    }
    
    public function getPreviewFilename()
    {
    	if (strlen($this->filename) < 2)
    	{
    		$this->decodeBarcode();
    	}
    	
    	$preview = $this->basedir.'/cache/640x480/A'.$this->schrank.'-'.$this->lade.'-'.$this->reihe.'-'.$this->bildno.'.jpg';
    		
		if (file_exists($preview))
		{
			return ($preview);
		}
		else 
		{
			$this->buildCache();
			
			return ($preview);
		}
    }
    
    private function decodeBarcode()
    {
    	$barcode 	= $this->barcode;
    	
    	$schrank 	= substr($barcode,1,2);
    	$lade		= substr($barcode,4,2);
    	$reihe		= substr($barcode,7,2);	
    	$bildno		= substr($barcode,10,3);
    	
    	$this->schrank 	= $schrank;
    	$this->lade		= $lade;
    	$this->reihe	= $reihe;
    	$this->bildno	= $bildno;
    	
    	$filename = $this->basedir.'/archiv/Schrank-'.$schrank.'/Lade-'.$lade.'/Reihe-'.$reihe.'/A'.$schrank.'-'.$lade.'-'.$reihe.'-'.$bildno.'.tif';
    	
    	$this->filename = $filename;
    	
    	return;
    }
    
    private function checkDir($dir, $test_writeable = false, $create_nonexistant = false, $create_perms = 0755)
	{		
		if (!is_dir($dir))
		{
			if ($create_nonexistant)
			{
				$ret = mkdir($dir,$create_perms);
				return $ret;
			}
			else
			{
				return false;
			}
		}
		else
		{
			if ($test_writeable)
			{
				$ret = is_writeable($dir);
				return $ret;
			}
		}
	}
	
	private function convertImage($input, $output, $to_res,$is_thumbnail = false)
	{
		$imagemagick_convert = $this->convert;
		
		if ($is_thumbnail)
		{
			// we sharpen thumbnails
			$cmd = $imagemagick_convert
							." \"".$input."\" "
							."-scale ".$to_res
							." -sharpen 4 \"".$output."\"";
		}
		else
		{
			$cmd = $imagemagick_convert
							." \"".$input."\" "
							."-scale ".$to_res
							." \"".$output."\"";
		}
		
		unset($result);
		exec(escapeshellcmd($cmd), $result, $ret);
		
		/*
		echo ("Cmd: $cmd\n<br>\n");
		echo ("Ret: $ret\n<br>\n");
		*/
		
		
		// print_r($result);
						
		if ($ret == 0) {
			return true;
		}
		else {
			return false;
		}
	}
    
    private function buildCache()
    {
    	$schrank 	= $this->schrank;
    	$lade		= $this->lade;
    	$reihe		= $this->reihe;
    	$bildno		= $this->bildno;
    	
    	$filename_base = 'A'.$schrank.'-'.$lade.'-'.$reihe.'-'.$bildno;
		    	
    	// Zwischenspeicher prüfen und bei Bedarf anlegen

		$ret = $this->checkDir($this->basedir.'/cache/',true,true,0777);

		if (!$ret)
		{
			$errorstring = "Fehler beim Anlegen des Zwischenspeicher-Verzeichnisses! \n<br>\n";
			die ($errorstring);
		}
		else 
		{
		
			$ret = $this->checkDir($this->basedir.'/cache/1600x1200/',true,true,0777);
	
			if (!$ret)
			{
				$errorstring = "Fehler beim Anlegen des Zwischenspeicher-Verzeichnisses (1600x1200)! \n<br>\n";
				die ($errorstring);
			}
			
			// zunächst in 1600x1200 umwandeln (als Basis für weitere Konvertierungen)
			
			$baseimage_filename = $this->basedir.'/cache/1600x1200/'.$filename_base.'.jpg';
	
			$res = '1600x1200';
	
			$ret = $this->convertImage($this->filename,$baseimage_filename,$res, false);
	
			if (!$ret)
			{
				$errorstring = "Fehler beim Umrechnen des Bildes in die Aufl&ouml;sung 1600x1200! \n<br>\n";
				die ($errorstring);
			}
								
			foreach ($this->resolutions as $res)
			{
				// Unterverzeichnisse für einzelne Auflösungen prüfen
				$ret = $this->checkDir($this->basedir.'/cache/'.$res,true,true, 0777);
				
				if (!$ret) {
					$errorstring = "Fehler beim Anlegen des Zwischenspeicher-Verzeichnisses (".$res.")\n<br>\n";
					die ($errorstring);
				}

				if ($res == '120x90') {
					$is_thumbnail = true;
				}
				else {
					$is_thumbnail = false;
				}

				$output_filename = $this->basedir.'/cache/'.$res.'/'.$filename_base.'.jpg';

				$ret = $this->convertImage($baseimage_filename,$output_filename,$res, $is_thumbnail);

				if (!$ret) {
					$errorstring = "Fehler beim Umrechnen des Bildes in die Aufl&ouml;sung (".$res."! \n<br>\n";
					die ($errorstring);
				}
			}
		}
    }
}
?>