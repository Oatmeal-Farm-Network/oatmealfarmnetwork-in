<!DOCTYPE HTML >
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
 <!--#Include virtual="/connloa.asp"--> 

<% ID= Request.QueryString("ID") 
If Len(ID) < 1 then
ID= Request.Form("ID") 
End If 
ID = Session("AnimalID")

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
connLOA.Execute(Query) 
connLOA.Close
Set connLOA = Nothing 
response.redirect("MembersPhotos.asp?ID=" & ID & "#" & ImageID)

%>

 </Body>
</HTML>
