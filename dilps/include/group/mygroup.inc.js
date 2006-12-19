function copy (groupid, groupname, groupowner, grouplastpath)
{
	opener.document.forms["Main"].elements["query[mygroup]"].value  = groupname;
	opener.document.forms["Main"].elements["query[mygroupid]"].value  = groupid;
	opener.document.forms["Main"].elements["query[mygroupowner]"].value  = groupowner;
	opener.document.forms["Main"].elements["query[mygrouplastpath]"].value  = grouplastpath;
	opener.document.forms["Main"].submit();
}

function conditionalcopy (groupid, groupname, groupowner, grouplastpath)
{
	if (opener.document.forms["Main"].elements["query[mygroupid]"].value != '')
	{
		opener.document.forms["Main"].elements["query[mygroup]"].value  = groupname;
		opener.document.forms["Main"].elements["query[mygroupid]"].value  = groupid;
		opener.document.forms["Main"].elements["query[mygroupowner]"].value  = groupowner;
		opener.document.forms["Main"].elements["query[mygrouplastpath]"].value  = grouplastpath;
		opener.document.forms["Main"].submit();
	}
	
}

function conditionalclearopener() 
{
	if (opener.document.forms["Main"].elements["query[mygroupid]"].value != '')
	{
		opener.document.forms["Main"].elements["query[mygroup]"].value = '';
		opener.document.forms["Main"].elements["query[mygroupid]"].value = '';
		opener.document.forms["Main"].elements["query[mygroupowner]"].value = '';
		opener.document.forms["Main"].elements["query[mygrouplastpath]"].value = '';
		opener.document.forms["Main"].submit();
	}
}