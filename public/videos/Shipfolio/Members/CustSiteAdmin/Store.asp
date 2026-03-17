<html>

<head>
<!--#Include virtual="/GlobalVariables.asp"-->

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
<!--#Include virtual="/StoreHeader.asp"-->

<font class = "body">Please check out our alpaca products for sale below. 
To order please give us a call at <br>(541) 826-7411 or e-mail us at <a href = "mailto:Richard@AlpacasOnTheWeb.com" Class = "body">Richard@AlpacasOnTheWeb.com</a>. We accept Visa, Mastercard, check or cash. An online order form will be available soon.</font><br><br>


<table width = "<%=bodywidth%>" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "Left" >
	<tr>
	  <td  valign = "top" height = "2" valign = "bottom" ><a name = "Yarns"></a><h1>Yarns for Sale<br><img src = "images/line.jpg" height = "2" width = "630" border = "0"></h1>
	  </td>
	</tr>
	<tr>
	  <td valign = "top" align = "left"   class = "body">



<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     
		sql = "SELECT distinct * FROM Products, ProductsAdditionalPhotos WHERE products.productID=ProductsAdditionalPhotos.ID  and forsale = true and  (Category = 'Yarns' ) order by Price DESC " 
	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 %>
<!--#Include virtual="/ProductsDetailInclude.asp"--> 
<br><br>	



	 </td>
	</tr>
	<tr>
	  <td  valign = "top" height = "2" valign = "bottom" ><a name = "Clothing"></a><h1>Clothing for Sale<br><img src = "images/line.jpg" height = "2" width = "630" border = "0"></h1>
	  </td>
	<tr>
	  <td  valign = "top" height = "2" valign = "bottom" background = "images/Underline.jpg"><img src = "images/px.gif" height = "2" border = "0"></td>
	</tr>
	<tr>
	  <td valign = "top" align = "left"   class = "body">



<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
          Buttoncounter = 0
	sql = "SELECT * FROM Products, ProductsAdditionalPhotos WHERE products.productID=ProductsAdditionalPhotos.ID  and forsale = true and  (Category = 'Clothing' ) order by Price DESC " 
	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	
	If Not rs.eof then
 %>
<!--#Include virtual="/ProductsDetailInclude.asp"--> 
<br><br>		

<% Else %>
	We do not currently have any clothing available online. Please check back later.
<% End If %>
<br><br><br><br>
      </td>
	</tr>
	<tr>
	  <td  valign = "top" height = "2" valign = "bottom" ><a name = "other"></a><h1>Other Alpaca Products for Sale<br><img src = "images/line.jpg" height = "2" width = "630" border = "0"></h1>
	  </td>
	<tr>
	<tr>
	  <td valign = "top" align = "left"   class = "body">



<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
          Buttoncounter = 0
	sql = "SELECT * FROM Products, ProductsAdditionalPhotos WHERE products.productID=ProductsAdditionalPhotos.ID  and forsale = true and  (Category = 'other' ) order by Price DESC " 
	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	
	If Not rs.eof then
 %>
<!--#Include virtual="/ProductsDetailInclude.asp"--> 
<br><br>		

<% Else %>
	We do not currently have any "other" alpaca products available online. Please check back later.
<% End If %>
<br><br><br><br>
      </td>
	</tr>
	</table>


 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>