<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
<BODY >

<!--#Include virtual="/conn.asp"--> 



<%
filename=Request.Querystring("filename")
ReturnPage= Request.form("ReturnPage") 
JudgeID=Request.Form("JudgeID")
 rowcount =1
ImageName = "Image" & ImageID
CaptionName = "ImageCaption" & ImageID
PageLayout2ID = request.Form("PageLayout2ID")
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


Query =  " UPDATE Judges Set JudgeImage = '0'  " 
Query =  Query & " where JudgeID = " & JudgeID & "" 


response.write(Query)	

Conn.Execute(Query) 

	  rowcount= rowcount +1


	Conn.Close
	Set Conn = Nothing 
	
	
	 if len(ReturnPage) > 1 then
  response.redirect(ReturnPage)
else
response.redirect("ContactsEdit.asp?JudgeID=" & JudgeID )
end if 

%>

	
 </Body>
</HTML>
