<?php

error_reporting(E_ALL);
ini_set('display_errors',1);

include_once( 'session.inc.php' );
ini_set('magic_quotes_runtime',0);

function __stripslashes( &$str )
{
	$str = stripslashes( $str );
}

function __stripslashes_array( &$arr )
{
	array_walk( $arr, '__stripslashes' );
}

function html_entity_decode_recursive($array) 
{
    foreach ($array as $key => $val)
    {
        if (is_string($val)) {
                $array[$key] = trim(html_entity_decode($val));
        }
        elseif (is_array($val)){
            $array[$key] = html_entity_decode_recursive($val);
        }
    }
    return $array;
}

class PhpRequestAndSessionWrapper
{   
	var $phpPostArray, $phpGetArray, $phpSessionArray;
	var $magicQuotesGpcStatus;
	
	var $allowedTypes;
	
    function __construct( $phpPostArray, $phpGetArray, $phpSessionArray )
    {
    	$this->phpPostArray 	=	html_entity_decode_recursive($phpPostArray);
		$this->phpGetArray 		=	html_entity_decode_recursive($phpGetArray);
		$this->phpSessionArray 	=	html_entity_decode_recursive($phpSessionArray);

		$this->magicQuotesGpcStatus = get_magic_quotes_gpc();
		$this->allowedTypes = array('post','get','session');
		
		/*
		echo ("POST: \n<br>\n");
		print_r($this->phpPostArray);
		echo ("\n<br>\n");
		
		echo ("GET: \n<br>\n");
		print_r($this->phpGetArray);
		echo ("\n<br>\n");
		
		echo ("SESSION: \n<br>\n");
		print_r($this->phpSessionArray);
		echo ("\n<br>\n");
		*/
    }
    
    private function isAllowedType($type)
    {
    	return (in_array(strtolower($type),$this->allowedTypes));
    }
    
    private function getRequestValue($type, $name)
    {
    	switch ($type)
    	{
    		case 'post':
    			$ret = isset($this->phpPostArray[$name]) ? (empty($this->phpPostArray[$name]) ? '' : $this->phpPostArray[$name]) : false;
    			break;
    		case 'get':
    			$ret = isset($this->phpGetArray[$name]) ? (empty($this->phpGetArray[$name]) ? '' : $this->phpGetArray[$name]) : false;
    			break;
    		case 'session':
    			$ret = isset($this->phpSessionArray[$name]) ? (empty($this->phpSessionArray[$name]) ? '' : $this->phpSessionArray[$name]) : false;
    			break;
    		default:
    			$ret = false;
    	}
    	
    	return $ret;
    }
    
    private function setRequestValue($type, $name, $value)
    {
    	switch ($type)
    	{
    		case 'post':
    		case 'get':
    			$ret = false;
    			break;
    		case 'session':
    			$_SESSION[$name] = $value;
    			/*
    			echo ("Set Session {$name} to: {$value}\n<br>\n");
    			echo ("\n<br>\n");
    			print_r($_SESSION);
    			echo ("\n<br>\n");
    			*/
    			$ret = true;
    			break;
    		default:
    			$ret = false;
    	}
    	
    	return $ret;
    }
    
    private function unsetRequestValue($type, $name)
    {
    	switch ($type)
    	{
    		case 'post':
    		case 'get':
    			$ret = false;
    			break;
    		case 'session':
    			if (isset($_SESSION[$name]))
    			{
    				unset($_SESSION[$name]);
    			}
    			$ret = true;
    			break;
    		default:
    			$ret = false;
    	}
    	
    	return $ret;
    }
    
    public function getValue($type, $name)
    {
    	if ($this->isAllowedType($type))
    	{
    		$ret = $this->getRequestValue($type,$name);
    		
    		if ($this->magicQuotesGpcStatus)
    		{
    			if (is_string($ret)) {
    				$ret = stripslashes($ret);
    			}
    			elseif (is_array($ret)) {
    				__stripslashes_array($ret);
    			}
    		}
    		return $ret;
    	}

    	return false;
    }
    
    public function setValue ($type, $name, $value)
    {
    	if ($this->isAllowedType($type))
    	{
    		return $this->setRequestValue($type, $name, $value);
    	}
    	
    	return false;
    }
    
    public function unsetValue ($type, $name)
    {
    	if ($this->isAllowedType($type))
    	{
    		return $this->unsetRequestValue($type, $name);
    	}
    	
    	return false;
    }
}
?>