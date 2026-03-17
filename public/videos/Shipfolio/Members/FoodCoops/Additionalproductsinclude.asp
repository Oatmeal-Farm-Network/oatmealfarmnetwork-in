<%	SCounter = 0
		
	sql = "SELECT  sfProducts.prodID, sfProducts.PeopleID, People.PeopleID, People.prodPurchasemethod, People.PaypalEmail , People.OtherURL, sfProducts.ProdDescription, sfProducts.ProdPrice, sfproducts.ProdName,  ProductsPhotos.*, sfsubcategories.* FROM sfProducts, People, ProductsPhotos,  sfsubcategories WHERE sfProducts.PeopleID = People.PeopleID and prodSubCategoryId = subcatID  and  cint(sfProducts.prodID) = ProductsPhotos.ID  and  People.PeopleID = " & CurrentPeopleID & " order by prodName DESC " 

'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
counter = 0
If Not rs.eof And rs.recordcount > 1 then
%>
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "600">
	<tr>
	    <td class = "body" valign = "top"  align = "left" >
			<br>More Products Available from <%=BusinessName%>: 
						<!--#Include file="smallProductsDetailInclude.asp"--> 
						<br><br>	
</td>
		</tr>
	</table>

			<%
			End if %>
	

	
