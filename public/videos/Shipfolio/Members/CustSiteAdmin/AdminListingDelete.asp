<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/administration/style.css"> 
 <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminHeader.asp"--> 
<br />
<% Current3 = "DeleteProducts"  %> 
<!--#Include virtual="/Administration/AdminProductsTabsInclude.asp"-->
 	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete a Product</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" width = "960"  height = "200" valign = "top" >
     <div align = "left">
			To delete an product simply select it below and push the button.<br> <b>But careful. Once a listing is deleted from your database, it's gone!</b></div><br><br>
		

<%  
dim aID(40000)
dim aName(40000)
dim aAdType(40000)
	sql2 = "select * from sfProducts order by Prodname "

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
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


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top" width = "900" height = "300" align = "center">
	<tr>
	<td width = "10">&nbsp;</td>
		<td class = "body" valign = "top" >
	
			<%If recordcount = 0 then %>		
					<h1>You do not currently have any products listed to delete.</h1>
			<% Else %>
			<form action= 'AdminListingDeleteHandleForm.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
			   <tr>
				 <td align = "center">
					<b>Product</b><br>
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
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
<br />
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>