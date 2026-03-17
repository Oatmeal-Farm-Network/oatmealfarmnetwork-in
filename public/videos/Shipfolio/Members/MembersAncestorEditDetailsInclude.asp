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
<table border=0 width="160" >
<tr><td class = "small">
<% If gender = "male" Then %>
<table width = "275" height = "60" class ="roundedtopandbottomblue">
<% Else %>
<table width = "275" height = "60" class ="roundedtopandbottompink">
<% End if %>
<tr>
<td  class = "small" colspan ="2" align = "left"><b>Name</b></font>
<% if gender = "male" then 

if sirescounter > 1 then %>

Select one of your <%=SireTerm %>s<br>
<select size="1" name="<%=AncestornameField%>2" onchange="submit();" width = "270" size=200 maxlength =200 style="width: 270px; text-align: left" class='formbox' > 
<option name = "AID0"class = "small" value= "" selected><small></small></option>
<% count = 1
while count < sirescounter
'if len(SiresName(count))> 1 then
%>
<option name = "AID1" value="<%=SiresName(count)%>" class = "small">
<font class = "small"><small><b><%=SiresName(count)%></b></small></font>
</option>
<% 	'end if
count = count + 1
wend %>
</select><br>


or type in the 
  <% end if %>  
    
    
    <%=SireTerm %>'s name<br />
<% else %>

<%if damscounter > 1 then %>

Select one of your <%=DamTerm %>s<br>
<select size="1" name="<%=AncestornameField%>2" onchange="submit();" width = "240" size=200 maxlength =200 style="width: 270px; text-align: left" class='formbox'>
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
or type in the 
    
<% end if %> 
    
    
    
    <%=DamTerm %>'s name<br />
<% end if %>	
<input name="<%=AncestornameField%>" value= "<%=Ancestorname%>" style="width: 270px; text-align: left" size = "30" class='formbox'></td>
</tr>
<tr><td colspan ="2" class = "small" align = "left"><b>Color</b></td></tr>
<tr><td colspan ="2" class = "small" align = "left"><input name="<%=AncestorColorField %>" value= "<%=AncestorColor%>" size = "25" style="width: 270px; text-align: left" class='formbox'></td></tr>
<tr><td colspan ="2" class = "small" align = "left"><b>Link</b></td></tr>
<tr><td colspan ="2" class = "small" align = "left"><input name="<%=AncestorLinkField%>" value= "<%=AncestorLink%>" size = "12" style="width: 270px; text-align: left" class='formbox' ></td>
</tr></table>
</td></tr></table>