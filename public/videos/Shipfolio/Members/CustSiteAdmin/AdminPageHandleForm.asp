<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<body >
<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include file="AdminDetailDBInclude.asp"--> 
<table width = "900" align = "center" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td class = "body" valign = "top">
<%

Dim PageName 
Dim PageTitle
Dim PageText

'rowcount = CInt
rowcount = 1

ReturnPage	 = Request.Form("ReturnPage") 
PageName = Request.Form("PageName") 
PageTitle = Request.Form("PageTitle")  
PageText = Request.Form("PageText")  
ID = Request.Form("ID")  
PageLayoutID= Request.Form("PageLayoutID")  
PageGroupID = request.form("PageGroupID")
LinkName=request.form("LinkName")
ShowPage=request.form("ShowPage")

'response.write(PageText)
Dim str1
Dim str2
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

str1 = PageTitle
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
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "</br>")
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
	PageText= Replace(str1,  str2, "&nbsp;")
End If 



str1 = PageText
str2 = vbCr
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "</br>")
End If  


str1 = PageText
str2 =vbFormFeed
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "</br>")
End If  

str1 = PageText
str2 = vbNullChar
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "&nbsp;")
End If 


str1 = PageText
str2 =vbNewline
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "</br>")
End If  

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
 Query =  " UPDATE PageLayout Set PageTitle = '" & PageTitle & "' "
Query =  Query & " where PageLayoutID = " & PageLayoutID 
DataConnection.Execute(Query) 

    Query =  " UPDATE PageLayout2 Set PageHeading = '" & PageTitle & "' ,"
	Query =  Query & " PageText = '" & PageText & "' "
    Query =  Query & " where PageLayoutID = " & PageLayoutID & " and BlockNum = 1;" 

response.write(Query)	
DataConnection.Execute(Query) 
rowcount= rowcount +1
Query =  " UPDATE PageLayout Set PageName = '" & PageName & "' ,"
Query =  Query & " Linkname = '" & Linkname & "', "
Query =  Query & " ShowPage = " & ShowPage & ", "
Query =  Query & " PageGroupID = " & PageGroupID & " "
Query =  Query & " where PageLayoutID = " & PageLayoutID & ";" 
response.write(Query)	
DataConnection.Execute(Query) 
rowcount= rowcount +1
DataConnection.Close
Set DataConnection = Nothing 
if ReturnPage = "AdminFemaleData.asp" then
    response.redirect(ReturnPage)
end if
response.redirect("AdminPageMaintenance.asp?PagelayoutID=" & PagelayoutID )
%>
</td>
</tr>
</table>
</Body>
</HTML>