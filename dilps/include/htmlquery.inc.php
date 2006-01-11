<?php

require_once( $config['includepath'].'dilpsMeta.class.php' );
require_once( $config['includepath'].'dilpsQuery.class.php' );

function prepare_query($query) {
    
	global $db, $db_prefix;

    if (empty($query['querypiece'])) {
        $query['prepared_where'] = '1';
        return $query;
    }
    
    if ($query['querytype'] == 'simple' && $query['fromquerytype'] == 'advanced') {
        unset ($query['querypiece']);
        $query['prepared_where'] = '1';
        return $query;
    }
    
    if ($query['querytype'] == 'simple') {
        $old_query = $query;
    }
    
	$query = cleanQuery($query);
	
	if ($query['fromquerytype'] == 'simple' && !empty($query['all']) && trim($query['all']) !== '') { 
	    $queryall_fields = array('year', 'name', 'title');    
	    $query = add_query_all_phrase($query, $queryall_fields, $query['all']);
	}

	if ($query['querytype'] == 'advanced') {
	    
    	//NOTE: query[querypiece][0] should always be present, and it should not be modified by this function.
        // add a new query piece if necessary
        $count = count($query['querypiece']);
        $lastindex = $count - 1;
        if ( $lastindex == 0 ||  // no first main query piece; can happen coming from easy query with no values specified
        
            (isset($query['querypiece'][$lastindex]['piece_connector']) && $query['querypiece'][$lastindex]['piece_connector'] != '') // user wants another phrase
            ) {
            $lastindex++;
            
            $query['querypiece'][$lastindex] = add_new_phrase();
        }
    
        // if it's coming from a simple query, "unset" the last phrase connector in query[querypiece][1]
        // unless the all field was used in the simple query
        if ($query["fromquerytype"] == "simple" && trim($query["all"]) == '') {
            $lastindex = count($query["querypiece"][1]["connector"]) - 1;
            $query["querypiece"][1]["connector"][$lastindex] = '';
        }
        
        
        // add a new phrase to one of the query pieces if necessary
        // and set the last entries connector to ''
        foreach ($query['querypiece'] as $key=>$qp) {
            
            if ($key != 0) {
                
                $count = count($qp['field']);
                $lastindex = $count - 1;
                if (isset($qp['connector'][$lastindex]) && $qp['connector'][$lastindex] != '') {
    
                    $query['querypiece'][$key] = add_new_phrase($query['querypiece'][$key]);
                    /*foreach ($collist as $property) {
                        $query['querypiece'][$key][$property][$count] = '';
                    }*/
                }
            }
        }
	}

	
	$querystruct = transform_query($query);

	$dbQuery = new dilpsQuery($db, $db_prefix);
	$where = $dbQuery->buildWhere($querystruct);

	if ($query['querytype'] == 'advanced') {
	   $query['prepared_where'] = $where;    

	   return $query;
	} else {
	    // for the simple query, leave the fields as they were, just provide the where clause
	   $old_query['prepared_where'] = $where;    
	   return $old_query;
	}
}


/* transforms html query pieces into the data structure expected by the dilpsQuery class
*/
function transform_query($htmlquery) 
{
    /*
    query = array(phrases, connectors) 
    phrases = array(atoms, connectors)
    connectors = array ({and | or})
    atoms = array(field, val, operator, not)
    */

    if (empty($htmlquery['querypiece'])) {
        return array();
    }
    
    $atomfields = array('val', 'field', 'operator', 'not');
    $query = array();
    $phrases = array();
    $qconnectors = array();
    
    $j = 0;
    foreach ($htmlquery['querypiece'] as $piecekey=>$querypiece) {
        
        $atoms = array();
        $aconnectors = array();
        
        $count = count($querypiece['field']);
        $last_connector = $count - 1;
        
        for ($i = 0; $i < $count; $i++) {
            
            $atom = array();
            
            foreach ($atomfields as $atomfield) {
            	$atom[$atomfield] = $querypiece[$atomfield][$i];
            }
            
            $atoms[$i] = $atom;
            
            if ($i < $last_connector) {
                $aconnectors[$i] = $querypiece['connector'][$i]; 
            }
        }
        
        $phrases[$j]['atoms'] = $atoms;
        $phrases[$j]['connectors'] = $aconnectors;
        
        if (isset($querypiece['piece_connector'])) {
            $qconnectors[$piecekey] = $querypiece['piece_connector'];
        }
        $j++;
    }
    
    $query['phrases'] = $phrases;
    $query['connectors'] = $qconnectors;
    
    return $query;
}



// NOTE: query[querypiece][0] should always be present, and it should not be modified by this function.
function cleanQuery($query) {
    
    if (empty($query['querypiece'])) {
        return $query;
    }
    
    
    // delete on request
    if (!empty($query['delete_phrase'])) {
        
        list($qpiece, $index) = explode(':', $query['delete_phrase']);
        
        foreach ($query['querypiece'][$qpiece] as $key=>$item) {
            
            if (is_array($item) && isset($item[$index])) {
                unset($query['querypiece'][$qpiece][$key][$index]);
            }
        }
        
        // unset the connector of the preceeding item, if this was the last item
        $piece_content_count = count($query['querypiece'][$qpiece]['field']);
        if ($index == $piece_content_count) {

            if ($index == 0 && $qpiece > 1) {
                $qpiece--;
                $query['querypiece'][$qpiece]['piece_connector'] = '';
            } else {
                $index--;
                if (isset($query['querypiece'][$qpiece]['connector'][$index])) {
                    $query['querypiece'][$qpiece]['connector'][$index] = '';
                }
            }
        }
        
    }
    
    // reorder the query pieces (qp) to start from a 0 index and
    // get rid of phrases in the query with no value
    $i = 0;
    $newquerypieces = array();
    foreach ($query['querypiece'] as $key=>$qp) {

       if ($key == 0) {
           $newquerypieces[$i] = $qp;
           $i++;
       } else {
           $j = 0;
           $newquerypiece = array();
           
           // get the numerical keys of the query phrases
           $qpkeys = array_keys($qp['field']);
           foreach ($qpkeys as $qpkey) {
               
                if ((isset($qp['val'][$qpkey]) && $qp['val'][$qpkey] != '') || is_switching_type($query, $key, $qpkey)) {
                    
                    $queryphraseelements = array_keys($qp);    //elements: e.g. field, val, operator
                    foreach ($queryphraseelements as $element) {
                        if (is_array($qp[$element])) {

                            if (isset($qp[$element][$qpkey])) {
                                $newquerypiece[$element][$j] = $qp[$element][$qpkey];
                            } else {
                                $newquerypiece[$element][$j] = '';
                            }
                        } else {
                            $newquerypiece[$element] = $qp[$element];
                        }
                    }
                    $j++;
                } 
            }
            
            if (!empty($newquerypiece)) {
                $newquerypieces[$i] = $newquerypiece;
                $i++;
            }
       }
    }

    //$last_index = count($newquerypieces) - 1;
    //unset($newquerypieces[$last_index]['piece_connector']);
    
    $query['querypiece'] = $newquerypieces;
    
    return $query;
}

/* returns true if query[querypiece][$key1][val][$key2] has been signaled as transforming it's type
*/
function is_switching_type($query, $key1, $key2) {
    if (empty($query['transforming_field'])) {
        return false;
    }

    return ("$key1:$key2" == $query['transforming_field']);
}           


/* returns the query piece with a new phrase added to it.  
 * if the query piece is empty, or none is provided, returns a newly created query piece with a single phrase.
*/
function add_new_phrase($query_piece = array()) {
    $array_elements = array('val', 'field', 'connector', 'operator', 'not', 'operator_list');
    if (empty($query_piece)) {
        $query_piece = array(   'val'=>array(), 
                                'field'=>array(), 
                                'connector'=>array(), 
                                'operator'=>array(), 
                                'not'=>array(), 
                                'operator_list'=>array(),
                                'piece_connector'=>'');
    }
    
    $index = count($query_piece['field']);
    foreach ($array_elements as $element) {
        $query_piece[$element][$index] = '';
    }
    return $query_piece;
}

function add_query_all_phrase($query, $fields, $value) {
    
    $value = trim($value);
    $queryall = array();
    
    $dq = new dilpsQuery();
    $metainfo = $dq->getColumnMetainfo();
    
    foreach ($fields as $field) {
        
        $queryall = add_new_phrase($queryall);
        
        $index = count($queryall['field']) - 1;
        
        $queryall['field'][$index] = $field;
        $queryall['val'][$index] = $value;
        $queryall['connector'][$index] = 'or';
        $queryall['operator'][$index] = 'like';
        $queryall['not'][$index] = '0';
        $queryall['operator_list'][$index] = $metainfo[$field]['operators'];
    }
    
    
    $index = count($query['querypiece']);
    $query['querypiece'][$index] = $queryall;
    
    // connect to last phrase with an or connector 
    // but not if it's the first query piece (which determines which collections to search in)
    
    if ($index > 1) {
        $query['querypiece'][$index - 1]['piece_connector'] = 'or';
    }
    return $query;
    
} 	    


?>