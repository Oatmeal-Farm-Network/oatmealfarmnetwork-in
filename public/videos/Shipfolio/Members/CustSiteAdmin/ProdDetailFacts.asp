
<% 
ProdID=request.form("ProdID") 
If ProdID  >0 then
Else
ProdID= Request.QueryString("ProdID") 

End if

Session("PhotoPageCount") = 0

'*******************Get Customer Location *********************
PeopleID = Session("PeopleID")
Dim CurrentCategoryID
Dim CurrentCategoryName

Dim SubCurrentCategoryID
Dim SubCurrentCategoryName

dim ColorsArray(900)
dim DimensionsArray(900)
dim AttrpriceChangeArray(900)
dim AttrQuantityAvailableArray(900)

if rs2.state = 0 then
else
rs2.close
end if




sql2 = "select DimensionTitle from SFAttributeTitles where ProdID=" & ProdID
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then
DimensionTitle = rs2("DimensionTitle")
end if
rs2.close




sql2 = "select PrimaryAttribute from sfAttributePrimary where ProdID=" & ProdID
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then
PrimaryAttribute = rs2("PrimaryAttribute")
end if
rs2.close

if len(PrimaryAttribute) > 0 then
else
PrimaryAttribute = "Color"
end if



sql2 = "select distinct Color from sfAttributes where len(lcase(Color))> 0 and len(" & PrimaryAttribute & ")> 0 and ProdID=" & ProdID & " Order by Color"

'response.write("sql2=" & sql2)
i = 0
rs2.Open sql2, conn, 3, 3 
while not rs2.eof 
i =i + 1
ColorsArray(i) = rs2("Color")
rs2.movenext
wend
TotalColors= i
rs2.close
'response.write("TotalColors=" & TotalColors )


sql2 = "select distinct Dimension from sfAttributes where len(lcase(Dimension))> 0 and len(" & PrimaryAttribute & ")> 0 and ProdID=" & ProdID & " Order by Dimension"
i = 0
rs2.Open sql2, conn, 3, 3 
while not rs2.eof 
i =i + 1

DimensionsArray(i) = rs2("Dimension")

rs2.movenext
wend
TotalDimensions= i
'response.write("TotalDimensions=" & TotalDimensions )
rs2.close






Totalattributes = i
'response.write("Totalattributes=" & Totalattributes )
i = 0







sql = "select * from productCategoriesList, sfCategories where productCategoriesList.prodCategoryID =  sfCategories.catID and prodcategoryID > 0 and ProductID = " & ProdID & ";" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 

if not rs.eof then
	Category1= rs("CatName")
	'response.Write("Category1=" & Category1)
	Category1ID = rs("catID")
	ProductCategoriesListID1= rs("ProductCategoriesListID")
end if
if not rs.eof then
	rs.movenext
end if
if not rs.eof then
	Category2= rs("CatName")
	'response.Write("Category2=" & Category2)
	Category2ID = rs("catID")
	ProductCategoriesListID2= rs("ProductCategoriesListID")
end if
if not rs.eof then
	rs.movenext
end if
if not rs.eof then
	Category3= rs("CatName")
	Category3ID = rs("catID")
	'response.Write("Category3=" & Category3)
	ProductCategoriesListID3= rs("ProductCategoriesListID")
end if
rs.close

sql = "select * from sfProducts where sfProducts.ProdID = " & ProdID & ";" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
ProdPrice  = rs("ProdPrice")
ProductID  = rs("ProductID")
SalePrice  = rs("SalePrice")
ProdDimensions  = rs("ProdDimensions")
ProdCustomOrder = rs("ProdCustomOrder")

ProdMadeIn= rs("ProdMadeIn")

	ProdFiberType1= rs("ProdFiberType1") 
	ProdFiberType2= rs("ProdFiberType2") 
	ProdFiberType3= rs("ProdFiberType3") 
	ProdFiberType4= rs("ProdFiberType4") 
	ProdFiberType5= rs("ProdFiberType5") 

	prodFiberPercent1= rs("prodFiberPercent1") 
	prodFiberPercent2= rs("prodFiberPercent2") 
	prodFiberPercent3= rs("prodFiberPercent3") 
	prodFiberPercent4= rs("prodFiberPercent4") 
	prodFiberPercent5= rs("prodFiberPercent5") 
ProdWeight =rs("ProdWeight")
ProdQuantityAvailable  = rs("ProdQuantityAvailable")
prodImageLargePath  = rs("prodImageLargePath")
ProdDescription = rs("ProdDescription")
ProdSellStore =request.form("ProdSellStore")
ProdForSale = rs("ProdForSale")
If ProdQuantityAvailable = 0 Then
	ProdForSale = false
End if

ProdName  = rs("ProdName")

str1 = ProdName
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdName= Replace(str1, "'", "'")
End If

	rs.close

	'response.write("CurrentCategoryName=" & CurrentCategoryName )

NeedQTY=request.QueryString("NeedQTY")
NeedColor=request.QueryString("NeedColor")
NeedSize=request.QueryString("NeedSize")

'Response.Write("NeedSize = " & NeedSize )
%>

<FORM METHOD=POST  action= 'ShoppingBagAddVerify.asp' >

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" width = "<%=screenwidth - 430 %>" >
<tr>
<td  class = "body" ><h2><%=ProdName %></h2>
<%=ProdDescription%>	<br />
<% if len(saleprice) > 0 then %>
<% if len(ProdPrice) > 0 then %>
Full Price:<strike><%=formatcurrency(ProdPrice,2) %></strike>	<br />
<% end if %>
<font color = "hotpink"><b>Discount Price: <%=formatcurrency(saleprice,2) %></b></font><br />
<% else %>
<% if len(ProdPrice) > 1 then %>
<%=formatcurrency(ProdPrice,2) %>
<% else %>
Call For Price
<% end if %><br />
<% end if %>

<% if len(ProductID) > 1 then%>
<font color = "#bababab"><%=ProductID%></font><br />
<% end if %>		
<table cellpadding = 0 cellpadding = 0>
<% if len(ProdMadeIn) > 0 then %>
<tr><td class = "body2">
Made In:
</td>
<td class = "body2">
<%=ProdMadeIn%>
</td>
</tr>
<% end if %>

<% if len(ProdWeight) > 0 then %>
 <% if prodWeight > 0 then %>
	<tr><td class = "body2">Weight:</td>
	<td class = "body2"><%=ProdWeight %> lbs </td></tr>
<% end if %>
<% end if %>
<%if len(ProdFiberType1) > 0 or len(ProdFiberType2) > 0 or len(ProdFiberType3) > 0 or len(ProdFiberType4) > 0 or len(ProdFiberType5) > 0 then %>
<tr><td class = "body2">Made From:</td>
<td class = "body2">
<%if len(ProdFiberType1) > 0 then %>
<%if len(prodFiberPercent1) > 0 then %>
<%if prodFiberPercent1 > 0 then %>
<%=prodFiberPercent1 %>% 
<% end if %>
<% end if %>
<%=ProdFiberType1 %>
<% end if %>
</td></tr>

<%if len(ProdFiberType2) > 0 then %>
<%if len(prodFiberPercent2) > 0 then %>
<%if prodFiberPercent2 > 0 then %>
<tr><td>&nbsp;</td>
<td class = "body">
<%=prodFiberPercent2 %>% 
<% end if %>
<% end if %>
<%=ProdFiberType2 %>
</td></tr>
<% end if %>


<%if len(ProdFiberType3) > 0 then %>
<%if len(prodFiberPercent3) > 0 then %>
<%if prodFiberPercent3 > 0 then %>
<tr><td>&nbsp;</td>
<td class = "body">
<%=prodFiberPercent3 %>% 
<% end if %>
<% end if %>
<%=ProdFiberType3 %>
</td></tr>
<% end if %>


<%if len(ProdFiberType4) > 0 then %>
<%if len(prodFiberPercent4) > 0 then %>
<%if prodFiberPercent4 > 0 then %>
<tr><td>&nbsp;</td>
<td class = "body">
<%=prodFiberPercent4 %>% 
<% end if %>
<% end if %>
<%=ProdFiberType4 %>
</td></tr>
<% end if %>

<%if len(ProdFiberType5) > 0 then %>
<%if len(prodFiberPercent5) > 0 then %>
<%if prodFiberPercent5 > 0 then %>
<tr><td>&nbsp;</td>
<td class = "body">
<%=prodFiberPercent5 %>% 
<% end if %>
<% end if %>
<%=ProdFiberType5 %>
</td></tr>
<% end if %>
<% end if %>
</table>
<% if prodPurchasemethod = "Contact Me" or ProdCustomOrder = True then %>
To purchase this product please contact us:<br>
<blockquote>
<% if len(Businessname) > 0 then %>
<B><%=Businessname %></B><br />
<% end if %>
<% if len(Owners) > 0 then %>
<%=Owners %><br />
<% end if %>
<% if len(Phone) > 0 then %>
<%=Phone %><br />
<% end if %>
<% if len(AddressStreet) > 0 then %>
<%=AddressStreet %><br />
<% end if %>
<% if len(AddressCity) > 0 then %>
<%=AddressCity%>,&nbsp; 
<% end if %>
<% if len(AddressState ) > 0 then %>
<%=AddressState %>
<% end if %>
<% if len(AddressZip) > 0 then %>
&nbsp;<%=AddressZip%>
<% end if %>
<% if len(AddressCity) > 0 or len(AddressState) > 0 or len(AddressZip) > 0 then %>
<br />
<% end if %>
<a href = "/ContactUs.asp" class = "body">Contact Us</a>
</blockquote>
<% else%>
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"    width = "470">
<tr><td width = "3"><img src = "images/px.gif" width = "3" /></td>


<% if Totalattributes = 0 then %>


<% if NeedQTY = "True" then %>
<td class = "body2" bgcolor = "HotPink" >
<font color="white" size = "1">&nbsp;<b>! Please select a Quantity</B></font>
<% else %>
<td class = "body2"  >
<font color="#606060">Quantity</font><br>
<% end if %>
<% if len(ProdQuantityAvailable) > 0 then
if ProdQuantityAvailable > 0 then
else
ProdQuantityAvailable = 7
end if
else
ProdQuantityAvailable = 7
end if %>
<select size="1" name="Quantity" width="150" style="width: 150px">
<option name = "AID0" value= "1" selected><font color="#bababa">1</font></option>
<% count = 1
while count < ProdQuantityAvailable
count = count + 1 %>
<option value="<%=count %>"><font face = "verdana" size = "1"><%=count %></font>
</option>
<% 	
wend %>
</select>
</td>
<% else %>
<td class = "body2"  >
<br /><br />

<table cellpadding = 5 cellspacing = 5>
<tr>

<% if TotalColors > 0 then %>
<td>
<% if Totalcolors = 1 then %>
Color: <%=ColorsArray(1) %>
<% else %>

Color: 
<% i = 0 %>
<select size="1" name="Color" >
<option value=""><font face = "verdana" color="#abacab">Select a Color</font></option>
<% while i < Totalcolors
 i = i + 1 %>
<option value="<%=ColorsArray(i) %>"><font face = "verdana" size = "1"><%=ColorsArray(i) %></font>
</option>
<% wend %>
</select>
<% i = 0 %>
<% end if %>
</td>
<% end if %>



<% if TotalDimensions > 0 then %>
<td>
<% if TotalDimensions = 1 then %>
<%=DimensionTitle %>: <%=DimensionsArray(1) %>
<% else %>

Color: 
<% i = 0 %>
<select size="1" name="Dimension" >
<option value=""><font face = "verdana" color="pink">Select a <%=DimensionTitle %></font></option>
<% while i < TotalDimensions 
 i = i + 1 %>
<option value="<%=DimensionsArray(i) %>"><font face = "verdana" size = "1"><%=DimensionsArray(i) %></font>
</option>
<% wend %>
</select>
<% i = 0 %>
<% end if %>
</td>
<% end if %>
</tr>
</table>


</td>
<% end if %>
</tr>
</table>
</td>
</tr>
<tr>
<td>
<input name="ordtmpProdServiceIDType" type = "hidden" value = "Product">
<input name="ProdID" type = "hidden" value = "<%=ProdID %>"><br />
<div align = "center"><input type=submit value = "Add to Shopping Bag"  class = "Regsubmit2" ></div>
</form>
<br />
</td></tr></table>
<% end if %>
 <br><br>