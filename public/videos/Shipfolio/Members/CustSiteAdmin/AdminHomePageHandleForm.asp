<!DOCTYPE HTML>
<%@ Language=VBScript %>
<HEAD>
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include virtual="/Administration/AdminGlobalvariables.asp"-->
</HEAD>
<body >



<%
set conn=Server.CreateObject("ADODB.Connection")
conn.Provider="Microsoft.Jet.OLEDB.4.0"
conn.Open(Server.Mappath(DatabasePath))
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
	str2 = vbCrLf
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
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
		text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 =vbFormFeed
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
	End If  

	str1 = text
	str2 = vbNullChar
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "&nbsp;")
	End If 

	str1 = text
	str2 =vbNewline
	If InStr(str1,str2) > 0 Then
		text= Replace(str1,  str2, "</br>")
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

	Query =  " UPDATE PageLayout  Set PageTitle = '" & Text & "' "
    Query =  Query & " where PageName = 'Home Page'"
	response.write(Query)	
	Set DataConnection = Server.CreateObject("ADODB.Connection")
    
    conn.Execute(Query)
    conn.Close
	Set conn = Nothing  

End If 


If TextBlock = "TB1" Then

	Query =  " UPDATE PageLayout  Set PageText = '" & Text & "' "
    Query =  Query & " where PageName = 'Home Page'"
	response.write(Query)	
	Set DataConnection = Server.CreateObject("ADODB.Connection")
    
    Conn.Execute(Query)
    Conn.Close
	Set Conn = Nothing 

End If 

If TextBlock = "TB2" Then

	Query =  " UPDATE PageLayout  Set PageText2 = '" & Text & "' "
    Query =  Query & " where PageName = 'Home Page'" 
	Set DataConnection = Server.CreateObject("ADODB.Connection")
    
    Conn.Execute(Query)
    Conn.Close
	Set Conn = Nothing 

End If 


If TextBlock = "TB3" Then
	Query =  " UPDATE PageLayout  Set PageText3 = '" & Text & "' "
    Query =  Query & " where PageName = 'Home Page'"
	Set DataConnection = Server.CreateObject("ADODB.Connection")
    
    Conn.Execute(Query)
    Conn.Close
	Set Conn = Nothing 

End If 

If TextBlock = "TB4" Then
	Query =  " UPDATE PageLayout  Set PageText4 = '" & Text & "' "
    Query =  Query & " where PageName = 'Home Page'"
	Set DataConnection = Server.CreateObject("ADODB.Connection")
    
    Conn.Execute(Query)
    Conn.Close
	Set Conn = Nothing 
End If 

If TextBlock = "TB5" Then
	Query =  " UPDATE PageLayout  Set PageText5 = '" & Text & "' "
    Query =  Query & " where PageName = 'Home Page'"
	Set DataConnection = Server.CreateObject("ADODB.Connection")
    
    Conn.Execute(Query)
    Conn.Close
	Set Conn = Nothing 
End If 

If TextBlock = "TB6" Then
	Query =  " UPDATE PageLayout  Set PageText6 = '" & Text & "' "
    Query =  Query & " where PageName = 'Home Page'"
		Set DataConnection = Server.CreateObject("ADODB.Connection")
    
    Conn.Execute(Query)
    Conn.Close
	Set Conn = Nothing 
End If 

If TextBlock = "TB7" Then
	Query =  " UPDATE PageLayout  Set PageText7 = '" & Text & "' "
    Query =  Query & " where PageName = 'Home Page'"
	Set DataConnection = Server.CreateObject("ADODB.Connection")
    
    Conn.Execute(Query)
    Conn.Close
	Set Conn = Nothing 
End If 

If TextBlock = "TB8" Then
	Query =  " UPDATE PageLayout  Set PageText8 = '" & Text & "' "
    Query =  Query & " where PageName = 'Home Page'"
		Set DataConnection = Server.CreateObject("ADODB.Connection")
    
    Conn.Execute(Query)
    Conn.Close
	Set Conn = Nothing 
End If 

%>


<%  Response.Redirect("AdminHomePage.asp") %>
	
 </Body>
</HTML>
