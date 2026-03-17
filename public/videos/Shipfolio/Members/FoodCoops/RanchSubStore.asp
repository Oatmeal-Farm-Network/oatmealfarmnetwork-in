<!DOCTYPE >
<head>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<% SetLocale("en-us") 
CurrentPeopleID=Request.Form("CurrentPeopleID") 

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Session("PeopleID") 
End if


if len(CurrentPeopleID) < 1 then
    response.Redirect("Default.asp?screenwidth=" & screenwidth   )
end if


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
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
	BusinessName = rs("BusinessName")
end if 
rs.close
end if

if len(AddressID) > 0 then
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
	AddressCity = rs("AddressCity")
	AddressState = rs("AddressState")
end if 
rs.close
end if

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
H1 {font: 24pt arial; color: <%=TitleColor %>}
H2 {font: 20pt arial; color: <%=TitleColor %>}
H3 {font: 12pt arial; color: <%=TitleColor %>}
H4 {font: 12pt arial; color: <%=MenuBackgroundColor%>}
.Body {font: 10pt arial; color: <%=PageTextColor %>}
A.Body {font: 10pt arial; color: <%=PageTextColor %>}
A.Body:hover { color: <%=PageTextMouseOverColor%>}
.Heading {font: 10pt arial; color: <%=MenuBackgroundColor%>}
A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}
</style>
<title>Products for Sale at <%=BusinessName%>  - <%=PeopleState%> Farm / Ranch</title>
<META name="Title" content="Products for Sale at <%=BusinessName%>  - <%=PeopleState%>  Farm /  Ranch">
<META name="description" content="Products for Sale at <%=BusinessName%>  - <%=PeopleState%> Farm / Ranch" />
<META name="keywords" content="<%=BusinessName%> ,
<%=PeopleState%>  products for sale,
products for sale">
<meta name="robots" content="index,follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="7"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subjects" content="Products" />
<link rel="stylesheet" type="text/css" href="/style.css">
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&CurrentPeopleID=<%=CurrentPeopleID %>&ProdID=<%=ProdID %>' );" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<!--#Include file="RanchHeader.asp"-->
<%Current3 = "Products" %>
<!--#Include file="RanchPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" ><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Products for Sale</div></H1>
</td></tr>
 <tr><td class = "roundedBottom" align = "left">
 <table width = "<%=screenwidth %>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" ><tr>
 
<% if screenwidth > 640 then %>  
 <td width = "200" valign = "top" bgcolor = "#eeeeee">
<a href ="StoreHome.asp?CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "menu3"><b>Products Home Page</b></a><br>

<% sql2 = "SELECT distinct CatID, catname FROM SFCategories, productCategoriesList, sfProducts where catID = productCategoriesList.prodCategoryId and sfproducts.prodID = productcategoriesList.ProductID and prodForSale = True and sfproducts.peopleID = " & CurrentpeopleID & " order by catname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof %>
<a href = "RanchStore.asp?catID=<%=rs2("CatID")%>&CurrentPeopleID=<%=CurrentpeopleID %>&screenwidth=<%=screenwidth %>" class = "menu3"><%=rs2("CatName")%></a><br>
<% 
rs2.movenext
Wend %>
</td>
<td  width = "<%=screenwidth - 200 %>" >
<% else %>

<td  width = "<%=screenwidth%>" >
<% end if %>
<br />
<% dim buttonimages(20)
dim buttontitle(20) 
Dim sSize(200)
Dim sExtraCost(200)
Dim cColor(200)
Dim Description
 Dim FoundBut(10)

	subCatID=request.form("subCatID") 
	If Len(subCatID) < 3 then
		subCatID= Request.QueryString("subCatID") 
	End If

	CatID=request.form("CatID") 
	If Len(CatID) < 3 then
		CatID= Request.QueryString("CatID") 
	End If
'response.write("subCatID=" & subCatID)

If Len(subCatID) > 0 Then

If subCatID= 0 Then
response.redirect("Ranchstore.asp?CurrentpeopleID=" & CurrentpeopleID & "&screenwidth=" & screenwidth )
end if

Else
response.redirect("Ranchstore.asp?CurrentpeopleID=" & CurrentpeopleID & "&screenwidth=" & screenwidth )
End If 

category = False
%>
<a name="top"></a>
<% SCounter = 0
If subcatID > 0 then
sql = "select * from sfsubCategories where subCatID =  " & subCatID 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
If Not rs.eof then
SubCategoryID = rs("subcatId")
SubCategoryName = rs("SubCategoryName")
ShowCategoryName = rs("SubCategoryName")
'RESPONSE.WRITE("SubCategoryIDList(SCounter)=" & SubCategoryIDList(SCounter))
rs.movenext
End if
rs.Close

SCounter = 0
Else 
'response.Write("subcatID=" & subcatID )
'response.Write("catID=" & catID )
If catId = 0 Then
category = true
sql = "select * from sfCategories where CatID =  " & CatID 

Set rs = Server.CreateObject("ADODB.Recordset")
					 rs.Open sql, conn, 3, 3 
						If Not rs.eof then
							CategoryID = rs("catId")
							CategoryName = rs("CategoryName")
							ShowCategoryName = rs("CategoryName")
							'RESPONSE.WRITE("SubCategoryIDList(SCounter)=" & SubCategoryIDList(SCounter))
					 rs.movenext
			
						End if
				rs.Close
			End If 
		End if

	SCounter = 0
     If subcatid > 0 then

sql = "SELECT distinct  ProdName, prodID, prodprice, prodsalePrice, ProdDescription, prodMadeIn, ProductsPhotos.ProductImage1 FROM productcategoriesList, sfProducts, ProductsPhotos WHERE productcategoriesList.productId = sfProducts.prodId and productcategoriesList.ProductId = ProductsPhotos.ID And prodforsale=True And productcategoriesList.prodSubCategoryId=" & subcatID & " and sfproducts.PeopleID = " & CurrentPeopleID  & " ORDER BY prodName;" 
'response.write("sql=" & sql)


Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
If Not rs.eof then
%>
<!--#Include file="ProductsDetailInclude.asp"--> 

					<% End if %>
			<% End if %>
	
  <% If subcatid= 0 And catid> 0 then
	sql = "SELECT  distinct sfProducts.prodID, sfProducts.prodMadeIn, sfProducts.PeopleID, People.PeopleID, People.prodPurchasemethod, People.PaypalEmail , People.OtherURL, sfProducts.ProdDescription, sfProducts.ProdPrice, sfproducts.ProdName,  ProductsPhotos.* FROM sfProducts, People, ProductsPhotos WHERE sfProducts.PeopleID = People.PeopleID  and  cint(sfProducts.prodID) = ProductsPhotos.ID  and  prodSubCategoryId = " & subCatID & " And sfproducts.PeopleID = " & CurrentPeopleID & " order by prodName DESC " 
'response.write ("sql2=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
If Not rs.eof then
%>
<!--#Include file="ProductsDetailInclude.asp"--> 

<% End if %>
<% End if %>
	<br><br>
<div align = "center"><a href = "#top" class ="body">&nbsp;Return to the top of this page</a></div><br><br>

</td></tr></table>
</td></tr></table>
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>