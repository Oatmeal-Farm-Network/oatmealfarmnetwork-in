<html>
<HEAD>

       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >


<!--#Include File="AdminGlobalVariables.asp"--> 
<!--#Include File="AdminSecurityInclude.asp"--> 

<%
rowcount = 1

Dim TextBlock
Dim Heading
Dim Text
Return = Request.querystring("Return")
response.write("return=" & Return & "<br>")
TextBlock= Request.Form("TextBlock")
Heading = Request.Form("Heading")
Text1= Request.Form("Text") 
Text2= Request.Form("Text2") 
Text3= Request.Form("Text3") 
Text4= Request.Form("Text4") 
Text5= Request.Form("Text5") 
Text6= Request.Form("Text6") 
Text7= Request.Form("Text7") 
Text8= Request.Form("Text8") 
Text9= Request.Form("Text9") 
Text10= Request.Form("Text10") 
Text11= Request.Form("Text11") 
Text12= Request.Form("Text12") 
Text13= Request.Form("Text13") 
Text14= Request.Form("Text14") 
Text15= Request.Form("Text15") 
Text16= Request.Form("Text16") 


text = Text1 & Text2 & Text3  & Text4  & Text5  & Text6  & Text7  & Text8  & Text9  & Text10  & Text11  & Text12  & Text13  & Text14  & Text15  & Text16
response.write("text = " & text & "<br>")
	Dim str1
	Dim str2
	str1 = text
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "''")
	End If  


	str1 = text
	str2 = vbCrLf
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "<br>")
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
		text= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = text
	str2 = vbCr
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "<br>")
	End If  

	str1 = text
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "<br>")
	End If  

	str1 = text
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = text
	str2 =vbNewline
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "<br>")
	End If  



	str1 =Heading
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "''")
	End If  

	str1 = Heading
	str2 = vbCrLf
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "<br>")
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
		Heading= Replace(str1,  str2, "<br>")
	End If  

	str1 = Heading
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "<br>")
	End If  

	str1 = Heading
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 =Heading
	str2 =vbNewline
	If InStr(str1,str2) > 0 Then
		Heading= Replace(str1,  str2, "<br>")
	End If  


If TextBlock = "Heading" Then
	Query =  " UPDATE PageLayout Set PageTitle = '" & Text & "' "
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	response.write(Query)	
	'response.write("DatabasePath=" & DatabasePath )
	Conn.Execute(Query) 
End If 


If TextBlock = "TB1" Then
	Query =  " UPDATE PageLayout Set PageHeading1 = '" & Heading & "', "
	Query =  Query & " PageText = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB2" Then

	Query =  " UPDATE PageLayout Set PageHeading2 = '" & Heading & "', "
	Query =  Query & " PageText2 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 


If TextBlock = "TB3" Then

	Query =  " UPDATE PageLayout Set PageHeading3 = '" & Heading & "', "
	Query =  Query & " PageText3 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	'Set DataConnection = Server.CreateObject("ADODB.Connection")

'DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

Conn.Execute(Query) 

'DataConnection.Close
'Set DataConnection = Nothing 

End If 

If TextBlock = "TB4" Then

	Query =  " UPDATE PageLayout Set PageHeading4 = '" & Heading & "', "
	Query =  Query & " PageText4 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	response.write(Query)	
	Conn.Execute(Query) 
End If 

If TextBlock = "TB5" Then
	Query =  " UPDATE PageLayout Set PageHeading5 = '" & Heading & "', "
	Query =  Query & " PageText5 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB6" Then
	Query =  " UPDATE PageLayout Set PageHeading6 = '" & Heading & "', "
	Query =  Query & " PageText6 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB7" Then
	Query =  " UPDATE PageLayout Set PageHeading7 = '" & Heading & "', "
	Query =  Query & " PageText7 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB8" Then
	Query =  " UPDATE PageLayout Set PageHeading8 = '" & Heading & "', "
	Query =  Query & " PageText8 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB9" Then
	Query =  " UPDATE PageLayout Set PageHeading9 = '" & Heading & "', "
	Query =  Query & " PageText9 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB10" Then
	Query =  " UPDATE PageLayout Set PageHeading10 = '" & Heading & "', "
	Query =  Query & " PageText10 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB11" Then
	Query =  " UPDATE PageLayout Set PageHeading11 = '" & Heading & "', "
	Query =  Query & " PageText11 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB12" Then
	Query =  " UPDATE PageLayout Set PageHeading12 = '" & Heading & "', "
	Query =  Query & " PageText12 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB13" Then
	Query =  " UPDATE PageLayout Set PageHeading13 = '" & Heading & "', "
	Query =  Query & " PageText13 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB14" Then
	Query =  " UPDATE PageLayout Set PageHeading14 = '" & Heading & "', "
	Query =  Query & " PageText14 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB15" Then
	Query =  " UPDATE PageLayout Set PageHeading15 = '" & Heading & "', "
	Query =  Query & " PageText15 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

If TextBlock = "TB16" Then

	Query =  " UPDATE PageLayout Set PageHeading16 = '" & Heading & "', "
	Query =  Query & " PageText16 = '" & Text & "'"  
    Query =  Query & " where PageName = '" & session("PageName") & "';"  
	Conn.Execute(Query) 
End If 

%>

<%
response.write("return = " & Return & "<br>") 
if len(Return)> 1 then
 'Response.Redirect("AdminPageData2Home.asp?PageName=Home%20Page")
else
 'Response.Redirect("AdminPageData2.asp?PageName=" & session("PageName")  & "#" & TextBlock)
end if
 %>
</Body>
</HTML>

