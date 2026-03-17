<!DOCTYPE html>
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<!--#Include file="AdminGlobalVariables.asp"-->
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>

<!--#Include virtual="/administration/adminHeader.asp"--> 
<% current = "Photos"
Current2="AlpacasHome"
Current3 = "UploadAlpacaEPD"%>
<%  if mobiledevice = False and screenwidth > 600 then %>
   <!--#Include file="AdminAnimalsTabsInclude.asp"-->
<% end if %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth%>">
<tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Upload Alpaca EPD CSV</div></H2>
 </td></tr>
<tr><td class = "roundedBottom body" align = "center" valign = "top" >
<blockquote>Upload your Alpaca CSV file below:<br /><br />

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" >
<tr><td class = "body" align = "left">	
<form action="AdminAlpacaEPDUploadhandle.asp" method="post" enctype="multipart/form-data" name="frmMain">  
Upload  
<input name="file1" type="file" class="regsubmit2">  
<input type="submit" name="Submit" value="Submit" class="regsubmit2">  
</form>  
</td></tr></table></blockquote>
</td></tr></table>
 <br /><br />
  <!-- #include virtual="/administration/adminFooter.asp" -->
 </Body>
</HTML>
