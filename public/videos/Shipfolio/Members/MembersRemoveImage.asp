<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Pricing Page</title>
       <link rel="stylesheet" type="text/css" href="//style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="Membersglobalvariables.asp"--> 

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

Query =  " UPDATE Photos Set " & ImageName & " = '0' , " 
Query =  Query & CaptionName & "  = '0'" 
Query =  Query & " where ID = " & ID & ";" 

Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 

response.Redirect("Membersphotos.asp?id=" & ID )
%>
</Body>
</HTML>
