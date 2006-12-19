function copy (groupid, groupname, groupowner, grouplastpath)
{
	opener.document.forms["Main"].elements["query[group]"].value = groupname;
	opener.document.forms["Main"].elements["query[groupid]"].value  = groupid;
	opener.document.forms["Main"].elements["query[groupowner]"].value  = groupowner;
	opener.document.forms["Main"].elements["query[grouplastpath]"].value  = grouplastpath;
	opener.document.forms["Main"].submit();
}

function conditionalcopy (groupid, groupname, groupowner, grouplastpath)
{
	if (opener.document.forms["Main"].elements["query[groupid]"].value != '')
	{
		opener.document.forms["Main"].elements["query[group]"].value = groupname;
		opener.document.forms["Main"].elements["query[groupid]"].value  = groupid;
		opener.document.forms["Main"].elements["query[groupowner]"].value  = groupowner;
		opener.document.forms["Main"].elements["query[grouplastpath]"].value  = grouplastpath;
		opener.document.forms["Main"].submit();
	}
}


function conditionalclearopener() {
	if (opener.document.forms["Main"].elements["query[groupid]"].value != '')
	{
		opener.document.forms["Main"].elements["query[group]"].value = '';
		opener.document.forms["Main"].elements["query[groupid]"].value = '';
		opener.document.forms["Main"].elements["query[groupowner]"].value = '';
		opener.document.forms["Main"].elements["query[grouplastpath]"].value = '';
		opener.document.forms["Main"].submit();
	}
}