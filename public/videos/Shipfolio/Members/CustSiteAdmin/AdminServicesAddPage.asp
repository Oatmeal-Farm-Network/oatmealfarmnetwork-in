<!DOCTYPE HTML >
<HTML>
<HEAD>
<% 

Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if
%>
<link rel="stylesheet" type="text/css" href="/administration/style.css"> 
  <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% 
    TempCategoryType="For Sale"
%>  
 
 
    <!--#Include file="AdminHeader.asp"--> 
 <%  Current3 = "Categories"   %> 
<!--#Include virtual="/Administration/AdminServicesTabsInclude.asp"-->



	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "980"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Add a Service Pages</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width= "100%" >
	<tr>
	    <td width = "100%">
	    
	    

			<form action= 'AdminServiceCategoryAddHandleForm.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" width = "400">
		<tr>
		<td  class = "body" valign = "top" colspan = "2">
		<h2>Add a New Service Page</H2>
        </td>
      </tr>
      <tr>
        <td bgcolor = "#abacab" height = "1" colspan = "2"></td>
        </tr>
				<tr>
						<td width = "200" class = "body" align = "right">
							<div align = "right">Menu Title:</div>
					</td>
					<td class = "body">
							<input name="NewCategory" size = "30">
							<input name="Menutitle" type = "hidden" Value = "<%=TempCategoryType%>">
					</td>
			</tr>
			<tr>
					<td  align = "center" valign = "middle" colspan = "2" class = "body">
						<center><input type=submit value = "Add Category" size = "110" class = "regsubmit2" ></center>
					</td>
			</tr>
			</table>
			</form>

			<b></b>



   </td>
   </tr>

</table><br><br><br>
	    </td>
	</tr>
</table>

<br>
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>