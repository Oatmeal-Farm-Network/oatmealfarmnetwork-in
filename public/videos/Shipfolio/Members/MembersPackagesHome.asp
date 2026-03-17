<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<%  Current2="Packages"
Current3="PackagesHome" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	%>
<!--#Include file="MembersPackagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtopandbottom" align = "left" valign = "top" height = 300>
		<H1><div align = "left">Packages</div></H1>
      
<table border = "0" width = "<%=screenwidth %>"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td valign = "top" class = "body">
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Key</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table border = "0" cellpadding = "0" cellspacing="0"  align = "right">
 <tr>
 
  <td class = "body" width = "30" align = "right"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0"></td>
 <td class = "body" width=  "35">Edit</td>
 
   <td class = "body" width = "30" align = "right"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></td>
 <td class = "body" width=  "40" align = "left">Photos</td>
   
    <td></td>
    
    </tr>
</table>
</td>
    
    </tr>
</table>
<br />
<%   sql = "select * from Package where PeopleId = " & session("PeopleId") & " order by PackageName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
    if rs.eof then %>
    
    Currently you do not have packages entered. To add a package please select the <a href = "PackagesAdd.asp" class = "body">Add Package</a> tab.
  <% else     
	rowcount = 1
dim PackageID(99999) 
dim PackageName(99999)  
dim PackagePrice(99999) 
dim BreedType(99999) 
dim PackageOBO(99999) 
dim ShowOnAPackages(99999) 
dim PackageValue(99999)
dim PackageDisplay(99999)
%>

<table  border = "0" width = "940" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	  <td>
 <br /><br />
<table   border = "0" width = "940" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td class = "body" align = "center" ><b>Package Name</b></td>
<td class = "body2" align = "center" ><b>OBO</b></td>
<td class = "body2" align = "center" ><b>Display</b></td>
<td class = "body2" align = "center" ><b>Price </b></td>	
<td class = "body2" align = "center" ><b>Value</b></td>
<td class = "body" align = "center" ><b>Options</b></td>
</tr>
<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	PackageID(rowcount) = rs("PackageID")
	PackageName(rowcount) = rs("PackageName")
	PackagePrice(rowcount) = rs("PackagePrice")
	PackageOBO(rowcount) = rs("PackageOBO")
	ShowOnAPackages(rowcount) = rs("ShowOnAPackages")
	PackageValue(rowcount) = rs("PackageValue")
    PackageDisplay(rowcount) = rs("PackageDisplay")
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "antiquewhite" >
<%	End If %>
	<td class = "body" width = "250" align = "left">
		<a href = "AddaPackageStep4.asp?PackageID=<%= PackageID( rowcount)%>#BasicFacts" class = "body"><%= PackageName( rowcount)%></a>
	</td>

	<td class = "body2" align = "center">
		<% if PackageOBO( rowcount) = 1 then%>&#10003;<% end if %>
	</td>
    	<td class = "body2" align = "center">
		<% if PackageDisplay( rowcount) = 1 then%>&#10003;<% end if %>
	</td>
		<td class = "body" width = "200" align = "right">
		<% if len(PackagePrice(rowcount)) > 0 then%>
		    <%= formatcurrency(PackagePrice(rowcount))%> 
		 <% else %>    
		     $0
		   <% end if %>
<img src = "images/px.gif" width = "10" height = "1" />
	</td>
<td class = "body" width = "170" align = "right">
		   <% if PackageValue(rowcount)> 1 then %> 
		        <%=  formatcurrency(PackageValue(rowcount))%>
		    <% else %>    
		    Not Set
		   <% end if %>
<img src = "images/px.gif"  height = "1" />
	</td>
	<td align = "center" class = "body" width = "130">
	
		<a href = "AddaPackageStep4.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "images/edit.gif" alt = "edit" height ="18" border = "0"></a> | <a href = "EditPackageLayout2.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "images/Layout.gif" alt = "edit" height ="18" border = "0"></a>
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


</table>

<br>

</td>
</tr>
</table>
</td>
</tr>

</table>
<% end if %>
</td>
</tr>
</table>
<br>

 <!--#Include virtual="/Footer.asp"--> 
 
</BODY>
</HTML>