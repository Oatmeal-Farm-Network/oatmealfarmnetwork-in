<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
   <!--#Include file="adminHeader.asp"-->
</HEAD>
<body >

<!--#Include file="AdminSecurityInclude.asp"-->
    <% 
   Current2="Packages"
   Current3="PackagesHome" %> 
<%
dim PackageID(99999) 
dim PackageName(99999)  
dim PackagePrice(99999) 
dim BreedType(99999) 
dim PackageOBO(99999) 
dim ShowOnAPackages(99999) 
dim PackageValue(99999)

 if mobiledevice = False  then %>
<!--#Include file="AdminPackagesTabsInclude.asp"-->

<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %>


<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Packages</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
 
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Key</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table border = "0" cellpadding = "0" cellspacing="0"  align = "right">
 <tr>
 
  <td class = "body" width = "30" align = "right"><img src= "/images/edit.gif" alt = "edit" height = "18"  border = "0"></td>
 <td class = "body" width=  "35">Edit</td>
 
   <td class = "body" width = "30" align = "right"><img src = "/images/delete.gif" height = "18" border = "0" alt = "Upload Photos"></td>
 <td class = "body" width=  "40" align = "left">Delete</td>
   
    <td></td>
    
    </tr>
</table>
</td>
    
    </tr>
</table>

        
<table border = "0" width = "100%"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td valign = "top" class = "body"><br />
<br />

<%   sql = "select * from Package  order by PackageName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
    if rs.eof then %>
    
    Currently you do not have packages entered. To add a package please select the <a href = "AdminPackagesAdd.asp" class = "body">Add a Package</a> tab.
  <% else     
	rowcount = 1
%>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
	<tr>
	  <td>
	  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<table   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
	<tr>
			<td class = "body2" align = "center" width = "300"><b>Package Name</b></td>
<td class = "body2" align = "center" width = "20%"><b>OBO</b></td>
<td class = "body2" align = "center" width = "20%"><b>Price </b></td>	
<td class = "body2" align = "center"  ><b>Value</b></td>
<% if screenwidth > 768 then%>
<td class = "body2" align = "center" width = "80"><b>Options</b></td>
<% end if %>
	</tr>
	</table>
</td></tr>
<tr><td class = "roundedBottom">
   <table   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">    
<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	PackageID(rowcount) =   rs("PackageID")
	PackageName(rowcount) =   rs("PackageName")
	PackagePrice(rowcount) =   rs("PackagePrice")
	PackageOBO(rowcount) =   rs("PackageOBO")
		PackageValue(rowcount) =   rs("PackageValue")
showstats = True
 %>
 <tr><td class = "body2"  align = "left" width = "300">
		<a href = "AdminAddaPackageStep4.asp?PackageID=<%= PackageID( rowcount)%>#BasicFacts" class = "body"><%= PackageName( rowcount)%></a>
	</td>
		<td class = "body2" align = "center" width = "20%">
		<% if PackageOBO( rowcount) = True then%>&#10003;<% end if %>
	</td>
		<td class = "body2" width = "20%" align = "right">
		<% if len(PackagePrice(rowcount)) > 0 then%>
		    <%= formatcurrency(PackagePrice(rowcount))%> 
		 <% else %>    
		     $0
		   <% end if %>
<img src = "/images/px.gif" width = "20%" height = "1" />
	</td>
<td class = "body2"  align = "right">
		   <% if PackageValue(rowcount)> 1 then %> 
		        <%=  formatcurrency(PackageValue(rowcount))%>
		    <% else %>    
		    Not Set
		   <% end if %>

	</td>
	<% if screenwidth > 768 then%>
	<td align = "center" class = "body2" width = "80">
	
		<a href = "AdminAddaPackageStep4.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "/images/edit.gif" alt = "edit" height ="18" border = "0"></a> | 
		<a href = "AdminPackagesDelete.asp?PackageID=<%= PackageID(rowcount)  %>" class = "body"><img src= "/images/delete.gif" alt = "edit" height ="18" border = "0"></a> 
		</td>
		<% end if %>
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

</td>
</tr>
</table>
</td>
</tr>

</table>
<% end if %>
</td>
</tr>
</table><br>
</td>
</tr>
</table>


<% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth-35 %>">
<tr><td  align = "left" class = "body">
		<H1><div align = "left">Packages</div></H1>
		<a href = "AdminPackagesAdd.asp" class = "body"><b>Create a Package</b></a>	
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "90%" align = "center">
<tr><td   class = "body">
<b>Name</b>
</td>
<td class = "body2" width = "70" align = "right">
<b>Price</b>
</td>
</tr>
<%   sql = "select * from Package  order by PackageName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
    if rs.eof then %>
    
    Currently you do not have packages entered. <a href = "AdminPackagesAdd.asp" class = "body">Click here to add a package.</a>
  <% else     
	rowcount = 1


row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	PackageID(rowcount) =   rs("PackageID")
	PackageName(rowcount) =   rs("PackageName")
	PackagePrice(rowcount) =   rs("PackagePrice")
	PackageOBO(rowcount) =   rs("PackageOBO")
		PackageValue(rowcount) =   rs("PackageValue")
showstats = True
 %>

<tr><td class = "body">
	<a href = "AdminAddaPackageStep4.asp?PackageID=<%= PackageID( rowcount)%>#BasicFacts" class = "body"><b><%= PackageName( rowcount)%></b></a>		
	</td>
	<td class = "body2" align = "right"  height = "23">	
		<% if len(PackagePrice(rowcount)) > 0 then%>
		    <%= formatcurrency(PackagePrice(rowcount))%> 
		 <% else %>    
		     $0
		   <% end if %>
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


<% end if %>
</table>
</td>
</tr>
</table>
<br>
<br><br>
<% end if %>
<br>
 <!--#Include file="adminFooter.asp"--> 
 
</BODY>
</HTML>