<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body >



<% ID= Request.QueryString("ID") 
		If Len(ID) < 1 then
			ID= Request.Form("ID") 
		End If 
 %>


<%
ID = Session("AnimalID")

'rowcount = CInt
rowcount = 1

ImageID=Request.Form("ImageID") 
 rowcount =1
ImageName = "Photo" & ImageID
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


Query =  " UPDATE Photos Set " & ImageName & " = '0'  " 
Query =  Query & " where ID = " & ID & ";" 

response.write(Query)	


'Set DataConnection = Server.CreateObject("ADODB.Connection")

'DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


Conn.Execute(Query) 

	rowcount= rowcount +1
'	DataConnection.Close
'	Set DataConnection = Nothing 
response.redirect("AdminPhotos.asp?ID=" & ID & "#" & ImageID)

%>

 </Body>
</HTML>
