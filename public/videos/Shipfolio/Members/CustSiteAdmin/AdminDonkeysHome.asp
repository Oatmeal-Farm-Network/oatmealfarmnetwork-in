<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalvariables.asp"-->
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<% SpeciesID = 7
AnimalType="Donkeys" %>  
<!--#Include file="AdminHeader.asp"-->
<%   Current3= SpeciesPlural & "Home" %> 
 <!--#Include file="AdminAnimalsTabsInclude.asp"-->
<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
<H1><div align = "left">List of <%=SpeciesPlural %></div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
<table border = "0" width = "100%"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td  valign = "top" class = "body" >
<table border = "0" width = "100%"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "100%" valign = "top" class = "body2" align = "right" >

<%  sql = "select distinct Pricing.*, animals.ID, FullName, PublishForSale, PublishStud, Category from Animals, Pricing where Animals.ID =Pricing.ID and speciesid = " & SpeciesID & " order by FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3  
    if rs.eof then %>
Currently you do not have any <%=SpeciesPlural %> listed. To add <%=SpeciesPlural %> please select the <a href = "AdminAnimalAdd1.asp" class = "body">Add <%=SpeciesPlural %></a> tab.
 <% else    
	rowcount = 1
dim ID(99999) 
dim Name(99999)  
dim Price(99999) 
dim StudFee(99999) 
dim ForSale(99999) 
dim ShowOnWebsite(99999) 
dim Discount(99999)
dim PublishForSale(99999) 
dim PublishStud(99999)
dim Category(99999)	

%>
<table border = "0" cellspacing="0" cellpadding = "0" ><tr><td class = "roundedtop" align = "left">
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



<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	  <td><br><br>
	  	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
			<tr><td class = "roundedtop" align = "left" width = "100%">
			
<table width = "100%"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr ">
			<td class = "body2" align = "center" width = "300"><b>Name</b></td>
					<td class = "body2" align = "center" width = "150"><b>Category</b></td>
			<td class = "body2" align = "center" width = "100"><b>For Sale</b></td>
			<td class = "body2" align = "center" width = "170" ><b>Price (<i>Discount Price</i>)</b></td>
			<td class = "body2" align = "center" width = "100"><b>Stud Fee</b></td>
			<% if screenwidth > 988 then %>
    <td class = "body2" align = "center" width = "100"><b>Options</b></td>
    <% end if %>
	</tr>
</table>
</td>
</tr>
 <tr><td class = "roundedBottom"  align = "center" width = "100%">  
<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	ID(rowcount) =   rs("animals.ID")
	Name(rowcount) =   rs("FullName")
	Category(rowcount) =   rs("Category")
	Price(rowcount) =   rs("Price")
	StudFee(rowcount) =   rs("StudFee")
	ForSale(rowcount) =   rs("ForSale")
	ShowOnWebsite(rowcount) =   rs("ShowOnWebsite")
	Discount(rowcount) =   rs("Discount")
	PublishForSale(rowcount) =   rs("PublishForSale")
	PublishStud(rowcount) =   rs("PublishStud")
showstats = True
 %>
		       

			<table border = "0" cellpadding=0 cellspacing=0  width = "100%" align = "center">
	<tr>	<td class = "body2" width = "300" align = "left">
		<a href = "AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>#BasicFacts" class = "body"><%= Name( rowcount)%></a>
	</td>
	<td class = "body2" width = "150" align = "left">
		<%= Category(rowcount)%>
	</td>
		<td class = "body2" align = "center" width = "100">
		<% if Forsale( rowcount) = True then%>&#10003;<% end if %>
	</td>
		<td class = "body2" width = "170" align = "right">
		<% if len(Price(rowcount)) > 0 then%>
		    <%= formatcurrency(Price(rowcount))%>
		    <% if Discount(rowcount)> 1 then %> 
		(<i><%=  formatcurrency((Price(rowcount) - (Price(rowcount) * (Discount(rowcount)/100))), 2)%></i>)
		     <% end if %>
		 <% else %>    
		     $0
		   <% end if %>

	</td>
			<td class = "body2" width = "100" align = "right">
		   <% if StudFee(rowcount)> 1 then %>
		     <%= formatcurrency(StudFee(rowcount),2)%>
		    <% else %>
		    N/A
		    <% end if %>&nbsp;
	</td>
<% if screenwidth > 988 then %>
		<td class = "body" align = "center" width = "100"><a href = "AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminPhotos.asp?ID=<%= ID( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="14" border = "0"></a><br>
		</td>
		<% end if %>
		</tr>
		</table>

<% 

		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing

 %>




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
</td>
</tr>
</table><br>
</td>
</tr>
</table>
<br><br>
 <!--#Include virtual="/administration/adminFooter.asp"--> 

</BODY>
</HTML>