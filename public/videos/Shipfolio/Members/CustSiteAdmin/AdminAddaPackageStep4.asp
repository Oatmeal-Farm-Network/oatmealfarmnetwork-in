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
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>

<!--#Include file="AdminHeader.asp"--> 
<!--#Include file="AdminSecurityInclude.asp"-->
    <% 
   Current2="Packages"
   Current3="PackageEdit" 
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
Dim QTYBreedings(40000)

if mobiledevice = False  then 


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

PackageID = request.querystring("PackageID")
if len(PackageID) < 1 then
PackageID = request.form("PackageID")
end if 

ID = PackageID

%>


<!--#Include file="AdminPackagesTabsInclude.asp"-->
<% 'response.write("packageID=" &  PackageID)

 sql = "select * from Package where PackageID = " & PackageID & " order by PackageID DESC"

    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
PackageName = rs("PackageName")
PackagePrice = rs("PackagePrice")
PackageValue = rs("PackageValue")
Description = rs("Description")
BreedType= rs("BreedType")
PackageOBO = rs("PackageOBO")
rs.close

pagename = "AdmineditPackageStep2.asp?PackageID=" & PackageID 
%>

<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Package</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">

		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Basic Facts</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />

<form action= 'AdminAddaPackageStep3.asp' method = "post">
<input type = "hidden" name="PackageID" value= "<%=  PackageID %>">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<td Class = "body2" align = "right">
			Package Name: 
		</td>
		<td Class = "body" align = "left">
			<input name="PackageName" size = "<%= fieldlength %>" fieldlength" value = "<%=PackageName%>" >(Required)
		</td>
</tr>
<tr>
<td Class = "body2" align = "right">Package Type:</td>
<td Class = "body" align = "left">
<select size="1" name="BreedType">
	<option value="<%=BreedType%>" selected><%=BreedType%></option>
	<option value="Huacaya">Huacaya</option>
	<option  value="Suri">Suri</option>
	<option  value="Huacaya & Suri">Huacaya & Suri</option>
</select><i> (required - Breed(s) of Alpaca(s) in the package)</i>
</td>
</tr>
	<tr>
	<td Class = "body2" align = "right">
			Package Price: 
	</td>
		<td Class = "body" align = "left">
					$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='Price' size=6 maxlength=10 value = "<%=PackagePrice%>">(number only please )
		
		</td>
		</tr>
		<tr>
	<td Class = "body2" align = "right">
			Package Value: 
	</td>
		<td Class = "body" align = "left">
					$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='Value' size=6 maxlength=10 value = "<%=PackageValue%>">(number only please )
		
		</td>
		</tr>
		<tr >
				<td class = "body2"  align = "right">
		
		<a class="tooltip" href="#"><b>OBO?:</b><span class="custom info"><img src="/images/logoTip.png" alt="Alpaca Infinity Screen Tip" height="48" width="48" /><em>About OBO</em>By sellecting OBO you are adding the ability for potential buyers to make you an offer; however, that does not mean that you have to accept an offer if you are not interested.</span></a>
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
				Package Description:
			</td>
		<td Class = "body" align = "left">
		<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>
<script type="text/javascript">
    var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "850";
    mysettings.Height = "200px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 200;
    WYSIWYG.attach('Description', mysettings);
</script>
				<textarea name="Description" ID="Description" cols="<%= fieldlength2 %>" rows="10" wrap="VIRTUAL" ><%=Description %></textarea>
			</td>
		</tr>
</table>
</td>
		</tr>
</table>
<br>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
	<tr>
		<td Class = "body" valign = "top">
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Alpaca for Sale</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
		<%
 sql = "select * from Animals   order by FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1

Recordcount = rs.RecordCount +1
if Recordcount > 1 then

%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">

<%
 While  Not rs.eof         
	IDArray(rowcount) =   rs("ID")
	 Name(rowcount) =   rs("FullName")
	    inpackage = False
 sql2 = "select * from Packageanimals where AnimalID = " & IDArray(rowcount) & " and PackageID = " &  PackageID & " and PackageType = 'ForSale'"

'response.write (sql2)
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
	If Not rs2.eof Then 
		inpackage = True
	Else
	   inpackage = False
	 End If 
	 rs2.close
%>
<tr >
		<td class = "body" align = "left">
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  IDArray( rowcount)%>">
			<% If inpackage = True Then %>
					  <INPUT TYPE=CHECKBOX NAME="Checkbox(<%=rowcount%>)"   Checked>
			<% Else %>
						<INPUT TYPE=CHECKBOX NAME="Checkbox(<%=rowcount%>)"   >
			<% End If %>
		    <input name="Name(<%=rowcount%>)" value= "<%= Name( rowcount)%>" type = "hidden"><%= Name( rowcount)%></td>
		<td>
</tr>
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
	else
%>
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
<tr>
  <td class = "body">
<center><b>Currently you do not have any alpacas for sale</b></center>
</td>
</tr>
<% end if 
TotalCount=rowcount 
	rs.close
%>


</table>
		
		</td>
	</tr>
</table>
		</td>
		<td width = "15"></td>
		<td valign = "top">
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left" valign = "top">
		<H2><div align = "left">Stud Breedings</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">

		<%

 sql = "select * from Animals where  ( category = 'Experienced Male' or  category = 'Inexperienced Male' ) order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	Studrowcount = 1



Recordcount = rs.RecordCount +1
if Recordcount > 1 then
%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%"">
<tr>
  <td width = "200">

  </td>
   <td class = "body"># of Breedings</td>
 </tr>
<%
 While  Not rs.eof         
	StudID(Studrowcount) =   rs("ID")
	 Name(Studrowcount) =   rs("FullName")

sql2 = "select * from Packageanimals where AnimalID = " & StudID(Studrowcount) & " and PackageID = " &  PackageID & " and PackageType = 'Stud'"

'response.write (sql2)
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
	If Not rs2.eof Then 
		inpackage = True
		 QTYBreedings(Studrowcount) =   rs2("QTYBreedings")

	Else
	   inpackage = False
	 End If 
	 rs2.close 
%>
	<tr  >
		<td class = "body" align = "left">
			<input type = "hidden" name="StudID(<%=Studrowcount%>)" value= "<%=  StudID( Studrowcount)%>">
		
			    <input name="Name(<%=Studrowcount%>)" value= "<%= Name(Studrowcount)%>" type = "hidden"><%= Name( Studrowcount)%></td>
		<td class = "body" align = "center">
					<select size="1" name="QTYBreedings(<%=Studrowcount%>)">
					<%  if len(QTYBreedings(Studrowcount)) then %>
					<option value="<%=QTYBreedings(Studrowcount) %>" selected><%=QTYBreedings(Studrowcount) %></option>
					<option value="0">0</option>
					<% else %>
						<option value="0" selected>0</option>
					<% end if %>
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
else
%>
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
<tr>
  <td class = "body">
<center><b>Currently you do not have any studs available.</b></center>
</td>
</tr>
<% end if 
	
StudTotalCount=Studrowcount 
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


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
	<tr>
		<td Class = "body2" align = "center">
			<Input type = Hidden name='StudTotalCount' value = <%=StudTotalCount%> >
				<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" class = "regsubmit2">
			</form>
		</td>
	</tr>	
</table>

	</td>
	</tr>	
</table>
<% else %>


<% PackageID = request.querystring("PackageID")
if len(PackageID) < 1 then
PackageID = request.form("PackageID")
end if


 sql = "select * from Package where PackageID = " & PackageID & " order by PackageID DESC"

    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
PackageName = rs("PackageName")
PackagePrice = rs("PackagePrice")
PackageValue = rs("PackageValue")
Description = rs("Description")
BreedType= rs("BreedType")
PackageOBO = rs("PackageOBO")
rs.close

pagename = "AdmineditPackageStep2.asp?PackageID=" & PackageID 
%>


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td  align = "left" class = "body" width = "100%">
	<a href = "AdminPackagesAdd.asp" class = "body"><b>Create a Package</b></a>	
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "body">
		<H2><div align = "left">Basic Facts</div></H2>
		<center>* = Required</center>
        </td></tr>
        <tr><td class = "body">
<br />

<form action= 'AdminAddaPackageStep3.asp' method = "post">
<input type = "hidden" name="PackageID" value= "<%=  PackageID %>">

<b>Package Name*</b>: <br />
<input name="PackageName" size = "30" value = "<%=PackageName%>" class = "regsubmit2 body"><br />
Package Type*:<br />
<select size="1" name="BreedType" class = "regsubmit2 body">
	<option value="<%=BreedType%>" selected><%=BreedType%></option>
	<option value="Huacaya">Huacaya</option>
	<option  value="Suri">Suri</option>
	<option  value="Huacaya & Suri">Huacaya & Suri</option>
</select><i></i><br />
<b>Package Price: </b><br />
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" name='Price' size=6 maxlength=10 value = "<%=PackagePrice%>" class = "body">(Num only)<br />

<b>Package Value:</b> (Num only)<br />
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');" name='Value' size=6 maxlength=10 value = "<%=PackageValue%>" class = "body"> <br />
	
<b>OBO?:</b> <br />
<% 		
		if PackageOBO = "Yes" Or PackageOBO = True Then %>
			Yes<input TYPE="RADIO" name="PackageOBO" Value = "Yes" checked>
			No<input TYPE="RADIO" name="PackageOBO" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PackageOBO" Value = "Yes" >
			No<input TYPE="RADIO" name="PackageOBO" Value = "No" checked>
		<% End If %>
 <br />
<b>Package Description:</b> <br />
<textarea name="Description" ID="Description" cols="30" rows="10" wrap="VIRTUAL" ><%=Description %></textarea><br />
		
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td  class = "body" colspan = "2">
<H2><div align = "left">Alpaca for Sale</div></H2>
 </td></tr>
<%
 sql = "select * from Animals   order by FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1

Recordcount = rs.RecordCount +1
if Recordcount > 1 then

 While  Not rs.eof         
	 Name(rowcount) =   rs("FullName")	
	 IDArray(rowcount) =   rs("ID")

	    inpackage = False
 sql2 = "select * from Packageanimals where AnimalID = " & IDArray(rowcount) & " and PackageID = " &  PackageID & " and PackageType = 'ForSale'"

'response.write (sql2)
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
	If Not rs2.eof Then 
		inpackage = True
	Else
	   inpackage = False
	 End If 
	 rs2.close
%>
<tr >
		<td class = "body" colspan = "2">
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  IDArray( rowcount)%>">
			<% If inpackage = True Then %>
					  <INPUT TYPE=CHECKBOX NAME="Checkbox(<%=rowcount%>)"   Checked  id="checkbox-1-<%= rowcount%>" class="regular-checkbox big-checkbox 3color arrows-color"><label for="checkbox-1-<%= rowcount%>"></label>
			<% Else %>
						<INPUT TYPE=CHECKBOX NAME="Checkbox(<%=rowcount%>)"    id="checkbox-2-<%= rowcount%>" class="regular-checkbox big-checkbox 3color arrows-color"><label for="checkbox-2-<%= rowcount%>"></label>
			<% End If %>
		    <input name="Name(<%=rowcount%>)" value= "<%= Name( rowcount)%>" type = "hidden"><%= Name( rowcount)%></td>
		<td>
</tr>
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
	else
%>

<tr>
  <td class = "body" colspan = "2">
<center><b>Currently you do not have any alpacas for sale</b></center>
</td>
</tr>
<% end if 
TotalCount=rowcount 
	rs.close
%>


<tr><td  colspan = "2" class = "body" valign = "top">
		<br /><H2><div align = "left">Stud Breedings</div></H2>
</td></tr>

<%

 sql = "select * from Animals where  ( category = 'Experienced Male' or  category = 'Inexperienced Male' ) order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	Studrowcount = 1



Recordcount = rs.RecordCount +1
if Recordcount > 1 then
%>


<tr>
  <td width = "70%">

  </td>
   <td class = "body"># Breedings</td>
 </tr>
<%
 While  Not rs.eof         
	StudID(Studrowcount) =   rs("ID")
	 Name(Studrowcount) =   rs("FullName")

sql2 = "select * from Packageanimals where AnimalID = " & StudID(Studrowcount) & " and PackageID = " &  PackageID & " and PackageType = 'Stud'"

'response.write (sql2)
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
	If Not rs2.eof Then 
		inpackage = True
		 QTYBreedings(Studrowcount) =   rs2("QTYBreedings")

	Else
	   inpackage = False
	 End If 
	 rs2.close 
%>
	<tr  >
		<td class = "body" align = "left">
			<input type = "hidden" name="StudID(<%=Studrowcount%>)" value= "<%=  StudID( Studrowcount)%>">
		
			    <input name="Name(<%=Studrowcount%>)" value= "<%= Name(Studrowcount)%>" type = "hidden"><%= Name( Studrowcount)%></td>
		<td class = "body" align = "center">
					<select size="1" name="QTYBreedings(<%=Studrowcount%>)" class = "regsubmit2 body">
					<%  if len(QTYBreedings(Studrowcount)) then %>
					<option value="<%=QTYBreedings(Studrowcount) %>" selected><%=QTYBreedings(Studrowcount) %></option>
					<option value="0">0</option>
					<% else %>
						<option value="0" selected>0</option>
					<% end if %>
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
else
%>
<tr>
  <td class = "body" colspan = "2">
<center><b>Currently you do not have any studs available.</b></center>
</td>
</tr>
<% end if 
	
StudTotalCount=Studrowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>


	<tr>
		<td Class = "body2" align = "center" colspan = "2">
			<Input type = Hidden name='StudTotalCount' value = <%=StudTotalCount%> >
				<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<center><input type=submit value = "Submit Changes" class = "regsubmit2 body"></center>
			</form>
		</td>
	</tr>	
</table>


<% end if %>
<br />
<!--#Include file="AdminFooter.asp"--> 


 </Body>
</HTML>
