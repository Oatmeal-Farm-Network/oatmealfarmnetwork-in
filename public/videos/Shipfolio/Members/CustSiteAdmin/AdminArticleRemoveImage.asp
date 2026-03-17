<!DOCTYPE HTML>

<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">

    <!--#Include file="AdminSecurityInclude.asp"-->
    <!--#Include file="AdminGlobalVariables.asp"--> 
    </head>
<body >


    <!--#Include file="AdminHeader.asp"--> 

<%


'rowcount = CInt
rowcount = 1

ImageID=Request.Form("ImageID") 
 rowcount =1
ImageName = "ArticleImage" & ImageID
CaptionName = "ImageCaption" & ImageID

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


Query =  " UPDATE Articles Set " & ImageName & " = '0' , " 
	Query =  Query & CaptionName & "  = '0'" 
	Query =  Query & " where ArticleID = " & Session("ArticleID") 

response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 

	  rowcount= rowcount +1


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 
Response.Redirect("AdminArticleMaintenance2.asp?ArticleID=" & Session("ArticleID"))
%>

	
 </Body>
</HTML>
