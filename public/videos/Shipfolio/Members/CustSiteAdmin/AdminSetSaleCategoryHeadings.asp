<!DOCTYPE HTML >

<HTML>
<HEAD>
<% 

Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if
%>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwGalleryIDth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<% 
    TempCategoryType="For Sale"
%>  
 
    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
    <!--#Include file="AdminHeader.asp"--> 
 <%  Current3 = "Category Headings"   %> 
<!--#Include virtual="/Administration/AdminProductsTabsInclude.asp"-->

<% TempCategoryType=request.form("TempCategoryType") 
	If Len(TempCategoryType) < 3 then
		TempCategoryType= Request.QueryString("TempCategoryType") 
	End If

   Dim Tempcategoryname
   Dim Tempcategorytype
   Dim TempcategoryID
      Dim Categorytype

	Tempcategoryname=Request.Form("categoryname" ) 
	TempcategoryShow=Request.Form("categoryShow" ) 
	Tempcategorytype=Request.Form("Tempcategorytype" ) 
	TempcategoryID=Request.Form("CategoryID" ) 
	Categorytype=Request.Form("Categorytype" ) 

	str1 = Tempcategoryname
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Tempcategoryname= Replace(str1, "'", "''")
	End If

If categorytype = "category" then
	Query =  " UPDATE SFCategories Set catName = '" & Tempcategoryname & "' , " 
	Query =  Query & " catShow = " & TempcategoryShow & " " 
    Query =  Query & " where catID = " & TempcategoryID & ";" 
	sLocalSQL = "SELECT catName FROM SFCategories WHERE CatId = " & TempcategoryID

End If 

If categorytype = "subcategory" then
	Query =  " UPDATE SFSubCategories Set SubCategoryname = '" &  Tempcategoryname & "' " 
    Query =  Query & " where subcatCategoryId = " & TempcategoryID & ";" 
	sLocalSQL = "SELECT SubCategoryname FROM SFSubCategories WHERE subcatCategoryId = " & TempcategoryID

End If 
'response.write("sLocalSQL=" & sLocalSQL)
'response.write("Query=" & Query)
	If Len(Query) > 3 then
    	Set DataConnection = Server.CreateObject("ADODB.Connection")
        DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
    	DataConnection.Execute(Query) 
    	DataConnection.Close
	    Set DataConnection = Nothing 
    end if 
	
%>

	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "980"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Product Categories</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width= "900" >
	<tr>
	    <td width = "360">
	    <% 
Dim CategoryID(100,100)
Dim CategoryName(100,100)
Dim CategoryShow(100,100)
Dim SubCategoryID(100)
Dim SubCategoryName(100)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from SFCategories  order by CatName " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CategoryID(CatCounter,0) = rs("CatID")
		CategoryName(CatCounter,0) = rs("CatName")
		CategoryShow(CatCounter,0) = rs("CatShow")
		'response.write(CategoryName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0 %>
<% While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left" >
		<H3><div align = "left"><%= CategoryName(CatCounter,0) %></div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "100" valign = "top"><br />
       
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "400">
			<tr>
		<td  class = "body" valign = "top" colspan = "3">
		<H2>Edit Existing Categories</H2>
        </td>
      </tr>
      <tr>
        <td bgcolor = "#abacab" height = "1" colspan = "3"></td>
        </tr>	
        <tr>
        <td class = "body" align = "center"><b>Name</b></td>
         <td class = "body" align = "center"><b>Display Page</b></td>
          <td></td>
        </tr>


			
			<tr>
			<td class = "body"> <form action= 'AdminSetSaleCategories.asp' method = "post" style="margin-bottom:0;" >
			<div style="display: inline;">
			<input name="categoryname" value ="<%= CategoryName(CatCounter,0) %>"  size = "20"></div>
			</td>

		</tr>

<% wend %>
</table>
	    </td>
	</tr>
</table>
	    </td>
	</tr>
</table>
<br>
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>