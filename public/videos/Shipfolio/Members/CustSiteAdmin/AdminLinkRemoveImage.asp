<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">



<!--#Include file="AdminSecurityInclude.asp"--> 
<!--#Include file="AdminGlobalVariables.asp"--> 

<%

LinkID = Session("LinkID")
LinkText =Session("LinkText")

'rowcount = CInt
rowcount = 1

ImageID=Request.Form("ImageID") 
 rowcount =1
ImageName = "Image" & ImageID
CaptionName = "PhotoCaption" & ImageID

'Response.write("CaptionName=")
'Response.write(CaptionName)

str1 = ImageName
str2 = ","
If InStr(str1,str2) > 0 Then
	ImageName= Replace(str1, ",", "")
End If


str1 = CaptionName
str2 = ","
If InStr(str1,str2) > 0 Then
	CaptionName= Replace(str1, ",", "")
End If

	Query =  " UPDATE links Set linkimage = '' " 
	Query =  Query & " where LinkID = " & LinkID & ";"  

response.write(Query)	
response.write("DatabasePath=" & DatabasePath)	

Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 

	  rowcount= rowcount +1


	DataConnection.Close
	Set DataConnection = Nothing 

response.redirect("AdminLinkphotos.asp?linkId=" & LinkID)
		

%>

 
 </Body>
</HTML>
