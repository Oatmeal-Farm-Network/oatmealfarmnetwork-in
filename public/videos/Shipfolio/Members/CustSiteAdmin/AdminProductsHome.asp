<!DOCTYPE HTML>

<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">

    <!--#Include File="AdminSecurityInclude.asp"--> 
    <!--#Include File="AdminGlobalVariables.asp"--> 
    <!--#Include File="AdminHeader.asp"--> 
    <% Current3 = "ProductsHome" %>
<!--#Include file="AdminProductsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">List of Products</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">
       <table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td >


<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Key</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table border = "0" cellpadding = "0" cellspacing="0"  align = "right">
 <tr>
 
  <td class = "body" width = "30" align = "right"><img src= "/images/edit.gif" alt = "edit" height = "18"  border = "0"></td>
 <td class = "body" width=  "35">Edit</td>
 
   <td class = "body" width = "30" align = "right"><img src = "/images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></td>
 <td class = "body" width=  "40" align = "left">Photos</td>
   
    <td></td>
    
    </tr>
</table>
</td>
    
    </tr>
</table>
</td></tr>
<tr>
<td height ="10">
</td></tr>
<tr>
<td> 
          
<%  
row = "even"

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from sfProducts  order by Prodname "

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	recordcount = rs2.recordcount
	if not  rs2.eof then
	  prodID = rs2("prodID") 
	    sql = "select * from productCategoriesList, sfcategories where productCategoriesList.prodCategoryId =  sfcategories.catID and ProductID = " & prodID
        	  ' response.Write(sql) 
	    Set rs = Server.CreateObject("ADODB.Recordset")
	    rs.Open sql, conn, 3, 3
	    if not  rs.eof then
	    catName1 = rs("catName")
	    if not rs.eof then
	     rs.movenext
	     if not rs.eof then
	     catName2 = rs("catName")
	     end if
	    end if
	      if not rs.eof then
	     rs.movenext
	     if not rs.eof then
	     catName3 = rs("catName")
	     end if
	    end if
	end if
	%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
			<tr><td class = "roundedtop" align = "left">
	 
			<table><tr><td class = "body" width = "450"><b>Name</b></td>
			<td class = "body" width = "350"><b>Category(s)</b></td>
			<td class = "body" width = "100"><b>Options</b></td></tr></table>
	</td></tr>
     <tr><td class = "roundedBottom" align = "center" width = "960"> 
<%	While Not rs2.eof  
	  prodID = rs2("prodID") 
	    sql = "select * from productCategoriesList, sfcategories where productCategoriesList.prodCategoryId =  sfcategories.catID and ProductID = " & prodID 
	 ' response.Write(sql) 
	   catName1 = ""
	   catName2 = ""
	   catName3 = ""
	    Set rs = Server.CreateObject("ADODB.Recordset")
	    rs.Open sql, conn, 3, 3
	    if not  rs.eof then
	    catName1 = rs("catName")
	    if not rs.eof then
	     rs.movenext
	     if not rs.eof then
	     catName2 = rs("catName")
	     end if
	    end if
	      if not rs.eof then
	     rs.movenext
	     if not rs.eof then
	     catName3 = rs("catName")
	     end if
	    end if	
  end if	
 If row = "even" Then 
 row = "odd"
 %>
		<table border = "0" cellpadding=0 cellspacing=0  width = "100%" align = "center" >
<% Else 
row = "even"%>

<table border = "0" cellpadding=0 cellspacing=0  width = "100%" align = "center" bgcolor = "#e6e6e6">
<%	End If %>


		<tr><td class= "body" width = "450">
<a href = "AdminAdEdit2.asp?prodID=<%= rs2("prodID") %>#BasicFacts" class = "body"><%=rs2("prodName")%></a>
</td>
<td class= "body" width = "350">
<%= catName1 %> 
<% if len(catname2) >0 then %>
,<%= catName2 %>  
<% end if %>
<% if len(catname3) >0 then %>
,<%= catName3 %>  
<% end if %>
</td>
<td class= "body" width = "100">
<a href = "AdminAdEdit2.asp?prodID=<%= rs2("prodID") %>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "/images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminListingDelete.asp?prodID=<%= rs2("prodID") %>" class = "body"><img src= "/images/Delete.gif" alt = "edit" height ="14" border = "0"></a>

|&nbsp;<a href = "AdminProductPhotos.asp?ID=<%= rs2("prodID") %>" class = "body"><img src = "/images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></a>

</td>
</tr>
</table>
		<%		catcounter  = catcounter  +1
				rs2.movenext
			Wend		
			FinalCatCounter = catcounter 
end if
			rs2.close%>
</td>
</tr>
</table><br />
</td>
</tr>
</table>
</td>
</tr>
</table>
<br />
  <!--#Include File="AdminFooter.asp"-->
</Body>
  </HTML>