<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">

</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include file="AdminHeader.asp"--> 
<br />
<% Current2="Packages"
   Current3="PackageDelete" %> 


<!--#Include file="AdminPackagesTabsInclude.asp"-->

<%
CurrentPackageID = request.QueryString("PackageID")

dim pID(200)
dim pName(200)
Dim pMADLotID(200)

if len(CurrentPackageID) < 0 then
sql = "select * from Package "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	pcounter = 1
	if Not rs.eof  then
		CurrentPackageName = rs("PackageName")
	end if
	rs.close
end if
	
 sql = "select * from Package "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	pcounter = 1
	While Not rs.eof 
		pID(pcounter) = rs("PackageID")
		pName(pcounter) = rs("PackageName")
		pcounter = pcounter +1
		rs.movenext
	Wend		
%>

<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Delete a Package</div></H1>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" width = "100%">
<br />

			To delete a package select the package and press the submit button.<br><br>
			<img src = "images/Important_Triangle.png"><b>Warning! </b>Once you delete a package, it's gone!<br><br>

<% if pcounter = 1  then%>
	<font class = "body"><b>Currently you do not have any packages. To create a package please <a href= "packagesadd.asp" class = "body"><b>click here</b></a>.</font><br><br>
<% else %>

<form action= 'AdminPackageDelete.asp' method = "post">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
	<td class = "body">
		  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0">
	<tr>
		<td class = "body"><b>Package Name:</b></td>
				 <td>
					<select size="1" name="PackageID">
					<% if len(CurrentPackageID) > 0 then %>
								<option name = "AID0" value= "<%=CurrentPackageID%>" selected><%=CurrentPackageName%></option>
					<% else %>
					<option name = "AID0" value= "" selected></option>
					<% end if  %>
					<% count = 1
						while count < pcounter
						response.write(count)
					If Len(pMADLotID(count) ) > 1 Then
					Else
					
					%>
						<option name = "AID1" value="<%=pID(count)%>">
							<%=pName(count)%>
						</option>
					<%End If 
					count = count + 1
					
					wend %>
					</select>
				</td>
				<td>
					<input type=submit value = "Delete" size = "110" class = "regsubmit2"  <%=Disablebutton %> >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>

<% end if 
	   rs.close
	   set rs=nothing
%>
<% If GarageSale = True then
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<a name = "Delete"></a><H2><div align = "left">Reset a Make a Deal Lot<br>
			<img src = "images/underline.jpg" width = "100%" height = "2"></div></H2>
			Make a Deal Alpaca Sale Lots cannot be deleted however they can be reset. To rest one of your lots select the lot below and select reset. <br><br>
			<img src = "images/Important_Triangle.png"><b>Warning!</b>Once you reset a lot of all of it's settings (list of animals, description, etc.) will be deleted!<br><br>
			
		</td>
	</tr>
</table>

<form action= 'Resetlot.asp' method = "post">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<td class = "body">
		  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0">
	<tr>
		<td class = "body"><b>MADAS Lot Name:</b></td>
				 <td>
					<select size="1" name="PackageID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < pcounter
						response.write(count)
					If Len(pMADLotID(count) ) > 1 Then
					
					
					%>
						<option name = "AID1" value="<%=pID(count)%>">
							<%=pName(count)%>
						</option>
					<%
					Else 
					End If 
					count = count + 1
					
					wend %>
					</select>
				</td>
				<td>
					<input type=submit value = "Reset" size = "110" class = "body" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>


<% End If %>
<br><br>
		</td>
	</tr>
</table>
</td>
	</tr>
</table>

<br><br>
<!--#Include file="adminFooter.asp"--> 
<br><br>
</BODY>
</HTML>