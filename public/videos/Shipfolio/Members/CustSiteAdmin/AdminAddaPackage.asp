<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>The Andresen Group Content Management System</title>
<meta name="Title" content="Alpaca Infinity Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
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
var checkOK = "0123456789" + comma ;
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
function verify() {
var themessage = "Please fill out the following fields: \r";
if (document.form.PackageName.value=="") {
themessage = themessage + " - Package Name \r";
}
if (document.form.BreedType.value=="") {
themessage = themessage + " - Package Breed Type \r";
}

//alert if fields are empty and cancel form submit
if (themessage == "Please fill out the following fields: \r") {
document.form.submit();
}
else {
alert(themessage);
return false;
   }
}
//  End -->
</script>

<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include file="AdminHeader.asp"--> 
</HEAD>
<body >

<!--#Include file="AdminSecurityInclude.asp"-->
    <% 
   Current2="Packages"
   Current3 = "AddPackage"%> 
<br>
<%

Dim TotalCount
dim rowcount
dim PackageName
dim Price
dim Description
Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
dim IDArray(400) 
dim StudID(400) 
dim	Name(400) 
dim	ForSale(400) 
dim	ARI(400) 
dim	DOB(400) 
dim	Color(400) 
dim	Category(400) 
dim	Breed(400) 
dim	ColorCategory(400) 
dim	GroupID(400) 
dim GroupName(400)
dim APackageID(400)
 if mobiledevice = False  then %>

<%

PackageName=Request.Form("PackageName")
Price=Request.Form("Price")
Value=Request.Form("Value")
Description=Request.Form("PackageDescription")
BreedType=Request.Form("BreedType")
PackageOBO=Request.Form("PackageOBO")

if len(PackageName) < 1 then
	response.redirect("AdminPackagesAdd.asp?PackageName=" & PackageName & "&Price=" & Price & "&Value=" & Value & "&Description=" & Description & "&BreedType=" & BreedType & "&PackageOBO=" & PackageOBO & "&NoName=True" )
else

str1 = Description
str2 = "'"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1, "'", "''")
End If

str1 = PackageName
str2 = "'"
If InStr(str1,str2) > 0 Then
	PackageName = Replace(str1, "'", "''")
End If

str1 = Price
str2 = "$"
If InStr(str1,str2) > 0 Then
	Price= Replace(str1, "$", "")
End If
If Len(Price)> 1 Then
Else
 Price = 0
End if

str1 = Value
str2 = "$"
If InStr(str1,str2) > 0 Then
	Value= Replace(str1, "$", "")
End If
If Len(Value)> 1 Then
Else
 Value = 0
End if

Query =  "INSERT INTO Package (PackageName, Description, PackageOBO, BreedType, PackagePrice, PackageValue)" 
Query =  Query & " Values ('" &  PackageName & "' ,"
Query =  Query &   " '" & Description & "',"
Query =  Query &   " " & PackageOBO & ","
Query =  Query &   " '" & BreedType & "',"
Query =  Query &   " " & Price & ","
Query =  Query &   " " & Value & " )" 

	Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

	DataConnection.Execute(Query) 

	DataConnection.Close
	Set DataConnection = Nothing 

 End If



 sql = "select * from Package where PackageName = '" & PackageName & "' order by PackageID DESC"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof then
		PackageID = rs("packageID")
	End If 
ID = PackageID
%>	
<!--#Include file="AdminPackagesTabsInclude.asp"-->
<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Create a Package</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
	<tr>
		<td Class = "body" align = "left">
			<h2>Step 2: Add Alpacas & Breedings to Your Package</h2>
			
			<form action= 'AdminAddaPackageStep3.asp' method = "post">
				<input type = "hidden" name="PackageID" value= "<%=  PackageID %>">
		</td>
	</tr>	
</table>

<table width = "100%">
  <tr>
     <td valign = "top" width = "40%">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add Alpacas for Sale</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top">
<br />

<% sql = "select * from Animals, Pricing where Animals.ID = Pricing.ID and forsale = Yes order by FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
Recordcount = rs.RecordCount +1
%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<% if Recordcount > 1 then
 While  Not rs.eof         
	IDArray(rowcount) =   rs("animals.ID")
	 Name(rowcount) =   rs("FullName")
	 APackageID(rowcount)=   rs("PackageID") %>
<tr  ><td class = "body" align = "left">
<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  IDArray( rowcount)%>">
<INPUT TYPE=CHECKBOX NAME="Checkbox(<%=rowcount%>)"   >
<input name="Name(<%=rowcount%>)" value= "<%= Name( rowcount)%>" type = "hidden"><%= Name( rowcount)%></td>
<td></tr>
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
else %>
<tr><td class = "body"><center><b>Currently you do not have alpacas for sale.</b></center></td></tr>
<% end if
	rs.close
%>
</table>
</td>
</tr>
</table>	
<br>
</td>
 <td valign = "top" width = "40%">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add Stud Breedings</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top">
<br />



<%

 sql = "select * from Animals where ( category = 'Experienced Male' or  category = 'Inexperienced Male' ) order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	Studrowcount = 1
Recordcount = rs.RecordCount +1
if recordcount > 1 then
%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>   <td class = "body"># of Breeding</td>
  <td >

  </td>

 </tr>
<%
 While  Not rs.eof         
	StudID(Studrowcount) =   rs("ID")
	 Name(Studrowcount) =   rs("FullName")
	 APackageID(Studrowcount)=   rs("PackageID")
%>

<tr  ><td class = "body" align = "center">
<select size="1" name="QTYBreedings(<%=Studrowcount%>)">
<option value="" selected></option>
<option value="1">1</option>
<option  value="2">2</option>
<option  value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
<option  value="8">8</option>
<option  value="9">9</option>
<option  value="10">10</option>
<option  value="11">11</option>
<option  value="12">12</option>
</select>
</td>
<td class = "body" align = "left">
<input type = "hidden" name="StudID(<%=Studrowcount%>)" value= "<%=  StudID(Studrowcount)%>">
 <input name="Name(<%=Studrowcount%>)" value= "<%= Name( Studrowcount)%>" type = "hidden"><%= Name( Studrowcount)%></td>

</tr>
<%
		Studrowcount = Studrowcount + 1
	   rs.movenext
	Wend
StudTotalCount=Studrowcount 
 else %>
 <table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr  >
<td class = "body" align = "center">
<b>Currently you do not have any studs available.</b>
</td>
</tr>
<%
end if
	rs.close
  set rs=nothing
  set conn = nothing
%>
</table>	
</td>
</tr>
</table>
</td>
</tr>
</table>
<br>

</b> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
	<tr>
		<td Class = "body2" align = "center">
			<Input type = Hidden name='StudTotalCount' value = <%=StudTotalCount%> >
				<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<center><input type=submit value = "Add Alpacas to Your Package" class = "regsubmit2 body"></center>
			</form>
		</td>
	</tr>	
</table>
	</td>
	</tr>	
</table>

<% else %>



<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >

<%

PackageName=Request.Form("PackageName")
Price=Request.Form("Price")
Value=Request.Form("Value")
Description=Request.Form("PackageDescription")
BreedType=Request.Form("BreedType")
PackageOBO=Request.Form("PackageOBO")

if len(PackageName) < 1 then
	response.redirect("AdminPackagesAdd.asp?PackageName=" & PackageName & "&Price=" & Price & "&Value=" & Value & "&Description=" & Description & "&BreedType=" & BreedType & "&PackageOBO=" & PackageOBO & "&NoName=True" )
else

str1 = Description
str2 = "'"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1, "'", "''")
End If

str1 = PackageName
str2 = "'"
If InStr(str1,str2) > 0 Then
	PackageName = Replace(str1, "'", "''")
End If

str1 = Price
str2 = "$"
If InStr(str1,str2) > 0 Then
	Price= Replace(str1, "$", "")
End If
If Len(Price)> 1 Then
Else
 Price = 0
End if

str1 = Value
str2 = "$"
If InStr(str1,str2) > 0 Then
	Value= Replace(str1, "$", "")
End If
If Len(Value)> 1 Then
Else
 Value = 0
End if

Query =  "INSERT INTO Package (PackageName, Description, PackageOBO, BreedType, PackagePrice, PackageValue)" 
Query =  Query & " Values ('" &  PackageName & "' ,"
Query =  Query &   " '" & Description & "',"
Query =  Query &   " " & PackageOBO & ","
Query =  Query &   " '" & BreedType & "',"
Query =  Query &   " " & Price & ","
Query =  Query &   " " & Value & " )" 
	
	Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

	DataConnection.Execute(Query) 

	DataConnection.Close
	Set DataConnection = Nothing 

 End If



 sql = "select * from Package where PackageName = '" & PackageName & "' order by PackageID DESC"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof then
		PackageID = rs("packageID")
	End If 

%>
<tr><td  align = "left" colspan = "2">	
			<h2>Step 2: Add Alpacas & Breedings</h2>
			
			<form action= 'AdminAddaPackageStep3.asp' method = "post">
				<input type = "hidden" name="PackageID" value= "<%=  PackageID %>">
		
</td></tr>
<tr><td  align = "left" colspan = "2">
		<H2>Add Alpacas for Sale</H2>
        </td></tr>
<% sql = "select * from Animals  order by FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
Recordcount = rs.RecordCount +1

 if Recordcount > 1 then
 While  Not rs.eof         
	IDArray(rowcount) =   rs("ID")
	 Name(rowcount) =   rs("FullName")
	 APackageID(rowcount)=   rs("PackageID") %>
<tr  ><td class="body" align = "left" colspan = "2">
<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  IDArray( rowcount)%>">

<INPUT TYPE=CHECKBOX NAME="Checkbox(<%=rowcount%>)"  id="checkbox-1-<%= rowcount%>" class="regular-checkbox big-checkbox 3color arrows-color"><label for="checkbox-1-<%= rowcount%>"></label>



<input name="Name(<%=rowcount%>)" value= "<%= Name( rowcount)%>" type = "hidden"><%= Name( rowcount)%></td>
<td></tr>
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
else %>
<tr><td class = "body" colspan = "2"><center><b>Currently you do not have alpacas for sale.</b></center></td></tr>
<% end if
	rs.close
%>

<tr><td  align = "left" colspan = "2">
		<H1><div align = "left">Add Stud Breedings</div></H1>
        </td></tr>



<%

 sql = "select * from Animals where ( category = 'Experienced Male' or  category = 'Inexperienced Male' ) order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	Studrowcount = 1
Recordcount = rs.RecordCount +1
if recordcount > 1 then
%>

<tr>
  <td >

  </td>
   <td class = "body">#Breeding</td>
 </tr>
<%
 While  Not rs.eof         
	StudID(Studrowcount) =   rs("ID")
	 Name(Studrowcount) =   rs("FullName")
	 APackageID(Studrowcount)=   rs("PackageID")
%>

<tr  >
<td class = "body" align = "left">
<input type = "hidden" name="StudID(<%=Studrowcount%>)" value= "<%=  StudID(Studrowcount)%>">
 <input name="Name(<%=Studrowcount%>)" value= "<%= Name( Studrowcount)%>" type = "hidden"><%= Name( Studrowcount)%>
 </td>
<td class = "body" align = "center" >
<select size="1" name="QTYBreedings(<%=Studrowcount%>)" class = "regsubmit2 body">
<option value="" selected></option>
<option value="1">1</option>
<option  value="2">2</option>
<option  value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
<option  value="8">8</option>
<option  value="9">9</option>
<option  value="10">10</option>
<option  value="11">11</option>
<option  value="12">12</option>
</select>
</td>
</tr>
<%
		Studrowcount = Studrowcount + 1
	   rs.movenext
	Wend
StudTotalCount=Studrowcount 
 else %>
<tr  >
<td class = "body" align = "center" colspan = "2">
<b>Currently you do not have any studs available.</b>
</td>
</tr>
<%
end if
	rs.close
  set rs=nothing
  set conn = nothing
%>
	<tr>
		<td Class = "body2" align = "right" colspan = "2">
			<Input type = Hidden name='StudTotalCount' value = <%=StudTotalCount%> >
				<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Add Alpacas to Your Package" class = "regsubmit2 body">
			</form>
		</td>
	</tr>	
</table>



<% end if %>
<br /><br />
<!--#Include file="adminFooter.asp"--> 
</BODY>
</HTML>