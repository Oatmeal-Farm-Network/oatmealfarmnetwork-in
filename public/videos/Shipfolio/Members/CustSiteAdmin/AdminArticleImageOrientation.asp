<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body >


    <!--#Include File="AdminHeader.asp"--> 

<%

'rowcount = CInt
rowcount = 1

ImageID=Request.Form("OrientationImageID") 
response.write("ImageID=")
response.write(ImageID)
Orientation=Request.Form("Orientation") 
 rowcount =1
ImageName = "Image" & ImageID
OrientationName = "ImageOrientation" & ImageID
PageName=Request.Form("PageName") 

'Response.write("OrientationName=")
'Response.write(OrientationName)

str1 = ImageName
str2 = ","
If InStr(str1,str2) > 0 Then
	ImageName= Replace(str1, ",", "")
End If


str1 = OrientationName
str2 = ","
If InStr(str1,str2) > 0 Then
	OrientationName= Replace(str1, ",", "")
End If

	Query =  " UPDATE Articles Set " & OrientationName & "= '" & Orientation & "' "
    Query =  Query & " where ArticleID = " & Session("articleID")  
	response.write(Query)	



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


Response.Redirect("AdminArticleMaintenance2.asp?ArticleID=" & Session("ArticleID") & "#TextBlock" & ImageID)
%>

	
 </Body>
</HTML>
