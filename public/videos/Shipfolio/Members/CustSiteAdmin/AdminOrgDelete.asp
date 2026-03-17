<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
 <!--#Include file="AdminGlobalVariables.asp"--> 
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include File="AdminHeader.asp"--> 
<% Current3 = "DeleteAnimals"  %> 
<!--#Include file="AdminAnimalsTabsInclude.asp"-->
<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth  %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth  %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete an Animal Listing</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "100%">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" >
		<tr>
		<td class = "body">
			To delete an animal from the website simply select the animals name and push the delete button.<br> <b>But be careful. Once an animal is deleted, it's gone!</b>
		</td>
	</tr>
	</table>
<table width = "100%" height = "100"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" >
	<tr>
    <td class = "body" valign = "top" width = "100%" align = "center">
 
 
<%  Request.querystring("BusinessID=" & BusinessID)
dim aID(40000)
dim aName(40000)
	
'	sql2 = "select Animals.ID, Animals.FullName from Animals where BusinessID = " & BusinessID & " order by Fullname "

sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname "
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		aID(acounter) = rs2("ID")
		aName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
	    set conn = nothing



%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
	<tr>
		<td>
			<form action= 'AdminAnimalDeleteHandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td>
					<b>Animal Name</b><br>
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
					<input type=submit value = "Delete" class="regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
<br>
	</td>
	</tr>
</table></td>
	</tr>
</table><br><br>
<!--#Include File="AdminFooter.asp"--> </Body>
</HTML>