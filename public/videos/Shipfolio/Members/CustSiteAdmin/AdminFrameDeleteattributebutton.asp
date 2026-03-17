<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<!--#Include file="AdminConn.asp"-->
</head>
<body>
<% 
attrDetailID=request.querystring("attrDetailID")
ProdID=request.querystring("ProdID")
%>


<table width = "60" cellpadding = "0" cellspacing = "0" border = "0" >
<tr><td align = 'absbottom'>
<form action= 'AdminProductAttributedelete.asp?TempattrDetailID=<%=attrDetailID %>&ProdID=<%=ProdID %>' method = "post">
<input type=submit value="Delete" class = "regsubmit2">
</form>
</td></tr></table>
</body>
</html>