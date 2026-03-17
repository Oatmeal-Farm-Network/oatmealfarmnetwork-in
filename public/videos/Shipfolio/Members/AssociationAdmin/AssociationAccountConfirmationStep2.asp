<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us">
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include virtual="/conn.asp"-->
<% 
Password = Trim(Request.Form("Password"))
Password2 = Trim(Request.Form("Password2"))
'response.write("Password=" & password)
'response.write("Password2=" & password2)
AssociationID = Trim(Request.Form("AssociationID"))
PeopleId = Request.Form("PeopleId")
'response.write("ActivationCode=" & ActivationCode)

errorstring1=""
errorstring2=""
emailerror = False
Passworderror = False
ActivationCodeerror = False


Passwordlengtherror = False
If len(Trim(Password)) < 8 Then
	Passwordlengtherror = true
End If 

If Not(Trim(Password) = Trim(Password2)) Then
	Passworderror = true
End If 

response.write("Passworderror=" & Passworderror)
response.write("peopleID=" & peopleID)
If Passworderror = False then

'If len(peopleID) < 1 Then

Query =  "UPDATE People Set PeoplePassword = '" & Password & "', Accesslevel = 1 " 
Query =  Query & " where PeopleID = " & PeopleID & ";" 
response.write("Query=" & query)
Conn.Execute(Query)

'end if
 End if


If  Passworderror = True  Or Passwordlengtherror = True  Then 
	redirectString = "AssociationAccountConfirmation.asp?Passwordlengtherror=" & Passwordlengtherror & "&Passworderror=" & Passworderror & "&AssociationID=" & AssociationID & "&PeopleID=" & PeopleID  
	response.redirect(redirectString)
else
Session("MemberAccessLevel")= 3
Session("AssociationID")= AssociationID
Session("PeopleID")= PeopleID
Session("WebsiteAccess")=True
response.redirect("/Associationadmin/Default.asp?Welcome=True&AssociationID=" & AssociationID & "&PeopleID=" & PeopleID )
end if	



%>

</body>
</html>