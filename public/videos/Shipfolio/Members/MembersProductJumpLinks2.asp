
<%

if rs.state > 0 then
    rs.close
end if

ProdID=request.form("ProdID") 
ProductID=request.form("ProductID") 
If len(ProdID) > 0 then
Else
ProdID= Request.QueryString("ProdID") 
End if 


If len(ProdID) > 0 then
 Session("ProdID") = ProdID
Else
'ProdID= Session("ProdID") 
End if

Session("PhotoPageCount") = 0
if len(ProdID) > 0 then
sql = "select * from ProductsPhotos where id = " & ProdID
'response.write("sql=" & sql )
rs.Open sql, conn, 3, 3
If rs.eof Then
	Query =  "INSERT INTO ProductsPhotos (ID)" 
	Query =  Query & " Values (" &  prodID & ")"

conn.Execute(Query) 
end if

end if




'*******************Get Customer Location *********************
PeopleID = Session("PeopleID")
Dim CurrentCategoryID
Dim CurrentCategoryName

Dim SubCurrentCategoryID
Dim SubCurrentCategoryName

prodCategory1ID = request.querystring("prodCategory1ID")
if len(prodCategory1ID) > 0 then
else
prodCategory1ID = session("prodCategory1ID")
end if

prodCategory2ID = request.querystring("prodCategory2ID")
if len(prodCategory2ID) > 0 then
else
prodCategory2ID = session("prodCategory2ID")
end if

prodCategory3ID = request.querystring("prodCategory3ID")
if len(prodCategory3ID) > 0 then
else
prodCategory3ID = session("prodCategory3ID")
end if

prodSubCategory1ID = request.querystring("prodSubCategory1ID")
if len(prodSubCategory1ID) > 0 then
else
prodSubCategory1ID = session("prodSubCategory1ID")
end if

prodSubCategory2ID = request.querystring("prodSubCategory2ID")
if len(prodSubCategory2ID) > 0 then
else
prodSubCategory2ID = session("prodSubCategory2ID")
end if

prodSubCategory3ID = request.querystring("prodSubCategory3ID")
if len(prodSubCategory3ID) > 0 then
else
prodSubCategory3ID = session("prodSubCategory3ID")
end if

if rs.state = 0 then
else
rs.close
end if

sql = "select * from people where peopleId = " & PeopleID & ";"
rs.Open sql, conn, 3, 3   
if not rs.eof then
PaypalEmail = rs("PaypalEmail")
end if
if len(ProdID) > 0 then
    sql = "select * from productCategoriesList, sfCategories where productCategoriesList.prodCategoryID =  sfCategories.catID and prodcategoryID > 0 and ProductID = " & ProdID & ";" 
    'response.write("sql=" & sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    Set rs3 = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 

    if not rs.eof then
	    Category1= rs("CatName")
	    prodCategory1ID = rs("catID")
        prodSubCategory1ID = rs("prodSubCategoryId")
		ProductCategoriesListID1= rs("ProductCategoriesListID")
    end if

    if not rs.eof then
	    rs.movenext
    end if
    if not rs.eof then
	    Category2= rs("CatName")
	    prodCategory2ID = rs("catID")
	    prodSubCategory2ID = rs("prodSubCategoryId")
	    ProductCategoriesListID2= rs("ProductCategoriesListID")
    end if
    if not rs.eof then
	    rs.movenext
    end if
    if not rs.eof then
	    Category3= rs("CatName")
	    prodCategory3ID = rs("catID")
	    prodSubCategory3ID = rs("prodSubCategoryId")
	    ProductCategoriesListID3= rs("ProductCategoriesListID")
    end if
    rs.close

    noproducts = True
    sql = "select * from sfProducts where sfProducts.ProdID = " & ProdID & ";" 
    'response.write("sql=" & sql )
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
    if not rs.eof then
        noproducts = False
        ProductID = rs("ProdProductID")
        ProdPrice  = rs("ProdPrice")
        ProdForSalex  = rs("ProdForSale")
        SalePrice = rs("SalePrice")

        if  SalePrice = "0.00"  or SalePrice = "0" then
            SalePrice  = ""
        else
        end if
        if ProdPrice = "0.00"  or  ProdPrice  = "0" then
            ProdPrice  = ""
        else
        end if
    prodCustomOrder = rs("prodCustomOrder")
    ProdDimensions  = rs("ProdDimensions")
    Prodsize1 =rs("Prodsize1")
    ProdSize2  = rs("ProdSize2")
    ProdSize3  = rs("ProdSize3")
    ProdSize4  = rs("ProdSize4")
    ProdSize5  = rs("ProdSize5")
    ProdSize6  = rs("ProdSize6")
    ProdSize7  = rs("ProdSize7")
    ProdSize8  = rs("ProdSize8")
    ProdSize9  = rs("ProdSize9")
    ProdSize10  = rs("ProdSize10")

    ExtraCost1 =rs("ExtraCost1")
    ExtraCost2 =rs("ExtraCost2")
    ExtraCost3 =rs("ExtraCost3")
    ExtraCost4 =rs("ExtraCost4")
    ExtraCost5 =rs("ExtraCost5")
    ExtraCost6 =rs("ExtraCost6")
    ExtraCost7 =rs("ExtraCost7")
    ExtraCost8 =rs("ExtraCost8")
    ExtraCost9 =rs("ExtraCost9")
    ExtraCost10 =rs("ExtraCost10")
    prodStateTaxIsActive=rs("prodStateTaxIsActive") 
    ProdAnimalID = rs("ProdAnimalID")
    ProdAnimalID2 = rs("ProdAnimalID2")
    ProdAnimalID3 = rs("ProdAnimalID3")
    Color1 =rs("Color1")
    Color2 =rs("Color2")
    Color3 =rs("Color3")
    Color4 =rs("Color4")
    Color5 =rs("Color5")
    Color6 =rs("Color6")
    Color7 =rs("Color7")
    Color8 =rs("Color8")
    Color9 =rs("Color9")
    Color10 =rs("Color10")

    Color11 =rs("Color11")
    Color12 =rs("Color12")
    Color13 =rs("Color13")
    Color14 =rs("Color14")
    Color15 =rs("Color15")
    Color16 =rs("Color16")
    Color17 =rs("Color17")
    Color18 =rs("Color18")
    Color19 =rs("Color19")
    Color20 =rs("Color20")

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
	    ProdForSale = False
    End if

    ProdName  = rs("ProdName")

    str1 = ProdName
    str2 = "'"
    If InStr(str1,str2) > 0 Then
	    ProdName= Replace(str1, "'", "'")
    End If
    end if
	rs.close
END IF
	'response.write("ProdName=" & ProdName )


'Dim CategoryID(100,100)
'Dim CatName(100,100)

'Dim SubCategoryIDX(1000)
'Dim SubCatName(1000)

'sql = "select * from SFCategories  order by Catname " 
'Set rs = Server.CreateObject("ADODB.Recordset")
 '   rs.Open sql, conn, 3, 3 
'	CatCounter= 0
'	 While Not rs.eof 
'		CatCounter = CatCounter + 1
'		CategoryID(CatCounter,0) = rs("CatID")
'		CatName(CatCounter,0) = rs("CatName")
'		'response.write(CatName(CatCounter,0))
'		rs.movenext
'	Wend
	FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
firsttime = False
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1
	
	

	sql = "select * from SFSubCategories where CategoryID = '" & CategoryID(CatCounter,0) & "' Order by SubcategoryName"
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	If Not rs.eof Then
	SubCatCounter= 0
	If Len(SubCurrentCategoryName) > 0 And firsttime = False  Then
		firsttime = True
		Varieties =  Varieties  & " [""" & SubCurrentCategoryName & """], "
		Varieties =  Varieties  & " ["" No Sub Categories "" ," & vbCrLf
	Else
			Varieties =  Varieties  & " ["" Sub Categories "", "
	End if
	While Not rs.eof
		SubCatCounter= SubCatCounter +1
		SubCatCounter2 = SubCatCounter2  +1
		CategoryID(CatCounter,SubCatCounter) = rs("subcatId") 
		CatName(CatCounter,SubCatCounter) = rs("SubCategoryName") 

		SubCategoryIDX(SubCatCounter2) = rs("subcatId") 
		SubCatName(SubCatCounter2) = rs("SubCategoryName") 
		Varieties  = Varieties & """"  & CatName(CatCounter,SubCatCounter)  
		
rs.movenext
If Not(rs.eof) Then 
Varieties  = Varieties  &  """ , " 
End If 
	Wend
	Varieties  = Varieties & """ ]," & vbCrLf
	Else
		If SubCurrentCategoryID > 0  Then
		
		Varieties =  Varieties  & " [""" & SubCurrentCategoryName & """ ]," & vbCrLf
		
		Else
		If firsttime = False Then
			firsttime = True
				Varieties =  Varieties  & " ["" No Sub Categories "" ]," & vbCrLf
				Varieties =  Varieties  & " ["" No Sub Categories "" ]," & vbCrLf
		Else
				Varieties =  Varieties  & " ["" No Sub Categories "" ]," & vbCrLf
		End if
		
		End if
	End If 
wend

FinalSubCatCounter2 = SubCatCounter2
   		FinalSubCatCounter = CatCounter

Varietielen  = Len(Varieties)
'response.write(Varieties)
'Varieties = Left(Varieties, (Varietielen-3))
 %>
<br />

<a href = "#Top" class = "body"></a>
<div class="nav" style ="min-height: 40px">

<div >
    <a class="jumplinks" href="MembersProductList.asp?ProdID=<%=ProdID %>#top"><img src= "https://www.GlobalLivestockSolutions.com/images/Products.svg" alt = "edit" height ="64" border = "0"></a>
</div>


<% if Current3 = "Summary" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProductList.asp?ProdID=<%=ProdID %>#top"><b>List</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="MembersProductList.asp?ProdID=<%=ProdID %>#top">List</a>
  </div>
<%end if %>

<% if Current3 = "Add" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersClassifiedAdPlace0.asp#top"><b>Add</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersClassifiedAdPlace0.asp#top">Add</a>
  </div>
<%end if %>


    <% If noproducts = False then %>
<% if len(ProdID) > 1 then %>

    <% if Current3 = "Basics" then %>
    <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProductEditBasic.asp?ProdID=<%=ProdID %>#top"><b>Basics</b></a>
    </div>
    <% else %> 
    <div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
     <a class="jumplinks" href="MembersProductEditBasic.asp?ProdID=<%=ProdID %>#top">Basics</a>
    </div>
    <%end if %>

    <% if Current3 = "Description" then %>
    <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProductEditDescription.asp?ProdID=<%=ProdID %>#top"><b>Description</b></a>
    </div>
    <% else %> 
    <div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProductEditDescription.asp?ProdID=<%=ProdID %>#top">Description</a>
    </div>
    <%end if %>

    <% if prodPurchasemethod = "PayPal" then %>
        <% if Current3 = "Shipping" then %>
        <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
        <a class="jumplinks" href="MembersProductEditShipping.asp?ProdID=<%=ProdID %>#top"><b>Shipping</b></a>
        </div>
        <% else %> 
        <div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
        <a class="jumplinks" href="MembersProductEditShipping.asp?ProdID=<%=ProdID %>#top">Shipping</a>
        </div>
        <%end if %>
    <% end if %>

    <% if Current3 = "Photos" then %>
    <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProductsUploadPhotos.asp?ProdID=<%=ProdID %>#Photos"><b>Photos</b></a>
    </div>
    <% else %> 
    <div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProductsUploadPhotos.asp?ProdID=<%=ProdID %>#Photos">Photos</a>
    </div>
    <%end if %>

 

    
<% end if %>


       <% if Current3 = "Delete" then %>
    <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersDeleteListing.asp?ProdID=<%=ProdID %>#Photos"><b>Delete</b></a>
    </div>
    <% else %> 
    <div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersDeleteListing.asp?ProdID=<%=ProdID %>#Photos">Delete</a>
    </div>
    <%end if %>
<% end if %>


<% if Current3 = "Statistics" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProductStats.asp?ProdID=<%=ProdID %>"><b>Statistics</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="MembersProductStats.asp?ProdID=<%=ProdID %>">Statistics</a>
  </div>
<%end if %>

<% if Current3 = "Settings" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href=" MembersProductECommerce.asp"><b>Settings</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href=" MembersProductECommerce.asp">Settings</a>
  </div>
<%end if %>

</div>

<span class="border-bottom-3"></span>

<table width = "100%" class="body"><tr><td class = "body"><h2><% =ProdName %></h2></td></tr></table>
<% if len(ProdName) > 1 and len(ProdID) > 1 then %>

<span class="border-bottom-3"></span>

 <center><iframe src="/members/MembersProductPublishFrame.asp?ProdID=<%=ProdID %>" frameborder =0 width = "100%" height = "80" scrolling = "no" class ="roundedtopandbottom" align = "center" ></iframe></center>

<% end if %>