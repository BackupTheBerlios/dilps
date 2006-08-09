<?php


/**
* set newlogin, is 1 if just loged in
*/

//print_r($_POST);
//print_r($_GET);


if (isset($_POST['Login'])) {
	$smarty->assign('newlogin', '1');
}

/**
* if a mygroup is set
*/
if (isset($_REQUEST['mygroup']) && is_array($_REQUEST['mygroup'])) 
{
	$smarty->assign('mygroup',$_REQUEST['mygroup']);
} else {
	$smarty->assign('mygroup','');
}

$action = array();

if( isset($_REQUEST['action']) && is_array( $_REQUEST['action'] )) 
{
	$action = $_REQUEST['action'];	
} else {
	$action = array();
}

$smarty->assign('action',$action);

$query = array();

if( isset($_REQUEST['query']) && is_array( $_REQUEST['query'] )) 
{
	$query = $_REQUEST['query'];
} else {
  $query = array('querypiece'=>array());
}

cleanQuery($query);

$query['queryid'] = empty($_SESSION['counter']) ? 0 : $_SESSION['counter'];
$query = prepare_html_query($query);

$config['soapresults'] = (!empty($query['collectionid']) && $query['collectionid'] == '-1') ? true : false;

$smarty->assign( 'config', $config );

if( !$valid_login )
{
  $logins->logout();
  $smarty->display( $config['skin'].'/login.tpl' );
  exit();
}

$admin = $logins->isInGroup( $config['authdomain'], $config['admingroup'] );
$editor = $logins->isInGroup( $config['authdomain'], $config['editorgroup'] );

if( $admin )
{
  $editor = true;
}

$user = array('login'			=>	$logins->getUID( $config['authdomain'] ),
               'editor'			=>	($editor ? 1 : 0 ),
               'admin'			=>	($admin ? 1 : 0 ),
               'usemygroup' =>	(($admin || ($config['usemygroup'] 	== 'editor' ? $editor : 0)	| $config['usemygroup'] 	== 'user') ? 1 : 0),
               'editgroup' 	=>	(($admin || ($config['editgroup'] 		== 'editor' ? $editor : 0)	| $config['editgroup'] 		== 'user') ? 1 : 0),
               'insertimage' 	=>	(($admin || ($config['insertimage'] 		== 'editor' ? $editor : 0)	| $config['insertimage']	== 'user') ? 1 : 0)	
               );

$smarty->assign( 'user', $user );

$view = array();

if( isset($_REQUEST['view']) && is_array( $_REQUEST['view'] )) 
{
  $view = $_REQUEST['view'];
  $smarty->assign( 'view', $view );
}

$edit = array();

if( isset($_REQUEST['edit']) && is_array( $_REQUEST['edit'] ))
{
$edit = $_REQUEST['edit'];
$smarty->assign( 'edit', $edit );
}

$template = array();
$sql = "SELECT * FROM {$db_prefix}type";
$rs = $db->Execute( $sql );

while( !$rs->EOF )
{
	$template[$rs->fields['name']] = $rs->fields;
	$rs->MoveNext();
}
$rs->Close();

$smarty->assign( 'template', $template );

if( !isset( $view['type'] ) )
{
	$view['type'] = 'grid_detail';
}

switch( $view['type'] )
{
	case 'detail':
  if( !isset( $query['rows'] )) $query['rows'] = 12;
  $tpl = 'detail.tpl';
  break;
  
	case 'liste':
  if( !isset( $query['rows'] )) $query['rows'] = 12;
  $tpl = 'liste.tpl';
  break;
  
	case 'grid':
  if( !isset( $query['rows'] )) $query['rows'] = 4;
  if( !isset( $query['cols'] )) $query['cols'] = 4;
  $tpl = 'grid.tpl';
  break;
  
	case 'grid_detail':
  if( !isset( $query['rows'] )) $query['rows'] = 4;
  if( !isset( $query['cols'] )) $query['cols'] = 3;
  $tpl = 'grid_detail.tpl';
  break;
  
	default:
  if( !isset( $query['rows'] )) $query['rows'] = 4;
  if( !isset( $query['cols'] )) $query['cols'] = 3;
  $tpl = 'grid_detail.tpl';
  break;
}

$smarty->assign( 'query', $query );

?>
