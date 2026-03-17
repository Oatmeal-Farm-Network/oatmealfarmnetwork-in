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

<%
Subject="For Sale"
MissingSubCategory = request.QueryString("MissingSubCategory")
MissingProdName = request.QueryString("MissingProdName")
MissingProdPrice= request.QueryString("MissingProdPrice")
Missingcategory= request.QueryString("Missingcategory")
ProductID=request.querystring("ProductID") 
Category1ID=request.querystring("Category1ID") 
Category2ID=request.querystring("Category2ID") 
Category3ID=request.querystring("Category3ID") 
prodCallForPrice=request.querystring("prodCallForPrice") 
SubCategory1ID = request.querystring("SubCategory1ID")
SubCategory2ID = request.querystring("SubCategory2ID") 
SubCategory3ID = request.querystring("SubCategory3ID")


ProdName=request.querystring("ProdName") 
ProdPrice =request.querystring("ProdPrice")
SalePrice =request.querystring("SalePrice")
ProdQuantityAvailable=request.querystring("ProdQuantityAvailable")
ProdForSale =request.querystring("ProdForSale")
if len(ProdForSale) > 0 then
else
ProdForSale = True
end if

ProdDescription   =request.querystring("ProdDescription")
ProdSellStore =request.querystring("ProdSellStore")
Prodsize1 =request.querystring("Prodsize1")
Prodsize2 =request.querystring("Prodsize2")
Prodsize3 =request.querystring("Prodsize3")
Prodsize4 =request.querystring("Prodsize4")
Prodsize5 =request.querystring("Prodsize5")
Prodsize6=request.querystring("Prodsize6")
Prodsize7 =request.querystring("Prodsize7")
Prodsize8 =request.querystring("Prodsize8")
Prodsize9 =request.querystring("Prodsize9")
Prodsize10 =request.querystring("Prodsize10")
ExtraCost1 =request.querystring("ExtraCost1")
ExtraCost2 =request.querystring("ExtraCost2")
ExtraCost3 =request.querystring("ExtraCost3")
ExtraCost4 =request.querystring("ExtraCost4")
ExtraCost5 =request.querystring("ExtraCost5")
ExtraCost6=request.querystring("ExtraCost6")
ExtraCost7 =request.querystring("ExtraCost7")
ExtraCost8 =request.querystring("ExtraCost8")
ExtraCost9 =request.querystring("ExtraCost9")
ExtraCost10 =request.querystring("ExtraCost10")

Color1=request.querystring( "Color1" )
Color2=request.querystring( "Color2" ) 
Color3=request.querystring( "Color3" ) 
Color4=request.querystring( "Color4" ) 
Color5=request.querystring( "Color5" ) 
Color6=request.querystring( "Color6" ) 
Color7=request.querystring( "Color7" ) 
Color8=request.querystring( "Color8" ) 
Color9=request.querystring( "Color9" ) 

Color10=request.querystring( "Color10") 
Color11=request.querystring( "Color11" ) 	
Color12=request.querystring( "Color12") 
Color13=request.querystring( "Color13") 
Color14=request.querystring( "Color14") 
Color15=request.querystring( "Color15")
Color16=request.querystring( "Color16")
Color17=request.querystring( "Color17")
Color18=request.querystring( "Color18")
Color19=request.querystring( "Color19")
Color20=request.querystring( "Color20")

Color21=request.querystring( "Color21")
Color22=request.querystring( "Color22")
Color23=request.querystring( "Color23")
Color24=request.querystring( "Color24")
Color25=request.querystring( "Color25")
Color26=request.querystring( "Color26")
Color27=request.querystring( "Color27")
Color28=request.querystring( "Color28")
Color29=request.querystring( "Color29")
Color30=request.querystring( "Color30")

Color31=request.querystring( "Color31") 
Color32=request.querystring( "Color32")
Color33=request.querystring( "Color33")
Color34=request.querystring( "Color34")
Color35=request.querystring( "Color35")
Color36=request.querystring( "Color36")
Color37=request.querystring( "Color37")
Color38=request.querystring( "Color38")
Color39=request.querystring( "Color39")
Color40=request.querystring( "Color40")

Color41=request.querystring( "Color41")
Color42=request.querystring( "Color42")
Color43=request.querystring( "Color43")
Color44=request.querystring( "Color44")
Color45=request.querystring( "Color45")
Color46=request.querystring( "Color46")
Color47=request.querystring( "Color47")
Color48=request.querystring( "Color48")
Color49=request.querystring( "Color49")
Color50=request.querystring( "Color50")

ProdMadeIn=request.querystring( "ProdMadeIn")

ProdFiberType1=request.querystring( "ProdFiberType1") 
ProdFiberType2=request.querystring( "ProdFiberType2") 
ProdFiberType3=request.querystring( "ProdFiberType3") 
ProdFiberType4=request.querystring( "ProdFiberType4") 
ProdFiberType5=request.querystring( "ProdFiberType5") 
prodFiberPercent1=request.querystring( "prodFiberPercent1") 
prodFiberPercent2=request.querystring( "prodFiberPercent2")
prodFiberPercent3=request.querystring( "prodFiberPercent3")
prodFiberPercent4=request.querystring( "prodFiberPercent4")
prodFiberPercent5=request.querystring( "prodFiberPercent5")


if len(Category1ID) > 0 then
    if Category1ID > 0 then
    sql = "select CatName from SFCategories where CatID= " & Category1ID
    response.write("sql=" & sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, Conn, 3, 3 
        if not rs.eof then
            Category1 = rs("CatName")
        end if 
        rs.close
    end if
end if

if len(Category2ID) > 0 then
    if Category2ID > 0 then
    sql = "select CatName from SFCategories where CatID= " & Category2ID
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
        if not rs.eof then
            Category2 = rs("CatName")
        end if 
           rs.close
    end if
end if

if len(Category3ID) > 0 then
    if Category3ID > 0 then
    sql = "select CatName from SFCategories where CatID= " & Category3ID
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
        if not rs.eof then
            Category3 = rs("CatName")
        end if
     rs.close       
    end if
end if
%>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current2="AdminHome" %> 
<!--#Include file="adminHeader.asp"-->
<% If not rs.State = adStateClosed Then
 rs.close
End If   	
Current3 = "AddProducts" %>
<!--#Include file="AdminProductsTabsInclude.asp"-->
<% 
Session("Step2") = False 
Session("PhotoPageCount") = 0
'*******************Get Customer Location *********************
sql = "select AddressID from People where Peopleid = 695;" 
'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	
	AddressID = rs("AddressID")

	rs.close

	sql = "select * from Address where AddressID = " & AddressID 
	'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	
	AddressCity = rs("AddressCity")
	AddressZip = rs("AddressZip")
	AddressState  = rs("AddressState")

	rs.close
	
	
If SubCategoryIDCount > 0 then

	sql = "select * from SFSubCategories where CategoryID = '" &  CategoryID & "' Order by SubcategoryName"
	Set rs = Server.CreateObject("ADODB.Recordset")
	'Response.write(sql)
	rs.Open sql, conn, 3, 3 
	CatCounter= 0
	For CatCounter = 0 To (SubCategoryIDCount -1 )
		If Not( rs. eof )Then
		SubCategoryID = rs("subcatId")
		'Response.write("SubCategoryID=")
		'Response.write(SubCategoryID)
		
			rs.movenext
		End If
	Next
	rs.MovePrevious
		SubCategoryID = rs("subcatId")
		'Response.write("SubCategoryID=")
		'Response.write(SubCategoryID)


 sql = "select * from SFSubCategories where subcatId = " & SubCategoryID & ";"
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	If Not rs.eof Then
		SubCategoryName = rs("SubCategoryName")

	End If
	
End If 
%>





<SCRIPT LANGUAGE="JavaScript">
<!-- Original:  Nannette Thacker -->
<!-- http://www.shiningstar.net -->
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
var checkOK = "0123456789. " + comma + period ;
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
alertsay = alertsay + checkOK +  "\"."
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
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "980"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Add a Product<a name="Add"></a></div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">
<blockquote><div align = "left" class = "body">Enter your information in the boxes below then select the "Save & Proceed to the Next Page ->" button at the bottom of the form to proceed to the next step.<br /><br /></div></blockquote>

<% if len(MissingProdName) > 0 or len(MissingProdName) > 0 or len(MissingProdPrice) > 0 or len(MissingSubCategory) > 0 then %>
<table width = '900' align = 'center'><tr><td align = "left" class = "body"><font color = "maroon"><b>Missing Information!<ul>
<%  if len(MissingProdName) > 0 then %>
<li>Please enter a Product Name.</li>
<% end if %>
<%  if len(Missingcategory) > 0 then %>
<li>Please select a category.</li>
<% end if %>
<%  if len(MissingProdPrice) > 0 then %>
<li>Please enter a price greater than $0.</li>
<% end if %>
<%  if len(MissingSubCategory) > 0 then %>
<li>Please enter at least on category and subcategory.</li>
<% end if %>
</ul></font></b></td></tr></table>
<% end if %>

<form name="myform" method="post" action= 'AdminClassifiedAdPlaceStep2.asp' >
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "940" align = "center">
  <tr>
    <td valign = "top" align = "right">
	<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=2 cellspacing=0 width = "500">
	<tr>
	<td  align = "right" colspan = "3" valign = "top">
	
	<table border = "0" width = "510" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr><td class = "roundedtop" align = "right" >
		<H3><div align = "left">Basics</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "100" width = "480" valign = "top">
        <div align = "left"><img src ="images/px.gif" width = '70' height = "1" /><font class="body">* = Required Field</font></div>
        <table>
  <tr>
	<td class = "body" width = "100"><div align = "right">
			Name*:&nbsp;</div>
		</td>
		<td class ="body" align = "left" width = "380">
			<input name="ProdName" value="<%=ProdName %>" size = "50">
		</td>
	</tr>
	
	<tr><td colspan = "2">
	<iframe src="AdminAddProductCategoriesInclude.asp?Category1ID=<%=Category1ID %>&Category2ID=<%=Category2ID %>&Category3ID=<%=Category3ID %>&SubCategory1ID=<%=SubCategory1ID %>&SubCategory2ID=<%=SubCategory2ID %>&SubCategory3ID=<%=SubCategory3ID %>&twocatagories=True" height = '210' width = '460' frameborder= '0' seamless = Yes scrolling = no></iframe>
	
	</td></tr>
		
		
	
<tr><td  class = "body" ><div align = "right">
			Price:&nbsp;</div>
		</td>
		<td class ="body" align = "left">
		$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="ProdPrice" size=10 maxlength=10 value="<%=ProdPrice%>">

			<i><font color = "#404040"><small>Must be a number, and greater than $0.</small></font></i>
</td></tr>

<tr><td  class = "body" ><div align = "right">
			Sale Price:&nbsp;</div>
		</td>
		<td class ="body" align = "left">
		$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="SalePrice" size=10 maxlength=10 value="<%=SalePrice%>">

			<i><font color = "#404040"><small>Must be a number, and greater than $0.</small></font></i>
</td></tr>
<tr><td  class = "body" ><div align = "right">
			For Sale:&nbsp;</div>
		</td>
		<td class = "body">
			<% if  ProdForSale = "Yes" Or  ProdForSale = True Then %>
						Yes<input TYPE="RADIO" name="ProdForSale" Value = True checked>
						No<input TYPE="RADIO" name="ProdForSale" Value = False >
					<% Else %>
						Yes<input TYPE="RADIO" name="ProdForSale" Value = True >
						No<input TYPE="RADIO" name="ProdForSale" Value = False checked>
				<% End if%>
		</td>
	</tr>
		<tr>
	<td  class = "body" ><div align = "right">
			# Available:&nbsp;</div>
		</td>
		<td class = "body" align = "left">
			<input name="ProdQuantityAvailable" onBlur="checkNumeric(this,-5,5000,',','.','-');" value="<%=ProdQuantityAvailable%>" size = "20"> 
		</td>
	</tr>
	<tr><td  class = "body" ><div align = "right">
			Made In:&nbsp;</div>
		</td>
		<td class = "body">
			<input name="ProdMadeIn" value="<%=ProdMadeIn%>" size = "20">
</td></tr>
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
               <i><font color = "#404040">List the different materials used in the creation of your product and the percent composition if appropriate (i.e. a silk and alpaca swaether may be 80% alpaca and 20% silk.)</font></i>
	   	    <table border = "0" width = "480" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	    <tr>
				<td class = "body2" align = "center" width = "100"></td>
				<td class = "body2" align = "center" width = "300"><b>Type</b></td>
				<td class = "body" align = "left" width = "80"><b>Percent</b></td>
			</tr>
		<tr>
				<td class = "body2"  align = "right" >
					Material 1:&nbsp;</td>
				<td class = "body" ><input type=text name='ProdFiberType1' size=40 maxlength=60 value="<%=ProdFiberType1 %>"></td>
				<td>
					<input type=text name='prodFiberPercent1' size=2 maxlength=4 value="<%=prodFiberPercent2 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
				</td>
			</tr>
		<tr>
				<td class = "body2"  align = "right" >
					Material 2:&nbsp;</td>
				<td class = "body"><input type=text name='ProdFiberType2' size=40 maxlength=60 value="<%=ProdFiberType2 %>"></td>
				<td>
					<input type=text name='prodFiberPercent2' size=2 maxlength=4 value="<%=prodFiberPercent2 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
				</td>
			</tr>
			<tr>
				<td class = "body2"  align = "right" >
					Material 3:&nbsp;</td>
				<td class = "body"><input type=text name='ProdFiberType3' size=40 maxlength=60 value="<%=ProdFiberType3 %>"></td>
				<td>
					<input type=text name='prodFiberPercent3' size=2 maxlength=4 value="<%=prodFiberPercent3 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
				</td>
			</tr>
			<tr>
				<td class = "body2"  align = "right" >
					Material 4:&nbsp;</td>
				<td class = "body"><input type=text name='ProdFiberType4' size=40 maxlength=60 value="<%=ProdFiberType4 %>"></td>
				<td>
					<input type=text name='prodFiberPercent4' size=2 maxlength=4 value="<%=prodFiberPercent4 %>" onBlur="checkNumeric(this,-5,5000,',','.','-');">%
				</td>
			</tr>
			<tr>
				<td class = "body2"  align = "right" >
					Material 5:&nbsp;</td>
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
				<td class = "body2" align = "right" >Size 1:&nbsp;</td>
				<td class = "body">
					<input type=text 	name='ProdSize1' size=40 maxlength=60 value = "<%=ProdSize1 %>">
				</td>
				<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost1' size=5 maxlength=10 value="<%=ExtraCost1%>" >
				</td>
			</tr>
<tr>
				<td class = "body2" align = "right" >Size 2:&nbsp;</td>
				<td class = "body">
					<input type=text name='ProdSize2' size=40 maxlength=60 value = "<%=ProdSize2 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost2' size=5 maxlength=10 value="<%=ExtraCost2 %>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 3:&nbsp;</td>
				<td class = "body">
					<input type=text name='ProdSize3' size=40  maxlength=60 value = "<%=ProdSize3 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost3' size=5 maxlength=10 value="<%=ExtraCost3 %>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 4:&nbsp;</td>
				<td class = "body">
					<input type=text name='ProdSize4' size=40 maxlength=60 value = "<%=ProdSize4 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost4' size=5 maxlength=10 value="<%=ExtraCost4%>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 5:&nbsp;</td>
				<td class = "body">
					<input type=text 	name='ProdSize5' size=40 maxlength=60 value = "<%=ProdSize5 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost5' size=5 maxlength=10 value="<%=ExtraCost5%>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 6:&nbsp;</td>
				<td class = "body">
					<input type=text 	name='ProdSize6' size=40 maxlength=60 value = "<%=ProdSize6 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost6' size=5 maxlength=10 value="<%=ExtraCost6%> ">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right"  >Size 7:&nbsp;</td>
				<td class = "body">
					<input type=text 	name='ProdSize7' size=40 maxlength=60 value = "<%=ProdSize7 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost7' size=5 maxlength=10 value="<%=ExtraCost7%>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 8:&nbsp;</td>
					<td class = "body">
					<input type=text 	name='ProdSize8' size=40 maxlength=60 value = "<%=ProdSize8 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost8' size=5 maxlength=10 value="<%=ExtraCost8%>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right" >Size 9:&nbsp;</td>
				
				<td class = "body">
					<input type=text 	name='ProdSize9' size=40  maxlength=60 value = "<%=ProdSize9 %>">
				</td>
<td>$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='ExtraCost9' size=5 maxlength=10 value="<%=ExtraCost9%>">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right">Size 10:&nbsp;</td>
				<td class = "body">
					<input type=text 	name='ProdSize10' size=40 maxlength=60 value = "<%=ProdSize10 %>">
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
   <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left" >
		<H3><div align = "left"><font color = "black">Shipping & Taxes</font></div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "50" valign = "top">
         <table border = "0" width = "400" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left"><tr><td class = "body2" valign = "top" align = "left">
     <font color="black"><b>You will be able to set shipping and tax information for this product on the next page.</b></font>
        </td></tr>
        </table>
        			
        </td>
        </tr>
        </table>
        <br />
  
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left" >
		<H3><div align = "left">Colors</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">
	    <table border = "0" width = "400" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
			<tr>
				<td class = "body">
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
 
	<center><textarea name="ProdDescription" ID="ProdDescription" cols="60" rows="20"   ><%=ProdDescription%></textarea></center>
</td>
	</tr>
</table>
</td>
</tr>
<td  colspan = "3" align = "center" valign = "middle" class = "body" bgcolor = "dedede">
			<div align = "right"><input type=submit value = "Save & Proceed to the Next Page ->" class = "regsubmit2" ></div>
		</td>
</tr>
</table>	</form>
<br />
</td>
</tr>
</table>	</td>
</tr>
</table>	
<br><br>
<!--#Include file="adminFooter.asp"--> </Body>
</HTML>