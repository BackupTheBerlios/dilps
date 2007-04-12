function viewDetail( sessionid, imageid, remoteCollectionId) {
   props = 'toolbar=no,location=no,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=no,copyhistory=no';
   win = window.open( 'view_detail.php?PHPSESSID='+sessionid+'&newwin=1&query[id]='+imageid+'&query[remoteCollection]='+remoteCollectionId+'&view[detail][id]='+imageid, 'imageView', props + ',width=700,height=720' );
   win.focus();
}


function editElement( sessionid, imageid, element, val ) {
   props = 'toolbar=no,location=no,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=no,copyhistory=no';
   win = window.open( 'edit_element.php?PHPSESSID='+sessionid+'&query[id]='+imageid+'&query[element]='+element+'&query[value]='+escape(val)+'&query[remoteCollection]=0', 'elementView', props + ',width=900,height=550' );
   win.focus();
}


function editNameElement( sessionid, imageid, element, docelements ) {
   props = 'toolbar=no,location=no,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=no,copyhistory=no';
   win = window.open( 'edit_element.php?PHPSESSID='+sessionid+'&query[id]='+imageid+'&query[element]='+element+'&query[name1id]='+docelements["edit[name1id]"].value+'&query[name1text]='+escape(docelements["edit[name1text]"].value)+'&query[name2id]='+docelements["edit[name2id]"].value+'&query[name2text]='+escape(docelements["edit[name2text]"].value), 'elementView', props + ',width=700,height=720' );
   win.focus();
}

function editArchaeologyElement( sessionid, imageid, element, docelements ) {
   var props = 'toolbar=no,location=no,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=no,copyhistory=no';
   
   //	var fn_index = "edit["+element+"_fn]";
   //	var val_index = "edit["+element+"]";
   // 	var fn_val = docelements[fn_index].value;
   //	var val_val = docelements[val_index].value;
   
   win = window.open( 'edit_archaeology_element.php?PHPSESSID='+sessionid+'&query[id]='+imageid+'&query[element]='+element, 'archaelogyEdit', props + ',width=900,height=720' );
   win.focus();
}

function editArchitectureElement( sessionid, imageid, element, docelements ) {
   var props = 'toolbar=no,location=no,directories=no,status=yes,scrollbars=yes,resizable=yes,menubar=no,copyhistory=no';
   
   //	var fn_index = "edit["+element+"_fn]";
   //	var val_index = "edit["+element+"]";
   // 	var fn_val = docelements[fn_index].value;
   //	var val_val = docelements[val_index].value;
   
   win = window.open( 'edit_architecture_element.php?PHPSESSID='+sessionid+'&query[id]='+imageid+'&query[element]='+element, 'archaelogyEdit', props + ',width=900,height=720' );
   win.focus();
}


function Adjust() {
  if ((document.forms["Main"].elements["view[detail][id]"].value==""))
  if (document.forms["Main"].elements["view[edit][id]"].value=="")
      document.getElementById('navigation').colSpan = "1";
}


function changeView( view )
{
   switch( view )
   {
	case 'detail':
       document.forms["Main"].elements["query[cols]"].value=1;
       document.forms["Main"].elements["query[rows]"].value=8;
	break;
	case 'liste':
       document.forms["Main"].elements["query[cols]"].value=1;
       document.forms["Main"].elements["query[rows]"].value=8;
		break;
	case 'grid':
       document.forms["Main"].elements["query[rows]"].value=8;
       document.forms["Main"].elements["query[cols]"].value=6;
		break;
	case 'grid_detail':
       document.forms["Main"].elements["query[rows]"].value=8;
       document.forms["Main"].elements["query[cols]"].value=3;
		break;
	default:
       document.forms["Main"].elements["query[rows]"].value=8;
       document.forms["Main"].elements["query[cols]"].value=3;
		break;
	}
   document.forms["Main"].elements["view[type]"].value=view;
   document.forms["Main"].elements["query[page]"].value="1";
   document.forms["Main"].elements["view[detail][id]"].value="";
   document.forms["Main"].elements["view[edit][id]"].value="";
   document.forms["Main"].submit();
}


function changepage(page )
{
  document.forms["Main"].elements["query[page]"].value= page;
  document.forms["Main"].submit();
}


function showDetail( sessionid, id, remoteCollectionId)
{
	document.forms["Main"].elements["view[edit][id]"].value="";
	document.forms["Main"].elements["view[detail][id]"].value=id;
	document.forms["Main"].elements["query[remoteCollection]"].value=remoteCollectionId;
	document.forms["Main"].submit();
}


function editDetail( id )
{
	document.forms["Main"].elements["view[detail][id]"].value="";
	document.forms["Main"].elements["view[edit][id]"].value=id;
	document.forms["Main"].submit();
}


function changeType()
{
	document.forms["Main"].elements["edit[loadtype]"].value="changetype";
	document.forms["Main"].submit();
}

function saveImage()
{
	document.forms["Main"].elements["view[detail][id]"].value=document.forms["Main"].elements["view[edit][id]"].value;
	document.forms["Main"].elements["view[edit][id]"].value="";
	
	
	if (document.forms["Main"].elements["edit[currentuser]"].value != "")
	{
		document.forms["Main"].elements["edit[metaeditor]"].value = document.forms["Main"].elements["edit[currentuser]"].value;
	}
	document.forms["Main"].elements["edit[loadtype]"].value="save";
	
	document.forms["Main"].submit();
}

function setStatus( status )
{
	document.forms["Main"].elements["edit[status]"].value=status;
	saveImage();
}

// function ChangeQuery()
//
// Takes the value of the queryrows selection and sets query[cols]
// and query[rows] accordingly.

function ChangeQuery()
{
	var inpstr = document.forms["Main"].elements["queryrows"].value;
	var cols   = inpstr.substr(0,inpstr.indexOf('x'));
	var rows   = inpstr.substr(inpstr.indexOf('x')+1, 10);
	
	document.forms["Main"].elements["query[cols]"].value = cols;
	document.forms["Main"].elements["query[rows]"].value = rows;
}

function editDetail( id )
{
	document.forms["Main"].elements["view[detail][id]"].value="";
	document.forms["Main"].elements["view[edit][id]"].value=id;
	document.forms["Main"].submit();
}

function changeQueryType(type) {
	if (type == 'advanced') {
		document.forms["Main"].elements["query[querytype]"].value='advanced';
	} else {
		document.forms["Main"].elements["query[querytype]"].value='simple';
	}
	document.forms["Main"].submit();
}


function UpdateSelectList(selectlist, operatorlist, field, form) {

    var i;
    var operators = operator_lists[column_operators[field.value]];
    for (i=form.elements[selectlist].options.length-1;i>=0;i--) {
        form.elements[selectlist].options[i] = null;
    }

    j = 0;
    
    if (PrototypeIncluded()) {
        // this syntax is necessary when prototype.js is included (regular "for i in obj" loops don't work as expected):
        $H(operators).each( function(val){
            form.elements[selectlist].options[j] = new Option(val.value, val.key, false, false);
            j++;        
        });
    } else {
        for (i in operators) {
            form.elements[selectlist].options[j] = new Option(operators[i], i, false, false);
            j++;        
        }
    }
    
    form.elements[operatorlist].value=column_operators[field.value];

    // some things need a drop down list instead of a free text entry field, which requires a reload
    // set the value for the field to something, so that it won't get removed in the pre-processing
    //var selectboxfields = ":type:collectionid:status:";
    var selectboxfields = ":type:collectionid:";
    var valstr = selectlist.replace('operator', 'val');
    var needsreload = false;

    if (selectboxfields.indexOf(':' + field[field.selectedIndex].value +':') != -1) {
        needsreload = true;
        form.elements[valstr].value = '-1';
    } else if (form.elements[valstr].type.indexOf('select') == 0) {
        needsreload = true;
        form.elements[valstr].options[form.elements[valstr].length] = new Option('', '', false, false);
        form.elements[valstr].value = '';
    }

    if (needsreload) {
        var changing_item = valstr.replace(/.*?(\d+).*?(\d+).*/, "$1:$2");
        form.elements["query[transforming_field]"].value = changing_item;
        form.submit();
    }
}

function showCollection( sessionid, collectionid, queryid )
{
	//document.forms["Main"].elements["view[edit][id]"].value="";
	//document.forms["Main"].elements["view[detail][id]"].value=id;
	//document.forms["Main"].elements["view[type]"].value = "soap";
	//document.forms["Main"].elements["query[remote]"].value = collectionid+":"+queryid;
	document.forms["Main"].elements["query[collectionid]"].value = collectionid;
	document.forms["Main"].elements["query[showoverviewlink]"].value="1";
	document.forms["Main"].submit();
}

function updateRemoteCollectionFields(sessionid, queryid) {
    afu = new FieldUpdater('ajax-update-field', 'remoteCount.php', 'wait.gif', sessionid, queryid);
    afu.updateAll();
}

function PrototypeIncluded() {
    var included = false;
    try {
        if (Prototype) {
            included = true;
        }
    } catch (e) {
        //it's not included
    }
    return included;
}

function queryAllCollections()
{
	document.forms["Main"].elements["query[collectionid]"].value='-1';
	editDetail('');
}

function newQuery()
{
	document.forms["Main"].elements["query[showoverviewlink]"].value="0";
	editDetail('');
}

function clearSimpleQuery()
{
	var fieldnames = new Array(	'all','title','category','object',
									'name','iconography','dating_ext',
									'material_ext','location_ext',
									'location','literature','imageid');
	var actfn = '';
	
	for(var i =0; i < fieldnames.length; i++)
	{
		actfn = 'query['+fieldnames[i]+']';
		
		if (document.forms["Main"].elements[actfn] != null)
		{
				document.forms["Main"].elements[actfn].value = '';			
		}
	}
	
	// reset image status query field
	actfn = 'query[status]';
	
	document.forms["Main"].elements[actfn].options[0].selected = true;
	
	cleargroup();
	
	return true;
}

function queryCheckbox(form, hiddenvalue, cbox) {
	if (form.elements[cbox].checked == false) {
	    form.elements[hiddenvalue].value = 0;
	} else {
	    form.elements[hiddenvalue].value = 1;
	}
}

function setAndSubmit(form, element, value) {
    form.elements[element].value = value;
    form.submit();
}


// globals necessary for the advanced query
var operator_lists;
var column_operators;

function cleargroup() {
	document.forms["Main"].elements["query[group]"].value = '';
	document.forms["Main"].elements["query[groupid]"].value = '';
	document.forms["Main"].elements["query[groupowner]"].value = '';
	document.forms["Main"].elements["query[grouplastpath]"].value = '';
	document.forms["Main"].submit();
}

function clearmygroup() {
	document.forms["Main"].elements["query[mygroup]"].value = '';
	document.forms["Main"].elements["query[mygroupid]"].value = '';
	document.forms["Main"].elements["query[mygroupowner]"].value = '';
	document.forms["Main"].elements["query[mygrouplastpath]"].value = '';
	document.forms["Main"].submit();
}

function updatemygroup()
{
	// check, if someone has use a group button
	if (document.forms["Main"].elements["query[mygroupid]"].value != '')
	{
		// set mygroupid as target
		document.forms["Main"].elements["action[gid]"].value = document.forms["Main"].elements["query[mygroupid]"].value
		
		// update target for next action
		document.forms["Main"].elements["action[target]"].value = 'mygroup';
		document.forms["Main"].elements["action[function]"].value = 'update';

		// submit
		document.forms["Main"].submit();
	}
	
	// otherwise: do nothing
	return;		
}

function performlogout() {
	document.forms["Main"].elements["logout"].value = 1;
	document.forms["Main"].submit();
}


function makeVisible(divid) {
	// alert('Vis: '+divid);

	if (document.getElementById(divid) != null)
	{
		document.getElementById(divid).style.visibility = "visible";
		return true;
	}
	return false;
}

function makeInvisible(divid) {
	// alert('Invis: '+divid);
	if (document.getElementById(divid) != null)
	{
		document.getElementById(divid).style.visibility = "hidden";
		return true;
	}
	return false;
}

function showGroups(Indexes) {
	
	if (Indexes[0] != -1)
	{
		// set first selection and get the corresponding data
		document.forms[0].elements["gid-0-groups"].selectedIndex = Indexes[0];
		
		var sElem1 		= document.forms[0].elements["gid-0-groups"].options[Indexes[0]].value;
		var sElem1Parts = extractData(sElem1);
		var sElem1ID 	= sElem1Parts[0];
		
		if ( sElem1ID != null)
		{
			// show the second level select box
			sElem1Div = "gid-"+sElem1ID;
			sElem1Select = "gid-"+sElem1ID+"-groups";
			makeVisible(sElem1Div);
			
			if (Indexes[1] != -1)
			{
				// set second selection and get the corresponding data
				document.forms[0].elements[sElem1Select].selectedIndex = Indexes[1];
				
				var sElem2 = document.forms[0].elements[sElem1Select].options[Indexes[1]].value;
				var sElem2Parts = extractData(sElem2);
				var sElem2ID = sElem2Parts[0];
				
				if ( sElem2ID != null)
				{
					// show the third level select box
					sElem2Div = "gid-"+sElem2ID;
					sElem2Select = "gid-"+sElem2ID+"-groups";
					makeVisible(sElem2Div);
					
					if (Indexes[2] != -1) {
						// set third selection
						document.forms[0].elements[sElem2Select].selectedIndex = Indexes[2];
					}							
				}
			}
		}
	}
	return;
}

function hideGroups(Indexes) 
{
	var curElem;
	var nextElem;
	
	if (Indexes[0] != -1)
	{
		curElem = document.forms[0].elements["gid-0-groups"];
		
		// get old first element
		var sElem1 		= curElem.options[Indexes[0]].value;
		var sElem1Parts = extractData(sElem1);
		var sElem1ID 	= sElem1Parts[0];
		
		if ( sElem1ID != null)
		{
			// hide the second level select box
			sElem1Div = "gid-"+sElem1ID;
			sElem1Select = "gid-"+sElem1ID+"-groups";
			
			// alert('div: '+sElem1Div);
			
			makeInvisible(sElem1Div);
			
			if (Indexes[1] != -1)
			{
				curElem = document.forms[0].elements[sElem1Select];
				
				// get old second element
				var sElem2 		= curElem.options[Indexes[1]].value;
				var sElem2Parts = extractData(sElem2);
				var sElem2ID 	= sElem2Parts[0];
				
				if ( sElem2ID != null)
				{
					// hide the third level select box
					sElem2Div = "gid-"+sElem2ID;
					sElem2Select = "gid-"+sElem2ID+"-groups";
					
					// alert('div: '+sElem1Div);
					
					makeInvisible(sElem2Div);
				}
			}
		}
	}
	return;
}

function loadPath() {
	// load group path
	
	if (document.forms[0].elements['lastpath'] != null)
	{
		var lastpath = document.forms[0].elements['lastpath'].value;
		
		if (lastpath != '')	{		
			var Indexes = new Array();
			Indexes = lastpath.split(":");
		}
		else {
			var Indexes = new Array(-1,-1,-1);
		}
		
		// alert('lastpath - load: '+lastpath);
		
		return Indexes;
	}
	
	var Indexes = new Array(-1,-1,-1);
	return Indexes;	
}

function savePath(Indexes) {
	// save group path
	
	// alert('length: '+Indexes.length);
	
	if (document.forms[0].elements['lastpath'] != null)
	{
		var path = Indexes.join(':');
		document.forms[0].elements['lastpath'].value = path;
		
		// alert('lastpath - save: '+path);
		
		return true;
	}
	return false;
}


function extractData(datastring) {
	if (datastring != '')
	{
		var Data = datastring.split(":");
		return Data;
	}
	return false;
}

function copyData(groupData)
{
	if (groupData.length == 3) {
		document.forms[0].elements["currentid"].value = groupData[0];
		document.forms[0].elements["currentname"].value = groupData[1];
		document.forms[0].elements["currentowner"].value = groupData[2];
		return true;
	}
	return false;
}

function checkParameter()
{
	// check whether we need an input box for a parameter
	var currentAction = document.forms[0].elements["action"].value;
	
	if (currentAction == 'rename' || currentAction == 'addgroup' || currentAction == 'addsubgroup') {
		document.getElementById('parameter').style.visibility = 'visible';
	}
	else {
		document.getElementById('parameter').style.visibility = 'hidden';
	}
	
	if (currentAction != 'nothing') {
		document.getElementById('commit').style.visibility = 'visible';
	}
	
	return;
}

function switchToAndSelect(currentlevel, currentid) 
{
	// alert ('currentlevel: '+currentlevel+', currentid: '+currentid);
	// alert (document.forms[0].elements["gid-0-groups"].options[0].value);
	
	var curElemSelect = "gid-"+currentid+"-groups";
	var curElem = document.forms[0].elements[curElemSelect];
	
	// check for hint element - if present, delete it
	if (curElem.options[curElem.length - 1].value == -1)
	{
		curElem.options[curElem.length - 1] = null;
	}
	
	var Indexes = loadPath();
	
	/*
	for (i in Indexes) {
		alert ('Indexes['+i+'] = '+Indexes[i]);
	}
	*/
	
	// if there are any old selection boxes, hide them
	hideGroups(Indexes);
	
	// update path - everything right of current element is marked with -1
	
	Indexes[currentlevel] = document.forms[0].elements[curElemSelect].selectedIndex;
	
	for (i = currentlevel + 1; i < 3; i++) {
		Indexes[i] = -1;
	}
	
	/*
	for (i in Indexes) {
		alert ('Indexes['+i+'] = '+Indexes[i]);
	}
	*/
			
	// show new selection boxes
	showGroups(Indexes);
	
	// copy the data to the operation fields
	var groupData = extractData(document.forms[0].elements[curElemSelect].value);
	
	copyData(groupData);
	
	// we need the level when we delete something
	document.forms[0].elements["currentlevel"].value = currentlevel;
	
	// store path
	savePath(Indexes);
	
	return;
}

function restoreSelection(groupid, lastpath, userid, iseditor) 
{
	// alert ('currentlevel: '+currentlevel+', currentid: '+currentid);
	// alert (document.forms[0].elements["gid-0-groups"].options[0].value);
	
	if (lastpath != '')
	{
		var grouplevel = '';
		var curElem;
		
		// extract selections
		var Indexes = extractData(lastpath);
		
		if (Indexes[0] != -1)
		{
			curElem = document.forms[0].elements["gid-0-groups"];
			
			// set first selection and get the corresponding data
			curElem.selectedIndex = Indexes[0];
			
			// check for hint element - if present, delete it
			if (curElem.options[curElem.length - 1].value == -1)
			{
				curElem.options[curElem.length - 1] = null;
			}
			
			var sElem1 		= curElem.options[Indexes[0]].value;
			var sElem1Parts = extractData(sElem1);
			var sElem1ID 	= sElem1Parts[0];
			
			// set grouplevel and copy groupdata
			grouplevel = 0;
			copyData(sElem1Parts);
			
			if ( sElem1ID != null)
			{
				// show the second level select box
				sElem1Div = "gid-"+sElem1ID;
				sElem1Select = "gid-"+sElem1ID+"-groups";
				makeVisible(sElem1Div);
				
				if (Indexes[1] != -1)
				{
					curElem = document.forms[0].elements[sElem1Select];
					
					// set second selection and get the corresponding data
					curElem.selectedIndex = Indexes[1];
					
					// check for hint element - if present, delete it
					if (curElem.options[curElem.length - 1].value == -1)
					{
						curElem.options[curElem.length - 1] = null;
					}
					
					var sElem2 = curElem.options[Indexes[1]].value;
					var sElem2Parts = extractData(sElem2);
					var sElem2ID = sElem2Parts[0];
					
					// set grouplevel and copy groupdata
					grouplevel = 1;
					copyData(sElem2Parts);
					
					if ( sElem2ID != null)
					{
						// show the third level select box
						sElem2Div = "gid-"+sElem2ID;
						sElem2Select = "gid-"+sElem2ID+"-groups";
						makeVisible(sElem2Div);
						
						if (Indexes[2] != -1) 
						{
							
							curElem = document.forms[0].elements[sElem2Select];
					
							// set third selection and get the corresponding data
							curElem.selectedIndex = Indexes[2];
							
							// check for hint element - if present, delete it
							if (curElem.options[curElem.length - 1].value == -1)
							{
								curElem.options[curElem.length - 1] = null;
							}
							
							var sElem3 = curElem.options[Indexes[2]].value;
							var sElem3Parts = extractData(sElem3);
							
							// set grouplevel and copy groupdata
							grouplevel = 2;
							copyData(sElem3Parts);
						}							
					}
				}
			}
		}
		
		// store level information for the future
		document.forms[0].elements["currentlevel"].value = grouplevel;

		// re-get possible actions
		getActions(userid,iseditor)
			
		return true;
	}
	
	return false;
}

function showError(errormsg)
{
	alert(errormsg+"!");
	return false;
}

function copyEditValue(elementName,newValue)
{
	if (opener.document.forms["Main"].elements[elementName] != null) {
		opener.document.forms["Main"].elements[elementName].value = newValue;
	}
}

function storeInSession(sessionid, imageid, key1, value1, key2, value2)
{
	if (opener.frames['sessioncontrol'] != null) {
		var url = 'session_control.php?PHPSESSID='+sessionid+'&id='+imageid+'&key1='+escape(key1)+'&value1='+escape(value1)+'&key2='+escape(key2)+'&value2='+escape(value2);
		opener.frames['sessioncontrol'].location.href = url;
	}
}

function expandTextbox(elementName)
{
	if (opener.document.forms["Main"].elements[elementName] != null) {
		opener.document.forms["Main"].elements[elementName].style.height = '40px';
		opener.document.forms["Main"].elements[elementName].style.visibility = 'visible';
	}
}

function collapseTextbox(elementName)
{
	if (opener.document.forms["Main"].elements[elementName] != null) {
		opener.document.forms["Main"].elements[elementName].style.height = '0px';
		opener.document.forms["Main"].elements[elementName].style.visibility = 'hidden';
	}
}