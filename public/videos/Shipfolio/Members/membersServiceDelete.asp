<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include File="membersGlobalVariables.asp"--> 
</head>
<body >

<% Current1="Services"
Current2 = "DeleteService"
Current3 = "Delete" %> 
<!--#Include file="membersHeader.asp"--> 
	 <% Hidelinks = False %>
	  <!--#Include File="MembersServicesJumpLinks.asp"--> 
<div class ="container roundedtopandbottom">
<H1>Delete a Service</H1>


<%  
dim ServicesID(40000)
dim ServiceTitle(40000)
dim aAdType(40000)

sql2 = "select * from Services where peopleiD = " & session("PeopleID") & " order by ServiceTitle "
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	recordcount = 1
    if rs2.eof then

        recordcount = 0
    else
	While Not rs2.eof  
		ServicesID(acounter) = rs2("ServicesID")
		ServiceTitle(acounter) = rs2("ServiceTitle")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
    end if
		rs2.close
		set rs2=nothing
		set conn = nothing
%>

<table valign = "top" width = "100%" height = "300" align = "center">
	<tr>
	<td width = "10">&nbsp;</td>
		<td class = "body" valign = "top" >
	
			<%If recordcount = 0 then %>		
					<font color = maroon><b>You do not currently have any services listed to delete.</b></font>
			<% Else %>
			<form action= 'membersServiceDeleteStep2.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
			   <tr>
               <td align = "center" >
					<b>Service</b>&nbsp;
               </td>
			    <td align = "center" valign = top>
					<select size="1" name="ServicesID" class = "formbox">
					<option  value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option  value="<%=ServicesID(count)%>">
							<%=ServiceTitle(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
               <td align = "center" width = 10>
			   </td>
				<td valign = top>
					<input type=submit value = "Delete Service"  class = "regsubmit2"  <%=Disablebutton %> >
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

</div>
<br />
<!--#Include file="membersFooter.asp"--> </Body>
</HTML>