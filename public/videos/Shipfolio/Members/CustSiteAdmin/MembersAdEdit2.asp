<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
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
End if%>

<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% Current1="Products"
Current2 = "AddaProduct"
Current3 = "EditProduct"




%> 
<!--#Include file="AdminHeader.asp"--> 

<br />
<!--#Include file="AdminProductsTabsInclude.asp"-->

<!--#Include virtual="/connloa.asp"-->
<% 



If len(ProdID) > 0 then
 Session("ProdID") = ProdID
Else
ProdID= Session("ProdID") 
End if

Session("PhotoPageCount") = 0
if rs.state = 0 then
else
rs.close
end if

sql = "select * from ProductsPhotos where id = " & prodID
'response.write("sql=" & sql )
rs.Open sql, connloa, 3, 3
If rs.eof Then
	Query =  "INSERT INTO ProductsPhotos (ID)" 
	Query =  Query & " Values (" &  prodID & ")"

connloa.Execute(Query) 
end if




'*******************Get Customer Location *********************
PeopleID = Session("AIID")
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

sql = "select * from people where peopleId = " & PeopleID & ";"
rs.Open sql, connloa, 3, 3   
if not rs.eof then
PaypalEmail = rs("PaypalEmail")
end if


sql = "select * from productCategoriesList, sfCategories where productCategoriesList.prodCategoryID =  sfCategories.catID and prodcategoryID > 0 and ProductID = " & ProdID & ";" 
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
Set rs3 = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connloa, 3, 3 

if not rs.eof then
	Category1= rs("CatName")
	Category1ID = rs("catID")

	SubCategory1ID = rs("prodSubCategoryId")
	
	ProductCategoriesListID1= rs("ProductCategoriesListID")
end if



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
rs.Open sql, connloa, 3, 3 
if not rs.eof then

ProductID = rs("ProductID")

ProdPrice  = rs("ProdPrice")

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
end if
	rs.close



	'response.write("CurrentCategoryName=" & CurrentCategoryName )


Dim CategoryID(100,100)
Dim CatName(100,100)

Dim SubCategoryIDX(1000)
Dim SubCatName(1000)

sql = "select * from SFCategories  order by Catname " 
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, connloa, 3, 3 
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
    rs.Open sql, connloa, 3, 3 
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


 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = <%=screenwidth-32 %> >
<tr><td align = "left" class = roundedtop>
<H1><div align = "left">Edit Product: <%=ProdName %></div></H1>
</td></tr>
<tr><td class = "body roundedBottom">
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "640" align = "right" >
<tr>
	<td  class = "body">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -32 %>" align = "center" >
  <tr><td>





 <form action="membersAdEdit2.asp" method = "post">
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" class = roundedtopandbottom width = 600>
<tr><td class = "body2" align = "right">
<% 
Dim XIDArray(1000)
Dim XProdname(1000)
sql2 = "select * from sfProducts where peopleid = " & session("AIID") & " order by Prodname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connloa, 3, 3 
While Not rs2.eof  
XIDArray(acounter) = rs2("prodID")
XProdname(acounter) = rs2("Prodname")
acounter = acounter +1
rs2.movenext
Wend		
rs2.close

%>
<select size="1" name="ProdID" class=formbox width="300" style="width: 300px">
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

</td>
</tr>
<tr><td>


<% sql = "select * from people where peopleId = " & session("AIID")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connloa, 3, 3   

prodPurchasemethod = rs("prodPurchasemethod")
PaypalEmail = rs("PaypalEmail")
OtherURL= rs("OtherURL")
peopleEmail = rs("peopleEmail")
Weblink= rs("Weblink")
showtaxes = false
if showtaxes = true then
TaxNexusState= rs("TaxNexusState")
TaxRate= rs("TaxRate")
TaxActive= rs("TaxActive")
end if
If Len(prodPurchasemethod) > 3 Then

else
	prodPurchasemethod ="Contact Me"
End If 

If Len(OtherURL) > 3 Then
else
	OtherURL =Weblink
End If 

If Len(PaypalEmail) > 3 Then
else
	PaypalEmail =custEmail 
End If 
%>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "right"  width = 100%>
	<tr>

		<td valign = "top" class = roundedtopandbottom>
			 <form action= 'membersStoreAccountHandleForm.asp?ProdID=<%=ProdID %>' method = "post">
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td  align = "left" >
		<H2>Payment Method</H2>
        <i>Note: The information below applies to all of your products that you list.</i>
        </td></tr>
        <tr><td align = "center" height = "100" valign = "top"><br />
          
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "500">
<tr>
	<td class = "body">
		<b>How can people pay for your products? </b>
	</td>
</tr>
<tr>
	<td valign = "top" class = "body">
		<select size="1" name="prodPurchasemethod" class = "formbox" style="width:300px">
			<option value="<%=prodPurchasemethod %>" selected><%=prodPurchasemethod %></option>
			<option value="Contact Me">Contact Me</option>
			<option value="PayPal">PayPal</option>
        <% anotherwbsiteoption = false
        if anotherwbsiteoption = True then %>
			<option value="Send Users to Another Website">Send Users to Another Website</option>
        <% end if %>
		</select>
	</td>
</tr>
<tr>
	<td class = "body"><br>
		<b>Email used if your paypal account (if applicable)</b>
	</td>
</tr>
<tr>
	<td valign = "top" class = "body">
		<input name="PaypalEmail"  size = "60" value = "<%=PaypalEmail %>" class = "formbox">
    <td>
</tr>
<% if anotherwbsiteoption = True then %>
<tr>
	<td class = "body"><br>
		<b>Other Website (if applicable)</b>
	</td>
</tr>
<tr>
	<td valign = "top" class = "body">
		http://<input name="OtherURL"  size = "50" value = "<%= OtherURL %>" class = "formbox">
	</td>
</tr>
<% end if %>
</table>
</td></tr></table>
<br />	
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "500"><tr><td align = "center"><input type=submit value = "Submit Changes" class = "regsubmit2" ></td></tr></table>
</form>


<br />
</td>
</tr>
</table>
</td>
</tr>
</table>

<table width = <%=screenwidth - 42 %> cellpadding = 0 cellspacing = 0 height = 100 class = "formbox">
<tr><td >
<h2>Photos</h2>
<a href = "membersProductPhotos.asp?ID=<%=ProdID %>" class = 'body'><b>Click Here</b></a> to add photos of your product.
</td>
</tr>
</table>
<br />

<br />
<table width = <%=screenwidth - 42 %> cellpadding = 0 cellspacing = 0 height = 170 bgcolor = "#e6e6e6">
<tr><td align = center>
<center><iframe src="/administration/MembersProductPublishFrame.asp?ProdID=<%=ProdID %>" frameborder =0 width = "100%" height = "170" scrolling = "no" bgcolor = "#e6e6e6" align = "center" ></iframe></center>
</td></tr></table>
<br />

<table width = <%=screenwidth -32  %> align = center cellpadding = 0 cellspacing = 0 border = 0 >
<tr><td class = roundedtopandbottom align=left>
<iframe src="membersProductGeneralStatsFrame.asp?ProdID=<%=ProdID %>&prodCategory1ID=<%=prodCategory1ID%>&prodCategory2ID=<%=prodCategory2ID%>&prodCategory3ID=<%=prodCategory3ID%>&prodSubCategory1ID=<%=prodSubCategory1ID%>&prodSubCategory2ID=<%=prodSubCategory2ID%>&prodSubCategory3ID=<%=prodSubCategory3ID%>" height = '950' width = '<%=screenwidth -62%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no ></iframe>
</td>
</tr>
</table>
<br />

<table width = <%=screenwidth -32  %> align = center cellpadding = 0 cellspacing = 0 border = 0 >
<tr><td class = roundedtopandbottom align=left>
<iframe src="membersProductdescriptionFrame.asp?ProdID=<%=ProdID %>" height = '568' width = '<%=screenwidth -62%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
</td>
</tr>
</table>
<br />


<% 
if prodPurchasemethod = "PayPal" then

sqls = "select count(*) as recordcount from sfShipping where ProdID=" & ProdID
Set rss = Server.CreateObject("ADODB.Recordset")
rss.Open sqls, connloa, 3, 3 
numcountries = rss("recordcount")
rss.close
%>
<table width = <%=screenwidth -32  %> align = center cellpadding = 0 cellspacing = 0 border = 0 >
<tr><td class = roundedtopandbottom align=left>
<H2>Shipping & Handling</H2>
<iframe src ="membersShippingFrame.asp?ProdID=<%=ProdID %>&screenwidth=<%=screenwidth %>" height="388" width="<%=screenwidth -62%>" frameborder = "0" scrolling = "auto" valign = "top" align = "center" ></iframe>
<br>
</td></tr>
</table><br>

<% 
end if

if rs.state = 0 then
else
rs.close
end if




sql = "select count(*) as Recordcount from sfattributes where ProdId = '" & ProdId & "'"
'response.write("sqlX=" & sql)
rs.Open sql, connloa, 3, 3   
TotalRecordcount = cint(rs("RecordCount"))
rs.close

sql = "select count(*) as RecordCount from sfattributes where ProdId = '" & ProdId & "' and (len(Color)> 0 or len(AttrpriceChange) > 0 or len(AttrQuantityAvailable) > 0 or len(AttrQuantityAvailable) > 0 or len(Dimension) > 0 ) "
'response.write("sql=" & sql)

rs.Open sql, connloa, 3, 3   
filledRecordcount = cint(rs("RecordCount"))
rs.close

if cint(filledRecordcount) > cint(TotalRecordcount) -5 then

Query =  " Insert into sfattributes (ProdId)  " 
Query =  Query & " Values ( " & ProdId & ")"
connloa.Execute(Query) 
connloa.Execute(Query) 
connloa.Execute(Query) 
connloa.Execute(Query) 
connloa.Execute(Query) 
end if

sql = "select count(*) as recordcount from sfattributes where ProdId = '" & ProdId & "'"
rs.Open sql, connloa, 3, 3   
TotalRecordcount = rs("RecordCount")
rs.close

Frameheight = 550 + (cint(TotalRecordcount) *40)
%>
<table width = <%=screenwidth -32  %> align = center cellpadding = 0 cellspacing = 0 border = 0 >
<tr><td class = roundedtopandbottom align=left>
<H2>Pricing 
<% if prodPurchasemethod = "PayPal" then %>
& Attributes
<% else
Frameheight = 490
end if %>
</H2>

<iframe src="membersProductsAttributeValuesFrame.asp?ProdID=<%=ProdID %>&prodPurchasemethod=<%=prodPurchasemethod %>&screenwidth=<%=screenwidth -64%>&ProdPrice=<%=ProdPrice %>" height = '<%=Frameheight %>' width = '<%=screenwidth -80%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = auto></iframe>
</td></tr></table>




<% 
showtaxes=False
if showtaxes = true then %>
<tr><td  align = "left" class = "roundedtop">
<H1>Taxes</H1>
</td></tr>
<tr><td class = "roundedBottom">

<iframe src="membersProductTaxFrame.asp?ProdID=<%=ProdID %>&screenwidth=<%=screenwidth -64 %>" height = '270' width = '<%=screenwidth -80%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = auto></iframe>

</td></tr>
<% end if %>

</table>	



</td>
</tr>
</table>	
 <br><br>


</Body>
</HTML>