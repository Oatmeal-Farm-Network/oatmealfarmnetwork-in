<html>
<head>
<!--#Include file="AdminFrameGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<link rel="stylesheet" type="text/css" href="style.css">
<base target="_parent"> 
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<table border = 0 cellspacing = 0 cellpadding = 0 width = 182 >
<% Dim TempProdName(100000)
Dim TempProdID(100000) 
sql = "select * from sfProducts "
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1
Recordcount = rs.RecordCount +1
if not rs.eof Then 
row = "odd"
 While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
TempProdName(rowcount)=rs("ProdName") 
TempProdID(rowcount) =rs("ProdID")
If row = "even" Then %>
<tr bgcolor = "white">
<% Else %>
<tr bgcolor = "#e6e6e6">
<% End If %>
<td class = "body" valign = "top" height = "25" width = " <%=screenwidth - 710 %>" valign = "top"><a href = "AdminAdEdit2.asp?ProdID=<%= TempProdID( rowcount)%>" class = "body" ><%= TempProdName(rowcount)%></a></td></tr>
<% 
rowcount = rowcount + 1
rs.movenext
Wend
TotalCount=rowcount 
rs.close
%>
</table>
<% end if %>

</body>
</html>