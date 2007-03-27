<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="cache-control" content="no-cache">
	<meta name="keywords" content="Bilddatenbanksystem, Bilddatenbank, Diathek, digitalisiert">
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<meta http-equiv="Content-Script-Type" content="text/javascript">
	<meta http-equiv="Content-Style-Type" content="text/css">
	<meta name="author" content="juergen enge, sebastian doeweling, thorsten wuebbena">
	<meta name="date" content="2007-03-16">
	<link rel="shortcut icon" href="favicon.ico">
	<title>. : DILPS : .</title>
	<link rel="stylesheet" type="text/css" href="resource/dilps.css">

	<script language="javascript">
	
		// Set the BaseURL to the URL of your camera
		var BaseURL = "http://132.199.135.201/";
		
		// This is the path to the image generating file inside the camera itself
		var File = "axis-cgi/jpg/image.cgi?resolution=1280x1024";
		
		function reloadImage()
		{
		  theDate = new Date();
		  var url = BaseURL;
		  url += File;
		  url += '&dummy=' + theDate.getTime().toString(10);
		  // The dummy above enforces a bypass of the browser image cache
		  // Here we load the image
		  document.theImage.src = url;
		
		}
	</script>
</head>
<body class="main" style="width: 100%;">
<table class="header" style="width: 100%;">
	<!-- heading line -->
	<tr>
		<td colspan="3">
			<div id="line_2" style="text-align: center;"> 
				<a class="heading" href="testCamera.php"><b>Johann Wolfgang Goethe-Universität Frankfurt / Bilderfassungs-System der Diathek</b></a>
			</div>
		</td>
	</tr>
	<!-- heading line end -->
	
	<tr>
		<td colspan="3" style="height: 40px;">&nbsp;
			
		</td>
	</tr>
	
	<!-- content -->
	<tr>
		<td style="vertical-align: top; text-align: center; width: 100%">
			<table class="query" cellspacing="0" cellpadding="0" style="width: 60%; vertical-align: top; text-align: center;">
				<tr>
					<td colspan="3">
						<img name="theImage" src="http://132.199.135.201/axis-cgi/jpg/image.cgi?resolution=1280x1024" height="320px" width="240px" alt="Camera image" onclick="reloadImage(); return true;">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<!-- content end -->
	
	<tr>
		<td colspan="3" style="height: 50px;">&nbsp;
			
		</td>

	</tr>

	<!-- footing line -->
	<tr>
		<td colspan="2">
			<div id="line_1" style="text-align: center; vertical-align: middle; margin-top: 3px;"> 
				<span style="font-size: 0.9em;"><b>Bitte den Barcode des Bildes scannen</b></span>
			</div>
		</td>

	</tr>
	<!-- footing line end -->
	
	<tr>
		<td colspan="3" style="height: 5px;">&nbsp;
			
		</td>
	</tr>
</table>

</body>
</html>