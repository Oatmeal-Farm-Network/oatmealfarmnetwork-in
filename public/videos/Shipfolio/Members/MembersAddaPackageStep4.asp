<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
<% 
   Current2="Packages"
   Current3="PackageEdit" %> 
<!--#Include file="MembersHeader.asp"-->
<br>
<!--#Include file="MembersPackagesTabsInclude.asp"-->
<% PackageID = request.querystring("PackageID")
if len(PackageID) < 1 then
PackageID = request.form("PackageID")
end if

 'response.write("packageID=" &  PackageID)
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
Dim QTYBreedings(40000)

sql = "select * from Package where PackageID = " & PackageID & " and PeopleID = " & Session("PeopleID") & " order by PackageID DESC"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1
PackageName = rs("PackageName")
PackagePrice = rs("PackagePrice")
PackageValue = rs("PackageValue")
Description = rs("Description")
BreedType= rs("BreedType")
ShowOnAPackages = rs("ShowOnAPackages")
PackageOBO = rs("PackageOBO")
PackageSold = rs("PackageSold")
PackageDisplay = rs("PackageDisplay")
rs.close

pagename = "editPackageStep2.asp?PackageID=" & PackageID 
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Create a Package</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center">
<b>No Need For Photos</b><br />Your package will automatically show images that you have uploaded for the individual animals.<br /><br />
<%showpackage  = false
if showpackage = True then %>
<iframe src="/Membersistration/MembersPackagePublishFrame.asp?PackageID=<%=PackageID%>" frameborder =0 width = "628" height = "120" scrolling = "no" bgcolor ="#FDF4DD" align = "center"></iframe> 
 <br />
 <% end if %>

		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "920"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Basic Facts</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />



			<form action= 'AddaPackageStep3.asp' method = "post">
				<input type = "hidden" name="PackageID" value= "<%=  PackageID %>">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<td Class = "body" align = "right">
			Package Name: 
		</td>
		<td Class = "body" align = "left">
			<input name="PackageName" size = "60" value = "<%=PackageName%>" >(Required)
		</td>
</tr>
	<tr>
	<td Class = "body" align = "right">
			Package Price: 
	</td>
		<td Class = "body" align = "left">
					$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='Price' size=6 maxlength=10 value = "<%=PackagePrice%>">(number only please )
		
		</td>
		</tr>
		<tr>
	<td Class = "body" align = "right">
			Package Value: 
	</td>
		<td Class = "body" align = "left">
					$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
					name='Value' size=6 maxlength=10 value = "<%=PackageValue%>">(number only please )
		
		</td>
		</tr>
		<tr >
				<td class = "body"  align = "right">
		
		<a class="tooltip" href="#"><b>OBO?:</b><span class="custom info"><em>About OBO</em>By sellecting OBO you are adding the ability for potential buyers to make you an offer; however, that does not mean that you have to accept an offer if you are not interested.</span></a>
</td>
		<td Class = "body" align = "left">
		
		<% 		
		if PackageOBO = "True" Or PackageOBO = 1 Then %>
			Yes<input TYPE="RADIO" name="PackageOBO" Value = "True" checked>
			No<input TYPE="RADIO" name="PackageOBO" Value = "False" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PackageOBO" Value = "True" >
			No<input TYPE="RADIO" name="PackageOBO" Value = "False" checked>
		<% End If %>
		</td>
</tr>
<tr >
	<td class = "body"  align = "right">
	<b>Package Sold?:</b>
</td>
		<td Class = "body" align = "left">
		
		<% 		
		if PackageSold = "True" Or PackageSold = 1 Then %>
			Yes<input TYPE="RADIO" name="PackageSold" Value = "True" checked>
			No<input TYPE="RADIO" name="PackageSold" Value = "False" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PackageSold" Value = "True" >
			No<input TYPE="RADIO" name="PackageSold" Value = "False" checked>
		<% End If %>
		</td>
		</tr>
        <tr >
	<td class = "body"  align = "right">
	<b>Display?:</b>
</td>
		<td Class = "body" align = "left">
		
		<% 		
		if PackageDisplay = "True" Or PackageDisplay = 1 Then %>
			Yes<input TYPE="RADIO" name="PackageDisplay" Value = "True" checked>
			No<input TYPE="RADIO" name="PackageDisplay" Value = "False" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PackageDisplay" Value = "True" >
			No<input TYPE="RADIO" name="PackageDisplay" Value = "False" checked>
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
    mysettings.Width = "850";
    mysettings.Height = "200px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 200;
    WYSIWYG.attach('Description', mysettings);
</script>
				<textarea name="Description" ID="Description" cols="65" rows="10" wrap="VIRTUAL" ><%=Description %></textarea>
			</td>
		</tr>
</table>
</td>
		</tr>
</table>
<br>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body" valign = "top">
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "450"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Animals for Sale</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
		<%
 sql = "select distinct * from Animals where PeopleID = " & session("PeopleID") & "  order by FullName"
rs.Open sql, conn, 3, 3   
rowcount = 1
if not rs.eof then
%>
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "300">

<%
 While  Not rs.eof         
	ID(rowcount) =   rs("ID")
	 Name(rowcount) =   rs("FullName")
	    inpackage = False
 sql2 = "select * from Packageanimals where AnimalID = " & ID(rowcount) & " and PackageID = " &  PackageID & " and PackageType = 'ForSale'"

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
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>">
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
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "300">
<tr>
  <td class = "body">
<center><b>Currently you do not have any animals for sale</b></center>
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
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "450"><tr><td class = "roundedtop" align = "left" valign = "top">
		<H2><div align = "left">Stud Breedings</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">

		<%

 sql = "select distinct * from Animals where PeopleID = " & session("PeopleID") & "  and ( category = 'Experienced Male' or  category = 'Inexperienced Male' or category = 'Experienced Males' or  category = 'Inexperienced Males'  ) order by Animals.FullName"
 rs.Open sql, conn, 3, 3   
Studrowcount = 1

if not rs.eof then
%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "300">
<tr>
  <td width = "200">

  </td>
   <td class = "body"># of Breeding</td>
 </tr>
<%
 While  Not rs.eof         
	StudID(Studrowcount) =   rs("ID")
	 Name(Studrowcount) =   rs("FullName")

sql2 = "select * from Packageanimals where AnimalID = " & StudID(Studrowcount) & " and PackageID = " &  PackageID & " and PackageType = 'Stud'"
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
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "300">
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


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>">
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
<br />
<!--#Include virtual="/Footer.asp"--> 


 </Body>
</HTML>
