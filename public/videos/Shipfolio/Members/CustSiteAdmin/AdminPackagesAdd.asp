<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">


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
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>

<!--#Include file="AdminGlobalVariables.asp"-->
   <!--#Include file="adminHeader.asp"--><br />

 
 <%   PackageName=Request.Querystring("PackageName")
Price=Request.Querystring("Price")
Value=Request.Querystring("Value")
PackageDescription=Request.Querystring("Description")
BreedType=Request.Querystring("BreedType")
PackageOBO=Request.Querystring("PackageOBO")
NoName=Request.Querystring("NoName")
   %> 
   <% 
     Current2="Packages"
   Current3 = "AddPackage"%> 

<% if mobiledevice = False  then %>
<!--#Include file="AdminPackagesTabsInclude.asp"-->
<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if 

if screenwidth > 987 then
    fieldlength = 80
     fieldlength2 = 60
end if 
if screenwidth < 987 then
    fieldlength = 70
      fieldlength2 = 60
end if
if screenwidth < 769 then
    fieldlength = 60
      fieldlength2 = 50
end if
 if screenwidth < 601 then
    fieldlength = 50
      fieldlength2 = 40
end if

%>

<tr><td class = "roundedtop" align = "left">
		<h1><div align = "left">Create a Package</div></h1>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
<br />

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
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
<form action= 'AdminAddaPackage.asp' method = "post" name=form>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
<tr>
<td Class = "body2" align = "right">
<b>Package Name: </b>
</td>
<td Class = "body" align = "left">
<input name="PackageName" size = "<%=  fieldlength%>" value ="<%=PackageName %>" >(Required)
</td>
</tr>
<tr>
	<td Class = "body2" align = "right">
			<b>Package Price: </b>
	</td>
		<td Class = "body" align = "left">
					$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='Price' size=6 maxlength=10 value ="<%=Price %>" />(number only please)
		
		</td>
		</tr>
<tr>
<td Class = "body2" align = "right" >
	<b>Package Value:</b>
</td>
<td Class = "body" valign = "top" align = "left">
			$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='Value' size=6 maxlength=10 value ="<%=Value %>">(number only please -  combined value of all of the animals / breedings)
		
		</td>
		</tr>
		 <tr >
				<td class = "body2"  align = "right">
		
		<a class="tooltip" href="#"><b>OBO?:</b><span class="custom info"><em>About OBO</em>By sellecting OBO you are adding the ability for potential buyers to make you an offer; however, that does not mean that you have to accept an offer if you are not interested.</span></a>
</td>
		<td Class = "body" align = "left">
		
		<% 		
		if PackageOBO = "Yes" Or PackageOBO = True Then %>
			Yes<input TYPE="RADIO" name="PackageOBO" Value = "Yes" checked>
			No<input TYPE="RADIO" name="PackageOBO" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PackageOBO" Value = "Yes" >
			No<input TYPE="RADIO" name="PackageOBO" Value = "No" checked>
		<% End If %>
		</td>
		</tr>
		<tr>
			<td  Class = "body2" valign = "top" align = "right">
				<b>Package Description:</b>
			</td>
		<td Class = "body" align = "left">
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
<script type="text/javascript">
    var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "550";
    mysettings.Height = "280px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 200;
    WYSIWYG.attach('PackageDescription', mysettings);
</script>
				<textarea name="PackageDescription" ID="PackageDescription" cols="<%=  fieldlength2%>" rows="10" wrap="VIRTUAL" ><%=PackageDescription %></textarea>
			</td>
		</tr>
		<tr>
			<td colspan = "2" align = "center">
			<input type=submit value="Create Package" onclick="verify();" class=  "regsubmit2 body">
<br /><br />
		</td>
	</tr>
</table>
</form>

</td>
	</tr>
</table>

</td>
	</tr>
</table>
<% else %>








<table border = "0" cellspacing="0" cellpadding = "0"  width = "<%=screenwidth %>">
<tr><td  align = "left" class = "body">
		<h1><div align = "left">Create a Package</div></h1>
<a href = "AdminPackageshome.asp" class = "body"><b>Edit Packages</b></a>
</td></tr>
<tr><td  align = "center" class = "body">
<br />* = Required<br />
			<% if NoName = "True" then %>
			<b><font color = "brown">Please enter a Package Name.</font></b>
			<% end if %>

<form action= 'AdminAddaPackage.asp' method = "post" name=form>

<b>Package Name:*</b><br />
<input name="PackageName" size = "40" value ="<%=PackageName %>" class = "regsubmit2 body"  ><br />
<b>Package Type:</b><br />
<select size="1" name="BreedType" class = "regsubmit2 body" >
<% if len(BreedType) > 0 then %>
	<option value="<%=BreedType %>" selected><%=BreedType %></option>
<% else %>
	<option value="" selected></option>
<% end if %>
	<option value="Huacaya">Huacaya</option>
	<option  value="Suri">Suri</option>
	<option  value="Huacaya & Suri">Huacaya & Suri</option>
</select>
<br />
<b>Package Price: </b><br />
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" name='Price' size=6 maxlength=10 value ="<%=Price %>" class = "regsubmit2 body"  />
<br />
<b>Package Value:</b>
<br />
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
name='Value' size=6 maxlength=10 value ="<%=Value %>" class = "regsubmit2 body" >
<br />
<b>OBO?:</b>
<% 		
		if PackageOBO = "Yes" Or PackageOBO = True Then %>
			Yes<input TYPE="RADIO" name="PackageOBO" Value = "Yes" checked>
			No<input TYPE="RADIO" name="PackageOBO" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PackageOBO" Value = "Yes" >
			No<input TYPE="RADIO" name="PackageOBO" Value = "No" checked>
		<% End If %>
<br />
<b>Package Description:</b>
<br />
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
<textarea name="PackageDescription" ID="PackageDescription" cols="30" rows="10" wrap="VIRTUAL" ><%=PackageDescription %></textarea>
			<br />
			<center><input type=submit value="Create Package" onclick="verify();" class=  "regsubmit2 body"></center>
<br /><br />
</form>

</td>
	</tr>
</table>


<% end if %>
<br><br>

 <!--#Include file="adminFooter.asp"--> 

</BODY>
</HTML>