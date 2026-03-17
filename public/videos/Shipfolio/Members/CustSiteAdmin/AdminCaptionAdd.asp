<!DOCTYPE HTML>
<% ' Clean directory NEA 4/2012 %>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"-->
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">

 
    <!--#Include File="AdminHeader.asp"--> 
    <!--#Include File="AdminDetailDBInclude.asp"--> 

<%

dim Caption
Dim captionid

ID = Session("AnimalID")
'response.write (ID)

'rowcount = CInt
rowcount = 1

Caption=Request.Form("Caption") 
CaptionID=Request.Form("CaptionID") 
 rowcount =1
CaptionName = "PhotoCaption" & CaptionID
'Response.write("CaptionName=")
'Response.write(CaptionName)
str1 = CaptionName
str2 = ","
If InStr(str1,str2) > 0 Then
	CaptionName= Replace(str1, ",", "")
End If

str1 = Caption
str2 = "'"
If InStr(str1,str2) > 0 Then
	Caption= Replace(str1, "'", "''")
End If

Query =  " UPDATE Photos Set " & CaptionName & " = '" &  Caption & "' " 
	Query =  Query + " where ID = " & ID & ";" 

'response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 

	  rowcount= rowcount +1


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 

response.redirect("AdminPhotos.asp?ID=" & ID & "#" & CaptionID)
%>
 </Body>
</HTML>
