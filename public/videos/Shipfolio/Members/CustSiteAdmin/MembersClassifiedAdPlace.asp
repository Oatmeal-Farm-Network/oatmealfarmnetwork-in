<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalvariables.asp"-->

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
ProdProductID =request.querystring("ProdProductID")
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

Color1=request.querystring("Color1" )
Color2=request.querystring("Color2" ) 
Color3=request.querystring("Color3" ) 
Color4=request.querystring("Color4" ) 
Color5=request.querystring("Color5" ) 
Color6=request.querystring("Color6" ) 
Color7=request.querystring("Color7" ) 
Color8=request.querystring("Color8" ) 
Color9=request.querystring("Color9" ) 
Color10=request.querystring("Color10") 
Color11=request.querystring("Color11" ) 	
Color12=request.querystring("Color12") 
Color13=request.querystring("Color13") 
Color14=request.querystring("Color14") 
Color15=request.querystring("Color15")
Color16=request.querystring("Color16")
Color17=request.querystring("Color17")
Color18=request.querystring("Color18")
Color19=request.querystring("Color19")
Color20=request.querystring("Color20")

Color21=request.querystring("Color21")
Color22=request.querystring("Color22")
Color23=request.querystring("Color23")
Color24=request.querystring("Color24")
Color25=request.querystring("Color25")
Color26=request.querystring("Color26")
Color27=request.querystring("Color27")
Color28=request.querystring("Color28")
Color29=request.querystring("Color29")
Color30=request.querystring("Color30")

Color31=request.querystring("Color31") 
Color32=request.querystring("Color32")
Color33=request.querystring("Color33")
Color34=request.querystring("Color34")
Color35=request.querystring("Color35")
Color36=request.querystring("Color36")
Color37=request.querystring("Color37")
Color38=request.querystring("Color38")
Color39=request.querystring("Color39")
Color40=request.querystring("Color40")

Color41=request.querystring("Color41")
Color42=request.querystring("Color42")
Color43=request.querystring("Color43")
Color44=request.querystring("Color44")
Color45=request.querystring("Color45")
Color46=request.querystring("Color46")
Color47=request.querystring("Color47")
Color48=request.querystring("Color48")
Color49=request.querystring("Color49")
Color50=request.querystring("Color50")

ProdMadeIn=request.querystring("ProdMadeIn")

ProdFiberType1=request.querystring("ProdFiberType1") 
ProdFiberType2=request.querystring("ProdFiberType2") 
ProdFiberType3=request.querystring("ProdFiberType3") 
ProdFiberType4=request.querystring("ProdFiberType4") 
ProdFiberType5=request.querystring("ProdFiberType5") 
prodFiberPercent1=request.querystring("prodFiberPercent1") 
prodFiberPercent2=request.querystring("prodFiberPercent2")
prodFiberPercent3=request.querystring("prodFiberPercent3")
prodFiberPercent4=request.querystring("prodFiberPercent4")
prodFiberPercent5=request.querystring("prodFiberPercent5")
	Set rs = Server.CreateObject("ADODB.Recordset")

if len(Category1ID) > 0 then
    if Category1ID > 0 then
if rs.state = 0 then
else
rs.close
end if
    sql = "select CatName from SFCategories where CatID= " & cint(Category1ID)
   response.write("sql=" & sql)


    rs.Open sql, connloa, 3, 3 
        if not rs.eof then
            Category1 = rs("CatName")
        end if 
        rs.close
    end if
end if

if len(Category2ID) > 0 then
    if Category2ID > 0 then
    sql = "select CatName from SFCategories where CatID= " & Category2ID

    rs.Open sql, connloa, 3, 3 
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
    rs.Open sql, connloa, 3, 3 
        if not rs.eof then
            Category3 = rs("CatName")
        end if
     rs.close       
    end if
end if
%>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% Current1="Products"
Current2 = "AddaProduct"
%> 
<!--#Include virtual="/ConnLOA.asp"-->
<!--#Include file="AdminHeader.asp"-->
<% If not rs.State = 0 Then
 rs.close
End If   	
%>
<!--#Include virtual="/ConnLOA.asp"-->
<% 
Session("Step2") = False 
Session("PhotoPageCount") = 0
'*******************Get Customer Location *********************
'sql = "select AddressID from People where Peopleid = 695;" 
'response.write(sql2)
'	Set rs = Server.CreateObject("ADODB.Recordset")
'    rs.Open sql, connloa, 3, 3 
'AddressID = rs("AddressID")
'rs.close

'sql = "select * from Address where AddressID = " & AddressID 
'response.write(sql2)
'Set rs = Server.CreateObject("ADODB.Recordset")
' rs.Open sql, connloa, 3, 3 
'AddressCity = rs("AddressCity")
'AddressZip = rs("AddressZip")
'AddressState  = rs("AddressState")
'rs.close

If SubCategoryIDCount > 0 then
sql = "select * from SFSubCategories where CategoryID = '" &  CategoryID & "' Order by SubcategoryName"
Set rs = Server.CreateObject("ADODB.Recordset")
	'Response.write(sql)
	rs.Open sql, connloa, 3, 3 
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
    rs.Open sql, connloa, 3, 3 
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

<!--    Begin
    var submitcount = 0;
    function checkSubmit() {

        if (submitcount == 0) {
            submitcount++;
            document.Surv.submit();
        }
    }


    function wordCounter(field, countfield, maxlimit) {
        wordcounter = 0;
        for (x = 0; x < field.value.length; x++) {
            if (field.value.charAt(x) == " " && field.value.charAt(x - 1) != " ") { wordcounter++ }  // Counts the spaces while ignoring double spaces, usually one in between each word.
            if (wordcounter > 250) { field.value = field.value.substring(0, x); }
            else { countfield.value = maxlimit - wordcounter; }
        }
    }

    function textCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
        { field.value = field.value.substring(0, maxlimit); }
        else
        { countfield.value = maxlimit - field.value.length; }
    }
//  End -->
</script>
<% Current3 = "AddProducts" %>
<br />
<!--#Include file="AdminProductsTabsInclude.asp"-->

<% sql = "select subscriptionlevel from People where Peopleid = " & session("AIID") & ";" 
'response.write(sql2)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connloa, 3, 3 
subscriptionlevel = rs("subscriptionlevel")
rs.close
 %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" >
<tr><td  align = "left" class = "body roundedtop">
<H1>Add a Product<a name="Add"></a></H1>
</tr></tr>
<tr><td class = "body roundedBottom">
<br /><br />
<blockquote><div align = "left" class = "body">Enter your information in the boxes below then select the "Save & Proceed to the Next Page ->" button at the bottom of the form to proceed to the next step.<br /><br /></div></blockquote>

<% if subscriptionlevel < 4 then %>
<table border = '0' leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=2 cellspacing=0 align = 'left' width = '460'bgcolor = "#e6e6e6">
<tr>
	<td class= "body" colspan = "3">
<font color = black size = 4>Online Holiday Bazaar</font></br>
<a href="MembersRenewSubscription.asp?PeopleID=<%=peopleid %>" class =body><b>Click here to upgrade to a Premium Membership</b></a> and your products will appear in on <a href='http://LOTWHolidayBazaar.com' target='_blank' class=body>Online Holiday Bazaar</a>!</a></br></br>
</td></tr></table>
<% end if %>

<% 
ProdNameFound = Request.querystring("ProdNameFound")
if ProdNameFound = "true" then%>
<table width = '<%=screenwidth -32%>' align = 'center'><tr><td align = "left" class = "body">
<font color = "maroon"><b>Product name already exists! Please enter a new product name.</font>
</td></tr></table>
<% end if%>

<% if len(MissingProdName) > 0 or len(MissingProdName) > 0 or len(MissingProdPrice) > 0 or len(MissingSubCategory) > 0 then %>
<table width = '<%=screenwidth -32%>' align = 'center'>
<tr><td align = "left" class = "body" bgcolor = "#F9E4C5">
<font color = "maroon"><b>Missing Information!<ul>
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
<li>Please enter at least one category and subcategory.</li>
<% end if %>
</ul></font></b><br /></td></tr></table>
<br />
<% end if %>

<form name="myform" method="post" action= 'membersClassifiedAdPlaceStep2.asp' >

<b><font color=#338333>Required Field are Shown in Green</font></b><br />
<br />
<font color=#338333><b>Product Name</b></font>&nbsp;<br>
<input name="ProdName" value="<%=ProdName %>" size = "40" class = "formbox"><br>
<br />
Product ID&nbsp;<br>
<input name="SKU" value="<%=SKU %>" size = "40" class = "formbox"><br>

<table cellpadding = 5 cellspacing = 5 width = 460 color = "#404040">
<tr><td class = body>
<br><iframe src="membersAddProductCategoriesInclude.asp?Category1ID=<%=Category1ID %>&Category2ID=<%=Category2ID %>&Category3ID=<%=Category3ID %>&SubCategory1ID=<%=SubCategory1ID %>&SubCategory2ID=<%=SubCategory2ID %>&SubCategory3ID=<%=SubCategory3ID %>&twocatagories=True" height = '240' width = '460' frameborder= '0' seamless = Yes scrolling = no  color = "#404040"></iframe><br><br />
</td></tr></table>

<b>Price</b><br>
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name="ProdPrice" size=10 maxlength=10 value="<%=ProdPrice%>" class = "formbox"><br>
<i><font color = "#404040"><small>Must be a number, and greater than $0.</small></font></i>
<br><br />
<b>Sale Price</b><br>
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" name="SalePrice" size=10 maxlength=10 value="<%=SalePrice%>" class = "Formbox"><br>
<i><font color = "#404040"><small>Must be a number, and greater than $0.</small></font></i>
<br><br />
<b>For Sale</b><br>
<% if ProdForSale = "Yes" Or ProdForSale = True Then %>
Yes<input TYPE="RADIO" name="ProdForSale" Value = 1 checked>
No<input TYPE="RADIO" name="ProdForSale" Value = 0 >
<% Else %>
Yes<input TYPE="RADIO" name="ProdForSale" Value = 1 >
No<input TYPE="RADIO" name="ProdForSale" Value = 0 checked>
<% End if%>
<br><br>
<a class="tooltip" href="#"><b>Custom Order?</b><span class="custom info"><em>Custom Orders</em>If your product is a custom order then customers will have to contact you to place their order. This allows you to get specifics that you need finish the customer’s order.</span></a><br>
<% if prodCustomOrder = True  Then %>
Yes<input TYPE="RADIO" name="prodCustomOrder" Value = 1 checked>
No<input TYPE="RADIO" name="prodCustomOrder" Value = 0 >
<% Else %>
Yes<input TYPE="RADIO" name="prodCustomOrder" Value = 1 >
No<input TYPE="RADIO" name="prodCustomOrder" Value = 0 checked>
<% End if%>
<br><i><font color = "#404040"><small>Customers cannot place custom orders online, they must contact you to place their order. </small></font></i><br>
<br>
<b># Available</b><br>

<%
if len(ProdQuantityAvailable) < 1 then
ProdQuantityAvailable = ""
else
 if ProdQuantityAvailable = 0 then
ProdQuantityAvailable = ""
end if
end if%>

<input name="ProdQuantityAvailable" onBlur="checkNumeric(this,-5,5000,',','.','-');" value="<%=ProdQuantityAvailable%>" size = "20" class = formbox> 
<br><br />
<b>Made In</b><br>
<select size="1" name="ProdMadeIn" class = formbox>
<option value=""> - </option>
<option value="USA">United States</option>
<option value="Canada">Canada</option>			
<option value="AF">Afghanistan</option>
<option value="AX">ALand Islands</option>
<option value="AL">Albania</option>
<option value="DZ">Algeria</option>
<option value="AS">American Samoa</option>
<option value="AD">Andorra</option>
<option value="AO">Angola</option>
<option value="AI">Anguilla</option>
<option value="AQ">Antarctica</option>
<option value="AG">Antigua And Barbuda</option>
<option value="AR">Argentina</option>
<option value="AM">Armenia</option>
<option value="AW">Aruba</option>
<option value="AU">Australia</option>
<option value="AT">Austria</option>
<option value="AZ">Azerbaijan</option>
<option value="BS">Bahamas</option>
<option value="BH">Bahrain</option>
<option value="BD">Bangladesh</option>
<option value="BB">Barbados</option>
<option value="BY">Belarus</option>
<option value="BE">Belgium</option>
<option value="BZ">Belize</option>
<option value="BJ">Benin</option>
<option value="BM">Bermuda</option>
<option value="BT">Bhutan</option>
<option value="BO">Bolivia</option>
<option value="BA">Bosnia And Herzegovina</option>
<option value="BW">Botswana</option>
<option value="BV">Bouvet Island</option>
<option value="BR">Brazil</option>
<option value="IO">British Indian Ocean Territory</option>
<option value="BN">Brunei Darussalam</option>
<option value="BG">Bulgaria</option>
<option value="BF">Burkina Faso</option>
<option value="BI">Burundi</option>
<option value="KH">Cambodia</option>
<option value="CM">Cameroon</option>
<option value="CA">Canada</option>
<option value="CV">Cape Verde</option>
<option value="KY">Cayman Islands</option>
<option value="CF">Central African Republic</option>
<option value="TD">Chad</option>
<option value="CL">Chile</option>
<option value="CN">China</option>
<option value="CX">Christmas Island</option>
<option value="CC">Cocos (Keeling) Islands</option>
<option value="CO">Colombia</option>
<option value="KM">Comoros</option>
<option value="CG">Congo</option>
<option value="CD">Congo, The Democratic Republic Of The</option>
<option value="CK">Cook Islands</option>
<option value="CR">Costa Rica</option>
<option value="CI">Cote D'Ivoire</option>
<option value="HR">Croatia</option>
<option value="CU">Cuba</option>
<option value="CY">Cyprus</option>
<option value="CZ">Czech Republic</option>
<option value="DK">Denmark</option>
<option value="DJ">Djibouti</option>
<option value="DM">Dominica</option>
<option value="DO">Dominican Republic</option>
<option value="EC">Ecuador</option>
<option value="EG">Egypt</option>
<option value="SV">El Salvador</option>
<option value="GQ">Equatorial Guinea</option>
<option value="ER">Eritrea</option>
<option value="EE">Estonia</option>
<option value="ET">Ethiopia</option>
<option value="FK">Falkland Islands (Malvinas)</option>
<option value="FO">Faroe Islands</option>
<option value="FJ">Fiji</option>
<option value="FI">Finland</option>
<option value="FR">France</option>
<option value="GF">French Guiana</option>
<option value="PF">French Polynesia</option>
<option value="TF">French Southern Territories</option>
<option value="GA">Gabon</option>
<option value="GM">Gambia</option>
<option value="GE">Georgia</option>
<option value="DE">Germany</option>
<option value="GH">Ghana</option>
<option value="GI">Gibraltar</option>
<option value="GR">Greece</option>
<option value="GL">Greenland</option>
<option value="GD">Grenada</option>
<option value="GP">Guadeloupe</option>
<option value="GU">Guam</option>
<option value="GT">Guatemala</option>
<option value=" Gg">Guernsey</option>
<option value="GN">Guinea</option>
<option value="GW">Guinea-Bissau</option>
<option value="GY">Guyana</option>
<option value="HT">Haiti</option>
<option value="HM">Heard Island And Mcdonald Islands</option>
<option value="VA">Holy See (Vatican City State)</option>
<option value="HN">Honduras</option>
<option value="HK">Hong Kong</option>
<option value="HU">Hungary</option>
<option value="IS">Iceland</option>
<option value="IN">India</option>
<option value="ID">Indonesia</option>
<option value="IR">Iran, Islamic Republic Of</option>
<option value="IQ">Iraq</option>
<option value="IE">Ireland</option>
<option value="IM">Isle Of Man</option>
<option value="IL">Israel</option>
<option value="IT">Italy</option>
<option value="JM">Jamaica</option>
<option value="JP">Japan</option>
<option value="JE">Jersey</option>
<option value="JO">Jordan</option>
<option value="KZ">Kazakhstan</option>
<option value="KE">Kenya</option>
<option value="KI">Kiribati</option>
<option value="KP">Korea, Democratic People'S Republic Of</option>
<option value="KR">Korea, Republic Of</option>
<option value="KW">Kuwait</option>
<option value="KG">Kyrgyzstan</option>
<option value="LA">Lao People'S Democratic Republic</option>
<option value="LV">Latvia</option>
<option value="LB">Lebanon</option>
<option value="LS">Lesotho</option>
<option value="LR">Liberia</option>
<option value="LY">Libyan Arab Jamahiriya</option>
<option value="LI">Liechtenstein</option>
<option value="LT">Lithuania</option>
<option value="LU">Luxembourg</option>
<option value="MO">Macao</option>
<option value="MK">Macedonia, The Former Yugoslav Republic Of</option>
<option value="MG">Madagascar</option>
<option value="MW">Malawi</option>
<option value="MY">Malaysia</option>
<option value="MV">Maldives</option>
<option value="ML">Mali</option>
<option value="MT">Malta</option>
<option value="MH">Marshall Islands</option>
<option value="MQ">Martinique</option>
<option value="MR">Mauritania</option>
<option value="MU">Mauritius</option>
<option value="YT">Mayotte</option>
<option value="MX">Mexico</option>
<option value="FM">Micronesia, Federated States Of</option>
<option value="MD">Moldova, Republic Of</option>
<option value="MC">Monaco</option>
<option value="MN">Mongolia</option>
<option value="MS">Montserrat</option>
<option value="MA">Morocco</option>
<option value="MZ">Mozambique</option>
<option value="MM">Myanmar</option>
<option value="NA">Namibia</option>
<option value="NR">Nauru</option>
<option value="NP">Nepal</option>
<option value="NL">Netherlands</option>
<option value="AN">Netherlands Antilles</option>
<option value="NC">New Caledonia</option>
<option value="NZ">New Zealand</option>
<option value="NI">Nicaragua</option>
<option value="NE">Niger</option>
<option value="NG">Nigeria</option>
<option value="NU">Niue</option>
<option value="NF">Norfolk Island</option>
<option value="MP">Northern Mariana Islands</option>
<option value="NO">Norway</option>
<option value="OM">Oman</option>
<option value="PK">Pakistan</option>
<option value="PW">Palau</option>
<option value="PS">Palestinian Territory, Occupied</option>
<option value="PA">Panama</option>
<option value="PG">Papua New Guinea</option>
<option value="PY">Paraguay</option>
<option value="PE">Peru</option>
<option value="PH">Philippines</option>
<option value="PN">Pitcairn</option>
<option value="PL">Poland</option>
<option value="PT">Portugal</option>
<option value="PR">Puerto Rico</option>
<option value="QA">Qatar</option>
<option value="RE">Reunion</option>
<option value="RO">Romania</option>
<option value="RU">Russian Federation</option>
<option value="RW">Rwanda</option>
<option value="SH">Saint Helena</option>
<option value="KN">Saint Kitts And Nevis</option>
<option value="LC">Saint Lucia</option>
<option value="PM">Saint Pierre And Miquelon</option>
<option value="VC">Saint Vincent And The Grenadines</option>
<option value="WS">Samoa</option>
<option value="SM">San Marino</option>
<option value="ST">Sao Tome And Principe</option>
<option value="SA">Saudi Arabia</option>
<option value="SN">Senegal</option>
<option value="CS">Serbia And Montenegro</option>
<option value="SC">Seychelles</option>
<option value="SL">Sierra Leone</option>
<option value="SG">Singapore</option>
<option value="SK">Slovakia</option>
<option value="SI">Slovenia</option>
<option value="SB">Solomon Islands</option>
<option value="SO">Somalia</option>
<option value="ZA">South Africa</option>
<option value="GS">South Georgia And The South Sandwich Islands</option>
<option value="ES">Spain</option>
<option value="LK">Sri Lanka</option>
<option value="SD">Sudan</option>
<option value="SR">Suriname</option>
<option value="SJ">Svalbard And Jan Mayen</option>
<option value="SZ">Swaziland</option>
<option value="SE">Sweden</option>
<option value="CH">Switzerland</option>
<option value="SY">Syrian Arab Republic</option>
<option value="TW">Taiwan, Province Of China</option>
<option value="TJ">Tajikistan</option>
<option value="TZ">Tanzania, United Republic Of</option>
<option value="TH">Thailand</option>
<option value="TL">Timor-Leste</option>
<option value="TG">Togo</option>
<option value="TK">Tokelau</option>
<option value="TO">Tonga</option>
<option value="TT">Trinidad And Tobago</option>
<option value="TN">Tunisia</option>
<option value="TR">Turkey</option>
<option value="TM">Turkmenistan</option>
<option value="TC">Turks And Caicos Islands</option>
<option value="TV">Tuvalu</option>
<option value="UG">Uganda</option>
<option value="UA">Ukraine</option>
<option value="AE">United Arab Emirates</option>
<option value="GB">United Kingdom</option>
<option value="US">United States</option>
<option value="UM">United States Minor Outlying Islands</option>
<option value="UY">Uruguay</option>
<option value="UZ">Uzbekistan</option>
<option value="VU">Vanuatu</option>
<option value="VE">Venezuela</option>
<option value="VN">Viet Nam</option>
<option value="VG">Virgin Islands, British</option>
<option value="VI">Virgin Islands, U.S.</option>
<option value="WF">Wallis And Futuna</option>
<option value="EH">Western Sahara</option>
<option value="YE">Yemen</option>
<option value="ZM">Zambia</option>
<option value="ZW">Zimbabwe</option>
</select>

<br />
<br />
<b>Description</b><br />
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
		<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		
    <script language="javascript1.2" type="text/javascript">
        // attach the editor to the textarea with the identifier 'textarea1'.

        WYSIWYG.attach("ProdDescription", mysettings);
        mysettings.Width = "880px"
        mysettings.Height = "300px"
 </script>
 
<textarea name="ProdDescription" ID="ProdDescription" cols="60" rows="20"   ><%=ProdDescription%></textarea>
<br>
<div align = "right"><input type=submit value = "Save & Proceed to the Next Page ->" class = "regsubmit2"  <%=Disablebutton %> ></div>
		</form>
<br />
</td>
</tr>
</table>	
<br><br>
<!--#Include File="adminFooter.asp"--> 
</Body>
</HTML>