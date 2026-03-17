<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Remove Image</title>
       <link rel="stylesheet" type="text/css" href="style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

<!--#Include file="globalvariables.asp"--> 
<!--#Include File="Header.asp"--> 

<%

'rowcount = CInt
rowcount = 1
PageLayout2ID=Request.Form("PageLayout2ID") 
filename=Request.Form("filename")
 rowcount =1
ImageName = "Image" & ImageID
CaptionName = "ImageCaption" & ImageID
PageLayout2ID = request.Form("PageLayout2ID")

Query =  " UPDATE EventPagelayout2 Set Upload = '0'  " 
Query =  Query & " where PageLayout2ID = " & PageLayout2ID & "" 
Conn.Execute(Query) 
	  rowcount= rowcount +1
	Conn.Close
	Set Conn = Nothing 
Response.Redirect(filename & "&EventID=" & EventID)

%>

	
 </Body>
</HTML>
