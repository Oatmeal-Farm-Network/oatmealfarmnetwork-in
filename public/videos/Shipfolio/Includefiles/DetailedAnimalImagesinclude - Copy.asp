<table cellpadding = 0 cellspacing = 0 width = 300 align = right>
<% if len(ARIPhoto) > 1 or len(HistogramPhoto) > 1 or len(FiberAnalysisPhoto) > 1then %>
<tr><td colspan = 2>
    
<% if len(ARIPhoto) > 1  then %>
<a href = "<%=ARIPhoto%>" class= "body" target = "_blank"><img src = "/images/ARIThumb.jpg" border = "0" height = "50"></a>
<% end if %>
<% if len(HistogramPhoto) > 1 then %>
<a href = "<%=HistogramPhoto%>" class= "body" target = "_blank"><img src = "/images/HistogramThumb.jpg" border = "0" height = "50"></a>
<% end if %>
<% if len(FiberAnalysisPhoto) > 1 then %>
<a href = "<%=FiberAnalysisPhoto%>" class= "body" target = "_blank"><img src = "/images/FiberAnalysisThumb.jpg" border = "0" height = "50"></a>
<% end if %>
</td></tr>
<% end if %>

<tr><td align = "center" valign = top width = 320>
<% if noimage = true then%>
<%=click%>
<% else %>

<div class="featured-image">
<IMG alt="<%=signularanimal %> For Sale - <%=Name%> at <%= BusinessName %>" title="<%=signularanimal %> For Sale - <%=Name%> at <%= BusinessName %>" class = "pictures my-foto" border=0  name=but1 src="<%=buttonimages(1)%>" align = "center" width = "300"></div>
<% end if%>
</td>
</tr>
<tr>
<td valign = top>
<% if not rsA.eof then 
rsA.movefirst
counter = 0
counttotal = 16 %>
<table border = 0 cellpadding = 3 cellspacing=3 border = 0 >

<td width = 80 valign = top>
<% While counter < counttotal and TotalPics > 1
counter = counter +1
 If Len(buttonimages(counter)) > 11 then
   if counter = 1 or counter = 5 then %>
    <tr>
        <td valign = "top" align = "center" class = "small">
        <font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" onMouseOut="img<%=counter%>('but1')"  class = "menu">

        <img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
        <% If Len(buttontitle(counter)) > 2 Then %>
            <small><%=buttontitle(counter)%></small>
        </font>
    <% End If %>
</td>

<% counter = counter +1 %>
<td valign = "top" align = "center" class = "small">
    <% if len(buttonimages(counter)) > 4 then%>
         <font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" onMouseOut="img<%=counter%>('but1')"  class = "menu">
        <img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
        <% If Len(buttontitle(counter)) > 2 Then %>
            <small><%=buttontitle(counter)%></small>
        <% End If %></font>
    <% End If %>
</td>
</tr>

<% end if 
end if 
wend %>

<% else %>
</tr>
<tr><td>
<% While counter < counttotal and TotalPics > 1
counter = counter +1
If Len(buttonimages(counter)) > 11 then
if counter = 1 or counter = 5 then %>
<tr>
<% end if %>
<td valign = "top" align = "center" class = "small">
<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">

<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br><% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %></font>
</td>

<% counter = counter +1 %>
<td valign = "top" align = "center" class = "small">
<% if len(buttonimages(counter)) > 4 then%>

<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">
<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
<% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %></font>

<% End If %>
</td>


<% counter = counter +1 %>
<td valign = "top" align = "center" class = "small">
<% if len(buttonimages(counter)) > 4 then%>

<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">
<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
<% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %></font>

<% End If %>
</td>


<% counter = counter +1 %>
<td valign = "top" align = "center" class = "small">
<% if len(buttonimages(counter)) > 4 then%>

<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">
<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
<% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %></font>

<% End If %>
</td>



</tr>

<% end if %>
<% wend %>

</td></tr>

<% end if %>


</table>
</td></tr>
<% if len(AnimalVideo) > 1  then 
str1 = AnimalVideo
str2 = "width"
If InStr(str1,str2) > 0 Then
AnimalVideo= Replace(str1, "width", "width = 460 widthx") %>

<tr><td colspan = 2 align = right>
<%=AnimalVideo %>
</td>
</tr>
<% End If %>
<% end if %>

</table>