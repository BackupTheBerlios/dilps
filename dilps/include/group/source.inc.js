function copy (groupid, groupname, groupowner, grouplastpath)
{
	opener.document.forms["Main"].elements["source[group]"].value = groupname;
	opener.document.forms["Main"].elements["source[groupid]"].value  = groupid;
	opener.document.forms["Main"].elements["source[groupowner]"].value  = groupowner;
	opener.document.forms["Main"].elements["source[grouplastpath]"].value  = grouplastpath;
	opener.document.forms["Main"].submit();
}

function conditionalcopy (groupid, groupname, groupowner, grouplastpath)
{
	if (opener.document.forms["Main"].elements["source[groupid]"].value != '')
	{
		opener.document.forms["Main"].elements["source[group]"].value = groupname;
		opener.document.forms["Main"].elements["source[groupid]"].value  = groupid;
		opener.document.forms["Main"].elements["source[groupowner]"].value  = groupowner;
		opener.document.forms["Main"].elements["source[grouplastpath]"].value  = grouplastpath;
		opener.document.forms["Main"].submit();
	}
}


function conditionalclearopener() {
	if (opener.document.forms["Main"].elements["source[groupid]"].value != '')
	{
		opener.document.forms["Main"].elements["source[group]"].value = '';
		opener.document.forms["Main"].elements["source[groupid]"].value = '';
		opener.document.forms["Main"].elements["source[groupowner]"].value = '';
		opener.document.forms["Main"].elements["source[grouplastpath]"].value = '';
		opener.document.forms["Main"].submit();
	}
}