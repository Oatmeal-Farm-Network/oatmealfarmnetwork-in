<%  
Dim PropIDArray(2000)
Dim PropNameArray(2000)
	sql2 = "select * from properties where PeopleID = " & session("peopleid") & " order by propname"
	
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
recordcount = rs2.recordcount
While Not rs2.eof  
PropIDArray(acounter) = rs2("PropID")
PropNameArray(acounter) = rs2("PropName")
'response.write (SSName(studcounter))
acounter = acounter +1
rs2.movenext
Wend		
rs2.close
set rs2=nothing
set conn = Nothing
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top" ><tr><td width = "10">&nbsp;</td><td class = "body" valign = "top" align = "center">
	
			<%If recordcount = 0 then %>		
					<b>You do not currently have any properties listed to delete.</b><br><br>
			<% Else %>
			<form action= 'DeletePropertyhandleform.asp' method = "post">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				 <td align = "center" class = "body">
					<b>Select the property you want deleted: </b>
					<select size="1" name="propID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=PropIDArray(count)%>">
							<%=PropNameArray(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
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