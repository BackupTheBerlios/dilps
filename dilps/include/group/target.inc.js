function copy (groupid, groupname, groupowner, grouplastpath)
{
	opener.document.forms["Main"].elements["target[group]"].value = groupname;
	opener.document.forms["Main"].elements["target[groupid]"].value  = groupid;
	opener.document.forms["Main"].elements["target[groupowner]"].value  = groupowner;
	opener.document.forms["Main"].elements["target[grouplastpath]"].value  = grouplastpath;
	opener.document.forms["Main"].submit();
}

function conditionalcopy (groupid, groupname, groupowner, grouplastpath)
{
	if (opener.document.forms["Main"].elements["target[groupid]"].value != '')
	{
		opener.document.forms["Main"].elements["target[group]"].value = groupname;
		opener.document.forms["Main"].elements["target[groupid]"].value  = groupid;
		opener.document.forms["Main"].elements["target[groupowner]"].value  = groupowner;
		opener.document.forms["Main"].elements["target[grouplastpath]"].value  = grouplastpath;
		opener.document.forms["Main"].submit();
	}
}


function conditionalclearopener() {
	if (opener.document.forms["Main"].elements["target[groupid]"].value != '')
	{
		opener.document.forms["Main"].elements["target[group]"].value = '';
		opener.document.forms["Main"].elements["target[groupid]"].value = '';
		opener.document.forms["Main"].elements["target[groupowner]"].value = '';
		opener.document.forms["Main"].elements["target[grouplastpath]"].value = '';
		opener.document.forms["Main"].submit();
	}
}