<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="AdminGlobalVariables.asp"-->
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% Current1="Products"
Current2 = "ProductPhotos"
Current3 = "ProductPhotos" %> 
<!--#Include file="AdminHeader.asp"-->

<% conn.close
set conn = nothing %>
<!--#Include virtual="/connloa.asp"-->

<br />
<!--#Include file="AdminProductsTabsInclude.asp"-->
<%  
Dim IDArray(1000)
Dim IDArray2(1000)
Dim ProductName2(1000)

ID= Request.QueryString("ID")
 
If Len(ID) < 1 then
	ID= Request.Form("ID") 
End If 

If Len(ID) < 1 then
	ID= Request.querystring("prodID") 
End If 

Session("ProductId")= ID
ProdID = ID
Dim ProductName(200) 

If Len(ProdID) < 1 Then 
sql2 = "select ProdID, ProdName from sfProducts where PeopleID = " & session("AIID") & "  order by Prodname"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connloa, 3, 3 
	
	While Not rs2.eof  
		IDArray2(acounter) = rs2("ProdID")
		ProductName2(acounter) = rs2("ProdName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set connloa = nothing
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = <%=screenwidth-32 %> class = "roundedtopandbottom">
<tr><td align = "left" class = body>
<H1>Upload Photos</H1>


<% if acounter > 1 then %>
        
<form action="membersProductPhotos.asp" method = "post">
			  	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth - 32 %>" align = "left">
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your products:
					<select size="1" name="ID" class = "formbox">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray2(count)%>">
							<%=ProductName2(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Select"  class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
<% else %>
Currently you do not have an products listed. To add products please select the <A href = "PlaceClassifiedAd0.asp" class = "body">Add Products</A> tab above.

<% end if %>
<% Else %>
	
 <!-- #include file="membersProductsPhotoFormInclude2.asp" -->
 <% End if %>
</td>
</tr>
</table>
<br />
<!--#Include file="adminFooter.asp"-->
 </Body>
</HTML>
