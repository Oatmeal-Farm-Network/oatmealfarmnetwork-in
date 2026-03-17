<!DOCTYPE html>
<%@ Language=VBScript %>
<% 
TempVideo = request.Form("TempVideo")
 VideogalleryCatID = request.form(" VideogalleryCatID")
%>
</HEAD>
<BODY>
<!--#Include virtual="/connloa.asp"-->
<%
PeopleID=  request.form("PeopleID")
ID = request.Form("ID")
TempVideo = Request.Form("TempVideo")
   
str1 = TempVideo
str2 = "'"
If InStr(str1,str2) > 0 Then
TempVideo= Replace(str1,  str2, "''")
end if

Query =  " UPDATE Photos Set AnimalVideo = '" &  TempVideo & "' " 
Query =  Query & " where ID = " & ID

connloa.Execute(Query) 
connloa.Close
Set connloa = Nothing 	
	

response.Redirect("MembersPhotos.asp?ID=" & ID & "#Video")
%>

</BODY>
</HTML>
