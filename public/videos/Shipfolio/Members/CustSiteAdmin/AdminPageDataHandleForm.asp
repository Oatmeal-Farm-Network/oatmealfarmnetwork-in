<head>


<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<%
'rowcount = CInt
rowcount = 1

Dim TextBlock
Dim Heading
Dim Text

TextBlock= Request.Form("TextBlock")
LinkName= Request.Form("LinkName")
PagegroupID = Request.Form("PagegroupID")
response.write("PagegroupID=" & PagegroupID  )
PageTitle= Request.Form("PageTitle")
ShowPage= Request.Form("ShowPage")
PageLayoutID= Request.Form("PageLayoutID")
PageName= Request.Form("PageName")
returnpage= Request.Form("returnpage")
response.Write("Pagename=" & pagename)
Heading = Request.Form("Heading")
Text= Request.Form("Text") 
tempPageLayout2ID= Request.Form("tempPageLayout2ID")
ReturnTextBlock= Request.Form("ReturnTextBlock")

response.Write("ReturnTextBlock=" & ReturnTextBlock )

Dim str1
Dim str2
	
str1 = LinkName
str2 = "'"
If InStr(str1,str2) > 0 Then
	LinkName= Replace(str1,  str2, "''")
End If 
	
str1 = PageTitle
str2 = "'"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "''")
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

	str1 = text
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "''")
	End If  

	str1 = text
	str2 = vbCr
	If InStr(str1,str2) > 0 Then
		'text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 = vbtab
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = text
	str2 = vbVerticalTab
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = text
	str2 = vbLf 
	If InStr(str1,str2) > 0 Then
	'	text= Replace(str1,  str2, "&nbsp;")
	End If 



	str1 = text
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		'text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = text
	str2 =vbNewline
	If InStr(str1,str2) > 0 Then
		'text= Replace(str1,  str2, "</br>")
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


If TextBlock = "Heading" Then
response.write("PagegroupID = " & trim(PagegroupID)) & "!<BR>"
	Query =  " UPDATE PageLayout Set LinkName = '" & LinkName & "', " 
	if len(trim(PagegroupID)) > 0 then
    	if PagegroupID > 0 then
	    Query =  Query & " PagegroupID = " & PagegroupID & ", "
        end if
	end if 
    Query =  Query & " ShowPage = " & ShowPage & ", "  
    Query =  Query & " PageTitle = '" & PageTitle & "', "  
    Query =  Query & " PageName = '" & PageName & "' "  
    Query =  Query & " where PageLayoutID = " & PageLayoutID & ";"  
	response.write(Query)	
response.write("Query=" & Query )

	Conn.Execute(Query) 

else

	Query =  " UPDATE PageLayout2 Set PageText = '" & Text & "'"  
    Query =  Query & " where PageLayout2ID = " & tempPageLayout2ID & ";"  
	response.write(Query)	

	Conn.Execute(Query) 


End If 


	Conn.Close
	Set Conn = Nothing 
if len(returnpage) > 0 then
 Response.Redirect(returnpage) 
else
Response.Redirect("AdminPageData.asp?PageLayoutID=" & PageLayoutID & "#" & ReturnTextBlock) 
 end if
 %>
	</head>
<body >
</body>
</html>

