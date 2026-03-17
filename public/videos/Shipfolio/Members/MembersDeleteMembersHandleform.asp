<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</HEAD>

<body >

<!--#Include file="MembersGlobalVariables.asp"-->
<% Current1="Products"
Current2 = "DeleteProduct" %> 
<!--#Include file="MembersHeader.asp"-->

<%

dim AssociationMemberID

AssociationMemberID=Request.Form("AssociationMemberID") 

If Len(AssociationMemberID)  > 0 then
	Query =  "Delete From associationmembers where associationID=" & session("associationID") & " and AssociationMemberID = " &  AssociationMemberID & "" '
	'response.write(Query)
	Conn.Execute(Query) 
end if
Set Conn = Nothing
 
 Response.redirect("DeleteUser.asp?Message=The user has successfully been deleted.")
 %>
 

 </Body>
</HTML>
