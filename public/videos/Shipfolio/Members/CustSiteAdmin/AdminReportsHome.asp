<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>


<!--#Include virtual="/Administration/Header.asp"--> 
 
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "780" bgcolor = "antiquewhite">
			<tr>
		<td align = "center"  colspan = "2"><img src = "images/ReportsHeader.jpg" width = "780"></td>
	</tr>
		<tr>
		    <td class = "body" valign = "top" align = "left"><blockquote>
			<br><br>Below is the report(s) that are currently available:
			<br>
			<br>
			
			<a href = "ReportSaleList.asp" class = "body" target = "blank">Printable Complete Sales List</a><br>
			<a href = "ReportAnimalSalesPage.asp" class = "body" >Printable Individual Animal Sales Page</a></blockquote>

			
			</td>
			<td bgcolor = "#C0A176" width = "250" height = "200" class = "body" valign = "top">
			<h2>Upload Your Logo</h2>
			 (JPG, PNG, or GIF format only!)<br>
			Some reports have include your logo. To have it show up you need to upload your logo first.<br>
			<a href = "uploadlogo.asp" class = "body">Click here upload your Logo</a>
			<br>
				<br><h2>Printing Suggestion</h2>You may need to make changes to your browsers page setup settings to perfect how your reports look up to you.<br><br>
				
				In Internet explorer go to Print>Page Setup to make changes to the page settings.
				</td>

		</tr>
	</table>
<br><br><br>

 <!--#Include file="Footer.asp"--> 
</BODY>
</HTML>