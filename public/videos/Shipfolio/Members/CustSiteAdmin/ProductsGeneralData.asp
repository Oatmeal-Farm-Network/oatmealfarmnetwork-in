<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ Language=VBScript %>

<HTML>
<HEAD>
 <title>Edit Pages</title>
       <link rel="stylesheet" type="text/css" href="style.css">
		


<% 

Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if
%>
</HEAD>

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


		<!--#Include file="Header.asp"-->
<!--#Include file="storeHeader.asp"--> 
		<!--#Include file="adminDetailDBInclude.asp"--> 
			<!--#Include file="ProductsGeneralDataInclude.asp"--> 

 
<!--#Include file="Footer.asp"--> </Body>
</HTML>