<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include file="MembersGlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> Online Animal Marketplace</title>
<meta name="Title" content="Create Account - <%=WebSiteName %> Online Animal Marketplace">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="/Style.css">

<% '********************************************************************************
showcoupons = false


Membership = Request.Form("Membership")
if len(Membership) > 0 then
else
Membership = Request.querystring("Membership")
end if

if len(Membership) > 0 then
else
Membership = session("Membership")
end if

if len(Membership) > 0 then
session("Membership") = Membership
end if

Membership = lcase(Membership)

website = request.querystring("website") 

if len(website) > 0 then
else
website = request.form("website") 
end if

websitesignupcount = 0


if len(Businessemail) > 0  then
session("Businessemail") = BusinessEmail
else
Businessemail =Request.querystring("BusinessEmail") 
end if

if len(Businessemail) > 0  then
session("Businessemail") = BusinessEmail
else
Businessemail =session("Businessemail")
end if




%>
</head>
<body >




<% BusinessID = Request.querystring("BusinessID")
'if len(BusinessID) > 0 then
'else
'BusinessID = Request.form("BusinessID")
'end if 


associations = Request.querystring("associations")
if len(associations) > 0 then
else
associations = Request.form("associations")
end if 

response.write("<br>associations=" & associations & "<br>" )

Query =  "Delete from associationmembers where BusinessID = " & BusinessId & " and Accesslevel = 1 "
response.write("Query=" & Query )
conn.Execute(Query) 


if not len(associations) > 1 then


Query =  "update Business set  FavoriteAssocitaionID= 0 where Businessid =  " & BusinessID
response.write("Query=" & Query )
conn.Execute(Query) 

else


strAryWords = Split(associations, ", ")
For i = 0 to Ubound(strAryWords)
'Response.Write strAryWords(i) & "<BR>"
Found = False

sql = "select * from associationmembers where BusinessID = " & BusinessId & " and AssociationId = " & trim(strAryWords(i))
response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
 Found = True
end if

response.write("Found=" & Found & "<br>" )
If Found = False then
Query =  "INSERT INTO associationmembers (BusinessID, AssociationID, MemberPosition, Accesslevel) "
Query =  Query & " Values (" & BusinessID & " , " & strAryWords(i) & ", 'General Member' , 1)"
response.write("<br>Query=" & Query & "<br>" )
conn.Execute(Query) 
end if

Next
end if


if rs.state = 0 then
else
rs.close
end if

sql = "select COUNT(*) as count from associationmembers where BusinessID = " & BusinessId 
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
 associationcount = rs("count")
end if
rs.close


 
donationshown = False
 %>


<% if cint(associationcount) = 1 and len(associations) > 1 and donationshown = False then 

strAryWords = Split(associations, ", ")

FavoriteAssocitaionID = cint(trim(strAryWords(0)))


sql = "select associationname from associations where associationid = " & FavoriteAssocitaionID
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
 FavoriteAssocitaionName = rs("associationname")
end if


Query =  "Update Associationmembers set favorite = 1 where BusinessID = " & Businessid & " and associationid = " & FavoriteAssocitaionID & " "
Conn.Execute(Query)  

Query =  "Update Business set FavoriteAssocitaionID = " & FavoriteAssocitaionID & " where BusinessID = " & Businessid 
Conn.Execute(Query)  

 end if 
 
 
response.redirect("MembersAssociations.asp?BusinessID=" & BusinessId & "&changesmade=true" )  %>



</Body>