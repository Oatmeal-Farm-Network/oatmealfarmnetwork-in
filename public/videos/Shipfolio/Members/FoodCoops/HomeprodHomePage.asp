<td class = "products" width = "200" align = "center" >
<% 
ProdImage = "/uploads/imagenotavailable.jpg"
numproducts =0
If Not rs.eof Then 
sql2 = "SELECT  distinct ProdPrice, ProdName, ProdDescription,  ProdSellStore, ProdMadeIn, ProdFiberType1, ProdFiberType2, ProdFiberType3, ProdFiberType4, ProdFiberType5, prodFiberPercent1, prodFiberPercent2, prodFiberPercent3, prodFiberPercent4, prodFiberPercent5, ProdID, sfproducts.peopleID, productImage1 FROM SFProducts, productCategoriesList, ProductsPhotos WHERE  productCategoriesList.prodCategoryId = " & CatID & " And sfProducts.prodId=ProductsPhotos.ID And sfProducts.prodId=productCategoriesList.ProductID and prodForSale = 1 and sfproducts.PeopleID = " & CurrentpeopleID & " order by  ProdPrice DESC " 
'response.write("sql2=" & sql2)

Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3  
max=0
while not rs2.eof
max = max + 1
rs2.movenext
wend
rs2.movefirst
max = max 

min=1
minprice = 0
maxprice = 0
imagecount = 0
While Not rs2.eof 
numproducts = max
	imagecount  = imagecount  +1
	Imagearray(imagecount) = rs2("productImage1")
	currentprice = 	rs2("prodprice") 

	if len(currentprice) > 0 then
	else currentprice = 0
	end if

	if len(minprice) > 0 then
	else minprice = 0
	end if

	if len(maxprice) > 0 then
	else maxprice = 0
	end if

If cint(currentprice) < cint(minprice) Or cint(minprice) = 0 Then
	minprice =currentprice
End If 
If cint(currentprice) > cint(maxprice) Or cint(maxprice) = 0 Then
	maxprice =currentprice
End If 

rs2.movenext
wend 
finalimagecount = imagecount
 If max > 1 then
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

If max = 1  Then
If Len(productImage1) < 30 Then 
	ProdImage = "/uploads/" & productImage1
Else
 ProdImage = productImage1
End If 
 End If

 If max > 1 Then
Randomize
my_num=int((max-min+1)*rnd+min)
For i = 0 To my_num - 1
	rs2.movenext
Next
						
If Not rs2.eof Then
	If Len(productImage1) < 30 Then 
	ProdImage = "/uploads/" & productImage1
Else
 ProdImage = productImage1
End If 
End If 
End If 
			
  If Len(ProdImage) > 1 Then
str1 = lcase(ProdImage) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
ProdImage =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If             
 End If        				
Imagearray(0) = "" 
 rs.movenext  
End If 
if numproducts > 0 then
%>

<table border = "0"  width = "200" height = "200"   leftmargin="5" topmargin="5" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr><td class = "body" width = "190" align = "center">

<table border = "0" bordercolor = "#abacab" width = "190" height = "180"   leftmargin="5" topmargin="5" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr><td class = "body2 roundedtopandbottom" width = "190" align = "center">


<a href = "RanchStore.asp?catID=<%=CatID%>&CurrentPeopleID=<%=currentPeopleID%>" class = "body">
<IMG alt="<%=Trim(CategoryName)%>" border=0  src="<%= ProdImage %>" align = "center" height = "130">
</a><br>
 <a href = "RanchStore.asp?catID=<%=CatID%>&CurrentPeopleID=<%=currentPeopleID%>" class = "body">
<b><%=Trim(CategoryName)%></b>
</td>
</tr>
</table>
</td>
</tr>
</table>
<br>
<% else
colcount  = colcount - 1
 end if %>
