function copy (groupid, groupname, groupowner, grouplastpath)
{
	opener.document.forms["Main"].elements["query[group]"].value = groupname;
	opener.document.forms["Main"].elements["query[groupid]"].value  = groupid;
	opener.document.forms["Main"].elements["query[groupowner]"].value  = groupowner;
	opener.document.forms["Main"].elements["query[grouplastpath]"].value  = grouplastpath;
	opener.document.forms["Main"].submit();
}