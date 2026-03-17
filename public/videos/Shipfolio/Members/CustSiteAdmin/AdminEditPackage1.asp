<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<meta name="Title" content="Alpaca Infinity Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>

<!--#Include file="AdminHeader.asp"--> 
<!--#Include file="AdminSecurityInclude.asp"-->

    <% 
   Current2="Packages"
   Current3="PackageEdit" %> 
<br>
<!--#Include file="AdminPackagesTabsInclude.asp"-->


<% 

Dim PackageID(2000)
Dim PackageName(2000) 
	
	sql2 = "select * from Package order by Packagename"
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		PackageID(acounter) = rs2("PackageID")
		PackageName(acounter) = rs2("PackageName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close

%>

<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Edit Your Packages</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">

<% If acounter > 1 Then %>
			<form  action="AdminAddaPackageStep4.asp" method = "post" >
			    <tr>
		
				 <td class = "body">
					<br>Select one of your packages:
					<select size="1" name="PackageID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=PackageID(count)%>">
							<%=PackageName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			<input type=submit value = "Edit" size = "110" class = "regsubmit2" >
				</td>
			  </tr>
<% Else %>
	<tr>
		<td class = "body"><br>
<font class = "body"><b>Currently you do not have any packages. To create a package please <a href= "packagesadd.asp" class = "body"><b>click here</b></a>.</font><br><br>
		</td>
	</tr>
<% End If %>
		    </table>
		  </form>



<br><br></td>
</tr>
</table></td>
</tr>
</table><br><br>
<!--#Include file="adminFooter.asp"--> 

 </Body>
</HTML>
