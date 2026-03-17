<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->
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
var checkOK = "0123456789." + comma ;
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



</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >

<% 
   Current2="Packages"
   Current3 = "AddPackage"
   
   PackageName=Request.Querystring("PackageName")
Price=Request.Querystring("Price")
Value=Request.Querystring("Value")
PackageDescription=Request.Querystring("Description")
BreedType=Request.Querystring("BreedType")
PackageOBO=Request.Querystring("PackageOBO")
NoName=Request.Querystring("NoName")
   %> 

   <!--#Include file="MembersHeader.asp"-->

<br>
<!--#Include file="MembersPackagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<h1><div align = "left">Create a Package</div></h1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700">
	<tr>
		<td Class = "body2" align = "left">
		
		<br>
			<h2><div align = "left">Step 1: Basic Facts</div></h2>
			<% if NoName = "True" then %>
			<b><font color = "brown">Please enter a Package Name.</font></b>
			<% end if %>
		</td>
	</tr>	
</table>
<form action= 'AddaPackage.asp' method = "post" name=form>
<input name="PeopleID" type = "hidden" value ="<%=PeopleID %>" >
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr>
<td Class = "body" align = "right">
Package Name: 
</td>
<td Class = "body" align = "left">
<input name="PackageName" size = "60" value ="<%=PackageName %>" >(Required)
</td>
</tr>
<tr>
	<td Class = "body" align = "right">
			Package Price: 
	</td>
		<td Class = "body" align = "left">
					$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='Price' size=6 maxlength=10 value ="<%=Price %>" />(number only please)
		
		</td>
		</tr>
<tr>
<td Class = "body" align = "right" >
	Package Value:
</td>
<td Class = "body" valign = "top" align = "left">
			$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='Value' size=6 maxlength=10 value ="<%=Value %>">(number only please -  combined value of all of the animals / breedings)
		
		</td>
		</tr>
		 <tr >
				<td class = "body"  align = "right">
		
		<a class="tooltip" href="#"><b>OBO?:</b><span class="custom info"><img src="/images/logoTip.png" alt="Alpaca Infinity Screen Tip" height="48" width="48" /><em>About OBO</em>By sellecting OBO you are adding the ability for potential buyers to make you an offer; however, that does not mean that you have to accept an offer if you are not interested.</span></a>
</td>
		<td Class = "body" align = "left">
		
		<% 		
		if PackageOBO = "True" Or PackageOBO = True Then %>
			Yes<input TYPE="RADIO" name="PackageOBO" Value = "True" checked>
			No<input TYPE="RADIO" name="PackageOBO" Value = "False" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PackageOBO" Value = "True" >
			No<input TYPE="RADIO" name="PackageOBO" Value = "False" checked>
		<% End If %>
		</td>
		</tr>
		<tr>
			<td  Class = "body" valign = "top" align = "right">
				Package Description:
			</td>
		<td Class = "body" align = "left">
		<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>
<script type="text/javascript">
    var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "550";
    mysettings.Height = "280px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 200;
    WYSIWYG.attach('PackageDescription', mysettings);
</script>
				<textarea name="PackageDescription" ID="PackageDescription" cols="65" rows="10" wrap="VIRTUAL" ><%=PackageDescription %></textarea>
			</td>
		</tr>
		<tr>
			<td colspan = "2" align = "center">
			<input type=submit value="Create Package" onclick="verify();" class=  "regsubmit2">
<br /><br />
		</td>
	</tr>
</table>
</form>


</td>
	</tr>
</table>

<br>

 <!--#Include virtual="/Footer.asp"--> 

</BODY>
</HTML>