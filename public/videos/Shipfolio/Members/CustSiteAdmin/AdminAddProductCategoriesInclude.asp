<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
<%
						
'sql2 = "select * from SiteDesign where PeopleId = 695;" 
Dim CategoryID(1000)
Dim CatName(1000)

Dim SubCategoryID(1000)
Dim SubCatName(1000)
Set rs = Server.CreateObject("ADODB.Recordset")
Set rsA = Server.CreateObject("ADODB.Recordset")

sqlA= "select AdministrationID from SiteDesign"
rsA.Open sqlA, conn, 3, 3   
If Not rsA.eof Then
AdministrationID = rsA("AdministrationID")
end if
rsA.close

sqlA= "select * from Administration where AdministrationID =" & AdministrationID 
rsA.Open sqlA, conn, 3, 3   
If Not rsA.eof Then
AdminHeaderImage = rsA("AdminHeaderImage")
AdminAuthor = rsA("AdminAuthor")
AdminTitle= rsA("AdminTitle")
Admincurrency= rsA("Admincurrency")
Admindateformat= rsA("Admindateformat")
Copyrightname= rsA("Copyrightname")
CopyrightLink= rsA("CopyrightLink")
PaypalCurrencyCode = rsA("PaypalCurrencyCode")
SetLocale(rsA("LocalCode"))
Currencycode=rsA("AdminCurrencyCode")
End If 
rsA.close
%>

<form name="form1" method="post" action= 'AdminAddProductCategoriesInclude.asp' >
<table border = '0' leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=2 cellspacing=0 align = 'left' width = '460'>

<% 
Category1ID = request.Querystring("Category1ID")
if len(Category1ID) > 0 then
else
Category1ID = request.Form("Category1ID")
end if


SubCategory1ID = request.Querystring("SubCategory1ID")
if len(SubCategory1ID) > 0 then
else
SubCategory1ID = request.form("SubCategory1ID")
end if

Category2ID = request.form("Category2ID")
if len(Category2ID) > 0 then
else
Category2ID = request.Querystring("Category2ID")
end if

SubCategory2ID = request.Querystring("SubCategory2ID")
if len(SubCategory2ID) > 0 then
else
SubCategory2ID = request.form("SubCategory2ID")
end if

Category3ID = request.form("Category3ID")
if len(Category3ID) > 0 then
else
Category3ID = request.Querystring("Category3ID")
end if

SubCategory3ID = request.Querystring("SubCategory3ID")
if len(SubCategory3ID) > 0 then
else
SubCategory3ID = request.form("SubCategory3ID")
end if

Session("Category1ID") = Category1ID
Session("SubCategory1ID") = SubCategory1ID
Session("Category2ID") = Category2ID
Session("SubCategory2ID") = SubCategory2ID
Session("Category3ID") = Category3ID
Session("SubCategory3ID") = SubCategory3ID

sql = "select * from SFCategories  order by CatName " 

rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CategoryID(CatCounter) = rs("CatID")
		CatName(CatCounter) = rs("CatName")
		rs.movenext
	Wend
FinalCatCounter = CatCounter
rs.close


if len(SubCategory1ID) > 0 then

sql = "select * from sfSubCategories  where subcatID = " & SubCategory1ID  & " order by SubCategoryName " 
rs.Open sql, conn, 3, 3 
if Not rs.eof then
    SubCategory1= rs("SubCategoryName")
    subassociatedCategoryID = rs("CategoryID")
end if
rs.close
end if

if len(Category1ID) > 0 then
if subassociatedCategoryID = Category1ID then
   Validsublist = True
 else
 Validsublist = False
end if

sql = "select * from SFCategories  where  CatID=" & Category1ID 
rs.Open sql, conn, 3, 3 
if Not rs.eof then
    Category1 = rs("catName")
    Category1ID = rs("catID")
end if
rs.close

CatCounter= 0
SubCatCounter2 = 0

sql = "select * from sfSubCategories  where categoryID = '" & Category1ID  & "' order by SubCategoryName " 
Moresubcatid = ""	
    rs.Open sql, conn, 3, 3 
	SubCatCounter= 0
	 While Not rs.eof 
		SubCatCounter = SubCatCounter + 1
		SubCategoryID(SubCatCounter) = rs("subcatID")
		SubCatName(SubCatCounter) = rs("SubCategoryName")
		if SubCatName(SubCatCounter) = "More" then
		  Moresubcatid =  rs("subcatID")
		  SubCatCounter = SubCatCounter - 1
		end if
		rs.movenext
	Wend
	if len(Moresubcatid) > 0 then
	    SubCatCounter = SubCatCounter + 1
	    SubCatName(SubCatCounter) = "More (other)"
	    SubCategoryID(SubCatCounter) = Moresubcatid 
	end if
rs.close	 

FinalSubCatCounter = SubCatCounter 
end if
%>
<tr>	<td  class = "body" >Category 1*:</td><td  class = "body" >Sub-Category</td></tr>
<tr>
<td class = "body">
	<select name="Category1ID" onChange="document.form1.submit()" class = "formbox">
	
    <% 
	CatCounter = 0 %>
	<% if len(Category1) > 0 then %>
		<option value="<%=Category1ID%>" selected><%= Category1%></option>
	<% else %>
<option value="0">--</option>
	<% end if %>
	<%	While   CatCounter  < FinalCatCounter 
		CatCounter = CatCounter+ 1 %>
		<option value="<%=CategoryID(CatCounter)%>"><%=CatName(CatCounter)%></option>
	<% Wend %>
</select>
</td>
<td class = "body">
<% 

 if len(Category1ID) > 0 then %>

<select name="SubCategory1ID" onChange="document.form1.submit()" class = "formbox">
	
    <% 
	SubCatCounter = 0 %>
	<% if len(SubCategory1ID) > 0 and Validsublist = True then %>
		<option value="<%=SubCategory1ID%>" selected><%= SubCategory1%></option>
	<% else %>
<option value="0">--</option>
	<% end if %>
	<%	While   SubCatCounter  < FinalSubCatCounter 
		SubCatCounter = SubCatCounter+ 1 %>
		<option value="<%=SubCategoryID(SubCatCounter)%>"><%=SubCatName(SubCatCounter)%></option>
	<% Wend %>
</select>

<% end if %>



</td>
</tr>


<% 


if len(SubCategory2ID) > 0 then

sql = "select * from sfSubCategories  where subcatID = " & SubCategory2ID  & " order by SubCategoryName " 
rs.Open sql, conn, 3, 3 
if Not rs.eof then
    SubCategory2= rs("SubCategoryName")
    subassociatedCategoryID = rs("CategoryID")
end if
rs.close
end if

if len(Category2ID) > 0 then
if subassociatedCategoryID = Category2ID then
   Validsublist = True
 else
 Validsublist = False
end if


sql = "select * from SFCategories  where  CatID=" & Category2ID 
rs.Open sql, conn, 3, 3 
if Not rs.eof then
    Category2 = rs("catName")
    Category2ID = rs("catID")
end if
rs.close

CatCounter= 0
SubCatCounter2 = 0

sql = "select * from sfSubCategories  where categoryID = '" & Category2ID  & "' order by SubCategoryName " 
Moresubcatid = ""	
    rs.Open sql, conn, 3, 3 
	SubCatCounter= 0
	 While Not rs.eof 
		SubCatCounter = SubCatCounter + 1
		SubCategoryID(SubCatCounter) = rs("subcatID")
		SubCatName(SubCatCounter) = rs("SubCategoryName")
		if SubCatName(SubCatCounter) = "More" then
		  Moresubcatid =  rs("subcatID")
		  SubCatCounter = SubCatCounter - 1
		end if
		rs.movenext
	Wend
	if len(Moresubcatid) > 0 then
	    SubCatCounter = SubCatCounter + 1
	    SubCatName(SubCatCounter) = "More (other)"
	    SubCategoryID(SubCatCounter) = Moresubcatid 
	end if
rs.close	 

FinalSubCatCounter = SubCatCounter 

end if


%>
<tr>
<td  class = "body" >Category 2:
</td>
</tr>
<tr>
<td class = "body">
	<select name="Category2ID" onChange="document.form1.submit()" class = "formbox">
	
    <% 
	CatCounter = 0 %>
	<% if len(Category2) > 0 then %>
		<option value="<%=Category2ID%>" selected><%= Category2%></option>
		<option value="0">--</option>
	<% else %>
<option value="0">--</option>
	<% end if %>
	<%	While   CatCounter  < FinalCatCounter 
		CatCounter = CatCounter+ 1 %>
		<option value="<%=CategoryID(CatCounter)%>"><%=CatName(CatCounter)%></option>
	<% Wend %>
</select>
</td>
<td class = "body">
<% 

 if len(Category2ID) > 0 then %>

<select name="SubCategory2ID" onChange="document.form1.submit()" class = "formbox">
	
    <% 
	SubCatCounter = 0 %>
	<% if len(SubCategory2ID) > 0 and Validsublist = True then %>
		<option value="<%=SubCategory2ID%>" selected><%= SubCategory2%></option>
		<option value="0">--</option>
	<% else %>
<option value="0">--</option>
	<% end if %>
	<%	While   SubCatCounter  < FinalSubCatCounter 
		SubCatCounter = SubCatCounter+ 1 %>
		<option value="<%=SubCategoryID(SubCatCounter)%>"><%=SubCatName(SubCatCounter)%></option>
	<% Wend %>
</select>

<% end if %>
</td>
</tr>


<% 
if len(SubCategory3ID) > 0 then

sql = "select * from sfSubCategories  where subcatID = " & SubCategory3ID  & " order by SubCategoryName " 
rs.Open sql, conn, 3, 3 
if Not rs.eof then
    SubCategory3= rs("SubCategoryName")
    subassociatedCategoryID = rs("CategoryID")
end if
rs.close
end if

if len(Category3ID) > 0 then
if subassociatedCategoryID = Category3ID then
   Validsublist = True
 else
 Validsublist = False
end if


sql = "select * from SFCategories  where  CatID=" & Category3ID 
rs.Open sql, conn, 3, 3 
if Not rs.eof then
    Category3 = rs("catName")
    Category3ID = rs("catID")
end if
rs.close

CatCounter= 0
SubCatCounter3 = 0

sql = "select * from sfSubCategories  where categoryID = '" & Category3ID  & "' order by SubCategoryName " 
Moresubcatid = ""	
    rs.Open sql, conn, 3, 3 
	SubCatCounter= 0
	 While Not rs.eof 
		SubCatCounter = SubCatCounter + 1
		SubCategoryID(SubCatCounter) = rs("subcatID")
		SubCatName(SubCatCounter) = rs("SubCategoryName")
		if SubCatName(SubCatCounter) = "More" then
		  Moresubcatid =  rs("subcatID")
		  SubCatCounter = SubCatCounter - 1
		end if
		rs.movenext
	Wend
	if len(Moresubcatid) > 0 then
	    SubCatCounter = SubCatCounter + 1
	    SubCatName(SubCatCounter) = "More (other)"
	    SubCategoryID(SubCatCounter) = Moresubcatid 
	end if
rs.close	 

FinalSubCatCounter = SubCatCounter 

end if


%>
<tr>
<td  class = "body" >Category 3:</td>
</tr>
<tr>
<td class = "body">
	<select name="Category3ID" onChange="document.form1.submit()" class = "formbox">
	
    <% 
	CatCounter = 0 %>
	<% if len(Category3) > 0 then %>
		<option value="<%=Category3ID%>" selected><%= Category3%></option>
        	<option value="0">--</option>
	<% else %>
<option value="0">--</option>
	<% end if %>
	<%	While   CatCounter  < FinalCatCounter 
		CatCounter = CatCounter+ 1 %>
		<option value="<%=CategoryID(CatCounter)%>"><%=CatName(CatCounter)%></option>
	<% Wend %>
</select>
</td>
<td class = "body">
<% 

 if len(Category3ID) > 0 then %>

<select name="SubCategory3ID" onChange="document.form1.submit()" class = "formbox">
	
    <% 
	SubCatCounter = 0 %>
	<% if len(SubCategory3ID) > 0 and Validsublist = True then %>
		<option value="<%=SubCategory3ID%>" selected><%= SubCategory3%></option>
        	<option value="0">--</option>
	<% else %>
<option value="0">--</option>
	<% end if %>
	<%	While   SubCatCounter  < FinalSubCatCounter 
		SubCatCounter = SubCatCounter+ 1 %>
		<option value="<%=SubCategoryID(SubCatCounter)%>"><%=SubCatName(SubCatCounter)%></option>
	<% Wend %>
</select>
<% end if
set conn = nothing
 %>
 </td></tr>
 <% if AdministrationID  = 1 or AdministrationID  = 3 then %>
<tr>
	<td class= "body" colspan = "3"><font color = "#777777">The categories that you choose determine where your product will appear.<br /> <br />You can select up to three categories. Subcategories may not be used by your website, but they are used by <a href = "http://www.livestockoftheworld.com" class = body target = _blank>Livestock of the World</a>.</font></td>
	</tr>
    <% end if %>
 
 </table>
 </form>
</body>	