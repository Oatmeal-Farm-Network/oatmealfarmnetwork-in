<% Administration= True %><!--#Include virtual="/Conn.asp"--> 
<% 
'*******************Get Customer Location *********************
CustID = Session("CustID")
Dim SourceCategoryID
Dim SourceCategoryName
Dim SourceSubCategoryID
Dim SourceSubCategoryName
'response.write(ID)]
SourceProdID  = ProdID 

sql = "select * from productCategoriesList where  prodcategoryID > 0 and ProductID = " & ProdID & ";" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 

if not rs.eof then
	SourceCategory1ID = rs("catID")
	SourceSubCategory1ID = rs("prodSubCategoryId")
end if

if not rs.eof then
	rs.movenext
end if
if not rs.eof then
SourceCategory2ID = rs("catID")
SourceSubCategory2ID = rs("prodSubCategoryId")
end if
if not rs.eof then
	rs.movenext
end if
if not rs.eof then
SourceCategory3ID = rs("catID")
SourceSubCategory3ID = rs("prodSubCategoryId")
end if
rs.close

response.write("Category1ID=" & Category1ID & "<br>")
response.write("Category2ID=" & Category2ID & "<br>")
response.write("Category3ID=" & Category3ID & "<br>")
response.write("SubCategory1ID =" & SubCategory1ID  & "<br>")
response.write("SubCategory2ID =" & SubCategory2ID  & "<br>")
response.write("SubCategory3ID =" & SubCategory3ID  & "<br>")

sql = "select * from sfProducts where sfProducts.ProdID = " & ProdID & ";" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, Conn, 3, 3 
SourceLOAProductID  = rs("LOAProductID")
SourceProductID = rs("ProductID")
SourceProdPrice  = rs("ProdPrice")
sourceSalePrice = rs("SalePrice")
SourceProdDimensions  = rs("ProdDimensions")
sourceProdMadeIn = rs("ProdMadeIn")
SourceProdsize1 =rs("Prodsize1")
SourceProdSize2  = rs("ProdSize2")
SourceProdSize3  = rs("ProdSize3")
SourceProdSize4  = rs("ProdSize4")
SourceProdSize5  = rs("ProdSize5")
SourceProdSize6  = rs("ProdSize6")
SourceProdSize7  = rs("ProdSize7")
SourceProdSize8  = rs("ProdSize8")
SourceProdSize9  = rs("ProdSize9")
SourceProdSize10  = rs("ProdSize10")
SourceExtraCost1 = rs("ExtraCost1")
response.write("SourceExtraCost1 =" & SourceExtraCost1  )
SourceExtraCost2 = rs("ExtraCost2")
SourceExtraCost3 = rs("ExtraCost3")
SourceExtraCost4 = rs("ExtraCost4")
SourceExtraCost5 = rs("ExtraCost5")
SourceExtraCost6 = rs("ExtraCost6")
SourceExtraCost7 = rs("ExtraCost7")
SourceExtraCost8 = rs("ExtraCost8")
SourceExtraCost9 = rs("ExtraCost9")
SourceExtraCost10 = rs("ExtraCost10")
SourceColor1 =rs("Color1")
SourceColor2 =rs("Color2")
SourceColor3 =rs("Color3")
SourceColor4 =rs("Color4")
SourceColor5 =rs("Color5")
SourceColor6 =rs("Color6")
SourceColor7 =rs("Color7")
SourceColor8 =rs("Color8")
SourceColor9 =rs("Color9")
SourceColor10 =rs("Color10")
SourceColor11 =rs("Color11")
SourceColor12 =rs("Color12")
SourceColor13 =rs("Color13")
SourceColor14 =rs("Color14")
SourceColor15 =rs("Color15")
SourceColor16 =rs("Color16")
SourceColor17 =rs("Color17")
SourceColor18 =rs("Color18")
SourceColor19 =rs("Color19")
SourceColor20 =rs("Color20")
SourceColor21 =rs("Color21")
SourceColor22 =rs("Color22")
SourceColor23 =rs("Color23")
SourceColor24 =rs("Color24")
SourceColor25 =rs("Color25")
SourceColor26 =rs("Color26")
SourceColor27 =rs("Color27")
SourceColor28 =rs("Color28")
SourceColor29 =rs("Color29")
SourceColor30 =rs("Color30")
SourceColor31 =rs("Color31")
SourceColor32 =rs("Color32")
SourceColor33 =rs("Color33")
SourceColor34 =rs("Color34")
SourceColor35 =rs("Color35")
SourceColor36 =rs("Color36")
SourceColor37 =rs("Color37")
SourceColor38 =rs("Color38")
SourceColor39 =rs("Color39")
SourceColor40 =rs("Color40")
SourceColor41 =rs("Color41")
SourceColor42 =rs("Color42")
SourceColor43 =rs("Color43")
SourceColor44 =rs("Color44")
SourceColor45 =rs("Color45")
SourceColor46 =rs("Color46")
SourceColor47 =rs("Color47")
SourceColor48 =rs("Color48")
SourceColor49 =rs("Color49")
SourceColor50 =rs("Color50")
SourceProdFiberType1 =rs("ProdFiberType1")
SourceProdFiberType2 =rs("ProdFiberType2")
SourceProdFiberType3 =rs("ProdFiberType3")
SourceProdFiberType4 =rs("ProdFiberType4")
SourceProdFiberType5 =rs("ProdFiberType5")
SourceprodFiberPercent1 =rs("prodFiberPercent1")
SourceprodFiberPercent2 =rs("prodFiberPercent2")
SourceprodFiberPercent3 =rs("prodFiberPercent3")
SourceprodFiberPercent4 =rs("prodFiberPercent4")
SourceprodFiberPercent5 =rs("prodFiberPercent5")

SourceProdQuantityAvailable  = rs("ProdQuantityAvailable")
If SourceProdQuantityAvailable = 0 Then
    SourceProdQuantityAvailable = 1
End if
SourceprodImageLargePath  = rs("prodImageLargePath")

SourceProdDescription = rs("ProdDescription")
SourceProdSellStore =request.form("ProdSellStore")
SourceProdForSale = rs("ProdForSale")

SourceProdName  = rs("ProdName")
str1 =SourceProdName
str2 = "'"
If InStr(str1,str2) > 0 Then
SourceProdName= Replace(str1,  str2, "''")
End If  	 
		

	rs.close

sql = "select * from ProductsPhotos where ID = " & ProdID & ";" 
'response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, Conn, 3, 3 
	
	If Not rs.eof then
SourceProductImage1  = rs("ProductImage1")
SourceProductImage2  = rs("ProductImage2")
SourceProductImage3  = rs("ProductImage3")
SourceProductImage4  = rs("ProductImage4")
SourceProductImage5  = rs("ProductImage5")
SourceProductImage6  = rs("ProductImage6")
SourceProductImage7  = rs("ProductImage7")
SourceProductImage8  = rs("ProductImage8")
	Else
	SourceProductImage1  = ""
SourceProductImage2   = ""
SourceProductImage3   = ""
SourceProductImage4   = ""
SourceProductImage5   = ""
SourceProductImage6   = ""
SourceProductImage7   = ""
SourceProductImage8   = ""


	End if
    
%>

