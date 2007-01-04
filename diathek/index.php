<?php
// include_once( 'session.inc.php' );
include( 'db.inc.php' );

?><html>
<head>
<style type="text/css">
#name_mod {text-align:left;}
#name_input {width:20em;height:1.4em;}
#name_container {position:absolute;z-index:9050;}
#name_container .yui-ac-content {position:absolute;left:0;top:0;width:20em;border:1px solid #404040;background:#fff;overflow:hidden;text-align:left;z-index:9050;}
#name_container .yui-ac-shadow {position:absolute;left:0;top:0;margin:.3em;background:#a0a0a0;z-index:9049;}
#name_container ul {padding:5px 0;width:100%;}
#name_container li {padding:0 5px;cursor:default;white-space:nowrap;}
#name_container li.yui-ac-highlight {background:#ff0;}
</style>
<script type='text/javascript' src='dilpsserver.php?<?php echo strip_tags(SID); ?>&client=all&stub=dilpsacquisitionajax'></script>
<script type="text/javascript" src="yui/build/yahoo/yahoo.js"></script> 
<script type="text/javascript" src="yui/build/dom/dom.js"></script> 
<script type="text/javascript" src="yui/build/event/event.js"></script> </head>
<script type="text/javascript" src="yui/build/animation/animation.js"></script> 
<script type="text/javascript" src="yui/build/autocomplete/autocomplete.js"></script> 
<script type="text/javascript" src="yui/build/utilities/utilities.js"></script> 
<script type="text/javascript">

var remoteHW = new DilpsAcquisitionAJAX();

var num = 20;

function do_getContents( field, sQuery, num )
{
    return remoteHW.getContents( field, sQuery, num );
}
</script> 
<body>
<form name="main" method="get" action="<?=$_SERVER['PHP_SELF'] ?>">

<!-- AutoComplete begins -->
<div id="name_mod">
    <label>Name</label>
    <input id="name_input">
    <!-- <input id="name_submit" type="submit" value="Submit Query"> -->
    <div id="name_container"></div>
</div>
<!-- AutoComplete ends -->

<script type="text/javascript">
//
// Name
//
var name_data = function( sQuery ) {
    arr = do_getContents( "name1", sQuery, num );
    return arr;
} 
name_DS = new YAHOO.widget.DS_JSFunction(name_data);
//name_DS.queryMatchContains = true;
//name_DS.maxCacheEntries = num; 

// Instantiate AutoComplete
name_AutoComp = new YAHOO.widget.AutoComplete("name_input","name_container", name_DS);
name_AutoComp.useShadow = true;
name_AutoComp.minQueryLength = 1;
name_AutoComp.queryDelay = 0;
name_AutoComp.maxResultsDisplayed = num;
name_AutoComp.allowBrowserAutocomplete = true; 
name_AutoComp.formatResult = function(oResultItem, sQuery) 
{
    return oResultItem[1];
};
name_AutoComp.doBeforeExpandContainer = function(oTextbox, oContainer, sQuery, aResults) {
    var pos = YAHOO.util.Dom.getXY(oTextbox);
    pos[1] += YAHOO.util.Dom.get(oTextbox).offsetHeight;
    YAHOO.util.Dom.setXY(oContainer,pos);
    return true;
};
</script>

<?php

?>
</form>
</body>
</html>
