<!doctype html>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<link rel="stylesheet" type="text/css" href="style.css">
  <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalvariables.asp"--> 
</head>
<body >

  
    <!--#Include file="AdminHeader.asp"--> 
    
<% 
ServicesID=request.form("ServicesID") 
If Len(ServicesID) < 3 then
	ServicesID= Request.QueryString("ServicesID") 
End If
Session("ServicesID") = ServicesID
'response.write("ServicesID=")
'response.write(ServicesID)
Dim IDArray2(1000)
Dim ServiceTitle2(10000)
Dim AdType(10000)

 If Len(ServicesID) = 0 Then 
  
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from Services order by ServiceTitle"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray2(acounter) = rs2("ServicesID")
		ServiceTitle2(acounter) = rs2("ServiceTitle")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
 <%  Current3 = "EditServices"%> 

 <!--#Include file="AdminServicesTabsInclude.asp"-->
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit Your Service<br>Step 1: Select a Service</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960"  height = "200" valign = "top">
        
        
<table border = "0" width = "800"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >

<form action="AdminServicesEdit2.asp" method = "post">
		
			   <tr>
				<td width ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your listings:<br>
					<select size="1" name="ServicesID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray2(count)%>">
							<%=ServiceTitle2(count)%> <font class = "small"></font>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
</td>
</tr>
</table>
		  
<% Else %>
	
 <!-- #include file="AdminProductsPhotoFormInclude2.asp" -->
 <% End if %>
<br>
  <!-- #include file="AdminFooter.asp" -->
 </Body>
</HTML>
