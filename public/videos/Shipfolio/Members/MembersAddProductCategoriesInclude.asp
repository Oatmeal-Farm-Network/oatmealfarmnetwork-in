<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<!--#Include file="MembersGlobalVariables.asp"-->
      <link rel="stylesheet" href="https://www.GlobalGrange.world/members/Membersstyle.css">
<% Validsublist = True
'sql2 = "select * from SiteDesign where PeopleId = 695;" 
Dim CategoryID(1000)
Dim CatName(1000)

Dim SubCategoryID(1000)
Dim SubCatName(1000)
Set rs = Server.CreateObject("ADODB.Recordset")
twocatagories= request.querystring("twocatagories")

ProdCategory1ID = request.Querystring("ProdCategory1ID")
if len(ProdCategory1ID) > 0 then
else
ProdCategory1ID = request.Form("ProdCategory1ID")
end if


prodSubCategory1ID = request.Querystring("prodSubCategory1ID")
if len(prodSubCategory1ID) > 0 then
else
prodSubCategory1ID = request.form("prodSubCategory1ID")
end if

prodCategory2ID = request.form("prodCategory2ID")
if len(prodCategory2ID) > 0 then
else
prodCategory2ID = request.Querystring("prodCategory2ID")
end if

prodSubCategory2ID = request.Querystring("prodSubCategory2ID")
if len(prodSubCategory2ID) > 0 then
else
prodSubCategory2ID = request.form("prodSubCategory2ID")
end if



Session("ProdCategory1ID") = ProdCategory1ID
Session("prodSubCategory1ID") = prodSubCategory1ID
Session("prodCategory2ID") = prodCategory2ID
Session("prodSubCategory2ID") = prodSubCategory2ID


sql = "select * from SFCategories  order by Catname " 

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


if len(prodSubCategory1ID) > 0 then

sql = "select * from sfSubCategories  where subcatID = " & prodSubCategory1ID  & " order by SubCategoryName " 
rs.Open sql, conn, 3, 3 
if Not rs.eof then
    SubCategory1= rs("SubCategoryName")
    subassociatedCategoryID = rs("CategoryID")
end if
rs.close
end if

if len(ProdCategory1ID) > 0 then
if subassociatedCategoryID = ProdCategory1ID then
   Validsublist = True
 else
 Validsublist = False
end if
Validsublist = True
sql = "select * from SFCategories  where  CatID=" & ProdCategory1ID 
rs.Open sql, conn, 3, 3 
if Not rs.eof then
    Category1 = rs("catName")
    ProdCategory1ID = rs("catID")
end if
rs.close

CatCounter= 0
SubCatCounter2 = 0

sql = "select * from sfSubCategories  where categoryID = '" & ProdCategory1ID  & "' order by SubCategoryName " 
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

</head>
<body>
<form name="form1" method="post" action= 'MembersAddProductCategoriesInclude.asp?twocatagories=<%=twocatagories %>' >
<div class ="container" style="background-color:white">
  <div class="row">
    <div class="col body" style="height: 70px">
		Category 1<br />

			<select name="ProdCategory1ID" onChange="document.form1.submit()" class = "formbox" style="width: 200px; text-align: left" required>
			<% CatCounter = 0 %>
			<% if len(Category1) > 0 then %>
				<option value="<%=ProdCategory1ID%>" selected><%= Category1%></option>
			<% else %>
				<option value="0">--</option>
			<% end if %>
			<% While CatCounter  < FinalCatCounter 
				CatCounter = CatCounter+ 1 %>
				<option value="<%=CategoryID(CatCounter)%>"><%=CatName(CatCounter)%></option>
			<% Wend %>
			</select><br /><br />
	</div>
	<div class="col body" style="height: 70px">
		Sub-Category 1<br />

			<select name="prodSubCategory1ID" onChange="document.form1.submit()" class = "formbox" style="width: 200px; text-align: left" required>
		<% SubCatCounter = 0 %>
		<% if len(prodSubCategory1ID) > 0 and Validsublist = True then %>
			<option value="<%=prodSubCategory1ID%>" selected><%= SubCategory1%></option>
		<% else %>
			<option value="0">--</option>
		<% end if %>
		<% While SubCatCounter < FinalSubCatCounter 
			SubCatCounter = SubCatCounter+ 1 %>
			<option value="<%=SubCategoryID(SubCatCounter)%>"><%=SubCatName(SubCatCounter)%></option>
		<% Wend %>
		</select><br /><br />

</div>
</div>
<% if len(prodSubCategory2ID) > 0 then
sql = "select * from sfSubCategories  where subcatID = " & prodSubCategory2ID  & " order by SubCategoryName " 
rs.Open sql, conn, 3, 3 
if Not rs.eof then
SubCategory2= rs("SubCategoryName")
subassociatedCategoryID = rs("CategoryID")
end if
rs.close
end if
if len(prodCategory2ID) > 0 then
if subassociatedCategoryID = prodCategory2ID then
Validsublist = True
else
Validsublist = False
end if
sql = "select * from SFCategories  where  CatID=" & prodCategory2ID 
rs.Open sql, conn, 3, 3 
if Not rs.eof then
    Category2 = rs("catName")
    Category2ID = rs("catID")
end if
rs.close

CatCounter= 0
SubCatCounter2 = 0

sql = "select * from sfSubCategories  where categoryID = '" & prodCategory2ID  & "' order by SubCategoryName " 
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
<div>
	<div class="col body" style="height: 70px">
		Category 2 <font color="#abacab">(Optional)</font><br />
		<select name="prodCategory2ID" onChange="document.form1.submit()" class = "formbox" style="width: 200px; text-align: left">
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
		</select><br />
	</div>
	<div class="col body" style="height: 60px">
		Sub-Category 2 <font color="#abacab">(Optional)</font><br />


		<select name="prodSubCategory2ID" onChange="document.form1.submit()" class = "formbox" style="width: 200px; text-align: left">
	<% SubCatCounter = 0 %>
		<% if len(prodSubCategory2ID) > 0 and Validsublist = True then %>
		<option value="<%=prodSubCategory2ID%>" selected><%= SubCategory2%></option>
		<option value="0">--</option>
		<% else %>
		<option value="0">--</option>
	<% end if %>
	<%	While   SubCatCounter  < FinalSubCatCounter 
		SubCatCounter = SubCatCounter+ 1 %>
		<option value="<%=SubCategoryID(SubCatCounter)%>"><%=SubCatName(SubCatCounter)%></option>
	<% Wend %>
</select>

<br /><br />
</div>
</div>
</div>

</form>
</body>	