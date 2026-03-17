<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="membersGlobalvariables.asp"--> 
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
   
<% Current1="Services" 
Current2 = "EditServices"%>
<!--#Include file="membersHeader.asp"--> 
    
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


	sql2 = "select * from Services where peopleid = " & session("PeopleID") & " order by ServiceTitle"
    'response.write("sql2=" & sql2)
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


	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td width = "<%=screenwidth %>" align = "left">
		<H1>Edit Your Service<h1>
        <h2>Step 1: Select a Service</H2>
<table border = "0" width = "100%"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >

<form action="MembersServicesEdit2.asp" method = "post">
		
			   <tr>
				<td width ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your listings:<br>
					<select size="1" name="ServicesID" class = "formbox">
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
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "regsubmit2"  <%=Disablebutton %> >
				</td>
			  </tr>
		    </table>
		  </form>
</td>
</tr>
</table>
		  
<% Else %>
	

 <% End if %>
<br>
  <!-- #include file="membersFooter.asp" -->
 </Body>
</HTML>
