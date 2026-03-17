<HEAD>

<!--#Include File="AdminGlobalVariables.asp"-->
</HEAD>

<body >

<%

Dim PageName 
Dim PageTitle
Dim PageText


Title = Request.Form("Title") 
Description = Request.Form("Description") 
Keyword1 = Request.Form("Keyword1") 
Keyword2 = Request.Form("Keyword2") 
Keyword3   = Request.Form("Keyword3") 
Keyword4  = Request.Form("Keyword4") 
Keyword5 = Request.Form("Keyword5") 
Keyword6 = Request.Form("Keyword6") 
Keyword7  = Request.Form("Keyword7") 
Keyword8  = Request.Form("Keyword8") 
Keyword9  = Request.Form("Keyword9") 
Keyword10  = Request.Form("Keyword10") 
Keyword11  = Request.Form("Keyword11") 
Keyword12  = Request.Form("Keyword12") 
Keyword13  = Request.Form("Keyword13") 
Keyword14  = Request.Form("Keyword14") 
Keyword15  = Request.Form("Keyword15") 
Keyword16  = Request.Form("Keyword16") 
Keyword17  = Request.Form("Keyword17") 
Keyword18  = Request.Form("Keyword18") 
Keyword19  = Request.Form("Keyword19")  
Keyword20  = Request.Form("Keyword20") 

'rowcount = CInt
rowcount = 1

PageName = Request.Form("PageName") 
ID = Request.Form("ID")  
 'response.write("title=")
'response.write(title)
Dim str1
Dim str2
str1 = Title
str2 = "'"
If InStr(str1,str2) > 0 Then
	Title= Replace(str1,  str2, "''")
End If  


str1 = Keyword1
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword1 = Replace(str1,  str2, "''")
End If  

str1 = Keyword2
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword2 = Replace(str1,  str2, "''")
End If  

str1 = Keyword3
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword3 = Replace(str1,  str2, "''")
End If  

str1 = Keyword4
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword4 = Replace(str1,  str2, "''")
End If  

str1 = Keyword5
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword5 = Replace(str1,  str2, "''")
End If  

str1 = Keyword6
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword6 = Replace(str1,  str2, "''")
End If  

str1 = Keyword7
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword7 = Replace(str1,  str2, "''")
End If  


str1 = Keyword8
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword8 = Replace(str1,  str2, "''")
End If  

str1 = Keyword9
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword9 = Replace(str1,  str2, "''")
End If  

str1 = Keyword10
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword10 = Replace(str1,  str2, "''")
End If  

str1 = Keyword1
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword11 = Replace(str1,  str2, "''")
End If  

str1 = Keyword12
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword12 = Replace(str1,  str2, "''")
End If  


str1 = Keyword13
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword13 = Replace(str1,  str2, "''")
End If  

str1 = Keyword14
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword14 = Replace(str1,  str2, "''")
End If  

str1 = Keyword15
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword15 = Replace(str1,  str2, "''")
End If  


str1 = Keyword16
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword16 = Replace(str1,  str2, "''")
End If  


str1 = Keyword17
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword17 = Replace(str1,  str2, "''")
End If  


str1 = Keyword18
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword18 = Replace(str1,  str2, "''")
End If  


str1 = Keyword19
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword19 = Replace(str1,  str2, "''")
End If  

str1 = Keyword20
str2 = "'"
If InStr(str1,str2) > 0 Then
	Keyword20 = Replace(str1,  str2, "''")
End If  



str1 = Description 
str2 = "'"
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "''")
End If  


str1 = Description 
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "</br>")
End If  


str1 = Description 
str2 = vbtab
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 

str1 = Description 
str2 = vbVerticalTab
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 


str1 =Description 
str2 = vbLf 
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "&nbsp;")
End If 



str1 = Description 
str2 = vbCr
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "</br>")
End If  


str1 = Description 
str2 =vbFormFeed
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "</br>")
End If  

str1 = Description 
str2 = vbNullChar
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "&nbsp;")
End If 


str1 = Description 
str2 =vbNewline
If InStr(str1,str2) > 0 Then
	Description = Replace(str1,  str2, "</br>")
End If  





    Query =  " UPDATE Pageseo Set Title = '" & Title & "' ,"
	Query =  Query & " Description  = '" & Description  & "', "
	Query =  Query & " Keyword1   = '" & Keyword1   & "', "
	Query =  Query & " Keyword2   = '" & Keyword2   & "' ,"
		Query =  Query & " Keyword3   = '" & Keyword3   & "', "
		Query =  Query & " Keyword4   = '" & Keyword4   & "', "
		Query =  Query & " Keyword5   = '" & Keyword5   & "', "
		Query =  Query & " Keyword6   = '" & Keyword6   & "', "
		Query =  Query & " Keyword7   = '" & Keyword7   & "', "
		Query =  Query & " Keyword8   = '" & Keyword8   & "', "
		Query =  Query & " Keyword9   = '" & Keyword9   & "' ,"
		Query =  Query & " Keyword10   = '" & Keyword10   & "' ,"
		Query =  Query & " Keyword11   = '" & Keyword11   & "', "
		Query =  Query & " Keyword12   = '" & Keyword12   & "' ,"
		Query =  Query & " Keyword13   = '" & Keyword13   & "' ,"
		Query =  Query & " Keyword14   = '" & Keyword14   & "' ,"
		Query =  Query & " Keyword15   = '" & Keyword15   & "' ,"
		Query =  Query & " Keyword16   = '" & Keyword16   & "' ,"
		Query =  Query & " Keyword17   = '" & Keyword17   & "' ,"
		Query =  Query & " Keyword18   = '" & Keyword18   & "' ,"
		Query =  Query & " Keyword19   = '" & Keyword19   & "' ,"
		Query =  Query & " Keyword20   = '" & Keyword20   & "' "
       Query =  Query & " where pageName = '" & PageName & "';" 


'response.write(Query)	


Conn.Execute(Query) 

	  rowcount= rowcount +1


	Conn.Close
	Set Conn = Nothing 

    response.redirect("AdminPageSEOMantainance.asp?pagename=" & PageName)
%>


 </Body>
</HTML>
