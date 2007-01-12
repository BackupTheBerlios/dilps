function replaceNL(s) {
	// replace newlines and tabs with whitespaces
	r = "";
	
	for (i=0; i < s.length; i++) {
		if (s.charAt(i) != '\n' && s.charAt(i) != '\r' && s.charAt(i) != '\t') {
			r += s.charAt(i);
		}
		else {
			r += ' ';
		}
		
	}
	return r;
}

function restoreState(js_fieldnames, js_values)
{
	for (var i=0; i < js_fieldnames.length; i++)
	{
		var element = document.forms["Main"].elements[js_fieldnames[i]];
		if (element != null && js_values[i] != '')
		{
			if (element.type == 'textarea')
			{
				element.value = js_values[i];
			}

			if (element.type == 'checkbox')
			{
				element.checked = true;
			}
		}
	}
}


function saveSelection(elementName)
{
	var elements = document.forms["Main"].elements;
	
	var elnum = elements.length;
	
	// alert(elnum);
	
	var sel_names = new Array();
	var sel_values = new Array();
	
	for (var i=0; i < elnum; i++)
	{
		var name, type, value, checked;
		
		name = elements[i].name;
		type = elements[i].type;
		value = elements[i].value;
		checked = elements[i].checked;
		
		if ((type == 'textarea' && value != '') || (type == 'checkbox' && checked))
		{
			name_cleaned = replaceNL(name);
			value_cleaned = replaceNL(value);
			
			sel_names.push(name_cleaned);
			sel_values.push(value_cleaned);
		}
	}
	
	// alert("Namen: "+sel_names.length+", Werte: "+sel_values.length);
	
	var sel_names_string = sel_names.join('; ');
	var sel_values_string = sel_values.join('; ');
	
	/*
	for (i=0; i < sel_names.length; i++)
	{
		sel_names_string += sel_names[i]+"; ";
		sel_values_string += sel_values[i]+"; ";
	}
	*/
	
	var fn_index = "edit["+elementName+"_fn]";
		var val_index = "edit["+elementName+"]";
	
	opener.document.forms["Main"].elements[fn_index].value = sel_names_string;
	opener.document.forms["Main"].elements[val_index].value = sel_values_string;
	
	// alert("sel_names_string: "+sel_names_string);
	// alert("sel_values_string: "+sel_values_string);
	
}