<html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<% Current = "Ranches"%>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<% SetLocale("en-us") 
CurrentPeopleID=Request.Form("CurrentPeopleID") 
	CatID=request.form("CatID") 
	If Len(CatID) < 3 then
		CatID= Request.QueryString("CatID") 
	End If

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if

If CurrentPeopleID = "notselected" Then
	Response.Redirect("/ranches/default.asp" )
End if	


sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
	RanchHomeText = rs("RanchHomeText")
	BusinessID   = rs("BusinessID")
	AddressID  = rs("AddressID")
	Logo = rs("Logo")
	Header = rs("Header")
	
	str1 = RanchHomeText
str2 = vblf
If InStr(str1,str2) > 0 Then
	RanchHomeText= Replace(str1, str2 , "</br>")
End If  

str1 = RanchHomeText
str2 = vbtab
If InStr(str1,str2) > 0 Then
	RanchHomeText= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
end if 

rs.close
if len(BusinessID) > 0 then
	else
	response.Redirect("default.asp"  )
	end if
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
	BusinessName = rs("BusinessName")
end if 

rs.close
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
	AddressCity = rs("AddressCity")
	AddressState = rs("AddressState")
end if 
rs.close


if len(AddressState) > 1 then
  
sql = "SELECT * from States where StateAbbreviation =  '" & AddressState & "'"
'response.write (sql)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql, conn, 3, 3   
if not rs2.eof then
StateName = trim(rs2("StateName"))
StateAbbreviation = rs2("StateAbbreviation")
Nicknames = rs2("Nicknames") 
end if
rs2.close
end if

If len(CatID) < 1 Then
if len(currentpeopleID) > 0 then
	'response.redirect("/ranches/storehome.asp?CurrentPeopleID=" & CurrentpeopleID   )
else
	'Response.Redirect("/ranches/default.asp" )
End if	
end if

If Len(CurrentPeopleID) > 0 Then
sql = "SELECT distinct Catname FROM sfcategories WHERE CatId  = " & CatID  & " order by CatName " 
response.write("sql=" & sql)

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
If Not rs.eof Then
CategoryName = rs("catName")
end if
rs.close
end if
%>
<title><%=CategoryName %>  for Sale - <%= BusinessName %></title>
<meta name="Title" content="<%=CategoryName %> for Sale - <%= BusinessName %>"/>
<meta name="description" content="<%=CategoryName %>  for Sale at <%= BusinessName %> in <%= AddressCity %>, <%=StateName %>." >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="7">
<meta name="Googlebot" content="index, follow">
<meta name="robots" content="All">
<meta name="subject" content="<%=CategoryName %>  for Sale">
<link rel="stylesheet" type="text/css" href="/style.css">
<% 
CurrentPeopleID=Request.Form("CurrentPeopleID") 

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if

If CurrentPeopleID = "notselected" Then
	Response.Redirect("Ranches.asp" )
End if	
sql = "select * from RanchSiteDesign where PeopleID= " & CurrentPeopleID
	rs.Open sql, conn, 3, 3
	If not rs.eof Then

		MenuBackgroundColor = rs("MenuBackgroundColor")
		MenuColor = rs("MenuColor")
		MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
		TitleColor = rs("TitleColor")
		PageBackgroundColor = rs("PageBackgroundColor")
		PageTextColor = rs("PageTextColor")
		LayoutStyle = rs("LayoutStyle")
		PageTextMouseOverColor = rs("PageTextMouseOverColor")
		
	End If
rs.close 

if PageBackgroundColor= "Black" Then
			TitleColor = "white"
			PageTextColor = "white"
		end if 
	%>	
<style type="text/css">
		H2 {font: 20pt arial; color: <%=TitleColor %>}
		H3 {font: 12pt arial; color: <%=TitleColor %>}
		H4 {font: 12pt arial; color: <%=MenuBackgroundColor%>}
		.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body:hover { color: <%=PageTextMouseOverColor%>}
			.Heading {font: 10pt arial; color: <%=MenuBackgroundColor%>}
		A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}
ul.LinkedList { display: block; 
    list-style-type : none; 
	padding: 0px 0px 0px 0px;
	border: 0px 0px 0px  0px;
	margin: 0px 0px 0px  0px;
}
li 
{ line-height : 22px;
  	padding: 0px 0px 0px 0px;
	border: 0px 0px 0px  0px;
	margin: 0px 0px 0px  0px;
}
/* ul.LinkedList ul { display: none; } */
.HandCursorStyle { cursor: pointer; cursor: hand; }  /* For IE */
  </style>
</head>
<body >
<!--#Include virtual="/Header.asp"-->
<%Current3 = "Products" %>
<div class="container-fluid" id="grad1"  >
	<div class = "row" >
        <div class = "col" >
			<H1><div align = "left"> 
				<h1><font color = "<%=TitleFontColor %>">&nbsp;&nbsp;&nbsp;<%=CategoryName %> for Sale</font></h1>
			</div></H1>
		</div>
   </div>
</div>
<!--#Include file="RanchPagesTabsInclude.asp"-->
<div class="container">
 <div class ="row roundedtopandbottom">
	<div class ="col" width = "200" valign = "top" bgcolor = "#eeeeee">
		<a href ="StoreHome.asp?CurrentPeopleID=<%=CurrentpeopleID %>" class = "menu3"><b>Products Home Page</b></a><br>
			<% 
			sql2 = "SELECT distinct CatID, catname FROM SFCategories, productCategoriesList, sfProducts where catID = productCategoriesList.prodCategoryId and sfproducts.prodID = productcategoriesList.ProductID and prodForSale = 1 and sfproducts.peopleID = " & CurrentpeopleID & " order by catname"
			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
			While Not rs2.eof %>
			<a href = "RanchStore.asp?catID=<%=rs2("CatID")%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "menu3"><%=rs2("CatName")%></a><br>
			<% 
			rs2.movenext
			Wend %>
	</div>
	<div >    

		<% dim buttonimages(20)
		dim buttontitle(20) 
		Dim sSize(200)
		Dim sExtraCost(200)
		Dim cColor(200)
		Dim Description
		 Dim FoundBut(10)

		subcategories = False
		noProducts=False

		If Len(CurrentPeopleID) > 0 Then

		sql = "SELECT distinct Catname, productcategoriesList.prodCategoryId , productcategoriesList.prodsubcategoryid FROM sfproducts, productcategoriesList, sfCategories WHERE sfproducts.prodId =  productcategoriesList.ProductID and  productcategoriesList.prodCategoryId = sfCategories.catID and Prodforsale=1 and productcategoriesList.prodCategoryId  = " & CatID & " and sfProducts.PeopleID = " & CurrentPeopleID  & " order by CatName " 
		'response.write("sql=" & sql)
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open sql, conn, 3, 3  

		If Not rs.eof Then
		CategoryName = rs("catName")
		prodCategoryId = rs("prodCategoryId") 
		subcatId = rs("prodsubcategoryid") 
		'response.write("subcatId = " & len(subcatId))
		if len(subcatId) > 0  then
		'response.redirect("RanchSubStore.asp?subcatID=" & subcatId & "&catID=" & CatID & "&CurrentPeopleID=" & CurrentPeopleID )
		end if
		%>
		<!--#Include file="RanchprodHomePage.asp"--> 
		<% 
		 Else
		noProducts=true
		End If 
		Else
		  'response.redirect("ranchhome.asp" )
		End If 

		If noProducts=True Then %><br><br>
		<h3><center>We do not currently have any products for sale. Please check back later. </center></h3><br><br><br><br>
		<%   else
		If subcategories = True Then %>
		<% else
		SCounter = 0
		sql = "select * from sfCategories where catName =  '" & CategoryName & "'"
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open sql, conn, 3, 3 
		CategoryID = rs("CatID")
		CategoryName = rs("catName")
		'RESPONSE.WRITE("SubCategoryIDList(SCounter)=" & SubCategoryIDList(SCounter))
		rs.movenext
		rs.Close
		SCounter = 0
		SCounter = 0
		End if 
		End if %>
		<br><br>
  </div>
</div>
<div align = "center" valaign = "bottom"><a href = "#top" class ="body">&nbsp;Return to the top of this page</a></div>
</div>
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>