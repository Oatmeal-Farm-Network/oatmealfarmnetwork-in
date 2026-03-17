<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<meta name="author" content="The Andresen Group">
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->

</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >


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
<body >
<% Current2="Products"
Current3 = "ProductEdit" %>
<!--#Include file="AdminHeader.asp"--> 
<% ProdID=request.form("ProdID") 
ProductID=request.form("ProductID") 
If len(ProdID) > 0 then
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

sql = "select * from productCategoriesList, sfCategories where productCategoriesList.prodCategoryID =  sfCategories.catID and prodcategoryID > 0 and ProductID = " & ProdID & ";" 
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
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
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
ProdID = rs("ProdID")
ProdProductID = rs("ProdProductID")
ProdPrice  = rs("ProdPrice")
ProdForSalex  = rs("ProdForSale")
SalePrice = rs("prodSalePrice")

if  SalePrice = "0.00"  or SalePrice = "0" then
SalePrice  = ""
else

end if
if  ProdPrice = "0.00"  or  ProdPrice  = "0" then
 ProdPrice  = ""
else

end if

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

 %>
<!--#Include file="AdminProductsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Select Another Product:</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960">
       <table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td >
<% 
Dim XIDArray(1000)
Dim XProdname(1000)
sql2 = "select * from sfProducts where PeopleID = " & session("PeopleID") & " order by Prodname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
	
While Not rs2.eof  
		XIDArray(acounter) = rs2("prodID")
		XProdname(acounter) = rs2("Prodname")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
			
<form action="AdminAdEdit2.asp" method = "post">

		<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "right"  valign ="top"    width = "600" >
			   <tr>
				 <td class = "body" align = "center">
					
					<select size="1" name="ProdID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=XIDArray(count)%>">
							<%=XProdname(count)%> <font class = "small"></font>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Select Another Product"  class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form></td></tr></table></td></tr></table>
		  		<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "870" align = "center">
  <tr><td>
	<div align = "right"><!--#Include file="AdminProductJumpLinks.asp"--> </div>
</td>
</tr>
</table>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Edit Product</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960">


<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"    width = "960">
<tr>
		<td class = "body" valign = "top"  width = "500">
			Make your changes below and then select the "Submit Changes" button at the bottom of the page.
   <form action= 'AdminAdEdit3.asp' method = "post" name="myform"> 
   <div align = "right"><input type=submit name= "button1" value = "Submit Changes" class = "regsubmit2" ></div>
</td>
</tr>

<tr>
<td>


<input name="Subject" type = "hidden" value = "<%=Subject%>">
<input name="ProdID" type = "hidden" value = "<%=ProdID%>">
<input name="AdType" type = "hidden" value = "<%=AdType%>">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "940" align = "center">
  <tr>
    <td valign = "top" align = "right">
	<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=2 cellspacing=0 width = "500">
	<tr>
	<td  align = "right" colspan = "3" valign = "top">
	<table border = "0" cellspacing="0" cellpadding = "0" align = "left" ><tr><td class = "roundedtop" align = "right" >
		<H3><div align = "left">Basics</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "100" width = "500" valign = "top">
        <div align = "left"><img src ="images/px.gif" width = '70' height = "1" /><font class="body">* = Required Field</font></div>
        
        
        <table>
  <tr>
	<td  class = "body" width = "100"><div align = "right">
			Name*:</div>
		</td>
		<td>&nbsp;</td>
		<td class ="body" align = "left">
			<input name="ProdName" value="<%=ProdName %>" size = "50">
		</td>
	</tr>
	<tr>
	<td  class = "body" ><div align = "right">
			Product ID:</div>
		</td>
		<td>&nbsp;</td>
		<td class ="body" align = "left">
			<input name="ProdProductID" value="<%=ProdProductID %>" size = "50">
		</td>
	</tr>
	
	<tr><td colspan = "3">

<iframe src="AdminAddProductCategoriesInclude.asp?Category1ID=<%=Category1ID %>&Category2ID=<%=Category2ID %>&Category3ID=<%=Category3ID %>&SubCategory1ID=<%=SubCategory1ID %>&SubCategory2ID=<%=SubCategory2ID %>&SubCategory3ID=<%=SubCategory3ID %>" height = '190' width = '480' frameborder= '0' seamless = Yes scrolling = no></iframe>
</td></tr>
	
	


<tr><td  class = "body" ><div valign = "top" align = "right">
			Price:</div>
		</td>
		<td>&nbsp;</td>
		<td class ="body" align = "left">
		<% if len(ProdPrice) > 0 then  %>
		<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="ProdPrice" size=8 maxlength=8 value="<%=formatcurrency(ProdPrice,2) %>">
<% else %>
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="ProdPrice" size=8 maxlength=8 value="<%=ProdPrice %>">
<% end if %>
<br>	<i><font color = "#404040">Must be a number, if left blank than the price will be "Call for Price."</font></i>
</td></tr>
<tr><td  class = "body" ><div align = "right">
			Sale Price:</div>
		</td>
		<td>&nbsp;</td>
		<td class ="body" align = "left">
				<% if len(SalePrice) > 0 then  %>
		<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="SalePrice" size=8 maxlength=8 value="<%=formatcurrency(SalePrice,2) %>">
<% else %>
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="SalePrice" size=8 maxlength=8 value="<%=SalePrice %>">
<% end if %>
			<i><font color = "#404040">Must be a number.</font></i>
</td></tr>
<tr><td  class = "body" ><div align = "right">
			For Sale:</div>
		</td>
		<td>&nbsp;</td>
		<td class = "body">
			 <% 'response.write("prodForsalex=" & ProdForSalex ) %>

			<% if  ProdForSalex = "Yes" Or  ProdForSalex = "True" Then %>
						True<input TYPE="RADIO" name="ProdForSale" Value = True checked>
						False<input TYPE="RADIO" name="ProdForSale" Value = False >
					<% Else %>
						True<input TYPE="RADIO" name="ProdForSale" Value = True >
						False<input TYPE="RADIO" name="ProdForSale" Value = False checked>
				<% End if%>
		</td>
	</tr>
		<tr>
	<td  class = "body" ><div align = "right">
			# Available:</div>
		</td>
		<td>&nbsp;</td>
		<td class = "body" align = "left">
			<input name="ProdQuantityAvailable" onBlur="checkNumeric(this,-5,5000,',','.','-');" value="<%=ProdQuantityAvailable%>" size = "20"> 
		</td>
	</tr>
	<tr><td  class = "body" ><div align = "right">
			Made In:</div>
		</td>
		<td>&nbsp;</td>
		<td class = "body">
			<input name="ProdMadeIn" value="<%=ProdMadeIn%>" size = "20">
</td></tr>
<% showweight = False
 if showweight = True then %>
		<tr>
	<td  class = "body" valign = "top"><div align = "right">
			Weight:</div>
		</td>
		<td>&nbsp;</td>
		<td class = "body">
		<% If ProdWeight = "0" Then
		ProdWeight = " "
		End If %>
		<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='prodweight' size=10 maxlength=10 value="<%=ProdWeight %>"> lbs <br /><i>
			</td>
			</tr>
			<% end if %>
			</table>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr>
	<td  align = "right" colspan = "3"><br />
	<table border = "0" cellspacing="0" cellpadding = "0" align = "left" ><tr><td class = "roundedtop" align = "right" >
		<H3><div align = "left">Materials</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" height = "100" width = "500" valign = "top"><br />
               <i><font color = "#404040">List the different materials used in the creation of your product and the percent composition if appropriate (i.e. a silk and alpaca sweater may be 80% alpaca and 20% silk.)</font></i>
	   	    <table border = "0" width = "480" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	    <tr>
				<td class = "body2" align = "center" width = "100"></td>
				<td class = "body2" align = "center" width = "300"><b>Type</b></td>
				<td class = "body" align = "left" width = "80"><b>Percent</b></td>
			</tr>
		<tr>
				<td class = "body2"  align = "right" width = "90">
					Material 1:</td>
				<td class = "body" ><input type=text name='ProdFiberType1' size=40 maxlength=60 value="<%=ProdFiberType1 %>"></td>
				<td>
					<input type=text name='prodFiberPercent1' size=2 maxlength=4 value="<%=prodFiberPercent2 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
				</td>
			</tr>
		<tr>
				<td class = "body2"  align = "right" width = "90">
					Material 2:</td>
				<td class = "body"><input type=text name='ProdFiberType2' size=40 maxlength=60 value="<%=ProdFiberType2 %>"></td>
				<td>
					<input type=text name='prodFiberPercent2' size=2 maxlength=4 value="<%=prodFiberPercent2 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
				</td>
			</tr>
			<tr>
				<td class = "body2"  align = "right" width = "90">
					Material 3:</td>
				<td class = "body"><input type=text name='ProdFiberType3' size=40 maxlength=60 value="<%=ProdFiberType3 %>"></td>
				<td>
					<input type=text name='prodFiberPercent3' size=2 maxlength=4 value="<%=prodFiberPercent3 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
				</td>
			</tr>
			<tr>
				<td class = "body2"  align = "right" width = "90">
					Material 4:</td>
				<td class = "body"><input type=text name='ProdFiberType4' size=40 maxlength=60 value="<%=ProdFiberType4 %>"></td>
				<td>
					<input type=text name='prodFiberPercent4' size=2 maxlength=4 value="<%=prodFiberPercent4 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
				</td>
			</tr>
			<tr>
				<td class = "body2"  align = "right" width = "90">
					Material 5:</td>
				<td class = "body"><input type=text name='ProdFiberType5' size=40 maxlength=60 value="<%=ProdFiberType5 %>"></td>
				<td>
					<input type=text name='prodFiberPercent5' size=2 maxlength=4 value="<%=prodFiberPercent5 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
				</td>
			</tr>
			</table>
			</td>
			</tr>
			</table>
		</td>
	</tr>

	<tr>
	<td  align = "right" colspan = "3"><br />
	<table border = "0" cellspacing="0" cellpadding = "0" align = "left" ><tr><td class = "roundedtop" align = "right" >
		<H3><div align = "left">Sizes</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" height = "100" width = "500" valign = "top"><br />
        <i><font color = "#404040">List the different sizes that your product comes in and an additional cost that any products may have (i.e. an XXXL sweater may have an extra $3.00 cost due to the extra material.)</font></i>
        
	    <table border = "0" width = "480" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	       <tr>
				<td class = "body" width = "90"></td>
				
				<td class = "body2" align = "center" width = "300">
					<b>Size</b>
				</td>
				<td class = "body" align = "left" width = "90">
					<b>Extra Cost</b>
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 1:</td>
				<td class = "body">
					<input type=text 	name='ProdSize1' size=40 maxlength=60 value = "<%=ProdSize1 %>">
				</td>
				<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost1' size=5 maxlength=10 value="<%=ExtraCost1%>" >
				</td>
			</tr>
<tr>
				<td class = "body2" align = "right" >Size 2:</td>
				<td class = "body">
					<input type=text name='ProdSize2' size=40 maxlength=60 value = "<%=ProdSize2 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost2' size=5 maxlength=10 value="<%=ExtraCost2 %>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right"  >Size 3:</td>
				<td class = "body">
					<input type=text name='ProdSize3' size=40 maxlength=60 value = "<%=ProdSize3 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost3' size=5 maxlength=10 value="<%=ExtraCost3 %>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right">Size 4:</td>
				<td class = "body">
					<input type=text name='ProdSize4' size=40 maxlength=60 value = "<%=ProdSize4 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost4' size=5 maxlength=10 value="<%=ExtraCost4%>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 5:</td>
				<td class = "body">
					<input type=text 	name='ProdSize5' size=40 maxlength=60 value = "<%=ProdSize5 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost5' size=5 maxlength=10 value="<%=ExtraCost5%>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 6:</td>
				<td class = "body">
					<input type=text 	name='ProdSize6' size=40 maxlength=60 value = "<%=ProdSize6 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost6' size=5 maxlength=10 value="<%=ExtraCost6%> ">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 7:</td>
				<td class = "body">
					<input type=text 	name='ProdSize7' size=40 maxlength=60 value = "<%=ProdSize7 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost7' size=5 maxlength=10 value="<%=ExtraCost7%>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 8:</td>
					<td class = "body">
					<input type=text 	name='ProdSize8' size=40 maxlength=60 value = "<%=ProdSize8 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost8' size=5 maxlength=10 value="<%=ExtraCost8%>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 9:</td>
				
				<td class = "body">
					<input type=text 	name='ProdSize9' size=40 maxlength=60 value = "<%=ProdSize9 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost9' size=5 maxlength=10 value="<%=ExtraCost9%>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 10:</td>
				<td class = "body">
					<input type=text name='ProdSize10' size=40 maxlength=60 value = "<%=ProdSize10 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost10' size=5 maxlength=10 value="<%=ExtraCost10%>">
				</td>
			</tr>
			</table><br />
				</td>
			</tr>
			</table>
		</td>
	</tr>
</table>
 </td>
  <td width = "20"></td>
  <td align = "left" width = "410" valign = "top">
 <% showsalestax = false
 if showsalestax = True then %>

  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left" >
		<H3><div align = "left">State Sales Tax</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" height = "100" valign = "top"><br />
         <table border = "0" width = "400" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
        <tr><td class = "body2" align = "right" valign = "bottom">Tax this Item? &nbsp;</td>
        <td class = "body">
        <% if  prodStateTaxIsActive = "Yes" Or  prodStateTaxIsActive = "True" Then %>
						Yes:<input TYPE="RADIO" name="prodStateTaxIsActive" Value = True checked>
						No:<input TYPE="RADIO" name="prodStateTaxIsActive" Value = False >
					<% Else %>
						Yes: <input TYPE="RADIO" name="prodStateTaxIsActive" Value = True >
						No: <input TYPE="RADIO" name="prodStateTaxIsActive" Value = False checked>
				<% End if%>
        </td></tr>
        </table>
<% 
		
sqlt = "select * from people where peopleId = " & Session("PeopleID")
Set rst = Server.CreateObject("ADODB.Recordset")
rst.Open sqlt, conn, 3, 3   
TaxNexusState= rst("TaxNexusState")
TaxRate= rst("TaxRate")
if len(TaxRate) > 0 then
else
TaxRate= 0
end if
rst.close
%>
Tax rate:<%=TaxRate %>%<br />
To change your tax rate select <a href = "/ADMINISTRATION/AdminStoreMaintenance.asp#Taxes" class = "body" >Taxes</a>.
</td></tr></table>
<% end if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "410">
<tr><td class = "roundedtop" align = "left" >
<H3><div align = "left">Shipping & Handling</div></H3>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "410" valign = "top">

<!--#Include virtual="/Conn.asp"--> 
<% sqls = "select * from sfShipping where ProdID=" & ProdID
Set rss = Server.CreateObject("ADODB.Recordset")
rss.Open sqls, conn, 3, 3 
numcountries = rss.recordcount
rss.close
set conns = nothing
%>
<iframe src ="AdminShippingFrame.asp?ProdID=<%=ProdID %>" height="<%=(numcountries * 40) + 130 %>" width="410" frameborder = "0" scrolling = "yes" valign = "top" align = "center" style="background-color:white" ></iframe>
</td></tr></table>	
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left" >
		<H3><div align = "left">Colors</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">
	    <table border = "0" width = "400" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
			<tr>
				<td class = "body" >
					&nbsp;&nbsp;1:<input type=text 	name='Color1' size=23 maxlength=30  class = "body" value = "<%=Color1 %>">
				</td>
				<td class = "body">
					26:<input type=text 	name='Color26' size=23 maxlength=30  class = "body" value = "<%=Color26%>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					&nbsp;&nbsp;2:<input type=text 	name='Color2' size=23 maxlength=30  class = "body" value = "<%=Color2%>">
				</td>
				<td class = "body">
					27:<input type=text 	name='Color27' size=23 maxlength=30  class = "body" value = "<%=Color27 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					&nbsp;&nbsp;3:<input type=text 	name='Color3' size=23 maxlength=30  class = "body" value = "<%=Color3 %>">
				</td>
				<td class = "body">
					28:<input type=text 	name='Color28' size=23 maxlength=30  class = "body" value = "<%=Color28 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					&nbsp;&nbsp;4:<input type=text 	name='Color4' size=23 maxlength=30  class = "body" value = "<%=Color4 %>">
				</td>
				<td class = "body">
					29:<input type=text 	name='Color29' size=23 maxlength=30  class = "body" value = "<%=Color29 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					&nbsp;&nbsp;5:<input type=text 	name='Color5' size=23 maxlength=30  class = "body" value = "<%=Color5 %>">
				</td>
				<td class = "body">
					30:<input type=text 	name='Color30' size=23 maxlength=30  class = "body" value = "<%=Color30 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					&nbsp;&nbsp;6:<input type=text 	name='Color6' size=23 maxlength=30  class = "body" value = "<%=Color6 %>">
				</td>
				<td class = "body">
					31:<input type=text 	name='Color31' size=23 maxlength=30  class = "body" value = "<%=Color31 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					&nbsp;&nbsp;7:<input type=text 	name='Color7' size=23 maxlength=30  class = "body" value = "<%=Color7 %>">
				</td>
				<td class = "body">
					32:<input type=text 	name='Color32' size=23 maxlength=30  class = "body" value = "<%=Color32 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					&nbsp;&nbsp;8:<input type=text 	name='Color8' size=23 maxlength=30  class = "body" value = "<%=Color8 %>">
				</td>
				<td class = "body">
					33:<input type=text 	name='Color33' size=23 maxlength=30  class = "body" value = "<%=Color33 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					&nbsp;&nbsp;9:<input type=text 	name='Color9' size=23 maxlength=30  class = "body" value = "<%=Color9 %>">
				</td>
				<td class = "body">
					34:<input type=text 	name='Color34' size=23 maxlength=30  class = "body" value = "<%=Color34 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					10:<input type=text 	name='Color10' size=23 maxlength=30  class = "body" value = "<%=Color10 %>">
				</td>
				<td class = "body">
					35:<input type=text 	name='Color35' size=23 maxlength=30  class = "body" value = "<%=Color35 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					11:<input type=text 	name='Color11' size=23 maxlength=30  class = "body" value = "<%=Color11 %>">
				</td>
				<td class = "body">
					36:<input type=text 	name='Color36' size=23 maxlength=30  class = "body" value = "<%=Color36 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					12:<input type=text 	name='Color12' size=23 maxlength=30  class = "body" value = "<%=Color12 %>">
				</td>
				<td class = "body">
					37:<input type=text 	name='Color37' size=23 maxlength=30  class = "body" value = "<%=Color37 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					13:<input type=text 	name='Color13' size=23 maxlength=30  class = "body" value = "<%=Color13 %>">
				</td>
				<td class = "body">
					38:<input type=text 	name='Color38' size=23 maxlength=30  class = "body" value = "<%=Color38 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					14:<input type=text 	name='Color14' size=23 maxlength=30  class = "body" value = "<%=Color14 %>">
				</td>
				<td class = "body">
					39:<input type=text 	name='Color39' size=23 maxlength=30  class = "body" value = "<%=Color39 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					15:<input type=text 	name='Color15' size=23 maxlength=30  class = "body" value = "<%=Color15 %>">
				</td>
				<td class = "body">
					40:<input type=text 	name='Color40' size=23 maxlength=30  class = "body" value = "<%=Color40 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					16:<input type=text 	name='Color16' size=23 maxlength=30  class = "body" value = "<%=Color16 %>">
				</td>
				<td class = "body">
					41:<input type=text 	name='Color41' size=23 maxlength=30  class = "body" value = "<%=Color41 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					17:<input type=text 	name='Color17' size=23 maxlength=30  class = "body" value = "<%=Color17 %>">
				</td>
				<td class = "body">
					42:<input type=text 	name='Color42' size=23 maxlength=30  class = "body" value = "<%=Color42 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					18:<input type=text 	name='Color18' size=23 maxlength=30  class = "body" value = "<%=Color18 %>">
				</td>
				<td class = "body">
					43:<input type=text 	name='Color43' size=23 maxlength=30  class = "body" value = "<%=Color43 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					19:<input type=text 	name='Color19' size=23 maxlength=30  class = "body" value = "<%=Color19 %>">
				</td>
				<td class = "body">
					44:<input type=text 	name='Color44' size=23 maxlength=30  class = "body" value = "<%=Color44 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					20:<input type=text 	name='Color20' size=23 maxlength=30  class = "body" value = "<%=Color20 %>">
				</td>
				<td class = "body">
					45:<input type=text 	name='Color45' size=23 maxlength=30  class = "body" value = "<%=Color45 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					21:<input type=text 	name='Color21' size=23 maxlength=30  class = "body" value = "<%=Color21 %>">
				</td>
				<td class = "body">
					46:<input type=text 	name='Color46' size=23 maxlength=30  class = "body" value = "<%=Color46 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					22:<input type=text 	name='Color22' size=23 maxlength=30  class = "body" value = "<%=Color22 %>">
				</td>
				<td class = "body">
					47:<input type=text 	name='Color47' size=23 maxlength=30  class = "body" value = "<%=Color47 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					23:<input type=text 	name='Color23' size=23 maxlength=30  class = "body" value = "<%=Color23 %>">
				</td>
				<td class = "body">
					48:<input type=text 	name='Color48' size=23 maxlength=30  class = "body" value = "<%=Color48 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					24:<input type=text 	name='Color24' size=23 maxlength=30  class = "body" value = "<%=Color24 %>">
				</td>
				<td class = "body">
					49:<input type=text 	name='Color49' size=23 maxlength=30  class = "body" value = "<%=Color49 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					25:<input type=text 	name='Color25' size=23 maxlength=30  class = "body" value = "<%=Color25 %>">
				</td>
				<td class = "body">
					50:<input type=text 	name='Color50' size=23 maxlength=30  class = "body" value = "<%=Color50 %>">
				</td>
			</tr>
			</table>
				</td>
			</tr>
			</table>	
 	</td>
</tr>
<tr>
		<td  colspan = "3" align = "center" valign = "middle" class = "body" >
		<br>
<br />
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "center" >
		<H3><div align = "left">Description</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "100" width = "900" valign = "top"><br />
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
		<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		
    <script language="javascript1.2" type="text/javascript">
        // attach the editor to the textarea with the identifier 'textarea1'.

        WYSIWYG.attach("ProdDescription", mysettings);
        mysettings.Width = "880px"
        mysettings.Height = "300px"
 </script>
 
	<center>	<textarea name="ProdDescription" ID="ProdDescription" cols="40" rows="30"   ><%=ProdDescription%></textarea></center>
</td>
	</tr>
</table>
</td>
</tr>
<td  colspan = "3" align = "center" valign = "middle" class = "body" bgcolor = "dedede">
			<div align = "right"><input type=submit value = "Submit Changes" class = "regsubmit2" ></div>
		</td>
</tr>
</table>	</form>
<br />
</td>
</tr>
</table>
</td>
</tr>
</table>	
 <br><br>


<!--#Include file="adminFooter.asp"--> </Body>
</HTML>