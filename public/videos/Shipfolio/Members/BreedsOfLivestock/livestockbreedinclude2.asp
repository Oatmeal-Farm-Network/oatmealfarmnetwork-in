

<%
Set rs2 = Server.CreateObject("ADODB.Recordset")
if len(screenwidth) > 2 then
if screenwidth > 900 then
templclass = "formnumbers2" 
else
templclass = "formnumbers" 
end if
else
templclass = "formnumbers" 
end if

 sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1  and SpeciesID=" & tempspeciesID & " and left(lcase(breed), 1) = '" & Letter & "' Order by trim(Breed)"

rs2.Open sql2, conn, 3, 3
if rs2.eof then %>
<a NAME="<%=Letter %>"></a>
<table cellpadding = 0 cellspacing  = 5 width = 100%>
<tr><td class="body">There are no <%=signularanimal %> breeds that start with the letter <%=Letter %>.</td></tr>
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

<% if screenwidth < 900 then %>
<br /><br />
<% end if %>
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
<tr><td height = 21><img src = "http://www.worldlivestock.com/images/px.gif" alt ="<%=Breed2  %> <%=signularanimal %>" /></td></tr>
<% while not(rs2.eof) 
Breed2 = rs2("Breed") 
BreedLookupID2 = rs2("BreedLookupID") 
Breeddescription= rs2("Breeddescription")
BreedImage= rs2("BreedImage")
Breedvideo= rs2("Breedvideo")
BreedImageOrientation = rs2("BreedImageOrientation")
BreedImageCaption = rs2("BreedImageCaption") %>
<tr><td bgcolor = '#888888' height = 1></td></tr>
<tr><td bgcolor = "#F0BC42" height = 40><h3><img src = "http://www.worldlivestock.com/images/px.gif" alt ="<%=Breed2  %> - Breeds of <%=signularanimal %>" width = 3 height = 30 /><%=Breed2  %></h3></td></tr>
<tr><td bgcolor = '#888888' height = 1></td></tr>
<tr><td class = "body">
<br>
<% if len(BreedImage) > 1 then%>
<a href="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>&Screenwidth=<%=screenwidth %>"><img src = "<%= BreedImage%>" alt = "<%=BreedImageCaption%>" width = "180" align = "left" hspace="20" border = 0/></a>
<% end if %>
<blockquote>
<%=left(Breeddescription, 550) %>
<%if len(Breeddescription) > 550 then %>
...
<% end if %>
<%if len(Breeddescription) > 25 then %>
<br />
<table width = 100%>
<tr><td></td>
<td width = 30%>
<form  name=Login method="post" action="Breeds.asp?BreedLookupID=<%= BreedLookupID2%>&SpeciesID=<%= SpeciesID%>&Screenwidth=<%=screenwidth %>" >
<input type="submit" class = "regsubmit2" value="LEARN MORE"  >
</form>
</td>
</tr>
</table>
<br>
<% end if %>
</blockquote>

</td></tr>
<tr><td height = 21><img src = "http://www.worldlivestock.com/images/px.gif" alt ="<%=Breed2  %> Breeds of Livestock" /></td></tr>
<%
 rs2.movenext
wend %>
</table>
<% end if 
rs2.close %>