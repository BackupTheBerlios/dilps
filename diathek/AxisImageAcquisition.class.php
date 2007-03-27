<?php

include_once( 'config.inc.php' );
include_once( 'session.inc.php' );

ini_set('magic_quotes_runtime',0);

class AxisImageAcquisition
{   
    private $barcode, $webcamno;
    
    private $videoResolution = '640x480';
    private $imageResolution = '640x480';
    
    private $axisUser 		= 'root';
    private $axisPassword 	= 'pass';
    
    private $basedir = '/Programme/xampp/htdocs/diathek/images';
    
    private $videoAccessPath, $imageAccessPath;
    
    private $authString;
    
    function __construct( $barcode, $webcamno )
    {
    	$this->barcode 	= $barcode;
    	$this->webcamno	= $webcamno;
    	
    	$this->videoAccessPath 	= "axis-cgi/mjpg/video.cgi?resolution=".$this->videoResolution;
    	$this->imageAccessPath	= "axis-cgi/jpg/image.cgi?resolution=".$this->imageResolution;
    	
    	if (!empty($this->axisUser) && !empty($this->axisPassword))
    	{
    		$this->authString = $this->axisUser.':'.$this->axisPassword.'@';
    	}
    	else 
    	{
    		$this->authString = '';
    	}
    }
    
	public function getVideoURL()
    {
    	global $ip_webcam1, $ip_webcam2;
    	
    	if ($this->webcamno == 2) {
    		$ip = $ip_webcam2;
    	}
    	else {
    		$ip = $ip_webcam1;
    	}
    	
    	return 'http://'.$this->authString.$ip.'/'.$this->videoAccessPath.'&dummy=garb';
    }
    
	public function getImageURL()
    {
    	global $ip_webcam1, $ip_webcam2;
    	
    	if ($this->webcamno == 2) {
    		$ip = $ip_webcam2;
    	}
    	else {
    		$ip = $ip_webcam1;
    	}
    	
    	return 'http://'.$this->authString.$ip.'/'.$this->imageAccessPath.'&dummy='.time();
    }
    
    private function saveImageFromURL($url,$timeout = 10)
    {
    	// code from selfhtml link checker
    	
		$timeout = (int)round($timeout/2+0.00000000001);
 		$return = array();
 		
 		// decode url

		$inf = parse_url($url);

		 if (!isset($inf['scheme']) || $inf['scheme'] !== 'http')
		 	return array('status' => -1);
		 if (!isset($inf['host']))
		 	return array('status' => -2);
		 
		 $host = $inf['host'];
		
		 if (!isset($inf['path']))
		 	return array('status' => -3);
		 
		 $path = $inf['path'];
		 
		 if (isset($inf['query']))
		 	$path .= '?'.$inf['query'];
		
		 if (isset($inf['port']))
		 	$port = $inf['port'];
		 else
		 	$port = 80;

		// open connection
 
		$pointer = fsockopen($host, $port, $errno, $errstr, $timeout);
		if (!$pointer) 
			return array('status' => -4, 'errstr' => $errstr, 'errno' => $errno);
			
		socket_set_timeout($pointer, $timeout);

		// build query string
		 $head =  	'HEAD '.$path.' HTTP/1.0'."\r\n".
		 			'Host: '.$host."\r\n";
		
		 if (isset($inf['user']))
		 {
			$head .= 'Authorization: Basic '.
		 	base64_encode($inf['user'].':'.(isset($inf['pass']) ? $inf['pass'] : ''))."\r\n";
		 }
		 
		 if (func_num_args() > 2) 
		 {
			for ($i = 2; $i < func_num_args(); $i++) 
			{
				$arg = func_get_arg($i);
				
				if 	(
						strpos($arg, ':') !== false && strpos($arg, "\r") === false &&
						strpos($arg, "\n") === false
					) 
				{
					$head .= $arg."\r\n";
				}
			}
		 }
		 else 
		 $head .= 'User-Agent: DILPS Diathek Webcam Image Acquisition'."\r\n";
		
		 $head .= 'Connection: close'."\r\n"."\r\n";

		// write query to connection
		 fputs($pointer, $head);
		
		 $response = '';
		
		 $status = socket_get_status($pointer);
		 
		 while (!$status['timed_out'] && !$status['eof']) {
			$response .= fgets($pointer);
			$status = socket_get_status($pointer);
		 }
		 fclose($pointer);
		 
		 if ($status['timed_out']) {
		 	return array('status' => -5, '_request' => $head);
		 }
		
		// decode responde
		$res = str_replace("\r\n", "\n", $response);
		$res = str_replace("\r", "\n", $res);
		$res = str_replace("\t", ' ', $res);
		
		$ares = explode("\n", $res);
		$first_line = explode(' ', array_shift($ares), 3);
		
		$return['status'] = trim($first_line[1]);
		$return['reason'] = trim($first_line[2]);
		
		foreach ($ares as $line) {
			$temp = explode(':', $line, 2);
			
			if (isset($temp[0]) and isset($temp[1])) 
			{
				$return[strtolower(trim($temp[0]))] = trim($temp[1]);
				
				if (strtolower($temp[0]) == 'content-length')
				{
					// do not touch possibly binary payload
					break;
				}
			}
		}
		
		// store payload in a separate field
		if (isset($return['content-length']))
		{
			$payload = trim(substr($response,strpos($response,'Content-Length: '.$return['content-length'])+strlen('Content-Length: '.$return['content-length'])+1,$return['content-length']));
			$return['_payload'] = $payload;
		}
		
		$return['_response'] = $response;
		$return['_request'] = $head;
		
		return $return;
		
	}
	
	public function saveCurrentImage($side = 'fs')
	{		
		if ($side == 'back' || $side =='bs')
		{
			$side = 'bs';
		}
		else 
		{
			$side = 'fs';
		}
		
		$serverResponse = $this->saveImageFromURL($this->getImageURL());
		
		// print_r($serverResponse);
		
		if ($serverResponse['status'] == '200')
		{
			if (isset($serverResponse['_payload']))
			{
				$fp = fopen($this->basedir.'/webcam/'.$this->barcode.'_'.$side.'.jpg','w');
				fwrite($fp,$serverResponse['_payload']);
				fclose($fp);
			
				return true;
			}
			else 
			{
				return false;
			}
		}
		else 
		{
			return false;
		}
	}
	
}
?>