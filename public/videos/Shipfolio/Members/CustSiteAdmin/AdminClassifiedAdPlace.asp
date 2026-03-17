<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Administration</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<!--#Include file="AdminGlobalVariables.asp"-->

<%
dim IDArray(99999)
dim alpacaName(99999)

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
prodCustomOrder = request.querystring("prodCustomOrder")
ProdCustomOrder =request.querystring("ProdCustomOrder")
ProdName=request.querystring("ProdName") 
ProdPrice =request.querystring("ProdPrice")

SalePrice =request.querystring("SalePrice")
ProdQuantityAvailable=request.querystring("ProdQuantityAvailable")
ProdForSale =request.querystring("ProdForSale")
prodCustomOrder =request.querystring("prodCustomOrder")
if len(ProdForSale) > 0 then
else
ProdForSale = True
end if
ProdAnimalID =request.querystring("ProdAnimalID")
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
<br>
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
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Add a Product<a name="Add"></a></div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">
<blockquote><div align = "left" class = "body">Enter your information in the boxes below then select the "Save & Proceed to the Next Page ->" button at the bottom of the form to proceed to the next step.<br /><br /></div></blockquote>

<% 
ProdNameFound = Request.querystring("ProdNameFound")
if ProdNameFound = "true" then%>
<table width = '<%=screenwidth %>' align = 'center'><tr><td align = "left" class = "body"><font color = "maroon"><b>Product name already exists! Please enter a new product name.</font>
</td></tr></table>
<% end if%>

<% if len(MissingProdName) > 0 or len(MissingProdName) > 0 or len(MissingProdPrice) > 0 or len(MissingSubCategory) > 0 then %>
<table width = '<%=screenwidth %>' align = 'center'><tr><td align = "left" class = "body"><font color = "maroon"><b>Missing Information!<ul>
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
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -40%>" align = "center">
  <tr>
    <td valign = "top" align = "right">
	<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=2 cellspacing=0 width = "<%=screenwidth -40%>">
	<tr>
	<td  align = "left" colspan = "3" valign = "top">
	
	<table border = "0" width = "<%=screenwidth -70%>" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr><td class = "roundedtop" align = "left" >
		<H3><div align = "left">Basics</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "100" width = "<%=screenwith %>" valign = "top">
        <div align = "center"><img src ="images/px.gif" width = '70' height = "1" /><font class="body">* = Required Field</font></div>
        <table>
  <tr>
	<td class = "body2" align = "right">
			Product Name*:&nbsp;</td>
            <td class ="body">
			<input name="ProdName" value="<%=ProdName %>" size = "50">
		</td>
	</tr>
      <tr>
	<td class = "body2" align = "right">
			Product ID:&nbsp;</td>
            <td class ="body">
			<input name="ProductID" value="<%=ProductID %>" size = "50">
		</td>
	</tr>
<tr><td colspan = "2">
	<iframe src="AdminAddProductCategoriesInclude.asp?Category1ID=<%=Category1ID %>&Category2ID=<%=Category2ID %>&Category3ID=<%=Category3ID %>&SubCategory1ID=<%=SubCategory1ID %>&SubCategory2ID=<%=SubCategory2ID %>&SubCategory3ID=<%=SubCategory3ID %>&twocatagories=True" height = '210' width = '460' frameborder= '0' seamless = Yes scrolling = no></iframe>
	
</td></tr>
<tr><td  class = "body2" align = "right" >
Price:&nbsp;</div>
</td>
<td class ="body" align = "left">
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="ProdPrice" size=10 maxlength=10 value="<%=ProdPrice%>"><br>
<i><font color = "#404040"><small>Must be a number, and greater than $0.</small></font></i>
</td></tr>
<tr><td  class = "body2" align = 'right'>
Sale Price:&nbsp;
</td>
<td class ="body" align = "left">
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" name="SalePrice" size=10 maxlength=10 value="<%=SalePrice%>"><br>
<i><font color = "#404040"><small>Must be a number, and greater than $0.</small></font></i>
</td></tr>
<tr><td  class = "body2" align = "right">
For Sale:&nbsp;</div>
</td>
<td class = "body">
<% if ProdForSale = "Yes" Or ProdForSale = True Then %>
Yes<input TYPE="RADIO" name="ProdForSale" Value = True checked>
No<input TYPE="RADIO" name="ProdForSale" Value = False >
<% Else %>
Yes<input TYPE="RADIO" name="ProdForSale" Value = True >
No<input TYPE="RADIO" name="ProdForSale" Value = False checked>
<% End if%>
</td></tr>
<tr><td  class = "body" ><div align = "right" >
<a class="tooltip" href="#"><b>Custom Order?:</b><span class="custom info"><em>Custom Orders</em>If your product is a custom order then customers will have to contact you to place their order. This allows you to get specifics that you need finish the customer’s order.</span></a>

</div></td>
<td class = "body"><% if prodCustomOrder = True  Then %>
Yes<input TYPE="RADIO" name="prodCustomOrder" Value = True checked>
No<input TYPE="RADIO" name="prodCustomOrder" Value = False >
<% Else %>
Yes<input TYPE="RADIO" name="prodCustomOrder" Value = True >
No<input TYPE="RADIO" name="prodCustomOrder" Value = False checked>
<% End if%>
<br><i><font color = "#404040"><small>Customers cannot place custom orders online, they must contact you to place their order. </small></font></i>
</td></tr>
<% 
if LivestockAvailable = True then 
sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"
if rs2.state = 0 then
else
rs2.close
end if
acounter = 1
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then
While Not rs2.eof  
IDArray(acounter) = rs2("ID")
alpacaName(acounter) = rs2("FullName")
acounter = acounter +1
rs2.movenext
Wend		
rs2.close
set rs2=nothing %>
<tr><td  class = "body" ><div align = "right" >
<a class="tooltip" href="#"><b>From Animal:</b><span class="custom info"><em>From Animal</em>If this product was made from one of your animals (usually their fiber/wool) then select the animal and a link will connect the product and animal on your website.</span></a>
</div></td>
<td>
<select size="1" name="ProdAnimalID" class = "regsubmit2 body">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter %>
<option name = "AID1" value="<%=IDArray(count)%>">
<%=alpacaName(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
</td></tr>
<% end if %>
<% end if %>
<tr>
<td class = "body" ><div align = "right">
# Available:</div>

<%
if len(ProdQuantityAvailable) < 1 then
ProdQuantityAvailable = ""
else
 if ProdQuantityAvailable = 0 then
ProdQuantityAvailable = ""
end if
end if%>
</td>
<td class = "body" align = "left">
<input name="ProdQuantityAvailable" onBlur="checkNumeric(this,-5,5000,',','.','-');" value="<%=ProdQuantityAvailable%>" size = "20"> 
</td></tr>
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
</Body>
</HTML>