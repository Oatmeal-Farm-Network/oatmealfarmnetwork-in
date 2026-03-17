<div class ="container" cellpadding = 10 cellspacing = 0 width = 300 align = right>
<% if len(ARIPhoto) > 1 or len(HistogramPhoto) > 1 or len(FiberAnalysisPhoto) > 1then %>
<div class ="row">
    <div class ="col">
    
        <% if len(ARIPhoto) > 1  then %>
        <a href = "<%=ARIPhoto%>" class= "body" target = "_blank"><img src = "/images/ARIThumb.jpg" border = "0" height = "50"></a>
        <% end if %>
        <% if len(HistogramPhoto) > 1 then %>
        <a href = "<%=HistogramPhoto%>" class= "body" target = "_blank"><img src = "/images/HistogramThumb.jpg" border = "0" height = "50"></a>
        <% end if %>
        <% if len(FiberAnalysisPhoto) > 1 then %>
        <a href = "<%=FiberAnalysisPhoto%>" class= "body" target = "_blank"><img src = "/images/FiberAnalysisThumb.jpg" border = "0" height = "50"></a>
        <% end if %>

    </div>
</div>
 <% end if %>
<div class ="row">
    <div class ="col" align = "center" valign = top width = 320 height ="290" style ="min-height: 290px">
        <% if noimage = true then%>
        <%=click%>
        <% else %>
        <div class="featured-image" >
            <IMG alt="<%=signularanimal %> For Sale - <%=Name%> at <%= BusinessName %>" title="<%=signularanimal %> For Sale - <%=Name%> at <%= BusinessName %>" class = "pictures my-foto" border=0  name=but1 src="<%=buttonimages(1)%>" align = "center" height = "280"><br />
              <small><%=buttontitle(1)%></small>
            <% end if%>
        </div>
    </div>
</div>
<div valign = top align ="right">
    <% if not rsA.eof then 
    rsA.movefirst
    counter = 0
    counttotal = 16 %>
    <table border = 0 cellpadding = 3 cellspacing=3 border = 0 >

    <td width = 80 valign = top>
        <% While counter < counttotal and TotalPics > 1
        counter = counter +1
            'response.write("<br>buttonimages(counter)=" & buttonimages(counter))
         If Len(buttonimages(counter)) > 4 then
           if counter = 1 or counter = 5 or counter = 9 then %>
            <tr>
                <td valign = "top" align = "center" class = "small">
                <font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" onMouseOut="img<%=counter%>('but1')"  class = "caption">

                <img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0" style="max-height:80px"><br>
                <% If Len(buttontitle(counter)) > 2 Then %>
                    <small><%=buttontitle(counter)%></small>
                </font>
            <% End If %>
        </td>

        <% else 
           ' counter = counter +1 %>
        <td valign = "top" align = "center" class = "small">
            <% if len(buttonimages(counter)) > 4 then
               ' response.write("<br>buttonimages(counter)=" & buttonimages(counter))
                %>


                 <font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" onMouseOut="img<%=counter%>('but1')"  class = "caption">
                <img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0" style="max-height:80px"><br>
                <% If Len(buttontitle(counter)) > 2 Then %>
                    <%=buttontitle(counter)%>
                <% End If %></font>
            <% End If %>
        </td>
        <% if counter=4 or counter=8 or counter=12 or counter=16 then %>
            </tr>
        <% end if %>

        <% end if 
        end if 
        wend %>

    <% else %>
    </table>
  </div>


<% end if %>

</table>
</div>