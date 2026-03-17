         


<td class = "products" width = "200" align = "center" >
<% 
Image = "/uploads/imagenotavailable.jpg"

If Not rs.eof Then 
sql2 = "SELECT sfProducts.*, sfCategories.*, ProductsPhotos.ProductImage1 FROM sfProducts, sfCategories, ProductsPhotos, sfcustomers WHERE sfProducts.custid = sfcustomers.custid and accesslevel > 0 and prodForSale = True and ProductsPhotos.ID=cint(sfProducts.prodid) And sfCategories.CatID=sfProducts.prodCategoryId And prodforsale=True And CatId=" &CatID & ";"

Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3  
max=rs2.recordcount - 1
min=1
minprice = 0
maxprice = 0
imagecount = 0
While Not rs2.eof 
	imagecount  = imagecount  +1
	Imagearray(imagecount) = rs2("productImage1")
currentprice = 	rs2("prodprice") 
If currentprice < minprice Or   minprice = 0 Then
	minprice =currentprice
End If 
If currentprice > maxprice Or   maxprice = 0 Then
	maxprice =currentprice
End If 
rs2.movenext
wend 
finalimagecount = imagecount
 If rs2.recordcount > 1 then
	rs2.movefirst
End If
If finalimagecount < 2 then
	productImage1 =Imagearray(1) 
Else
Randomize
randomnumber = int((finalimagecount -0+1)*rnd+0)
productImage1 =Imagearray(randomnumber)
End If 
If  Len(productImage1) > 3 Then
'productImage1 =rs2("productImage1")
Else
productImage1 = "imagenotavailable.jpg"
End If 
loopcounter = 0
If productImage1 = "imagenotavailable.jpg" And finalimagecount > 1  then
	while productImage1 = "imagenotavailable.jpg" And loopcounter < 8
		loopcounter = loopcounter  + 1
		randomnumber = int((finalimagecount -0+1)*rnd+0)
		productImage1 =Imagearray(randomnumber)
	If  Len(productImage1) > 3 Then
	Else
	productImage1 = "imagenotavailable.jpg"
End if
Wend
End If 

If rs2.recordcount = 1  Then
If Len(productImage1) < 30 Then 
	Image = "/uploads/" & productImage1
Else
 Image = productImage1
End If 
 End If

 If rs2.recordcount > 1 Then
Randomize
my_num=int((max-min+1)*rnd+min)
For i = 0 To my_num - 1
	rs2.movenext
Next
						
If Not rs2.eof Then
	If Len(productImage1) < 30 Then 
	Image = "/uploads/" & productImage1
Else
 Image = productImage1
End If 
End If 
End If 
							
Imagearray(0) = "" 
 rs.movenext  
End If %>


<table border = "1" bordercolor = "#abacab" width = "190" height = "200"   leftmargin="5" topmargin="5" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr><td class = "body" width = "190" align = "center">

<table border = "0"  width = "190" height = "200"   leftmargin="5" topmargin="5" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr><td class = "body" width = "190" align = "center">
<a href = "store.asp?catID=<%=CatID%>" class = "body">
<IMG alt="main image" border=0  src="<%= Image %>" align = "center" height = "120">
</a>
</td>
</tr>
<td class = "body" align = "center">
 <a href = "store.asp?subcatID=<%=CatID%>" class = "body">
<div align = "left"><b><%=Trim(CategoryName)%></b>
	
</b><br>
</div>

</td>
</tr>
</table>
</td>
</tr>
</table>
<br>
