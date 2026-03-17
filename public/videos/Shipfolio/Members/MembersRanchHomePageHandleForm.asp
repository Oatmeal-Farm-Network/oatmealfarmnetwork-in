<HEAD>
<link rel="stylesheet" type="text/css" href="/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >

<!--#Include virtual="/Members/MembersGlobalvariables.asp"-->

<%

'rowcount = CInt
rowcount = 1

Dim TextBlock
Dim Heading
Dim Text

TextBlock= Request.Form("TextBlock")
Heading = Request.Form("Heading")
Text= Request.Form("Text") 
NewsText= Request.Form("NewsText") 
if len(NewsText) > len(Text) then
   Text = NewsText
end if

	Dim str1
	Dim str2
	str1 = text
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "''")
	End If  


	str1 = text
	str2 = vbCr
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 = vbtab
	If InStr(str1,str2) > 0 Then
		'text= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = text
	str2 = vbVerticalTab
	If InStr(str1,str2) > 0 Then
		'text= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If 

	str1 = text
	str2 = vbLf 
	If InStr(str1,str2) > 0 Then
		'text= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = text
	str2 = vbCr
	If InStr(str1,str2) > 0 Then
		'text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		'text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		'text= Replace(str1,  str2, "&nbsp;")
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

	Query =  " UPDATE People Set RanchHomeHeading = '" & Text & "' "
    Query =  Query & " where PeopleID = " & session("PeopleID")  
	response.write(Query)	
	Conn.Execute(Query) 

End If 


If TextBlock = "TB1" Then

	Query =  " UPDATE People Set RanchHomeText = '" & Text & "'"  
    Query =  Query & " where PeopleID = " & session("PeopleID")  
	response.write(Query)	
	Conn.Execute(Query) 

End If 

If TextBlock = "TB2" Then

	Query =  " UPDATE People Set RanchHomeText2 = '" & Text & "'"  
    Query =  Query & " where PeopleID = " & session("PeopleID")  
	Conn.Execute(Query) 

End If 


If TextBlock = "TB3" Then
	Query =  " UPDATE People set RanchHomeText3 = '" & Text & "'"  
    Query =  Query & " where PeopleID = " & session("PeopleID")  
	Conn.Execute(Query) 

End If 

If TextBlock = "TB4" Then
	Query =  " UPDATE People Set  RanchHomeText4 = '" & Text & "'"  
    Query =  Query & " where PeopleID = " & session("PeopleID")  
	Conn.Execute(Query) 
End If 

Conn.Close
Set Conn = Nothing 

%>


<%  Response.Redirect("MembersRanchhomeAdmin.asp") %>
	
 </Body>
</HTML>
