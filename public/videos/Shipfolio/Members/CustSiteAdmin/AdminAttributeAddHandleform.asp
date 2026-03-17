<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include file="adminglobalvariables.asp"--> 
 <Link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<%

attrName=Request.Form("attrName")
attrDisplayOrder=Request.Form("attrDisplayOrder=") 
attrControltype=Request.Form("attrControltype") 
attrRequired=Request.Form("attrRequired") 
attrAvailableToAllProds=Request.Form("attrAvailableToAllProds") 
attrCatagoryId=Request.Form("attrCatagoryId") 
attrExtraCostAllowed=Request.Form("attrExtraCostAllowed") 

str1 = attrName
str2 = "'"
If InStr(str1,str2) > 0 Then
attrName= Replace(str1, "'", "''")
End If



sql = "select * from sfattributes "  
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
If not rs.eof  then
attrDisplayOrder = rs.recordcount + 1
else
attrDisplayOrder =1
End If


Query =  "INSERT INTO sfattributes  (attrName, attrDisplayOrder, attrControltype, attrRequired, attrAvailableToAllProds, attrCatagoryId, attrExtraCostAllowed  )" 

Query =  Query & " Values ('" &  attrName & "'," &  attrDisplayOrder & ", '" &  attrControltype & "' ," & attrRequired & "," &  attrAvailableToAllProds & "," & attrCatagoryId & "," & attrExtraCostAllowed  & ")"
response.write("Query=" & Query)
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 

response.Redirect("AdminProductsAttributesSet.asp")
%>
</Body>
</HTML>