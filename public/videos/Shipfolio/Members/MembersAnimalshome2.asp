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
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
<% Current2="AniamlsHome"
Current3="AnimalsHome" %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersAnimalsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width="<%=screenwidth %>" ><tr><td class = "roundedtopandbottom" align = "left">
<H1><div align = "left">Your Animals</div></H1>
<table border = "0" bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td  valign = "top" class = "body">
<table border = "0" width = "800"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "475" valign = "top" class = "body">
<%  sql = "select distinct Pricing.*, animals.ID, animals.speciesID, FullName, PublishForSale, PublishStud from Animals, Pricing where Animals.ID =Pricing.ID and  PeopleID = " & Session("PeopleID") & " order by FullName"
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
if rs.eof then %>
Currently you do not have any animals listed. To add animals please select the <a href = "MembersAnimalAdd1.asp" class = "body">Add Animals</a> tab.
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
<td class = "body2" align = "center" ><b>Species</b></td>
<td class = "body2" align = "center" ><b>Published</b></td>
<td class = "body2" align = "center" ><b>Published<br />Stud</b></td>
<td class = "body2" align = "center" ><b>For Sale</b></td>
<td class = "body2" align = "center" ><b>Price<br />(<i>Discount Price</i>)</b></td>
<td class = "body2" align = "center" ><b>Stud Fee</b></td>
<td class = "body2" align = "center" ><b>Options</b></td>
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
	Name(rowcount) =   rs("FullName")
	Price(rowcount) =   rs("Price")
	StudFee(rowcount) =   rs("StudFee")
	ForSale(rowcount) =   rs("ForSale")
	ShowOnWebsite(rowcount) =   rs("ShowOnWebsite")
	Discount(rowcount) =   rs("Discount")
	PublishForSale(rowcount) =   rs("PublishForSale")
	PublishStud(rowcount) =   rs("PublishStud")
    SpeciesName = ""
SpeciesID(rowcount) = rs("SpeciesID")
if SpeciesID(rowcount) = 2 then
SpeciesName="Alpaca" 
end if 
if SpeciesID(rowcount) = 3 then
SpeciesName="Dog"
end if 
if SpeciesID(rowcount) = 4 then
SpeciesName="Llama"
end if 
if SpeciesID(rowcount) = 5 then
SpeciesName="Horse"
end if 
if SpeciesID(rowcount) = 6 then
SpeciesName="Goat"
end if 
if SpeciesID(rowcount) = 7 then
SpeciesName="Donkey"
end if 
if SpeciesID(rowcount) = 8 then
SpeciesName="Cattle"
end if 
if SpeciesID(rowcount) = 9 then
SpeciesName="Bison"
end if 
if SpeciesID(rowcount) = 10 then
SpeciesName="Sheep"
end if 
if SpeciesID(rowcount) = 11 then
SpeciesName="Rabbit"
end if 
if SpeciesID(rowcount) = 12 then
SpeciesName="Pig"
end if 
if SpeciesID(rowcount) = 13 then
SpeciesName="Chicken"
end if 
if SpeciesID(rowcount) = 14 then
SpeciesName="Turkey"
end if 
if SpeciesID(rowcount) = 15 then
SpeciesName="Duck"
end if 
if  SpeciesID(rowcount) = 16 then
SpeciesName="Cat"
end if 
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "antiquewhite" >
<%	End If %>
		

	</td>
	<td class = "body" width = "250" align = "left">
		<a href = "EditAnimal.asp?ID=<%= ID( rowcount)%>#BasicFacts" class = "body"><%= Name( rowcount)%></a>
	</td>
    <td class = "body" align = "center">
		<%=SpeciesName %>
	</td>
	<td class = "body" align = "center">
		<% if PublishForSale(rowcount) = True then%>&#10003;<% end if %>
	</td>
		<td class = "body" align = "center">
		<% if PublishStud(rowcount) = True then%>&#10003;<% end if %>
	</td>
		<td class = "body" align = "center">
		<% if Forsale( rowcount) = True then%>&#10003;<% end if %>
	</td>
		<td class = "body" width = "160" align = "right">
		<% if len(Price(rowcount)) > 1 then%>
		    <%= formatcurrency(Price(rowcount))%>
		    <% if Discount(rowcount)> 1 then %> 
		        (<i><%=  formatcurrency((Price(rowcount) - (Price(rowcount) * (Discount(rowcount)/100))), 2)%></i>)
		     <% end if %>
		 <% else %>    
		    Call For Price
		   <% end if %>

	</td>
			<td class = "body" width = "100" align = "right">
		   <% if StudFee(rowcount)> 1 then %>
		     <%= formatcurrency(StudFee(rowcount),2)%>
		    <% else %>
		    N/A
		    <% end if %>&nbsp;
	</td>
	
		<td class = "body" align = "center" ><a href = "Editanimal.asp?ID=<%= ID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "MembersPhotos.asp?ID=<%= ID( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="14" border = "0"></a><br>
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