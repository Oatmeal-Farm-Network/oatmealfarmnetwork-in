<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title> Image</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


<!--#Include virtual="/Administration/Header.asp"--> 



<%

'rowcount = CInt
rowcount = 1
Redirect=Request.Form("Redirect") 
PageName=Request.Form("PageName") 
ImageID=Request.Form("OrientationImageID") 
response.write("ImageID=")
response.write(ImageID)
Orientation=Request.Form("Orientation") 
 rowcount =1
ImageName = "Image" & ImageID
OrientationName = "ImageOrientation" & ImageID

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

	Query =  " UPDATE PageLayout Set " & OrientationName & "= '" & Orientation & "' "
    Query =  Query & " where PageName = '" & PageName & "';"  
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
Response.Redirect(Redirect)
%>

	
 </Body>
</HTML>
