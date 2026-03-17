<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"-->


<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function checkNumeric(objName,minval, maxval,comma,period,hyphen)
{
	var numberfield = objName;
	if (chkNumeric(objName,minval,maxval,comma,period,hyphen) == false)
	{
		numberfield.select();
		numberfield.focus();
		return false;
	}
	else
	{
		return true;
	}
}

function chkNumeric(objName,minval,maxval,comma,period,hyphen)
{
// only allow 0-9 be entered, plus any values passed
// (can be in any order, and don't have to be comma, period, or hyphen)
// if all numbers allow commas, periods, hyphens or whatever,
// just hard code it here and take out the passed parameters
var checkOK = "0123456789$ " + comma + period ;
var checkStr = objName;
var allValid = true;
var decPoints = 0;
var allNum = "";

for (i = 0;  i < checkStr.value.length;  i++)
{
ch = checkStr.value.charAt(i);
for (j = 0;  j < checkOK.length;  j++)
if (ch == checkOK.charAt(j))
break;
if (j == checkOK.length)
{
allValid = false;
break;
}
if (ch != ",")
allNum += ch;
}
if (!allValid)
{	
alertsay = "Please enter only these values \""
alertsay = alertsay + checkOK + "\" in the \"" + checkStr.name + "\" field."
alert(alertsay);
return (false);
}

// set the minimum and maximum
var chkVal = allNum;
var prsVal = parseInt(allNum);
if (chkVal != "" && !(prsVal >= minval && prsVal <= maxval))
{


}
}
//  End -->
</script>
<SCRIPT LANGUAGE="JavaScript">

<!-- Begin
   var submitcount=0;
   function checkSubmit() {

      if (submitcount == 0)
      {
      submitcount++;
      document.Surv.submit();
      }
   }


function wordCounter(field, countfield, maxlimit) {
wordcounter=0;
for (x=0;x<field.value.length;x++) {
      if (field.value.charAt(x) == " " && field.value.charAt(x-1) != " ")  {wordcounter++}  // Counts the spaces while ignoring double spaces, usually one in between each word.
      if (wordcounter > 250) {field.value = field.value.substring(0, x);}
      else {countfield.value = maxlimit - wordcounter;}
      }
   }

function textCounter(field, countfield, maxlimit) {
  if (field.value.length > maxlimit)
      {field.value = field.value.substring(0, maxlimit);}
      else
      {countfield.value = maxlimit - field.value.length;}
  }
//  End -->
</script>
</head>

<%
ProdID=request.form("ProdID") 
ProductID=request.form("ProductID") 
If len(ProdID) > 0 then
Else
ProdID= Request.QueryString("ProdID") 
End if


 if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&ProdID=<%=ProdID %>');">
<% end if %>
<% Current2="Products"
Current3 = "ProductEdit" 
showattributes = True

%>
<!--#Include file="AdminHeader.asp"--> 
<% 
dim IDArray(99999)
dim alpacaName(99999)



If len(ProdID) > 0 then
 Session("ProdID") = ProdID
Else
ProdID= Session("ProdID") 
End if

Session("PhotoPageCount") = 0



'*******************Get Customer Location *********************
PeopleID = Session("PeopleID")
Dim CurrentCategoryID
Dim CurrentCategoryName

Dim SubCurrentCategoryID
Dim SubCurrentCategoryName

prodCategory1ID = request.querystring("prodCategory1ID")
if len(prodCategory1ID) > 0 then
Category1ID = prodCategory1ID
end if
prodCategory2ID = request.querystring("prodCategory2ID")
if len(prodCategory2ID) > 0 then
Category2ID = prodCategory2ID
end if
prodCategory3ID = request.querystring("prodCategory3ID")
if len(prodCategory3ID) > 0 then
Category3ID = prodCategory3ID
end if

prodSubCategory1ID = request.querystring("prodSubCategory1ID")
if len(prodSubCategory1ID) > 0 then
SubCategory1ID = prodSubCategory1ID
end if

prodSubCategory2ID = request.querystring("prodSubCategory2ID")
if len(prodSubCategory2ID) > 0 then
SubCategory2ID = prodSubCategory2ID
end if

prodSubCategory3ID = request.querystring("prodSubCategory3ID")
if len(prodSubCategory3ID) > 0 then
SubCategory3ID = prodSubCategory3ID
end if

if rs.state = 0 then
else
rs.close
end if

sql = "select * from people where peopleId = 667"
rs.Open sql, conn, 3, 3   
if not rs.eof then
PaypalEmail = rs("PaypalEmail")
end if

sql = "select * from productCategoriesList, sfCategories where productCategoriesList.prodCategoryID =  sfCategories.catID and prodcategoryID > 0 and ProductID = " & ProdID & ";" 
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs3 = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 

if not rs.eof then
	Category1= rs("CatName")
	Category1ID = rs("catID")

	SubCategory1ID = rs("prodSubCategoryId")
	
	ProductCategoriesListID1= rs("ProductCategoriesListID")
end if
'response.Write("Category1ID=" & Category1ID )

if not rs.eof then
	rs.movenext
end if
if not rs.eof then
	Category2= rs("CatName")
	Category2ID = rs("catID")
	SubCategory2ID = rs("prodSubCategoryId")
	ProductCategoriesListID2= rs("ProductCategoriesListID")
end if
if not rs.eof then
	rs.movenext
end if
if not rs.eof then
	Category3= rs("CatName")
	Category3ID = rs("catID")
	SubCategory3ID = rs("prodSubCategoryId")
	ProductCategoriesListID3= rs("ProductCategoriesListID")
end if
rs.close


sql = "select * from sfProducts where sfProducts.ProdID = " & ProdID & ";" 
'response.write("sql=" & sql )
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
ProdPrice  = rs("ProdPrice")
ProductID = rs("ProductID")

ProdForSalex  = rs("ProdForSale")
SalePrice = rs("SalePrice")

if  SalePrice = "0.00"  or SalePrice = "0" then
SalePrice  = ""
else

end if
if  ProdPrice = "0.00"  or  ProdPrice  = "0" then
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
Color21 =rs("Color21")
Color22 =rs("Color22")
Color23 =rs("Color23")
Color24 =rs("Color24")
Color25 =rs("Color25")
Color26 =rs("Color26")
Color27 =rs("Color27")
Color28 =rs("Color28")
Color29 =rs("Color29")

Color30 =rs("Color30")
Color31 =rs("Color31")
Color32 =rs("Color32")
Color33 =rs("Color33")
Color34 =rs("Color34")
Color35 =rs("Color35")
Color36 =rs("Color36")
Color37 =rs("Color37")
Color38 =rs("Color38")
Color39 =rs("Color39")

Color40 =rs("Color40")
Color41 =rs("Color41")
Color42 =rs("Color42")
Color43 =rs("Color43")
Color44 =rs("Color44")
Color45 =rs("Color45")
Color46 =rs("Color46")
Color47 =rs("Color47")
Color48 =rs("Color48")
Color49 =rs("Color49")

Color50 =rs("Color50")
Color51 =rs("Color51")
Color52 =rs("Color52")
Color53 =rs("Color53")
Color54 =rs("Color54")
Color55 =rs("Color55")
Color56 =rs("Color56")
Color57 =rs("Color57")
Color58 =rs("Color58")
Color59 =rs("Color59")

Color60 =rs("Color60")
Color61 =rs("Color61")
'response.write("Color61=" & Color61)
Color62 =rs("Color62")
Color63 =rs("Color63")
Color64 =rs("Color64")
Color65 =rs("Color65")
Color66 =rs("Color66")
Color67 =rs("Color67")
Color68 =rs("Color68")
Color69 =rs("Color69")

Color70 =rs("Color70")
Color71 =rs("Color71")
Color72 =rs("Color72")
Color73 =rs("Color73")
Color74 =rs("Color74")
Color75 =rs("Color75")


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
	'ProdForSale = false
End if

ProdName  = rs("ProdName")

str1 = ProdName
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdName= Replace(str1, "'", "'")
End If

	rs.close

	'response.write("CurrentCategoryName=" & CurrentCategoryName )


Dim CategoryID(100,100)
Dim CatName(100,100)

Dim SubCategoryIDX(1000)
Dim SubCatName(1000)

sql = "select * from SFCategories  order by Catname " 
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CategoryID(CatCounter,0) = rs("CatID")
		CatName(CatCounter,0) = rs("CatName")
		'response.write(CatName(CatCounter,0))
		rs.movenext
	Wend
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
Varieties = Left(Varieties, (Varietielen-3))
Current3 = "ProductEdit"


 %><br />
<!--#Include file="AdminProductsTabsInclude.asp"-->

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Edit Product: <%=ProdName %></div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "<%=screenwidth %>">




<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>" align = "center">
  <tr><td>
<% 
if len(ProdID) > 0 then %>
 <!--#Include virtual="/administration/transfers/TransferMoveProductData.asp"-->

  <% end if %>

 
<br />
     <!--#Include virtual="/Conn.asp"--> 
 <form action="AdminAdEdit2.asp" method = "post">
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" >
<tr><td class = "body">
<% 
Dim XIDArray(1000)
Dim XProdname(1000)
sql2 = "select * from sfProducts order by Prodname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof  
XIDArray(acounter) = rs2("prodID")
XProdname(acounter) = rs2("Prodname")
acounter = acounter +1
rs2.movenext
Wend		
rs2.close

%>
<select size="1" name="ProdID">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
%>
<option name = "AID1" value="<%=XIDArray(count)%>">
<%=XProdname(count)%> <font class = "small"></font>
</option>
<% 	count = count + 1
wend %>
</select>
<input type=submit value = "SELECT ANOTHER PRODUCT"  class = "regsubmit2"  <%=Disablebutton %> >
</td></tr>
<tr><td height = 20><br></td></tr>
</table>
</form>


<br />
<form action= 'AdminPaypalemailHandleForm.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "510" align = "right">
<tr>
	<td  class = "body">
	<b>Email used in your paypal account</b>
	</td>
<td  valign = "top" class = "body">
	<input name="PaypalEmail"  size = "25" value = "<%=PaypalEmail %>">
	</td>
    <td  valign = "top" class = "body">
	<input type=  submit value = "SUBMIT" class = "regSubmit2" <%=Disablebutton %> >
	</td>
</tr>
<tr><td colspan = 3 class = body2 >
<font color = "#404040">You will need a PayPal account before you can receive payments online.<br /><br /></font>
</td></tr>
</table>
<input name="ProdID"  type = hidden value = "<%=ProdID %>">
</form>



<table width = <%=screenwidth -15  %> align = center cellpadding = 0 cellspacing = 0 border = 0 >
<tr><td class = roundedtop>
<h2>Photos</h2>
</td>
</tr>
<tr><td class = "body roundedBottom">
<a href = "AdminProductPhotos.asp?ID=<%=ProdID %>" class = 'body'>Click here</a> to add photos of your product.
</td>
</tr>
</table>

<iframe src="AdminProductGeneralStatsFrame.asp?ProdID=<%=ProdID %>" height = '1620' width = '<%=screenwidth %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>


<iframe src="AdminProductdescriptionFrame.asp?ProdID=<%=ProdID %>" height = '508' width = '<%=screenwidth %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>

<% sqls = "select * from sfShipping where ProdID=" & ProdID
Set rss = Server.CreateObject("ADODB.Recordset")
rss.Open sqls, conn, 3, 3 
numcountries = rss.recordcount
rss.close
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -10%>" >
<tr><td height = 20>
</td></tr>
<tr><td  align = "left" class = "roundedtop">
<H1>Shipping & Handling</H1>
</td></tr>
<tr><td class = "roundedBottom">
<iframe src ="AdminShippingFrame.asp?ProdID=<%=ProdID %>&screenwidth=<%=screenwidth %>" height="338" width="<%=screenwidth -80%>" frameborder = "0" scrolling = "auto" valign = "top" align = "center" ></iframe>
<br>
</td></tr>
<tr><td height = 13><br>
</td>
</tr>
<% sql = "select * from sfattributes where ProdId = " & ProdId & " order by  AttrPriceChange DESC"
'response.write("sql=" & sql)

rs.Open sql, conn, 3, 3   
TotalRecordcount = rs.RecordCount
rs.close

sql = "select * from sfattributes where ProdId = " & ProdId & " and (len(Color)> 0 or len(AttrpriceChange) > 0 or len(AttrQuantityAvailable) > 0 or len(AttrQuantityAvailable) > 0 or len(Dimension) > 0 )  order by  AttrPriceChange DESC"
rs.Open sql, conn, 3, 3   
filledRecordcount = rs.RecordCount
rs.close

if filledRecordcount > TotalRecordcount -5 then

Query =  " Insert into sfattributes (ProdId)  " 
Query =  Query & " Values ( " & ProdId & ")"
Conn.Execute(Query) 
Conn.Execute(Query) 
Conn.Execute(Query) 
Conn.Execute(Query) 
Conn.Execute(Query) 
end if


showsttributes = false
if showattributes = True then
sql = "select * from sfattributes where ProdId = " & ProdId & " order by  AttrPriceChange DESC"
rs.Open sql, conn, 3, 3   
TotalRecordcount = rs.RecordCount
rs.close

Frameheight = 300 + (TotalRecordcount *40)
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -10%>" >
<tr><td  align = "left" class = "roundedtop">
<H1>Pricing & Attributes</H1>
</td></tr>
<tr><td class = "roundedBottom">
<iframe src="AdminProductsAttributeValuesFrame.asp?ProdID=<%=ProdID %>&screenwidth=<%=screenwidth %>&ProdPrice=<%=ProdPrice %>" height = '<%=Frameheight %>' width = '<%=screenwidth -80%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = auto target="_self"></iframe>
</td></tr></table>


<% end if %>

<% 
showtaxes=False
if showtaxes = true then %>
<tr><td  align = "left" class = "roundedtop">
<H1>Taxes</H1>
</td></tr>
<tr><td class = "roundedBottom">

<iframe src="AdminProductTaxFrame.asp?ProdID=<%=ProdID %>&screenwidth=<%=screenwidth %>" height = '170' width = '<%=screenwidth -80%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = auto></iframe>

</td></tr>
<% end if %>

</table>	



</td>
</tr>
</table>	
 <br><br>


<!--#Include file="adminFooter.asp"--> </Body>
</HTML>