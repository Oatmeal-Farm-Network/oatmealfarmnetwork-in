<HEAD>
 <title>About Us Page</title>
       <link rel="stylesheet" type="text/css" href="/Administration/style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">

		<!--#Include virtual="/Administration/Header.asp"-->
		<!--#Include virtual="/Administration/Dimensions.asp"-->
		<!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 
 
<table width = "680" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>

		
<td class = "body" valign = "top">




<%

Dim AboutUsHeading
Dim custRanchdescription


'rowcount = CInt
rowcount = 1

AboutUsHeading= Request.Form("AboutUsHeading") 
custRanchdescription = Request.Form("custRanchdescription")  

 
'response.write(PageText)
Dim str1
Dim str2
str1 = custRanchdescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1,  str2, "''")
End If  


str1 = custRanchdescription
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1,  str2, "</br>")
End If  


str1 = custRanchdescription
str2 = vbtab
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 

str1 = custRanchdescription
str2 = vbVerticalTab
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 


str1 = custRanchdescription
str2 = vbLf 
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1,  str2, "&nbsp;")
End If 



str1 = custRanchdescription
str2 = vbCr
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1,  str2, "</br>")
End If  


str1 = custRanchdescription
str2 =vbFormFeed
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1,  str2, "</br>")
End If  

str1 = custRanchdescription
str2 = vbNullChar
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1,  str2, "&nbsp;")
End If 


str1 = custRanchdescription
str2 =vbNewline
If InStr(str1,str2) > 0 Then
	custRanchdescription= Replace(str1,  str2, "</br>")
End If  



str1 = AboutUsHeading
str2 = "'"
If InStr(str1,str2) > 0 Then
	AboutUsHeading= Replace(str1,  str2, "''")
End If  


str1 = AboutUsHeading
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	AboutUsHeading= Replace(str1,  str2, "</br>")
End If  


str1 = AboutUsHeading
str2 = vbtab
If InStr(str1,str2) > 0 Then
	AboutUsHeading= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 

str1 = AboutUsHeading
str2 = vbVerticalTab
If InStr(str1,str2) > 0 Then
	AboutUsHeading= Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 


str1 = AboutUsHeading
str2 = vbLf 
If InStr(str1,str2) > 0 Then
	AboutUsHeading= Replace(str1,  str2, "&nbsp;")
End If 



str1 = AboutUsHeading
str2 = vbCr
If InStr(str1,str2) > 0 Then
	AboutUsHeading= Replace(str1,  str2, "</br>")
End If  


str1 = AboutUsHeading
str2 =vbFormFeed
If InStr(str1,str2) > 0 Then
	AboutUsHeading= Replace(str1,  str2, "</br>")
End If  

str1 = AboutUsHeading
str2 = vbNullChar
If InStr(str1,str2) > 0 Then
	AboutUsHeading= Replace(str1,  str2, "&nbsp;")
End If 


str1 = AboutUsHeading
str2 =vbNewline
If InStr(str1,str2) > 0 Then
	AboutUsHeading= Replace(str1,  str2, "</br>")
End If  










    Query =  " UPDATE sfcustomers Set custRanchdescription = '" & custRanchdescription & "' ,"
	Query =  Query & " AboutUsHeading = '" & AboutUsHeading & "' "
    Query =  Query & " where custID = " & session("custID") & ";" 


'response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 

	  rowcount= rowcount +1


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>
<br><h1>Your Changes Have Been Made</h1>
		<!--#Include virtual="/Administration/aboutusranchinclude.asp"--> 

</td>
</tr>
</table>


		<!--#Include virtual="/administration/Footer.asp"--></Body>
</HTML>

 </Body>
</HTML>
