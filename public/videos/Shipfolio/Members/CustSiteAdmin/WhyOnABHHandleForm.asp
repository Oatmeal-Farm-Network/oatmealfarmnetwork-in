<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Pricing Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

		<!--#Include virtual="/Administration/Dimensions.asp"-->
		<!--#Include virtual="/Administration/Header.asp"--> 
		<!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 



<%
'rowcount = CInt
rowcount = 1

ID=Request.Form("ID") 
WhyOnABH=Request.Form("WhyOnABH") 


Dim str1
Dim str2
str1 = WhyOnABH
str2 = "'"
If InStr(str1,str2) > 0 Then
	WhyOnABH= Replace(str1,  str2, "''")
	
End If  



Query =  " UPDATE Animals Set WhyOnABH = '" & WhyOnABH & "' " 
      Query =  Query + " where ID = " & ID & ";" 

'response.write(Query)





Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 



DataConnection.Execute(Query) 


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 


%>


		<!--#Include virtual="/administration/EditPagecontentInclude.asp"--> 


		<!--#Include virtual="/administration/Footer.asp"--></Body>
</HTML>

 </Body>
</HTML>
