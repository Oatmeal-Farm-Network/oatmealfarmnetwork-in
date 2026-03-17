<html>

<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<% dim buttonimages(20)
dim buttontitle(20) 
Dim sSize(200)
Dim sExtraCost(200)
Dim cColor(200)

%>

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> Farm Store</title>
<META name="description" content="<%= WebSiteName %> Farm Store">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% PageTitle = "Products for Sale"  %>
<!--#Include virtual="/StoreHeader2.asp"-->

<% colcount = 0 %>

<br>
	<table width = "600" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
		

<% 

Dim Description
 Dim FoundBut(10)
 Dim Imagearray(1000)
subcategories = False

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
"User Id=;Password=;" '& _ 
	
sqla = "SELECT catID, catName FROM sfcategories where not (CatID=16) order by catName" 
'response.write (sql)
Set rsa = Server.CreateObject("ADODB.Recordset")
rsa.Open sqla, conn, 3, 3  
						
while Not rsa.eof 
'response.write("catName=" & rsa("catName"))
CatID = rsa("CatID")
CategoryName = rsa("catName")

colcount = colcount + 1
If colcount = 1 Then %>
	<tr>
<% End If 	
     
sql = "SELECT distinct prodcategoryID FROM sfProducts WHERE prodcategoryID = " & CatID  & "" 
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
						
If Not rs.eof Then
	subcategories = True 
	If Not rs.eof Then


%>
colcount = <%=colcount%>
	<!--#Include file="HomeprodHomePage.asp"--> 
<% End If 
End If 
%>
  </td>
<%

If colcount = 3 Then 
colcount = 0%>
	</tr>
<% End If 	
	rsa.movenext
wend

sqla = "SELECT catID, catName FROM sfcategories where CatID=16" 
'response.write (sql)
Set rsa = Server.CreateObject("ADODB.Recordset")
rsa.Open sqla, conn, 3, 3  
						

'response.write("catName=" & rsa("catName"))
CatID = rsa("CatID")
CategoryName = rsa("catName")

colcount = colcount + 1
If colcount = 1 Then %>
	<tr>
<% End If 	
     
sql = "SELECT distinct prodcategoryID FROM sfProducts WHERE prodcategoryID = " & CatID  & "" 
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
						
If Not rs.eof Then
	subcategories = True 
	If Not rs.eof Then
%>
	<!--#Include file="HomeprodHomePage.asp"--> 
<% End If 
End If 
%>
  </td>
<% If colcount = 3 Then 
colcount = 0%>
	</tr>
<% End If 	

%>


</table>

<!--#Include file="Footer.asp"-->
</body>
</html>

