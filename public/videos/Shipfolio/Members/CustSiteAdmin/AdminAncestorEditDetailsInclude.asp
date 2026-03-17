<%
	if Ancestorname="0" then
		Ancestorname= ""
	end if

str1 = Ancestorname
str2 = "''"
If InStr(str1,str2) > 0 Then
	Ancestorname= Replace(str1, "''", "'")
End If

 if len(AncestorLink) > 5 then 
 else
 tempAncestorname = Ancestorname
str1 = tempAncestorname
str2 = "'"
If InStr(str1,str2) > 0 Then
tempAncestorname= Replace(str1, str2, "''")
End If
Set rsx = Server.CreateObject("ADODB.Recordset") 
sqlx = "select FullName, animals.ID, Regnumber, Color1 from Animals, AnimalRegistration, colors where animals.ID = Colors.ID and animals.AnimalRegistrationID = AnimalRegistration.AnimalRegistrationID and  FullName = '" & trim(tempAncestorname) & "'"
'response.write("sqlx=" & sqlx)
rsx.Open sqlx, conn, 3, 3
if not rsx.eof then

if len(AncestorARI ) > 0 then
else
AncestorARI = rsx("Regnumber")
end if

if len(AncestorLink) > 0 then
else
AncestorLink = "/details.asp?ID=" & rsx("ID") & "&Detailtype=" & Gender
end if

if len(AncestorColor ) > 0 then
else
AncestorColor =  rsx("Color1")
end if


end if
rsx.close
 end if


 if len(AncestorLink) > 5 then 
str1 = AncestorLink
str2 = "www"
If InStr(str1,str2) > 0 Then
	AncestorLink= "http://" & AncestorLink
End If

end if
if AncestorLink = "0" then
AncestorLink = ""
end if
	%>
	
	<% if mobiledevice = False then %>
	<table border=1 width="160">
	<% else %>
		<table border=0 width="100%">
	<% end if %>
					<tr>
						<td  class = "small">
						<% If gender = "male" Then %>
						
						<table width = "240" height = "60" bgcolor = "#3D7097">
						<% Else %>
							<table width = "240" height = "60" bgcolor = "#F1679A">
					<% End if %>

							<tr>
				
								<td  class = "small" colspan ="2" align = "left"><font color = "white"><b>Name:</b></font>
								<% if gender = "male" then %>
								<font color = "white">Select one of your sires:</font><br>
								<select size="1" name="<%=AncestornameField%>2" onchange="submit();">
								<option name = "AID0"class = "small" value= "" selected><small></small></option>
						<% count = 1
							while count < sirescounter
							'if len(SiresName(count))> 1 then
						%>
							<option name = "AID1" value="<%=SiresName(count)%>" class = "small">
								<font class = "small"><small><%=SiresName(count)%></small></font>
							</option>
						<% 	'end if
						
						count = count + 1
							wend %>
						</select><br>
								<font color = "white">or type in the sire's name:<br /></font>
							<% else %>
							
							
							
								<font color = "white">Select one of your dams:</font><br>
								<select size="1" name="<%=AncestornameField%>2" onchange="submit();">
								<option name = "AID0"class = "small" value= "" selected><small></small></option>
						<% count = 1
							while count < damscounter
							if len(DamsName(count))> 1 then

						%>
							<option name = "AID1" value="<%=DamsName(count)%>" class = "small">
								<font class = "small"><small><%=DamsName(count)%></small></font>
							</option>
						<% 	end if
						count = count + 1
							wend %>
						</select><br>
								<font color = "white">or type in the dam's name:<br /></font>
							<% end if %>	
								<input name="<%=AncestornameField%>" value= "<%=Ancestorname%>" size = "36"></td>
							</tr>
							<tr>
								<td  class = "small" ><font color = "white"><b>Color:</b></font></td>
								<td  class = "small" align = "left"><input name="<%=AncestorColorField %>" value= "<%=AncestorColor%>" size = "26"></td>
							</tr>
	<% if speciesID = 2 then %>						
							<tr>
								<td  class = "small"><font color = "white"><b>ARI:</b></font></td>
								<td  class = "small" align = "left"><input name="<%=AncestorARIField%>" value= "<%=AncestorARI%>" size = "12"></td>
							</tr>
							<tr>
								<td  class = "small"><font color = "white"><b>CLAA:</b></font></td>
								<td  class = "small" align = "left"><input name="<%=AncestorCLAAField%>" value= "<%=AncestorCLAA%>" size = "12"></td>
							</tr>
	<% end if %>
<tr>
<td  class = "small"><font color = "white"><b>Link:</b></font></td>
<td  class = "small" align = "left"><font color = "white">http://</font><input name="<%=AncestorLinkField%>" value= "<%=AncestorLink%>" size = "22"></td>
</tr>
</table>
</td></tr></table>		