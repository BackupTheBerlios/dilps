function copy1 (groupid, groupname, groupowner)
{
	opener.document.forms["Main"].elements["query[group1]"].value = groupname;
	opener.document.forms["Main"].elements["query[group1id]"].value = groupid;
	opener.document.forms["Main"].elements["query[group1owner]"].value  = groupowner;
}

function copy2 (groupid, groupname, groupowner)
{
	opener.document.forms["Main"].elements["query[group2]"].value = groupname;
	opener.document.forms["Main"].elements["query[group2id]"].value = groupid;
	opener.document.forms["Main"].elements["query[group2owner]"].value  = groupowner;
}

function copy3 (groupid, groupname, groupowner)
{
	opener.document.forms["Main"].elements["query[group3]"].value = groupname;
	opener.document.forms["Main"].elements["query[group3id]"].value = groupid;
	opener.document.forms["Main"].elements["query[group3owner]"].value  = groupowner;
}