<%if Ancestorname="0" then
Ancestorname= ""
end if
str1 = Ancestorname
str2 = """"
If InStr(str1,str2) > 0 Then
Ancestorname= Replace(str1, """", "''")
End If
str1 = Ancestorname
str2 = "''"
If InStr(str1,str2) > 0 Then
Ancestorname= Replace(str1, "''", "'")
End If
if AncestorLink = "NoLink.asp" or AncestorLink = "0"  then
AncestorLink = ""
end if

if AncestorColor = "Not Available" then
AncestorColor = ""
end if
%>
<table border=1 width="160">
<tr><td class = "small">
<% If gender = "male" Then %>
<table width = "240" height = "60" bgcolor = "#3D7097">
<% Else %>
<table width = "240" height = "60" bgcolor = "#F1679A">
<% End if %>
<tr>
<td  class = "small" colspan ="2" align = "left"><font color = "white"><b>Name:</b></font>
<% if gender = "male" then %>
<font color = "white">Select one of your <%=SireTerm %>s:</font><br>
<select size="1" name="<%=AncestornameField%>2" onchange="submit();" width = "270" style="width: 270px" class='formbox'>
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
<font color = "white">or type in the <%=SireTerm %>'s name:<br /></font>
<% else %>
<font color = "white">Select one of your <%=DamTerm %>s:</font><br>
<select size="1" name="<%=AncestornameField%>2" onchange="submit();" width = "240" style="width: 240px" class='formbox'>
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
<font color = "white">or type in the <%=DamTerm %>'s name:<br /></font>
<% end if %>	
<input name="<%=AncestornameField%>" value= "<%=Ancestorname%>" size = "30" class='formbox'></td>
</tr>
<tr><td  class = "small" ><font color = "white"><b>Color:</b></font></td>
<td  class = "small" align = "left"><input name="<%=AncestorColorField %>" value= "<%=AncestorColor%>" size = "25" class='formbox'></td></tr>
<tr><td  class = "small"><font color = "white"><b>Link:</b></font></td>
<td  class = "small" align = "left"><font color = "white">http://</font><input name="<%=AncestorLinkField%>" value= "<%=AncestorLink%>" size = "12" class='formbox'></td>
</tr></table>
</td></tr></table>