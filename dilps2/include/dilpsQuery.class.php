<?php
    /* @author: brian@mediagonal.ch
    */

class dilpsQuery {

    var $db;
    var $db_prefix;

    var $column_metainfo = array(
                        'collectionid' =>   array('function'=>'get_dropdown_where_query',
                                                'operators'=>'equals'),
                        'type'  =>          array('function'=>'get_dropdown_where_query',
                                                'operators'=>'equals'),
                        'title' =>          array('function'=>'get_meta_where_query',
                                                'operators'=>'normal'),
                        'name' =>           array('function'=>'get_artist_where_query',
                        						'operators'=>'extended'),
                        'addition' =>       array('function'=>'get_meta_where_query',
                                                'operators'=>'normal'),
                        'year' =>           array('function'=>'get_dating_where_query',
                                                'operators'=>'like'),
                        'material' =>       array('function'=>'get_meta_where_query',
                                                'operators'=>'normal'),
                        'technique' =>      array('function'=>'get_meta_where_query',
                                                'operators'=>'normal'),
                        'format' =>         array('function'=>'get_meta_where_query',
                                                'operators'=>'normal'),
                        'location' =>       array('function'=>'get_location_where_query',
                                                'operators'=>'extended'),
                        'institution' =>    array('function'=>'get_meta_where_query',
                                                'operators'=>'normal'),
                        'literature' =>     array('function'=>'get_meta_where_query',
                                                'operators'=>'normal'),
                        'commentary' =>     array('function'=>'get_meta_where_query',
                        						'operators'=>'normal'),
                        'keyword' =>        array('function'=>'get_meta_where_query',
                                                'operators'=>'normal'));

    function dilpsQuery($db = null, $db_prefix = null) {

        if (!is_null($db))
            $this->db = $db;
        if (!is_null($db_prefix))
            $this->db_prefix = $db_prefix;
    }

    function getColumnMetainfo() {
        return $this->column_metainfo;
    }

    function buildWhere($querystruct) {
        /*
        query = array(phrases, connectors)
        phrases = array(atoms, connectors)
        connectors = array ({and | or})
        atoms = array(field, val, operator, not)
        */
        if (empty($querystruct)) {
            return '1';
        }

        $where = '';

        $phrases = $querystruct['phrases'];
        $connectors = $querystruct['connectors'];
        //$count = count($connectors);
        $count = count($phrases) - 1;

        $where .= '(';
        $connector = '';
        for ($i = 0; $i < $count; $i++) {
        	$phrase = $this->buildPhrase($phrases[$i]);
        	if ($phrase != '') {
	            //$where .= $phrase;
	            //$where .= " {$connectors[$i]} ";
	            $where .= " $connector $phrase";
	            $connector = $connectors[$i];
        	}
        }
        $phrase = $this->buildPhrase($phrases[$i]);
        if ($phrase != '') {
        	$where .= " $connector $phrase";
        }
        $where .= ')';

        if ($where == '()') {
        	$where = '1';
        }

        return $where;

    }

    function buildPhrase($pieces) {
        $atoms = $pieces['atoms'];
        $connectors = $pieces['connectors'];

        $count = count($atoms) - 1;

        $known_columns = array_keys($this->column_metainfo);

        $connector = '';
        $phrase = '(';
        for ($i = 0; $i < $count; $i++) {

			$bit = $this->getPhraseBit($atoms[$i], $known_columns);
			if ($bit != '') {
	            $phrase .= " $connector $bit";
	            $connector = $connectors[$i];
			}
        }

		$bit = $this->getPhraseBit($atoms[$i], $known_columns);
		if ($bit != '') {
	            $phrase .= " $connector $bit";
		}
	    $phrase .= ')';

        if ($phrase == '()') {
        	$phrase = '';
        }

        return $phrase;

    }

    function getPhraseBit($atom, $known_columns) {

        if (isset($atom['field']) && in_array($atom['field'], $known_columns)) {

            $function = $this->column_metainfo[$atom['field']]['function'];

            $phrase_bit = $this->$function($atom['field'], $atom['val'], $atom['operator']);

            if ($atom['not']) {
                $phrase_bit = " !($phrase_bit) ";
            }

        } else {
            return '';
        }

        return $phrase_bit;

    }

    function get_meta_where_query($column, $value, $operator) {

        $where = "lower({$this->db_prefix}meta.$column) ";

        if ($operator == 'equals') {

            $where .= "= lower(". $this->db->qstr($value) . ")";

        } else {

            $where .= "like lower(" . $this->db->qstr("%$value%") .")";
        }


    	return $where;
    }


    /* gets the where chunk for meta table values that are displayed as dropdowns
    *  it is assumed that a value of -1 means not to include this chunk
    *
    */
    function get_dropdown_where_query($column, $value, $operator) {
        if ($value != "-1") {
            $where = "{$this->db_prefix}meta.$column = " .$this->db->qstr($value);

        } else {
            $where = '';
            //$where = '1';
        }

    	return $where;
    }


    function get_location_where_query($column, $value, $operator) {

        global $config;

        switch ($operator) {

        	case "equals":
        	    $where = "lower({$this->db_prefix}meta.$column) = lower(" . $this->db->qstr($value) .")";
        		break;

        	case "like":
                $where = "lower({$this->db_prefix}meta.$column) like lower(" . $this->db->qstr("%$value%") .")";
        		break;

        	case "soundslike":
                include_once($config['includepath'].'thesauri/soundex_fr.php');
                $sound = trim(soundex2($value));
                $where = "{$this->db_prefix}meta.{$column}sounds like  '%.$sound.%'";
                break;

        	/*case "likesoundslike":
                include_once($config['includepath'].'thesauri/soundex_fr.php');
                $sound = trim(soundex2($value));
                $where = "({$this->db_prefix}meta.{$column}sounds like  '%.$sound.%' or lower({$this->db_prefix}meta.$column) like lower(" . $this->db->qstr("%$value%") ."))";
        		break;*/

            default:
                $where = '';
        		break;
        }

    	return $where;
    }

    function get_artist_where_query($column, $value, $operator) {

        global $config;

        switch ($operator) {

        	case "equals":
                $where =  " (lower({$this->db_prefix}meta.name1) = lower(".$this->db->qstr("$value").")".
            	           " or lower({$this->db_prefix}meta.name2) = lower(".$this->db->qstr("$value")."))";
        		break;

            case "like":
                $where = " (lower({$this->db_prefix}meta.name1) like lower(".$this->db->qstr("%$value%").")".
            	           " or lower({$this->db_prefix}meta.name2) like lower(".$this->db->qstr("%$value%")."))";
                break;

            case "soundslike":
                include_once($config['includepath'].'thesauri/soundex_fr.php');
                $sound = trim(soundex2($value));
                $where = " ({$this->db_prefix}meta.name1sounds like '%.$sound.%' or {$this->db_prefix}meta.name2sounds like '%.$sound.%')";
                break;

            /*case "likesoundslike":
                include_once($config['includepath'].'thesauri/soundex_fr.php');
                $sound = trim(soundex2($value));
                $where = " ( (lower({$this->db_prefix}meta.name1) like lower(".$this->db->qstr("%$value%").")".
            	           " or lower({$this->db_prefix}meta.name2) like lower(".$this->db->qstr("%$value%")."))".
            	           " or ({$this->db_prefix}meta.name1sounds like '%.$sound.%' or {$this->db_prefix}meta.name2sounds like '%.$sound.%') )";
                break;*/

            default:
                $where = '';
        		break;
        }

    	return $where;
    }

    function get_dating_where_query($column, $value, $operator) {

        global $config;
        require_once( $config['includepath'].'tools.inc.php' );

        dating( $this->db, $value, $datelist );

    	if( count( $datelist ))
    	{
    		$date_to = $datelist[0]['to'];
    		$date_from = $datelist[0]['from'];

    		$sql = "select metaid from {$this->db_prefix}dating where {$this->db_prefix}dating.`from`<=$date_to AND {$this->db_prefix}dating.`to`>=$date_from";

    		$metaids = $this->db->GetCol($sql);

    		if ($metaids === false) {
    			$where = "'error trying to execute sql for dating: $sql'";
    		} else if (empty($metaids)) {
    			$where = "0";
    		} else {
    			$where = "{$this->db_prefix}meta.id in (".implode(',', $metaids).")";
    		}

    	} else {
    	   $where = "0";
    	}

    	return $where;
    }


}
?>