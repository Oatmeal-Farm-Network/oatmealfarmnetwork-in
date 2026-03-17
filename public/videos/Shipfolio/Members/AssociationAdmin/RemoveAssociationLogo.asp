<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Remove Logo</title>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<!--#Include file="AssociationGlobalVariables.asp"-->
<%
'rowcount = CInt
rowcount = 1
AssociationID = request.querystring("AssociationID")
pagelayoutid = Request.QueryString("pagelayoutid")
response.write("pagelayoutid=" & pagelayoutid )
PageDownloadsID=Request.querystring("PageDownloadsID") 
filenamex =Request.querystring("filename")
 rowcount =1
ImageName = "Image" & ImageID
CaptionName = "ImageCaption" & ImageID
PageLayout2ID = request.Form("PageLayout2ID")
'Response.write("CaptionName=")
'Response.write(CaptionName)


Query =  "Update associations set associationlogo ='' where associationID=" & associationID 


response.write(Query)	

Conn.Execute(Query) 

	  rowcount= rowcount +1

Conn.Close
Set Conn = Nothing 
Response.Redirect("AssociationLogo.asp?AssociationID=" & AssociationID )
 ' Response.write("filename =" & filename)
%>
</Body>
</HTML>
