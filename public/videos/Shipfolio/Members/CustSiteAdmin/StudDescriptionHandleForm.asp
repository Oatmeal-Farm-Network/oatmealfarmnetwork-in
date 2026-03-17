<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Stud Description Handle Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

		<!--#Include virtual="/Administration/Dimensions.asp"-->
		<!--#Include virtual="/Administration/Header.asp"--> 
		<!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 

<%
ID=Request.Form("ID") 
StudDescription=Request.Form("StudDescription") 


dim Rightlength

Dim str1
Dim str2
str1 = StudDescription 
str2 = "'"
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1,  str2, "''")
	
End If  

str1 = StudDescription 
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1, str2 , "</br>")
End If  
	


StudDescription1 = Left(StudDescription, 1500)
response.write("StudDescription1=" & StudDescription1)

If Len(StudDescription ) < 1501 Then
	StudDescription2 = ""
Else
	Rightlength = Len(StudDescription ) - 1500
'	response.write("rl=" & rightlength)
	StudDescription2 = right(StudDescription , cint(Rightlength))
End If 

		Query =  " UPDATE MaleData Set StudDescription  = '" & StudDescription1 & "' " 
      Query =  Query & " where ID = " & ID & ";" 

		
response.write(Query)

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

DataConnection.Execute(Query) 
Query =  " UPDATE MaleData Set StudDescription2 = '" & StudDescription2 & "' " 
      Query =  Query & " where ID = " & ID & ";" 
DataConnection.Execute(Query) 

DataConnection.Close
Set DataConnection = Nothing 

	
response.redirect("EditAlpaca.asp?ID=" & ID)
%>

 </Body>
</HTML>
