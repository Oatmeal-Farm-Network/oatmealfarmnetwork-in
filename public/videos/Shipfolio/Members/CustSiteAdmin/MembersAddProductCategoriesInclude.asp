<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="membersstyle.css">
</head>
<body>
 <!--#Include virtual="/ConnLOA.asp"-->
<% Validsublist = True
sql2 = "select * from SiteDesign where PeopleId = 695;" 
Dim CategoryID(1000)
Dim CatName(1000)

Dim SubCategoryID(1000)
Dim SubCatName(1000)
Set rs = Server.CreateObject("ADODB.Recordset")
twocatagories= request.querystring("twocatagories")
%>

<form name="form1" method="post" action= 'MembersAddProductCategoriesInclude.asp?twocatagories=<%=twocatagories %>' >
<table border = '0' leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=2 cellspacing=0 align = 'left' width = '460'bgcolor = "#e6e6e6">
<tr>
	<td class= "body" colspan = "3"><i><font color = "#404040">The categories and subcategories that you choose determine where your product will appear.<br /><br />Make sure to <b>select at least one Category & Sub-Category.</b></i></font><br />
    After you select a category, a list of sub-categies will appear.
    <br /><br /></td>
	</tr>
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

sql = "select * from SFCategories  order by Catname " 

rs.Open sql, connloa, 3, 3 
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
rs.Open sql, connloa, 3, 3 
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
Validsublist = True
sql = "select * from SFCategories  where  CatID=" & Category1ID 
rs.Open sql, connloa, 3, 3 
if Not rs.eof then
    Category1 = rs("catName")
    Category1ID = rs("catID")
end if
rs.close

CatCounter= 0
SubCatCounter2 = 0

sql = "select * from sfSubCategories  where categoryID = '" & Category1ID  & "' order by SubCategoryName " 
Moresubcatid = ""	
    rs.Open sql, connloa, 3, 3 
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
<tr><td  class = "body" width = '80' >
<font color=#338333><b>Category 1</b></font>
</td>
<td class = "body"><font color=#338333><b>Sub-Category 1</b></font></td></tr>
<tr><td class = "body">
<select name="Category1ID" onChange="document.form1.submit()">
<% CatCounter = 0 %>
<% if len(Category1) > 0 then %>
<option value="<%=Category1ID%>" selected><%= Category1%></option>
<% else %>
<option value="0">--</option>
<% end if %>
<% While CatCounter  < FinalCatCounter 
CatCounter = CatCounter+ 1 %>
<option value="<%=CategoryID(CatCounter)%>"><%=CatName(CatCounter)%></option>
<% Wend %>
</select>
</td>
<td class = "body">
<% if len(Category1ID) > 0 then %>
<select name="SubCategory1ID" onChange="document.form1.submit()">
<% SubCatCounter = 0 %>
<% if len(SubCategory1ID) > 0 and Validsublist = True then %>
<option value="<%=SubCategory1ID%>" selected><%= SubCategory1%></option>
<% else %>
<option value="0">--</option>
<% end if %>
<% While SubCatCounter < FinalSubCatCounter 
SubCatCounter = SubCatCounter+ 1 %>
<option value="<%=SubCategoryID(SubCatCounter)%>"><%=SubCatName(SubCatCounter)%></option>
<% Wend %>
</select>
<% end if %>
</td></tr>
<% if len(SubCategory2ID) > 0 then
sql = "select * from sfSubCategories  where subcatID = " & SubCategory2ID  & " order by SubCategoryName " 
rs.Open sql, connloa, 3, 3 
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
rs.Open sql, connloa, 3, 3 
if Not rs.eof then
    Category2 = rs("catName")
    Category2ID = rs("catID")
end if
rs.close

CatCounter= 0
SubCatCounter2 = 0

sql = "select * from sfSubCategories  where categoryID = '" & Category2ID  & "' order by SubCategoryName " 
Moresubcatid = ""	
    rs.Open sql, connloa, 3, 3 
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
<tr><td  class = "body" >
Category 2
</td>
<td class = body>Sub-Category 2</td>
</tr>
<tr><td valign = top>
<select name="Category2ID" onChange="document.form1.submit()">
<% CatCounter = 0 %>
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
<% if len(Category2ID) > 0 then %>
<select name="SubCategory2ID" onChange="document.form1.submit()">
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

<br /><br />
</td>
</tr>
</table>

</form>
</body>	