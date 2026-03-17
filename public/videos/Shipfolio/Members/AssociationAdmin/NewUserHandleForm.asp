<!DOCTYPE html>
<html>
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
</head>
<BODY   >
<%
PeopleID = Request.form("PeopleID") 

password =Request.Form("password") 
confirmpassword  =Request.Form("confirmpassword") 
AccessLevel=request.querystring("AccessLevel")

str1 = password
str2 = "'"
If InStr(str1,str2) > 0 Then
	password= Replace(str1,  str2, "''")
End If 

str1 = confirmpassword
str2 = "'"
If InStr(str1,str2) > 0 Then
	confirmpassword= Replace(str1,  str2, "''")
End If 


	Query =  "UPDATE People Set  Peoplepassword = '" &  password & "', ResetPassword = 0 "

    Query =  Query & " where PeopleID = " & PeopleID & ";" 


response.write("Query="	& Query )
Conn.Execute(Query) 
Conn.close
		Session("AccessLevel")= AccessLevel
		Session("PeopleID")= PeopleID
		Session("WebsiteAccess")=True
		Session.Timeout = 199

response.redirect("/Associationadmin/Default.asp")

 %>
<br><br><br>
</Body>
</HTML>