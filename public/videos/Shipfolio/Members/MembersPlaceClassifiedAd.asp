<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Alpaca Infinity Membersistration</title>
<meta name="Title" content="Alpaca Infinity Membersistration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />

</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
<!--#Include file="MembersSecurityInclude.asp"-->
    <% 
   Current2="Products"
   Current3="AddProduct" %> 
<!--#Include file="MembersHeader.asp"-->
<br>
<!--#Include file="MembersProductsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" class = "roundedtopandbottom">
<tr><td class = " body" align = "left" valign = "top">
<br />

<% Session("Step2") = False %>


<% 

iSubject=request.form("Subject") 
If Len(iSubject) < 3 then
	iSubject= Request.QueryString("Subject") 
End If
'response.write(iSubject)

Session("PhotoPageCount") = 0

'*******************Get Customer Location *********************
PeopleID = Session("PeopleID")

	sql = "select * from People where PeopleID = " & PeopleID & ";" 
	'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	
	CustCity = rs("CustCity")
		CustZip  = rs("CustZip")
		CustState  = rs("CustState")

	rs.close


	Dim CategoryID
	Dim CategoryName

	Dim SubCategoryID
	Dim SubCategoryName

	iSubject=Request.Form("Subject" ) 
	CategoryID=Request.Form("box1") 
	SubCategoryIDCount=Request.Form("box2ID" ) 
	
	sql = "select * from SFCategories where CatID = " & CategoryID & ";"
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	
	If Not rs.eof Then
		CategoryName = rs("CatName")
	End if
	

If SubCategoryIDCount > 0 then

	sql = "select * from SFSubCategories where CategoryID = '" &  CategoryID & "' Order by SubcategoryName"
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sql, conn, 3, 3 
	CatCounter= 0
	For CatCounter = 0 To (SubCategoryIDCount -1 )
		If Not( rs. eof )Then
		SubCategoryID = rs("subcatId")

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
var checkOK = "0123456789$" + comma + period ;
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


<form name="myform" method="post" action= 'PlaceClassifiedAdStep2.asp' >
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "960">
	<tr>
		<td class = "body" valign = "top"  ><h1>Add a Product<a name="Add"></a></h1>
			<blockquote>Enter your information in the boxes below then select the "Proceed to the Next Step ->" button at the bottom of the form to proceed on to the next step.</blockquote>
		</td>
	</tr>
</table>

<form action= 'PlaceClassifiedAdStep2.asp' method = "post">
<input name="box1" type = "hidden" value = "<%=CategoryID%>">
<input name="box2ID" type = "hidden" value = "<%=SubCategoryID%>">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "920" align = "left">
  <tr>
    <td valign = "top">
	<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "400">
	<tr>
			<td  class = "body" align = "Left"  colspan = "3">
			<br>
			<b>Category:</b>&nbsp;<%=CategoryName%><br>
		<% If Len(SubCategoryName) > 2 Then %>
			<b>Sub-Category:</b>&nbsp; <%=SubCategoryName%>
		
	<% End If %>
	</td>
	</tr>
	<tr>
		<td  class = "body" align = "right">
			Item Name:
		</td>
		<td>&nbsp;</td>
		<td>
			<input name="ProdName" size = "60" value = "<%=ProdName%>">
		</td>
	<tr>
	<td  class = "body" align = "right" >
			Price:
		</td>
		<td>&nbsp;</td>
		<td class = "body">$
		<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='Price' size=10 maxlength=10> <i>Must be a number.</i>
			
		</td>
	</tr>
<tr>
	<td  class = "body" align = "right" >
			For Sale:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
						Yes<input TYPE="RADIO" name="ProdForSale" Value = "Yes" checked>
						No<input TYPE="RADIO" name="ProdForSale" Value = "No" >
		
		</td>
	</tr>
<tr>
	<td  class = "body" align = "right" valign = "top">
			Weight:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
		<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='prodweight' size=10 maxlength=10> lbs <br>
	<i>Must be a number. <br>
	Round to the pound.<br>
	Necessary to determine shipping costs.</i><br>
			<br>
		</td>
	</tr>
	<tr>
		<td  class = "body" align = "right">
			Made In:
		</td>
		<td>&nbsp;</td>
		<td>
			<select size="1" name="ProdMadeIn">
					<option  value= "" selected></option>
					<option  value="USA">USA</option>
					<option  value="Canada">Canada</option>
				     <option  value="Peru">Peru</option>
					 <option value="Chile">Chile</option>
				     <option  value="Brazil">Brazil</option>
					 <option  value="Other">Other</option>
			</select>
		</td>
	<tr>
<% If CategoryName = "Clothing" Or CategoryName = "Yarn"  Or CategoryName = "Blankets and Throws" Or CategoryName = "Fleece"  Then %>
	<tr>
	<td class = "body" valign = "top">Composition:</td>
	<td  class = "body" align = "left" colspan = "2">
	    <table bgcolor = "antiquewhite">
			<tr>
				<td class = "body" colspan ="3">
					% Alpaca Fiber:<input type="hidden" name='ProdFiberType1' value = "Alpaca">
					<input type=text 	name='prodFiberPercent1' size=3 maxlength=4> %
				</td>
		</tr>
		<tr>
				<td class = "body">
					Fiber 2: <input type=text name='ProdFiberType2' size=20 maxlength=60>
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text name='prodFiberPercent2' size=3 maxlength=4>%
				</td>
			</tr>
			<tr>
				<td class = "body">
					Fiber 3: <input type=text name='ProdFiberType3' size=20 maxlength=60>
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text name='prodFiberPercent3' size=3 maxlength=4>%
				</td>
			</tr>
			<tr>
				<td class = "body">
					Fiber 4: <input type=text name='ProdFiberType4' size=20 maxlength=60>
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text name='prodFiberPercent4' size=3 maxlength=4>%
				</td>
			</tr>
			<tr>
				<td class = "body">
					Fiber 5: <input type=text name='ProdFiberType5' size=20 maxlength=60>
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text name='prodFiberPercent5' size=3 maxlength=4>%
				</td>
			</tr>
			</table>
			
		</td>
	</tr>
	<% End IF %>


<% If CategoryName = "Clothing"  Or CategoryName = "Blankets and Throws" Then %>
	<tr>
	<td></td>
	<td  class = "body" align = "left" colspan = "2">
	    <table>
			<tr>
				<td class = "body">
					Size 1:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize1' size = 15 maxlength=60>
				</td>
				<td class = "body">
					Size 6:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize6' size = 15 maxlength=60>
				</td>
			</tr>

	<tr>
				<td class = "body">
					Size 2:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize2' size = 15 maxlength=60>
				</td>
				<td class = "body">
					Size 7:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize7' size = 15 maxlength=60>
				</td>
			</tr>

	<tr>
				<td class = "body">
					Size 3:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize3' size = 15 maxlength=60>
				</td>
				<td class = "body">
					Size 8:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize8' size = 15 maxlength=60>
				</td>
			</tr>
	<tr>
				<td class = "body">
					Size 4:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize4' size = 15 maxlength=60>
				</td>
				<td class = "body">
					Size 9:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize9' size = 15 maxlength=60>
				</td>
			</tr>
			<tr>
				<td class = "body">
					Size 5:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize5' size = 15 maxlength=60>
				</td>
				<td class = "body">
					Size 10:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize10' size = 15 maxlength=60>
				</td>
			</tr>
			</table>
			
		</td>
	</tr>
	<% Else %>

<tr>
	<td  class = "body" align = "right" >
			Dimensions:
		</td>
		<td>&nbsp;</td>
		<td>
		<input type=text 	name='ProdDimensions' size=40 maxlength=60>
			
		</td>
	</tr>
	<% End If %>


	


	

	<tr>
	<td  class = "body" align = "right">
			# Available:
		</td>
		<td>&nbsp;</td>
		<td class = "body"><input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='Quantity' size=10 maxlength=10><i>Must be a number.</i>
			
		</td>
	</tr>
<tr>
		<td colspan = "3" align = "left" class = "body" valign = "top">
		Description:<br />
		<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>
<script type="text/javascript">
    var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "650";
    mysettings.Height = "200px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 200;
    WYSIWYG.attach('ProdDescription', mysettings);
</script>
		<textarea name="ProdDescription" ID="ProdDescription" cols="40" rows="25"  ><%=ProdDescription%></textarea>
			</td>
	</tr>
</table>
</td>
<td align = "left" width = "510" valign = "top">
<% If CategoryName = "Clothing" Or CategoryName = "Yarn" Or CategoryName = "Accessories" Or CategoryName = "Blankets & Throws" Or CategoryName = "Fleece" Then %>
<br><br><br>
	    <table border = "0" width = "390" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
		<tr>
				<td class = "body" bgcolor = "antiquewhite" align = "center" colspan = "3">
					<b>Colors</b>
				</td>
			</tr>
			<tr>
				<td class = "body" width = "130">
					1:<input type=text 	name='Color1' size=13 maxlength=30 class = "body">
				</td>
				<td class = "body" width = "130">
					26:<input type=text 	name='Color26' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body" width = "130">
					51:<input type=text 	name='Color51' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					2:<input type=text 	name='Color2' size=13 maxlength=30 class = "body">
				</td>
				<td class = "body">
					27:<input type=text 	name='Color27' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					52:<input type=text 	name='Color52' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					3:<input type=text 	name='Color3' size=13 maxlength=30 class = "body">
				</td>
				<td class = "body">
					28:<input type=text 	name='Color28' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					53:<input type=text 	name='Color53' size=12 maxlength=30 class = "body">
				</td>
			</tr>
				<tr>
				<td class = "body">
					4:<input type=text 	name='Color4' size=13 maxlength=30 class = "body">
				</td>
				<td class = "body">
					29:<input type=text 	name='Color29' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					54:<input type=text 	name='Color54' size=12 maxlength=30 class = "body" >
				</td>
			</tr>
				<tr>
				<td class = "body">
					5:<input type=text 	name='Color5' size=13 maxlength=30 class = "body">
				</td>
				<td class = "body">
					30:<input type=text 	name='Color30' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					55:<input type=text 	name='Color55' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					6:<input type=text 	name='Color6' size=13 maxlength=30 class = "body">
				</td>
				<td class = "body">
					31:<input type=text 	name='Color31' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					56:<input type=text 	name='Color56' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					7:<input type=text 	name='Color7' size=13 maxlength=30 class = "body">
				</td>
				<td class = "body">
					32:<input type=text 	name='Color32' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					57:<input type=text 	name='Color57' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					8:<input type=text 	name='Color8' size=13 maxlength=30 class = "body">
				</td>
				<td class = "body">
					33:<input type=text 	name='Color33' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					58:<input type=text 	name='Color58' size=12 maxlength=30 class = "body">
				</td>
			</tr>
				<tr>
				<td class = "body">
					9:<input type=text 	name='Color9' size=13 maxlength=30 class = "body">
				</td>
				<td class = "body">
					34:<input type=text 	name='Color34' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					59:<input type=text 	name='Color59' size=12 maxlength=30 class = "body">
				</td>
			</tr>
				<tr>
				<td class = "body">
					10:<input type=text 	name='Color10' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					35:<input type=text 	name='Color35' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					60:<input type=text 	name='Color60' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					11:<input type=text 	name='Color11' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					36:<input type=text 	name='Color36' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					61:<input type=text 	name='Color61' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					12:<input type=text 	name='Color12' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					37:<input type=text 	name='Color37' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					62:<input type=text 	name='Color62' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					13:<input type=text 	name='Color13' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					38:<input type=text 	name='Color38' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					63:<input type=text 	name='Color63' size=12 maxlength=30 class = "body">
				</td>
			</tr>
				<tr>
				<td class = "body">
					14:<input type=text 	name='Color14' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					39:<input type=text 	name='Color39' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					64:<input type=text 	name='Color64' size=12 maxlength=30 class = "body">
				</td>
			</tr>
				<tr>
				<td class = "body">
					15:<input type=text 	name='Color15' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					40:<input type=text 	name='Color40' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					65:<input type=text 	name='Color65' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					16:<input type=text 	name='Color16' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					41:<input type=text 	name='Color41' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					66:<input type=text 	name='Color66' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					17:<input type=text 	name='Color17' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					42:<input type=text 	name='Color42' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					67:<input type=text 	name='Color67' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					18:<input type=text 	name='Color18' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					43:<input type=text 	name='Color43' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					68:<input type=text 	name='Color68' size=12 maxlength=30 class = "body">
				</td>
			</tr>
				<tr>
				<td class = "body">
					19:<input type=text 	name='Color19' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					44:<input type=text 	name='Color44' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					69:<input type=text 	name='Color69' size=12 maxlength=30 class = "body">
				</td>
			</tr>
				<tr>
				<td class = "body">
					20:<input type=text 	name='Color20' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					45:<input type=text 	name='Color45' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					70:<input type=text 	name='Color70' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					21:<input type=text 	name='Color21' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					46:<input type=text 	name='Color46' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					71:<input type=text 	name='Color71' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					22:<input type=text 	name='Color22' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					47:<input type=text 	name='Color47' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					72:<input type=text 	name='Color72' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					23:<input type=text 	name='Color23' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					48:<input type=text 	name='Color48' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					73:<input type=text 	name='Color73' size=12 maxlength=30 class = "body">
				</td>
			</tr>
				<tr>
				<td class = "body">
					24:<input type=text 	name='Color24' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					49:<input type=text 	name='Color49' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					74:<input type=text 	name='Color74' size=12 maxlength=30 class = "body">
				</td>
			</tr>
				<tr>
				<td class = "body">
					25:<input type=text 	name='Color25' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					50:<input type=text 	name='Color50' size=12 maxlength=30 class = "body">
				</td>
				<td class = "body">
					75:<input type=text 	name='Color75' size=12 maxlength=30 class = "body">
				</td>
			</tr>
			</table>
			

	<% End if %>


</td>
</tr>

<tr>
		<td  colspan = "2" align = "center" valign = "right">
			<br>
			<input type=submit value = "Proceed to the Next Step ->" size = "310" class = "regsubmit2" >
			</form>
		</td>
</tr>
</table>
 
 
<br>		</td>
</tr>
</table><br><br>
<!--#Include virtual="/Footer.asp"--> </Body>
</HTML>