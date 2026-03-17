<html>
<head>

<!--#Include file="GlobalVariables.asp"-->

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Add a Listing</title>
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
<!--#Include virtual="/Administration/Header.asp"--> 
<table  height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>


<% Session("Step2") = False %>


<% 

iSubject=request.form("Subject") 
If Len(iSubject) < 3 then
	iSubject= Request.QueryString("Subject") 
End If
'response.write(iSubject)

Session("PhotoPageCount") = 0
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password= ;" 

'*******************Get Customer Location *********************
CustID = Session("CustID")

	sql = "select * from SFCustomers where CustID = " & CustID & ";" 
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


			 sql = "select * from SFCategories where CatID = " & CategoryID & ";"
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	
	If Not rs.eof Then
		CategoryName = rs("CatName")
	End if
	
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
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "730">
	<tr>
		<td class = "body" valign = "top"  ><h1>Add a Product - Step 2: Enter Text<a name="Add"></a>
			<img src = "images/underline.jpg" width = "600"></h1>
			<blockquote>Enter your information in the boxes below then select the "Proceed to the Next Step ->" button at the bottom of the form to proceed on to the next step.</blockquote>
		</td>
	</tr>
</table>

<form action= 'PlaceClassifiedAdStep2.asp' method = "post">
<input name="box1" type = "hidden" value = "<%=CategoryID%>">
<input name="box2ID" type = "hidden" value = "<%=SubCategoryID%>">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800" align = "left">
  <tr>
    <td valign = "top">
	<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "400">
	<tr>
			<td  class = "body" align = "Left"  colspan = "3">
			<br>
			<b>Category:</b>&nbsp;<%=CategoryName%><br>
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




<% If CategoryName = "Clothing" Then %>
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
		<td  class = "body"  align = "right" valign = "top">&nbsp;Description:</td>
		<td>&nbsp;</td>
		<td colspan = "2" align = "left" class = "body">
		<textarea name="ProdDescription" cols="40" rows="25"  onKeyDown="textCounter(this.form.ProdDescription,this.form.remLentext,1000);" onKeyUp="textCounter(this.form.ProdDescription,this.form.remLentext,1000);"><%=ProdDescription%></textarea>
		<br>Characters remaining: <input type=box readonly name=remLentext size=3 value=1000>
		</td>
	</tr>
</table>
</td>
<td align = "left" width = "510" valign = "top">

<br><br><br>
	    <table border = "1" width = "130" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
		<tr>
				<td class = "body" bgcolor = "antiquewhite" align = "center" colspan = "3">
					<b>Colors</b>
				</td>
			</tr>
			<tr>
				<td class = "body" width = "130">
					1:<input type=text 	name='Color1' size=13 maxlength=20 class = "body">
				</td>

			</tr>
			<tr>
				<td class = "body">
					2:<input type=text 	name='Color2' size=13 maxlength=20 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					3:<input type=text 	name='Color3' size=13 maxlength=20 class = "body">
				</td>
			</tr>
				<tr>
				<td class = "body">
					4:<input type=text 	name='Color4' size=13 maxlength=20 class = "body">
				</td>

			</tr>
				<tr>
				<td class = "body">
					5:<input type=text 	name='Color5' size=13 maxlength=20 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					6:<input type=text 	name='Color6' size=13 maxlength=20 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					7:<input type=text 	name='Color7' size=13 maxlength=20 class = "body">
				</td>
			</tr>
			<tr>
				<td class = "body">
					8:<input type=text 	name='Color8' size=13 maxlength=20 class = "body">
				</td>

			</tr>
				<tr>
				<td class = "body">
					9:<input type=text 	name='Color9' size=13 maxlength=20 class = "body">
				</td>
			</tr>
				<tr>
				<td class = "body">
					10:<input type=text 	name='Color10' size=12 maxlength=20 class = "body">
				</td>

			</tr>
			
			</table>
			




</td>
</tr>

<tr>
		<td  colspan = "2" align = "center" valign = "middle" class = "body" >
			<br>
			<input type=submit value = "Proceed to the Next step ->" size = "310" class = "body" >
			</form>
		</td>
</tr>
</table>
 
 
<br><br><br>
<!--#Include file="Footer.asp"--> </Body>
</HTML>