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
<% 
sql = "select distinct animals.*, Pricing.* from animals, Pricing where Animals.ID = Pricing.ID and sold = no order by speciesID, FullName"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1
Recordcount = rs.RecordCount +1
if not rs.eof Then
dim tempanimalID(9999)
dim tempName(9999)
row = "odd"
 While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
tempanimalID(rowcount) =   rs("animals.ID")
SpeciesID = rs("SpeciesID")
Breedlookupid  = rs("Breedlookupid")
tempName(rowcount) =   rs("FullName")
 If row = "even" Then %>
<tr bgcolor = "white">
<% Else %>
<tr bgcolor = "#e6e6e6">
<%End If %>
<td class = "body" height = "25" align = "left" width = "100%"><a href = "AdminAnimalEdit.asp?ID=<%= tempanimalID(rowcount)%>" class = "body"><%= tempName(rowcount)%></a></td>
</tr>
<% 
rowcount = rowcount + 1
rs.movenext
Wend
TotalCount=rowcount 
rs.close
end if %>
</table>
</body>
</html>