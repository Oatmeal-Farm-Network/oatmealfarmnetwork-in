<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include File="membersGlobalVariables.asp"--> 
<% Current2="Properties"
Current3 = "Summary" %> 
<!--#Include File="MembersHeader.asp"--> 
<!--#Include file="AdminPropertiesTabsInclude.asp"-->
<br />
<div class ="container roundedtopandbottom">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width="<%=screenwidth %>" ><tr><td class = "body " align = "left">
<H1><div align = "left">Your Properties</div></H1>
<% if SubscriptionLevel < 4 then %>
<b>Your account does not include property listings. Please <a href = "AdminRenewSubscription.asp?peopleID=<%=peopleID %>" class = "body"><b>click here</b></a> to upgrade your account.</b>

<% else %>


<table border = "0" bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td  valign = "top" class = "body">
<table border = "0" width = "800"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "475" valign = "top" class = "body">
<%  sql = "select distinct * from Properties where PeopleID = " & Session("PeopleID") & " order by PropName"
'response.write (sql)
rs.Open sql, conn, 3, 3  
if rs.eof then %> 
Currently you do not have any properties listed. To add properties please select the <a href = "AddaProperty.asp" class = "body">Add Properties</a> tab.
<% else    
rowcount = 1
dim PropID(99999) 
dim Name(99999)  
dim Price(99999) 
dim ForSale(99999) 
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
<td class = "body2" align = "center" ><b>For Sale</b></td>
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
PropID(rowcount) =   rs("PropID")
Name(rowcount) =   rs("PropName")
Price(rowcount) =   rs("PropPrice")
ForSale(rowcount) =   rs("PropForSale")
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
<td class = "body2" align = "center">
<% if Forsale(rowcount) = True then%>&#10003;<% end if %>
</td>
<td class = "body" width = "160" align = "right">
<% if len(Price(rowcount)) > 0 then%>
<%= formatcurrency(Price(rowcount))%>
<% end if %>
</td>
<td class = "body" align = "center" ><a href = "EditProperty0.asp?propID=<%= propID( rowcount)%>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "ProductsUploadPhotos.asp?propID=<%= propID( rowcount)%>" class = "body"><img src= "images/Photo.gif" alt = "edit" height ="14" border = "0"></a><br>
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
<% end if %>

<br>
</div>
 <!--#Include virtual="/Footer.asp"--> 

</BODY>
</HTML>