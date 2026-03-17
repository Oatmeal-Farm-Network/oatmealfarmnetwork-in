<!DOCTYPE HTML>
<HTML>
<HEAD>
 <link rel="stylesheet" type="text/css" href="style.css">
 <base target="_self" />
<!--#Include file="Membersglobalvariables.asp"-->
</HEAD>
<body >
<%
'rowcount = CInt
rowcount = 1
category=Request.Form("category")
'Business=Request.Form("Business") 
response.Write("ID=" & ID )
ListingDescription=Request.Form("ListingDescription") 
PageTitle = Request.form("PageTitle")

Dim str1
Dim str2
str1 = PageTitle
str2 = "'"
If InStr(str1,str2) > 0 Then
PageTitle= Replace(str1,  str2, "''")
End If  

str1 = ListingDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
ListingDescription= Replace(str1,  str2, "''")
End If  
	
ListingDescription = Left(ListingDescription, 2000)
If Len(ListingDescription) < 2001 Then
	ListingDescription2 = ""
Else
	Rightlength = Len(ListingDescription) - 2000
'	response.write("rl=" & rightlength)
	ListingDescription2 = right(ListingDescription, Rightlength)
End If 



Query =  " UPDATE Business Set RanchHomeHeading = '" & PageTitle & "' ,"
Query =  Query & " RanchHomeText = '" & ListingDescription & "' ,"
Query =  Query & " RanchHomeText2 = '" & ListingDescription2 & "' " 
Query =  Query & " where BusinessID = " & BusinessID & ";" 

response.write("Query=" & Query)
conn.Execute(Query) 
conn.Close
Set conn = Nothing 
response.redirect("MembersEditListingDescriptionFrame.asp?BusinessID=" & BusinessID & "&changesmade=True#top")
%>
</Body>
</HTML>
