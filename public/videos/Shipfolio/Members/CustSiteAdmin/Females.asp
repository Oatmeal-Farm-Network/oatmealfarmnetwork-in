<html>

<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<!--#Include virtual="/FormatPrice.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %> Female Alpacas for Sale</title>
<META name="description" content="<%= WebSiteName %>">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% PageTitle = "Female Alpacas for Sale" %>
<!--#Include virtual="/AlpacaSalesHeader.asp"-->

<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" >
	<tr>
		<td class = "body">
        		
		Below is our selection of female alpacas for sale. To see their recent crop of crias<br> please <a class= "body" href = "Crias.asp">click here.</a>
		</td>
	</tr>
	<tr>
		<td class = "body"><a name="top"></a><td></tr>
	<tr>		
		 <td  align = "center" valign ="top">

				<table width = "610"   border="0" cellspacing="0" cellpadding="0"  align = "center">
					<tr>
						<td  class = "body" valign = "top"  align = "center">
							<table width = "610"   border="0" cellspacing="0" cellpadding="0" >
								<tr>
									<td class = "body" valign = "top" width = "300">
																		


<a name="BredDams"></a>
<table valign = "top" border = "0" width = "610"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
	<td colspan = "3" height = "9" valign = "top">&nbsp;</td>
</tr>

<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     
	sql = "SELECT Animals.*, Pricing.*, Photos.listpageimage, Ancestors.* FROM Animals, Pricing, Photos, Ancestors WHERE Animals.ID=Pricing.ID   And Animals.ID=Photos.ID And Animals.ID=Ancestors.ID and ForSale = Yes and (category = 'Maiden' or category = 'Female Cria'  or category = 'Dam' or category = 'Female Yearling')  order by ColorCategory, Price DESC" 

	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 

					
    If (Not rs.eof) And (Not rs("AValue") = "Sold!") Then
		rs.close
		sql = "SELECT Animals.*, Pricing.*, Photos.listpageimage, Ancestors.*  FROM Animals, Pricing, Photos, Ancestors  WHERE Animals.ID=Pricing.ID   And Animals.ID=Photos.ID And Animals.ID=Ancestors.ID and ForSale = Yes and (category = 'Maiden' or category = 'Female Cria'  or category = 'Dam' or category = 'Female Yearling')  order by ColorCategory, price DESC" 

	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 


	End if


 	if rs.eof then %>
		  <tr><td class = "body" ><blockquote>We currently do not have any dams for sale.  Please check back with us for updates!</blockquote>
		<br><br></td></tr>  
	<%end if%>



<% DetailType = "Dam" %>
<!--#Include virtual="/DetailIncludeBD.asp"--> 


		</td>
		</tr>
</table>






 <div><a href = "#top" class ="body">&nbsp;Return to the top of this page</a></div><br><br>
			</td>
		</tr>
</table>
			</td>
		</tr>
</table>
 <!--#Include virtual="/SaleslistFooter.asp"--> 
</body>
</html>

