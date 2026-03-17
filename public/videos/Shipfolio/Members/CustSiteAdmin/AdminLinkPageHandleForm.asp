<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
<%
'rowcount = CInt
rowcount = 1

Dim TextBlock
Dim Heading
Dim Text
Returnpage = Request.Form("Returnpage")

PageTitle= Request.Form("PageTitle")
LinkName= Request.Form("LinkName")
CatID = Request.Form("CatID")
PageText= Request.Form("PageText")
PageLayoutID = Request.Form("PageLayoutID")
response.Write("ReturnTextBlock=" & ReturnTextBlock )

Dim str1
Dim str2
	
str1 = PageText
str2 = "'"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "''")
End If  

str1 = PageTitle
str2 = "?"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "")
End If  

str1 = PageTitle
str2 = "&"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "")
End If  
str1 = PageTitle
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "</br>")
End If  

str1 = PageTitle
str2 = vbtab
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 

str1 = PageTitle
str2 = vbVerticalTab
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 

str1 = PageTitle
str2 = vbLf 
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "&nbsp;")
End If 

str1 = PageTitle
	str2 = vbCr
	If InStr(str1,str2) > 0 Then
		PageTitle= Replace(str1,  str2, "</br>")
	End If  

	str1 = PageTitle
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		PageTitle= Replace(str1,  str2, "</br>")
	End If  

	str1 =PageTitle
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		PageTitle= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = PageTitle
	str2 =vbNewline
	If InStr(str1,str2) > 0 Then
		PageTitle= Replace(str1,  str2, "</br>")
	End If  

	str1 = PageText
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		PageText= Replace(str1,  str2, "''")
	End If  

	str1 = PageText
	str2 = vbCr
	If InStr(str1,str2) > 0 Then
		'PageText= Replace(str1,  str2, "</br>")
	End If  

	str1 = PageText
	str2 = vbtab
	If InStr(str1,str2) > 0 Then
		PageText= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = PageText
	str2 = vbVerticalTab
	If InStr(str1,str2) > 0 Then
		PageText= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = PageText
	str2 = vbLf 
	If InStr(str1,str2) > 0 Then
	'	PageText= Replace(str1,  str2, "&nbsp;")
	End If 



	str1 = PageText
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		'PageText= Replace(str1,  str2, "</br>")
	End If  

	str1 = PageText
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		PageText= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = PageText
	str2 =vbNewline
	If InStr(str1,str2) > 0 Then
		'PageText= Replace(str1,  str2, "</br>")
	End If  



	str1 =Heading
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "''")
	End If  

	str1 = Heading
	str2 = vbCrLf
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  

	str1 = Heading
	str2 = vbtab
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 =Heading
	str2 = vbVerticalTab
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = Heading
	str2 = vbLf 
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = Heading
	str2 = vbCr
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  

	str1 = Heading
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  

	str1 = Heading
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 =Heading
	str2 =vbNewline
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "</br>")
	End If  




	Query =  " UPDATE PageLayout Set PageTitle = '" & PageTitle & "', " 
    Query =  Query & " PageText = '" & PageText & "' "  
    Query =  Query & " where PageLayoutID = " & PageLayoutID & ";"  
	response.write(Query)	
response.write("DatabasePath=" & DatabasePath )
Conn.Execute(Query) 

Conn.Close
Set Conn = Nothing 
if len(Returnpage) > 0 then
Response.redirect(Returnpage)
else
Response.Redirect("AdminLinkPageMaintenance.asp?CatID=" & CatID ) 
end if
 %>
</Body>
</HTML>

