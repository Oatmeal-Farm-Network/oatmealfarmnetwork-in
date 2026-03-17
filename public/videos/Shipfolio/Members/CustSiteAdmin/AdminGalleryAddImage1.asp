<!DOCTYPE HTML>

<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
    
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
    <!--#Include File="AdminHeader.asp"--> 
        <%    Current3="AddImages" %> 
        
 <% if mobiledevice = False  then %>
<!--#Include file="AdminGalleryTabsInclude.asp"-->
   	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35  %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Add a Gallery Image - Step 1: Upload Gallery Image</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">
        
     
	
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%"  align = "center"  valign = "top">
		<tr>
			<td class = "body2"><br /><br />
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminGalleryImage2.asp" >
						Upload Image: <input name="attach1" type="file" size=55 class = "Submit">
						<center><input  type=submit value="Upload" class = "regsubmit2 body2"></center>
					</form>
			</td>
			</tr>
		</table>
<br><br></td>
			</tr>
		</table>
		
	<% else %>	
		
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td  align = "left" class = "body2">
<H2>Add a Gallery Image</div></H2>
        
<br /><br />
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminGalleryImage2.asp" >
						<b>Upload Image:</b><br /> <input name="attach1" type="file" size=55  class = "regsubmit2 body"><br />
						<center><input  type=submit value="Upload" class = "regsubmit2 body2"></center>
					</form>
		</td>
			</tr>
		</table>
<br>	<br>	<br>
<% end if %><br>

  <!-- #include File="AdminFooter.asp" -->
 </Body>
</HTML>
