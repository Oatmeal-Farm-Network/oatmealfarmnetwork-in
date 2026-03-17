<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>



<!--#Include file="MembersGlobalVariables.asp"-->
<% 
ProdID=Request.Form("ProdID") 

ProdDescription=Request.Form("ProdDescription") 


str1 = ProdDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdDescription= Replace(str1,  str2, "''")
End If 



  Query =  " UPDATE sfProducts Set "
  Query = Query  & " ProdDescription= '" & ProdDescription & "' "
  Query =  Query & " where prodID = " & ProdID & ";" 

response.write(Query)
Conn.Execute(Query) 

Conn.close
set conn=nothing %>

</head>
<body >
<% response.redirect("membersProductDescriptionFrame.asp?prodid=" & prodID & "&changesmade=True" ) %>


 </Body>
</HTML>