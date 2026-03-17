<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>


<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>




</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
<% 
Current2="Brokering"
Current3="Herdsire Brokering" %> 
<!--#Include file="MembersHeader.asp"-->
<br /> 
<!--#Include file="SiteMembersTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Brokered Herdsires</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
        <table border = "0" width = "920"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td  valign = "top" class = "body">
<br />
<br />
<form action= 'MembersBrokeringHerdsiresHandleForm.asp' method = "post"  name = "Brokeringform">
<table border = "0" width = "800"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "475" valign = "top" class = "body">

<%  sql = "select distinct Pricing.*, animals.ID, Brokered, FullName, PublishForSale, PublishStud from Animals, Pricing where Animals.ID =Pricing.ID and (category = 'Experienced Male' or category = 'Unexperienced Male')  order by FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3  
    if rs.eof then %>
   Currently you do not have any alpacas listed. To add alpacas please select the <a href = "MembersAnimalAdd1.asp" class = "body">Add Alpaca</a> tab.
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
dim AGBrokeredHerdsire(99999)

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
	
	<td class = "body" align = "center" ><b>AG Brokered Herdsire?</b></td>
			<td class = "body" align = "center" ><b>Name</b></td>
			<td class = "body" align = "center" ><b>Published</b></td>
			<td class = "body" align = "center" ><b>For Sale</b></td>
			<td class = "body" align = "center" ><b>Price (<i>Discount Price</i>)</b></td>
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

	AGBrokeredHerdsire(rowcount) =   rs("Brokered")
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "antiquewhite" >
<%	End If %>
		
	<td class = "body" width = "250" align = "left">
	<Input type = "hidden" name='ID(<%= rowcount%>)' Value = <%=ID(rowcount)%> >
<% 		
		if AGBrokeredHerdsire(rowcount)  = 1 Or AGBrokeredHerdsire(rowcount)  = True Then %>
			Yes<input type="radio" name="AGBrokeredHerdsire(<%= rowcount%>)" Value = "True" checked>
			No<input type="radio" name="AGBrokeredHerdsire(<%= rowcount%>)" Value = "False" >
		<% Else %>
			Yes<input type="radio" name="AGBrokeredHerdsire(<%= rowcount%>)" Value = "True" >
			No<input type="radio" name="AGBrokeredHerdsire(<%= rowcount%>)" Value = "False" checked>
		<% End If %>
	</td>
	<td class = "body" width = "250" align = "left">
		<a href = "EditAlpaca.asp?ID=<%= ID( rowcount)%>#BasicFacts" class = "body"><%= Name( rowcount)%></a>
	</td>
	<td class = "body" align = "center">
		<% if PublishForSale(rowcount) = True then%>&#10003;<% end if %>
	</td>
		
		<td class = "body" align = "center">
		<% if Forsale( rowcount) = True then%>&#10003;<% end if %>
	</td>
		<td class = "body" width = "150" align = "right">
		<% if len(Price(rowcount)) > 0 then%>
		    <%= formatcurrency(Price(rowcount))%>
		      <% if Discount(rowcount)> 1 then
            Pricex = clng(Price(rowcount))
            Discountx  = clng(Discount(rowcount))
            
             %> 
		        (<i><%= formatcurrency(Pricex - (Pricex * Discountx/100), 2)%></i>)
		     <% end if %>
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


</table>

<br>

</td>
</tr>
</table>
</td>
</tr>

</table>
<% end if %>

			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >

				<center><input type="submit" class = "regsubmit2" value="Submit"  ></center>
	</form>

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