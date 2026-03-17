<% 
 Dim Imagearray(1000)
While Not rs.eof  
counter = counter +1	

 %>          
 <table border = "0" width = "<%=screenwidth  - 200 %>"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr>
<% For counter = 1 To 3 
tempimage = ""
productImage1 = ""
Imagearray(1)  = ""
%>
<td class = "products" width = "200" align = "center" >
<% If Not rs.eof Then 
prodSubCategoryId = rs("prodSubCategoryId")
sql = "SELECT  distinct catname, prodSubCategoryId, prodCategoryId FROM sfProducts, sfcategories WHERE prodCategoryId=sfcategories.catID And Prodforsale=1 and  PeopleID = " & CurrentPeopleID  & " order by CatName " 

sql2 = "SELECT DISTINCT sfProducts.*, sfCategories.*, ProductsPhotos.* FROM sfProducts, sfCategories, sfcustomers, ProductsPhotos WHERE sfCategories.CatID=sfProducts.prodCategoryId and ProductsPhotos.ID=cint(sfProducts.prodid) and sfProducts.PeopleID= " & CurrentPeopleID & " and ProdForSale = 1 ORDER BY prodName DESC;"

	
sql2 = "SELECT ProductsPhotos.ProductImage1, prodprice FROM sfProducts, sfCategories, ProductsPhotos WHERE sfCategories.CatID=sfProducts.prodCategoryId and ProductsPhotos.ID=sfProducts.prodid and sfProducts.PeopleID= " & CurrentPeopleID & " and ProdForSale = 1 ORDER BY prodName DESC; "    
    	
'sql2 = "SELECT distinct sfProducts.*, sfCategories.*, ProductsPhotos.ProductImage1 FROM sfProducts, sfCategories, ProductsPhotos, sfcustomers WHERE sfProducts.PeopleID = sfcustomers.PeopleID and accesslevel > 0 and prodForSale = 1 and ProductsPhotos.ID=cint(sfProducts.prodid) And sfCategories.CatID=sfProducts.prodCategoryId And prodforsale=1 And prodSubCategoryId=" & prodSubCategoryId & " and sfProducts.PeopleID= " & CurrentPeopleID & " ORDER BY prodName DESC;"

'response.write ("sql2=" & sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3  
'response.write("recordcount=" & rs2.recordcount)
max=rs2.recordcount - 1
min=1
minprice = 0
maxprice = 0
imagecount = 0
	
If prodSubCategoryId > 0 Then
sql3 = "SELECT distinct subcategoryname, subcatID, ProductsPhotos.*  FROM sfProducts, sfsubCategories, productCategoriesList, ProductsPhotos WHERE productCategoriesList.ProductID = sfproducts.ProdID and  productCategoriesList.prodSubCategoryId = sfsubCategories.SubCatID and ProductsPhotos.ID =  sfProducts.ProdID and  productCategoriesList.prodSubCategoryId=" & rs("prodSubCategoryId") & " and sfproducts.PeopleID = " & CurrentPeopleId
'response.write(sql3)
Set rs3 = Server.CreateObject("ADODB.Recordset")
rs3.Open sql3, conn, 3, 3 
If Not rs3.eof Then
subcatname = rs3("subcategoryname")
subcatID = rs3("subcatID")
while not rs3.eof

tempimage = trim(rs3("productImage1"))

if len(tempimage) > 4 then
'response.write("tempimage=" & tempimage )
imagecount  = imagecount  +1 
Imagearray(imagecount) = tempimage
else
Imagearray(imagecount) =""
end if

rs3.movenext
wend
End if
rs3.close
Else
subcatname = ""
End If 

 finalimagecount = imagecount - 1

 If finalimagecount < 2 then
productImage1 =Imagearray(1) 
Else
Randomize
randomnumber = int((finalimagecount )*rnd+1)
productImage1 =Imagearray(randomnumber)
End If 
'response.write("randomnumber =" & randomnumber  )
If  Len(productImage1) > 3 Then
Else
productImage1 = "/uploads/imagenotavailable.jpg"
End if

str1 = lcase(productImage1)
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
productImage1= Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  

 loopcounter = 0


While Not rs2.eof 
	minprice = 0
    maxprice = 	0		     
Image = ""

prodCategoryId = rs("prodCategoryId") 
'if rs2("prodsubcategoryID")  = subcatID then
'imagecount  = imagecount  +1 
'Imagearray(imagecount) = rs2("productImage1")
'end if
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

	
 If rs2.recordcount > 1 then
rs2.movefirst
End If

prodSubCategoryId = rs("prodSubCategoryId")
%>
<a href = "RanchSubStore.asp?subcatID=<%=prodSubCategoryId%>&catID=<%=prodCategoryId %>&CurrentPeopleID=<%=CurrentPeopleID%>" class = "small">
<IMG alt="main image" border=0  src="<%= productImage1%>" align = "center" height = "140" class = "Pictures"><br>

<% 'response.Write("subcatname=" & subcatname )
if len(subcatname) > 1 then %>
	<b><%=Trim(subcatname)%></b><br>
<% End If %>
</b><br>
<br><br><br>
</div>
</td><% Imagearray(0) = "" 
 rs.movenext  
End If %>
<% Next %>

<% if counter < 4 then
for x = counter to 3 %>
<td></td>
<% next 
end if %>
</tr>
</table>
 <% Wend %>