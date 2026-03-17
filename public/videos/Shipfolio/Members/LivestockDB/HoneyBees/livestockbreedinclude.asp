<%
Set rs2 = Server.CreateObject("ADODB.Recordset")

 sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1  and SpeciesID=" & tempspeciesID & " and left((trim(LOWER(breed))), 1) = '" & lcase(trim(Letter)) & "' Order by trim(Breed)"
'response.write("sql2=" & sql2 )

rs2.Open sql2, conn, 3, 3
if rs2.eof then %>
<a NAME="<%=Letter %>"></a>
<table cellpadding = 0 cellspacing  = 5 width = 100%>
<tr><td class="body"><b>There are no <%=signularanimal %> breeds that start with the letter <%=Letter %>.</b></td></tr>
</table>

<% else %>
<br />
<a NAME="<%=Letter %>"></a>
<table cellpadding = 0 cellspacing  = 0 width = 100%>
<tr bgcolor =#e6e6e6><td  height = 1><div align = right><a href="#A" class = "<%=templclass%>">A</a>
<a href="#B" class = "<%=templclass%>">B</a>
<a href="#C" class = "<%=templclass%>">C</a>
<a href="#D" class = "<%=templclass%>">D</a>
<a href="#E" class = "<%=templclass%>">E</a>
<a href="#F" class = "<%=templclass%>">F</a>
<a href="#G" class = "<%=templclass%>">G</a>
<a href="#H" class = "<%=templclass%>">H</a>
<a href="#I" class = "<%=templclass%>">I</a>
<a href="#J" class = "<%=templclass%>">J</a>
<a href="#K" class = "<%=templclass%>">K</a>
<a href="#L" class = "<%=templclass%>">L</a>
<a href="#M" class = "<%=templclass%>">M</a>
<a href="#N" class = "<%=templclass%>">N</a>
<a href="#O" class = "<%=templclass%>">O</a>
<a href="#P" class = "<%=templclass%>">P</a>
<a href="#Q" class = "<%=templclass%>">Q</a>
<a href="#R" class = "<%=templclass%>">R</a>
<a href="#S" class = "<%=templclass%>">S</a>
<a href="#T" class = "<%=templclass%>">T</a>
<a href="#U" class = "<%=templclass%>">U</a>
<a href="#V" class = "<%=templclass%>">V</a>
<a href="#W" class = "<%=templclass%>">W</a>
<a href="#X" class = "<%=templclass%>">X</a>
<a href="#Y" class = "<%=templclass%>">Y</a>
<a href="#Z" class = "<%=templclass%>">Z</a>
<a href="#Top" class="body">Top</a></div></td></tr>
<tr><td height = 21></td></tr>
<% while not(rs2.eof) 
Breed2 = rs2("Breed") & " "
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")

str1 =Breeddescription
str2 = "rn P"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 



str1 =Breeddescription
str2 = "\r"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 

str1 =Breeddescription
str2 = "\n"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 

str1 =Breeddescription
str2 = "rnrn"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 

str1 =Breeddescription
str2 = "rn("
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 

str1 =Breeddescription
str2 = "rnA"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 


str1 =Breeddescription
str2 = "rnB"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 

str1 =Breeddescription
str2 = ",rn"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , " ")
End If 


str1 =Breeddescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	Breeddescription= Replace(str1, str2 , "''")
End If 

BreedImage= rs2("BreedImage")
str1 =BreedImage
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BreedImage= Replace(str1, str2 , "https://")
End If 

Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") %>
<tr><td bgcolor = '#888888' height = 1></td></tr>
<tr><td bgcolor = "#d6ceca" height = 40><h3><img src = "https://www.livestockoftheworld.com/images/px.gif" alt ="About <%=Breed2  %> <%=SpeciesNamePlural %>" width = 3 height = 30 /><%=Breed2  %></h3></td></tr>
<tr><td bgcolor = '#888888' height = 1></td></tr>
<tr><td class = "body" height = 300 valign = top>

<br>
<% if len(BreedImage) > 1 then%>
<a href="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>"><img src = "<%= BreedImage%>" alt = "<%=BreedImageCaption%>" title = "<%=BreedImageCaption%>" width = "250" align = "left" hspace="20" border = 0/></a>
<% end if %>

<%=left(Breeddescription, 750) %>
<%if len(Breeddescription) > 750 then %>
...
<% end if %>
<%if len(Breeddescription) > 25 then %>
<br />
<table width = 100%>
<tr><td></td>
<td width = 30%>
<form  name=Login method="post" action="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>" >
<input type="submit" class = "regsubmit2" value="LEARN MORE"  >
</form>
</td>
</tr>
</table>
<br>
<% end if %>


</td></tr>
<tr><td height = 21><img src = "https://www.livestockoftheworld.com/images/px.gif" title = alt ="<%=Breed2  %> - <%=SpeciesNamePlural %> Breeds" alt ="<%=Breed2  %> - <%=SpeciesNamePlural %> Breeds" /></td></tr>
<%
 rs2.movenext
wend %>
</table>
<% end if 
rs2.close %>