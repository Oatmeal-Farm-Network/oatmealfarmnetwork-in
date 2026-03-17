<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Caption</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


<!--#Include virtual="/Administration/Header.asp"--> 



<%

'rowcount = CInt
rowcount = 1

ImageID=Request.Form("CaptionImageID") 
response.write("ImageID=")
response.write(ImageID)
Caption=Request.Form("Caption") 
 rowcount =1
ImageName = "Image" & ImageID
CaptionName = "ImageCaption" & ImageID
ArticleID=Request.Form("ArticleID") 
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

	

	Query =  " UPDATE Articles Set " & CaptionName & " = '" & Caption & "' "
	Query =  Query + " where ArticleID = " & ArticleID & ";" 
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
	redirectname = "ArticleMantainance2.asp?ArticleID=" & ArticleID

Response.Redirect(redirectname)
%>

	
 </Body>
</HTML>
