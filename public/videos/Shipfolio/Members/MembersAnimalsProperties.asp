<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Membersistration</title>
<meta name="Title" content="<%=Sitenamelong %> Membersistration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
<% Current2="PropertiesHome"
Current3="PropertiesHome" %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersPropertiesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width="<%=screenwidth %>" ><tr><td class = "roundedtopandbottom" align = "left">
<H1><div align = "left">Your Properties</div></H1>
<table border = "0" bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td  valign = "top" class = "body">
<table border = "0" width = "800"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "475" valign = "top" class = "body">
<%  sql = "select distinct * from Properties where PeopleID = " & Session("PeopleID") & " order by PropName"
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
if rs.eof then %> 
Currently you do not have any properties listed. To add properties please select the <a href = "MembersaProperty.asp" class = "body">Add Properties</a> tab.
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
Dim SpeciesID(99999)
%>
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
<table width = "900"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td><br><br>
<table width = "900"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr bgcolor = "antiquewhite">
<td class = "body" align = "center" ><b>Name</b></td>
<td class = "body" align = "center" ><b>For Sale</b></td>
<td class = "body" align = "center" ><b>Price </b></td>
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
	ID(rowcount) =   rs("ID")
	Name(rowcount) =   rs("PropName")
	Price(rowcount) =   rs("Price")
	ForSale(rowcount) =   rs("ForSale")
  showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "antiquewhite" >
<%	End If %>
		

	</td>
	<td class = "body" width = "250" align = "left">
		<a href = "EditProperty0.asp?ID=<%= propID( rowcount)%>#BasicFacts" class = "body"><%= Name( rowcount)%></a>
	</td>
		<td class = "body" align = "center">
		<% if Forsale( rowcount) = True then%>&#10003;<% end if %>
	</td>
		<td class = "body" width = "160" align = "right">
		<% if len(Price(rowcount)) > 0 then%>
		    <%= formatcurrency(Price(rowcount))%>
<% end if %>
</td>
<td class = "body" align = "center" ><a href = "EditProperty0asp?propID=<%= propID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "ProductsUploadPhotos.asp?propID=<%= propID( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="14" border = "0"></a><br>
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
</td>
</tr>
</table>
<br>

 <!--#Include virtual="/Footer.asp"--> 

</BODY>
</HTML>