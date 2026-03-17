<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Livestock of AmericaAdministration</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include file="AdminSecurityInclude.asp"-->
<% Current2="Products"
   Current3="ProductDelete" %> 

   <!--#Include file="adminHeader.asp"-->

<br>
<!--#Include file="AdminProductsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "body roundedtopandbottom" align = "left"><br />
<H1><div align = "left">Delete Products</div></H1>
<%  
dim aID(40000)
dim aName(40000)
dim aAdType(40000)

	sql2 = "select * from sfProducts where PeopleID = " & session("PeopleID") & " order by Prodname "

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if rs2.eof then %>
	
        Currently you do not have any products listed. To add products please select the <A href = "PlaceClassifiedAd0.asp" class = "body">Add Products</A> tab above.
<br />


<%	else
	
	
	recordcount = rs2.recordcount
	While Not rs2.eof  
		aID(acounter) = rs2("prodID")
		aName(acounter) = rs2("ProdName")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top" >
	<tr>
	<td width = "10">&nbsp;</td>
		<td class = "body" valign = "top" align = "center">
	<br />
To delete an product simply select it below and push the button.<br> <b>But careful. Once a listing is deleted from your database, it's gone!</b><br><br>
			<%If recordcount = 0 then %>		
					<h1>You do not currently have any products listed to delete.</h1>
			<% Else %>
			<form action= 'DeleteListinghandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				 <td align = "center">
					<b>Product</b>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Delete"  class = "regsubmit2" >
				</td>
			  </tr>
			  <tr>
			     <td height = "200">&nbsp;
				 </td>
				</tr>
		    </table>
		  </form>
		  <% End If %>
		    <% End If %>
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
<!--#Include virtual="/Footer.asp"--> </Body>
</HTML>