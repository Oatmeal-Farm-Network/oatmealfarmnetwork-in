<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<% SetLocale("en-us") 
CurrentPeopleID=Request.Form("CurrentPeopleID") 

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if

If CurrentPeopleID = "notselected" Then
	Response.Redirect("/ranches/default.asp")
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
	response.Redirect("default.asp")
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
%>
<title><%=StateName %> Products for Sale - <%= BusinessName %></title>
<meta name="Title" content="<%=StateName %> Products for Sale - <%= BusinessName %>"/>
<meta name="description" content="<%=StateName %>  Products for Sale at <%= BusinessName %> in <%= AddressCity %>, <%=StateName %>." >
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index, follow">
<meta name="robots" content="All">
<meta name="subject" content="Products for Sale">
<link rel="stylesheet" type="text/css" href="/style.css">
<% 
CurrentPeopleID=Request.Form("CurrentPeopleID") 

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if

If CurrentPeopleID = "notselected" Then
	Response.Redirect("Ranches.asp")
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
<% dim buttonimages(20)
dim buttontitle(20) 
Dim sSize(200)
Dim sExtraCost(200)
Dim cColor(200)
%>
</head>
<body >
<!--#Include virtual="/Header.asp"-->
<%Current3 = "Products" %>
<div class="container-fluid" id="grad1"  >
	<div class = "row" >
        <div class = "col" >
			<H1><div align = "left"> 
				<h1><font color = "<%=TitleFontColor %>">&nbsp;&nbsp;&nbsp;Products for Sale</font></h1>
			</div></H1>
		</div>
   </div>
</div>
<!--#Include file="RanchPagesTabsInclude.asp"-->
<div class="container">
 <div class ="row roundedtopandbottom">
	<div class ="col">
		<% 
		Dim Description
		Dim FoundBut(10)
		Dim Imagearray(1000)
		subcategories = False
		sqla = "SELECT DISTINCT productcategoriesList.prodcategoryid, catname FROM sfproducts, productcategoriesList, People, sfcategories WHERE  People.PeopleID = sfproducts.PeopleID and sfproducts.ProdId = productcategoriesList.productID and productcategoriesList.prodCategoryId = sfcategories.catID and People.accesslevel > 0 and Prodforsale=1 and People.PeopleID = " & CurrentpeopleID & " order by catname; "
		'response.write (sqla)
		Set rsa = Server.CreateObject("ADODB.Recordset")
		rsa.Open sqla, conn, 3, 3  
		while Not rsa.eof 
		'response.write("catName=" & rsa("catName"))
		CatID = rsa("prodcategoryid")
		CategoryName = rsa("catname")
		sql = "SELECT distinct prodcategoryID FROM ProductcategoriesList WHERE prodcategoryID = " & CatID  & "" 
		'response.write (sql)
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open sql, conn, 3, 3  
		If Not rs.eof Then
		subcategories = True 
		If Not rs.eof Then
		colcount = colcount + 1
		If colcount = 1 Then %>
		<Div>
		<% End If 	
		%>
		<!--#Include file="HomeprodHomePage.asp"--> 
		<% End If 
		End If 
		%>
  </div>
<%

If colcount > 2 Then 
colcount = 0%>
	</div>
<% End If 	
	rsa.movenext
wend
%>
</div>
</div>
</div> 
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>

