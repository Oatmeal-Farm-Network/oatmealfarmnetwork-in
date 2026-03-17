<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
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
    <!--#Include File="AdminSecurityInclude.asp"--> 
    <!--#Include File="AdminGlobalVariables.asp"--> 
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">

    <!--#Include File="AdminHeader.asp"--> 
<br>

<table border = "0" width = "770" height = "25" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 background = "images/YourPackgesHeader.jpg" align = "center">
	<tr>
		<td height = "77" >&nbsp;</td></tr>
	<tr>
		<td Class = "body"   >
			&nbsp;<b>Maintain Your Packages:</b>

		</td>
		<td Class = "body"  align = "center">
			<a href = "#Add" class = "body">Add a Package</a>|
		</td>
		<td Class = "body"  align = "center">
			<a href = "#Edit" class = "body">Edit Packages</a>|
		</td>
		<td Class = "body" align = "center">
			<a href = "#Animals" class = "body">Assign Animals</a>|
		</td>
		<td Class = "body"  align = "center">
			<a href = "#Preview" class = "body">Preview</a>|
		</td>
		<td Class = "body"  align = "center">
			<a href = "#Delete" class = "body">Delete</a>&nbsp;
		</td>
	</tr>
</table>

<br>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body" width = "400" valign = "top">
		<form action= 'AddaPackage.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body" >
			<a name = "Add"></a><H2><div align = "left">Add a Package</div></H2>
		</td>
	</tr>	
	<tr>
		<td Class = "body" >
			Enter a name of the package and press the submit button.<br><br>
		</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

	<tr>
		<td Class = "body">
			Package Name: <input name="PackageName" size = "60">
		</td>
	</tr>
	<tr>
	<td Class = "body">
			Full Price: 
					$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='Price' size=6 maxlength=10 Value= "">(number only please )
		
		</td>
		</tr>
			<td colspan = "2" Class = "body" >
				Package Description:<br><textarea name="Description" cols="45" rows="10" wrap="VIRTUAL" ></textarea>
			</td>
		</tr>
		<tr>
			<td colspan = "2" align = "center">
			&nbsp; <input type=submit value = "Submit" >
		</td>
	</tr>
</table>
</form>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body" >
			<a name = "Edit"></a><H2><div align = "left">Edit Your Packages<br>
			<img src = "images/underline.jpg" width = "400"></div></H2>
			To make changes edit your data and press the submit button.<br>
		</td>
	</tr>
</table>
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Package where custID =  '" & session("custID") & "'"

response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim PackageID(200)
	dim Price(200)
	dim Value(200)
	dim PackageName(200)
	dim Description(200)
	dim CustID(200)

Recordcount = rs.RecordCount +1
%>
<% if rs.eof  then%>
	<font class = "body"><b>Sorry, currently there are no Packages that are available to be edited.</b></font>
<% else %>

<form action= 'Packageedithandleform.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0">
<%
 While  Not rs.eof     
	 PackageID(rowcount) =   rs("PackageID")
	 PackageName(rowcount) =   rs("PackageName")
	 Price(rowcount) =   rs("Price")
	  Value(rowcount) =   rs("Value")
	 Description(rowcount) =   rs("Description")
	 custID(rowcount) =   rs("custID")

%>
	<tr >
		<td class = "body"><input type = "hidden" name="PackageID(<%=rowcount%>)" value= "<%=PackageID(rowcount)%>" >


			<input type = "hidden" name="CustID(<%=rowcount%>)" value= "<%=CustID(rowcount)%>" >
			Title:<input name="PackageName(<%=rowcount%>)" value= "<%= PackageName(rowcount)%>" size = "50"><br>
					Value: <input name="Value(<%=rowcount%>)" value= "<%= Value(rowcount)%>" size = "6">(Required)<br>	Price: <input name="Price(<%=rowcount%>)" value= "<%= Price(rowcount)%>" size = "6">(Required)<br>

		</td>
		</tr>
		</tr>
			<td colspan = "2" class = "body">
				Description: <textarea name="Description(<%=rowcount%>)" cols="43" rows="12" wrap="VIRTUAL" ><%= Description(rowcount)%></textarea>
			</td>
		</tr>
		
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
%>
</tr>
			<td colspan = "2" align = "center">
			&nbsp; <input type=submit value = "Submit"  >
		</td>
	</tr>
</table>
<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
</form>
<% end if%>

</td>
<td valign = "top">

<table border = "0" width = "350" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body" colspan = "2">
			<a name = "Animals"></a><H2><div align = "left">Add Animals To Your Packages (Required)<br>
			<img src = "images/underline.jpg" width = "350" height = "2"></div></H2>
				To add animal to your Packages:<br>
				<ol>
					<li>Select a Package name to the right of your animal you wish to assign.
					<li>Select update.
				</ol>
				<b>Important! If you don't assign animals to your Package, then they will not show up on the website.</b>
				<br><br>
		</td>
	</tr>
			
			
			<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Animals where custid = " & session("custid") & "  order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(400) 
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



Recordcount = rs.RecordCount +1
%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<th >Full Name</th>
		<th >Package</th>
	
	</tr>
	
<%
 While  Not rs.eof 
	ID(rowcount) =   rs("ID")
	 Name(rowcount) =   rs("FullName")
	 PackageID(rowcount)=   rs("PackageID")
	  

%>

	<form action= 'PackagesEditAnimals.asp' method = "post">
	<tr  >
		
		<td >
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>">
		
		    <input name="Name(<%=rowcount%>)" value= "<%= Name( rowcount)%>" size = "30"></td>
		<td>

			<% 	rowcount2 = 1

			if rs("PackageID") = 0  then
				tempPackageName = "none"
				tempPackageID =0
			else
			  'response.write(rs("PackageID"))
				sql2 = "select * from Package where PackageID = " & rs("PackageID")
				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3   
				if not rs2.eof then
					tempPackageName = rs2("PackageName")
					tempPackageID =rs("PackageID")
				else
					tempPackageName = "none"
					tempPackageID =0
				end if
			end if

			sql2 = "select * from Package order by PackageName"
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3   
	
			While  Not rs2.eof 
				PackageID(rowcount2) =   rs2("PackageID")
				PackageName(rowcount2) =   rs2("PackageName")
				rowcount2 = rowcount2 + 1
				rs2.movenext
			Wend
			TotalCount2=rowcount2 
			%>

				<select size="1" name="PackageID(<%=rowcount%>)" size = "20">
					<option name = "PackageID0" value= "<%=tempPackageID%>" selected size = "20"><%=tempPackageName%></option>
					<option name = "PackageID1" value="0" size = "20">none</option>
					<% count = 1
						while count < TotalCount2
						'response.write(TotalCount2)
					%>
						<option name = "PackageID2" value="<%=PackageID(count)%>" size = "20">
							<%=PackageName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			</td>
		</tr>
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>

<tr>
		<td colspan = "2" align = "center" valign = "middle">
			<img src = "images/underline.jpg" width = "300"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<Input type = Hidden name='Page' value = "Packages" >
			<input type=submit value = "Submit Changes" >
			</form>
		</td>
</tr>
</table>	
	<br>
<%
dim pID(200)
dim pName(200)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Package where custid = '" & session("custid") & "'"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	pcounter = 1
	While Not rs.eof  
		pID(pcounter) = rs("PackageID")
		pName(pcounter) = rs("PackageName")
		'response.write (SSName(studcounter))

		pcounter = pcounter +1
		rs.movenext
	Wend		
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<a name = "Delete"></a><H2><div align = "left">Delete a Package<br>
			<img src = "images/underline.jpg" width = "300"></div></H2>
			To delete a package select the package and press the submit button.<br><br>
		</td>
	</tr>
</table>
<% if pcounter = 1  then%>
	<font class = "body"><b>Sorry, currently there are no packages that are available to be deleted.</b></font>
<% else %>

<form action= 'DeletePackages.asp' method = "post">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<td class = "body">
		  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0">
	<tr>
		<td class = "body">Package Name</td>
					<th></th>
			   </tr>
			    <tr>
				 <td>
					<select size="1" name="PackageID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < pcounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=pID(count)%>">
							<%=pName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Delete" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>

<% end if 
	   rs.close
	   set rs=nothing
%>
		</td>
</tr>
<tr>
	<td colspan ="2" align = "center" bgcolor = "antiquewhite">
				<a name = "Preview"></a><center><H1>Preview</h1><h2>Click on the links below to preview your Packages:<br>

			<% 
		rs2.close
			sql2 = "select * from Package where custid = '" & session("custid") & "' order by PackageID"
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			'response.write(sql2)
			rs2.Open sql2, conn, 3, 3   
			
				
				count = 1
						while count < rs2.recordcount + 1
						
					%>
					<a href ="http://www.alpacainfinity.com/Administration/Packagessample/Package.asp?PackageID=	<%=PackageID(count)%>" class = "body"><big><%=PackageName(count)%></big></a></h2><br>
						

					<% 	count = count + 1
					wend 
					
					  set conn = nothing%>

	</td>
</tr>
</table>
	</td>
</tr>
</table>
<br><br>


</BODY>
</HTML>