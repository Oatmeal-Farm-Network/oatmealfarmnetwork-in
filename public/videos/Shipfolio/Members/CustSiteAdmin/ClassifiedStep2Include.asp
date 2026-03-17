<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "700">
	<tr>
		<td class = "body" valign = "top"  ><br><h1>Add a Product - Step 3: Confirm Text<a name="Add"></a>
			<img src = "images/underline.jpg" width = "700"></h1>
			<blockquote>Please make sure that all of the information that you entered is correct.</blockquote>
		</td>
	</tr>
</table>



 <%

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password= ;" 
	sql2 = "select * from sfProducts, sfCategories where  sfCategories.CatID = sfProducts.prodCategoryId  and  sfProducts.ProdID = " & session("ProdID") & " ;"

'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	


ProductName= rs2("ProdName")
Category= rs2("CatName")
CategoryID= rs2("prodCategoryId")
SubCategoryID= rs2("prodSubCategoryId")

Price= rs2("ProdPrice")
Description= rs2("ProdDescription")
QuantityAvailable= rs2("ProdQuantityAvailable")
ProdForSale= rs2("ProdForSale")
ProdSize1= rs2("ProdSize1")
ProdSize2= rs2("ProdSize2")
ProdSize3= rs2("ProdSize3")
ProdSize4= rs2("ProdSize4")
ProdSize5= rs2("ProdSize5")
ProdSize6= rs2("ProdSize6")
ProdSize7= rs2("ProdSize7")
ProdSize8= rs2("ProdSize8")
ProdSize9= rs2("ProdSize9")
ProdSize10= rs2("ProdSize10")
Color1= rs2("Color1")
Color2= rs2("Color2")
Color3= rs2("Color3")
Color4= rs2("Color4")
Color5= rs2("Color5")
Color6= rs2("Color6")
Color7= rs2("Color7")
Color8= rs2("Color8")
Color9= rs2("Color9")
Color10= rs2("Color10")
ProdDimensions= rs2("ProdDimensions")

sql2 = "select * from sfproducts, sfSubCategories where sfSubCategories.subcatId = sfProducts.prodSubCategoryId and  sfProducts.ProdID = " & session("ProdID") & ";"

'Response.write(sql2)

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 

If rs2.eof Then
	SubCategory= "No Sub Category"
else
	SubCategory= rs2("SubCategoryName")
End If 

If Price = "0" Then
	Price = ""
End If 

str1 = Description
str2 = vblf
If InStr(str1,str2) > 0 Then
	Description= Replace(str1, str2 , "</br>")
End If  

str1 = Description
str2 = vbtab
If InStr(str1,str2) > 0 Then
	Description= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  


%>


<table    cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "700" Border = "0" Bgcolor = "#f6d9ad">
	
	
	<tr>
		<td width = "20" bgcolor = "#fdf4dd" >&nbsp;</td>
	   <td valign = "top">

	   <table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "700">
		<tr>
			<td  class = "body" align = "right">
					Item Name:
			</td>
			<td>&nbsp;</td>
			<td class = "body">
				<b><%=ProductName%></b>
			</td>
		</tr>
		<tr>
			<td  class = "body" align = "right">
					Category: 
			</td>
			<td>&nbsp;</td>
			<td class = "body">
				<%=Category%>
			</td>
		</tr>
		<% If Not(SubCategory= "No SubCategory") then  %>
		<tr>
			<td  class = "body" align = "right">
					Sub-Category:
			</td>
			<td>&nbsp;</td>
			<td class = "body">
				<%=SubCategory%>
			</td>
		</tr>
		<% End If %> 
		
		
		
		<tr>
			<td  class = "body" align = "right">
					Price:
			</td>
			<td>&nbsp;</td>
			<td class = "body">
			<% If Len(Price) > 1 Then %>
				 <%=FormatCurrency(Price,2)%>
				<% End If %>
			</td>
		</tr>
<tr>
			<td  class = "body" align = "right">
					For Sale:
			</td>
			<td>&nbsp;</td>
			<td class = "body"><%=ProdForSale%>


			</td>
		</tr>
	<% If Category = "Clothing" Then %>
	<tr>
	<td></td>
	<td  class = "body" align = "left" colspan = "2">
	    <table>
			<tr>
				<td class = "body">
					Size 1:
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize1%>
				</td>
				<td width = "10">&nbsp;</td>
				<td class = "body">
					Size 6:
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize6%>
				</td>
			</tr>

	<tr>
				<td class = "body">
					Size 2:
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize2%>
				</td>
				<td width = "10">&nbsp;</td>
				<td class = "body">
					Size 7:
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=ProdSize7%>
				</td>
			</tr>

	<tr>
				<td class = "body">
					Size 3:
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize3%>
				</td>
				<td width = "10">&nbsp;</td>
				<td class = "body">
					Size 8:
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=ProdSize8%>
				</td>
			</tr>
	<tr>
				<td class = "body">
					Size 4:
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=ProdSize4%>
				</td>
				<td width = "10">&nbsp;</td>
				<td class = "body">
					Size 9:
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize9%>
				</td>
			</tr>
				<tr>
				<td class = "body">
					Size 5:
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=ProdSize5%>
				</td>
				<td width = "10">&nbsp;</td>
				<td class = "body">
					Size 10:
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize10%>
				</td>
			</tr>

			</table>
			
		</td>
	</tr>
	<% Else %>
	<tr>
	<td  class = "body" align = "right" >
			Dimensions:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
		<%=ProdDimensions%>
			
		</td>
	</tr>
	<% End If %>

		
<% If Category = "Clothing" Then %>
	<tr>
	<td></td>
	<td  class = "body" align = "left" colspan = "2">
	    <table>
			<tr>
				<td class = "body">
					Color 1:
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=Color1%>
				</td>
				<td width = "10">&nbsp;</td>
				<td class = "body">
					Color 6:
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=Color6%>
				</td>
			</tr>

	<tr>
				<td class = "body">
					Color 2:
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=Color2%>
				</td>
				<td width = "10">&nbsp;</td>
				<td class = "body">
					Color 7:
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=Color7%>
				</td>
			</tr>

	<tr>
				<td class = "body">
					Color 3:
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=Color3%>
				</td>
				<td width = "10">&nbsp;</td>
				<td class = "body">
					Color 8:
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=Color8%>
				</td>
			</tr>
	<tr>
				<td class = "body">
					Color 4:
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=Color4%>
				</td>
				<td width = "10">&nbsp;</td>
				<td class = "body">
					Color 9:
				</td>
				<td >&nbsp;</td>
				<td class = "body">
					<%=Color9%>
				</td>
			</tr>
				<tr>
				<td class = "body">
					Color 5:
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=Color5%>
				</td>
				<td width = "10">&nbsp;</td>
				<td class = "body">
					Color 10:
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=Color10%>
				</td>
			</tr>

			</table>
			
		</td>
	</tr>
	
	<% End If %>









	<tr>
	<td  class = "body" align = "right" width = "150">
			Quantity Available:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
			<%=ProdQuantityAvailable %>
		</td>
	</tr>

	


<tr>
	<td  class = "body" align = "right" valign = "top">
			Description:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
			<%=Description%>
		</td>
	</tr>
</table>

<%
rs2.close
sql2 = "select * from sfproducts where sfProducts.ProdID = " & session("ID")  & " ;"
'response.write(sql2)

Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 

File1= rs2("prodImageLargePath")
If Len(File1) < 2 Then
   File1 = "http://www.ArtisanBarn.org/uploads/Artwork/ImageNotAvailable.jpg"
End If 
'response.write("File1=")
'response.write(rs2("ProdImage1"))
rs2.close
	   %>

		</td>
	</tr>
</table><br><br>




		
  
    <br> 

<table width = "700" align = "center">
	<tr>
		<td>
<form action= 'EditAd2.asp' method = "post">
<input name="box1" type = "hidden" value = "<%=CategoryID%>">
<input name="box2ID" type = "hidden" value = "<%=SubCategoryID%>">


<input name="ProdID" type = "hidden" value = "<%=session("ID") %>">
			<input type=submit value = "<--Go Back and Make Changes" size = "310" class = "body" >
			</form>
		
<form action= 'PlaceClassifiedAd0.asp' method = "post">


			<input type=submit value = "Add Another Listing -->" size = "310" class = "body" >
			</form>
		<form action= 'ProductsUploadPhotos.asp' method = "post">

<input name="ProdID" type = "hidden" value = "<%=session("ID") %>">
			<input type=submit value = "Upload Photos -->" size = "310" class = "body" >
			</form>
   </td>
    </tr>
</table>

		

<br><br><br>