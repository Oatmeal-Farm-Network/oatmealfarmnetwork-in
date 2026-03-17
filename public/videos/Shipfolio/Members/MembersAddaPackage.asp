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


</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >

<% 
Current2="Packages"
Current3 = "AddPackage"%> 
<!--#Include file="MembersHeader.asp"-->
<br>
<!--#Include file="MembersPackagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%= screenwidth%>"40"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Create a Package</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<%

Dim TotalCount
dim rowcount
dim PackageName
dim Price
dim Description

PeopleID=Request.Form("PeopleID")
if len(PeopleID) < 1 then
   PeopleID = Session("PeopleID")
end if

PackageName=Request.Form("PackageName")
Price=Request.Form("Price")
Value=Request.Form("Value")
Description=Request.Form("PackageDescription")
BreedType=Request.Form("BreedType")
PackageOBO=Request.Form("PackageOBO")

if len(PackageName) < 1 then
	response.redirect("PackagesAdd.asp?PackageName=" & PackageName & "&Price=" & Price & "&Value=" & Value & "&Description=" & Description & "&BreedType=" & BreedType & "&PackageOBO=" & PackageOBO & "&NoName=True" )
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
If Len(Price)> 0 Then
Else
 Price = 0
End if

str1 = Value
str2 = ","
If InStr(str1,str2) > 0 Then
	Value= Replace(str1, ",", "")
End If

str1 = Price
str2 = ","
If InStr(str1,str2) > 0 Then
	Price= Replace(str1, ",", "")
End If


str1 = Value
str2 = "$"
If InStr(str1,str2) > 0 Then
	Value= Replace(str1, "$", "")
End If
If Len(Value)> 0 Then
Else
 Value = 0
End if




if len(PeopleID) > 0 then
Query =  "INSERT INTO Package (PackageName, PeopleID, Description, "
if len(PackageOBO) > 0 then
    Query =  Query & " PackageOBO, "
end if 
Query =  Query & " BreedType, PackagePrice, PackageValue)" 
Query =  Query & " Values ('" &  PackageName & "' ,"
Query =  Query &   " '" & PeopleID & "',"
Query =  Query &   " '" & Description & "',"
if len(PackageOBO) > 0 then
Query =  Query &   " " & PackageOBO & ","
end if
Query =  Query &   " '" & BreedType & "',"
Query =  Query &   " " & Price & ","
Query =  Query &   " " & Value & " )" 
'response.Write("Query=" & Query )
Conn.Execute(Query) 
else
            Response.Redirect("/Login.asp")
end if
  '   response.write("Your changes have successfully been made.")
 

 End If



 sql = "select distinct * from Package where PeopleID = " & PeopleID & " and PackageName = '" & PackageName & "' order by PackageID DESC"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof then
		PackageID = rs("packageID")
	End If 

dim ID(400) 
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
%>	
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
	<tr>
		<td Class = "body" align = "left">
			<h2>Step 2: Add Animals & Breedings to Your Package</h2>
			
			<form action= 'AddaPackageStep3.asp' method = "post">
				<input type = "hidden" name="PackageID" value= "<%=  PackageID %>">
		</td>
	</tr>	
</table>

<table width = "900">
  <tr>
     <td valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "430"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add Animals for Sale</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top">
<br />

<% sql = "select distinct ID, FullName, PackageID from Animals where Publishforsale = True and PeopleID = " & session("PeopleID") & "  order by FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<% if not rs.eof then
 While  Not rs.eof         
	ID(rowcount) =   rs("ID")
	 Name(rowcount) =   rs("FullName")
	 APackageID(rowcount)=   rs("PackageID") %>
<tr  ><td class = "body" align = "left">
<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>">
<INPUT TYPE=CHECKBOX NAME="Checkbox(<%=rowcount%>)"   >
<input name="Name(<%=rowcount%>)" value= "<%= Name( rowcount)%>" type = "hidden"><%= Name( rowcount)%></td>
<td></tr>
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
else %>
<tr><td class = "body"><center><b>Currently you do not have animals for sale.</b></center></td></tr>
<% end if
	rs.close
%>
</table>
</td>
</tr>
</table>	
<br>
</td>
 <td valign = "top">

</b> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "430"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add Stud Breedings</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top">
<br />



<%
sql = "select distinct * from Animals where PeopleID = " & PeopleID & "  and PublishStud and ( category = 'Experienced Male' or  category = 'Inexperienced Male' ) order by Animals.FullName"
'response.write (sql)
rs.Open sql, conn, 3, 3   
Studrowcount = 1
if not rs.eof then
%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
  <td width = "250">

  </td>
   <td class = "body"># of Breeding</td>
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
 <input name="Name(<%=Studrowcount%>)" value= "<%= Name( Studrowcount)%>" type = "hidden"><%= Name( Studrowcount)%></td>
<td class = "body" align = "center">
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
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
	<tr>
		<td Class = "body2" align = "right">
			<Input type = Hidden name='StudTotalCount' value = <%=StudTotalCount%> >
				<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Add Animals to Your Package" class = "regsubmit2">
			</form>
		</td>
	</tr>	
</table>
	</td>
	</tr>	
</table>
<br />
<!--#Include virtual="/Footer.asp"--> 
</BODY>
</HTML>