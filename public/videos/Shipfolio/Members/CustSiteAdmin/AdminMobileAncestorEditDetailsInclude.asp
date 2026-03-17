<%
	if Ancestorname="0" then
		Ancestorname= ""
	end if

str1 = Ancestorname
str2 = "''"
If InStr(str1,str2) > 0 Then
	Ancestorname= Replace(str1, "''", "'")
End If

	%>
	<% if SmallMobile = False then %>

		<table border=0 width="100%">
					<tr>
						<td  class = "body">
						<% If gender = "male" Then %>
						
						<table width = "100%" height = "60" bgcolor = "#3D7097">
						<% Else %>
							<table width = "100%" height = "60" bgcolor = "#F1679A">
					<% End if %>

							<tr>
				
								<td  class = "body" colspan ="2" align = "left"><font color = "white"><b>Name:</b></font>
								<% if gender = "male" then %>
								<font color = "white">Select one of your sires:</font><br>
								<select size="1" name="<%=AncestornameField%>2" onchange="submit();" class = "regsubmit2 body">
								<option name = "AID0"class = "body" value= "" selected></option>
						<% count = 1
							while count < sirescounter
							'if len(SiresName(count))> 1 then
						%>
							<option name = "AID1" value="<%=SiresName(count)%>" class = "body">
								<font class = "body"><%=SiresName(count)%></font>
							</option>
						<% 	'end if
						
						count = count + 1
							wend %>
						</select><br>
								<font color = "white">or type in the sire's name:<br /></font>
							<% else %>
							
							
							
								<font color = "white">Select one of your dams:</font><br>
								<select size="1" name="<%=AncestornameField%>2" onchange="submit();" class = "regsubmit2 body">
								<option name = "AID0"class = "body" value= "" selected><body></body></option>
						<% count = 1
							while count < damscounter
							if len(DamsName(count))> 1 then

						%>
							<option name = "AID1" value="<%=DamsName(count)%>" class = "regsubmit2 body">
								<font class = "body"><body><%=DamsName(count)%></body></font>
							</option>
						<% 	end if
						count = count + 1
							wend %>
						</select><br>
								<font color = "white">or type in the dam's name:<br /></font>
							<% end if %>	
								<input name="<%=AncestornameField%>" value= "<%=Ancestorname%>" size = "30" class = "regsubmit2 body"></td>
							</tr>
							<tr>
								<td  class = "body" ><font color = "white"><b>Color:</b></font></td>
								<td  class = "body" ><input name="<%=AncestorColorField %>" value= "<%=AncestorColor%>" size = "26" class = "regsubmit2 body"></td>
							</tr>
							<tr>
								<td  class = "body"><font color = "white"><b>ARI:</b></font></td>
								<td  class = "body" align = "left"><input name="<%=AncestorARIField%>" value= "<%=AncestorARI%>" size = "12"class = "regsubmit2 body"></td>
							</tr>
							<tr>
								<td  class = "body"><font color = "white"><b>CLAA:</b></font></td>
								<td  class = "body" align = "left"><input name="<%=AncestorCLAAField%>" value= "<%=AncestorCLAA%>" size = "12" class = "regsubmit2 body"></td>
							</tr>
							<tr>
								<td  class = "body"><font color = "white"><b>Link:</b></font></td>
								<td  class = "body" align = "left"><font color = "white">http://</font><input name="<%=AncestorLinkField%>" value= "<%=AncestorLink%>" size = "12" class = "regsubmit2 body"></td>
							</tr>

				</table>
		</td>
	</tr>
</table>

<% else %>

<table border=0 width="100%">
					<tr>
						<td  class = "body">
						<% If gender = "male" Then %>
						
						<table width = "100%" height = "60" bgcolor = "#3D7097">
						<% Else %>
							<table width = "100%" height = "60" bgcolor = "#F1679A">
					<% End if %>

							<tr>
				
								<td  class = "body" colspan ="2" align = "left"><font color = "white"><b>Name:</b></font>
								<% if gender = "male" then %>
								<font color = "white">Select one of your sires:</font><br>
								<select size="1" name="<%=AncestornameField%>2" onchange="submit();" class = "regsubmit2 body">
								<option name = "AID0"class = "body" value= "" selected></option>
						<% count = 1
							while count < sirescounter
							'if len(SiresName(count))> 1 then
						%>
							<option name = "AID1" value="<%=SiresName(count)%>" class = "body">
								<font class = "body"><%=SiresName(count)%></font>
							</option>
						<% 	'end if
						
						count = count + 1
							wend %>
						</select><br>
								<font color = "white">or type in the sire's name:<br /></font>
							<% else %>
							
							
							
								<font color = "white">Select one of your dams:</font><br>
								<select size="1" name="<%=AncestornameField%>2" onchange="submit();" class = "regsubmit2 body">
								<option name = "AID0"class = "body" value= "" selected><body></body></option>
						<% count = 1
							while count < damscounter
							if len(DamsName(count))> 1 then

						%>
							<option name = "AID1" value="<%=DamsName(count)%>" class = "regsubmit2 body">
								<font class = "body"><body><%=DamsName(count)%></body></font>
							</option>
						<% 	end if
						count = count + 1
							wend %>
						</select><br>
								<font color = "white">or type in the dam's name:<br /></font>
							<% end if %>	
								<input name="<%=AncestornameField%>" value= "<%=Ancestorname%>" size = "30" class = "regsubmit2 body"></td>
							</tr>
							<tr>
								<td  class = "body" ><font color = "white"><b>Color:</b></font></td>
								<td  class = "body" ><input name="<%=AncestorColorField %>" value= "<%=AncestorColor%>" size = "26" class = "regsubmit2 body"></td>
							</tr>
							<tr>
								<td  class = "body"><font color = "white"><b>ARI:</b></font></td>
								<td  class = "body" align = "left"><input name="<%=AncestorARIField%>" value= "<%=AncestorARI%>" size = "12"class = "regsubmit2 body"></td>
							</tr>
							<tr>
								<td  class = "body"><font color = "white"><b>CLAA:</b></font></td>
								<td  class = "body" align = "left"><input name="<%=AncestorCLAAField%>" value= "<%=AncestorCLAA%>" size = "12" class = "regsubmit2 body"></td>
							</tr>
							<tr>
								<td  class = "body"><font color = "white"><b>Link:</b></font></td>
								<td  class = "body" align = "left"><font color = "white">http://</font><input name="<%=AncestorLinkField%>" value= "<%=AncestorLink%>" size = "12" class = "regsubmit2 body"></td>
							</tr>

				</table>
		</td>
	</tr>
</table>

<% end if %>
		