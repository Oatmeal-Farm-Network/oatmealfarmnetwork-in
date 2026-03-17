<% if mobiledevice = True  or screenwidth < 601 then %>
 <table  border = "0" height = "35" width = "100%" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" >
    <tr>
       <td  nowrap><div class = "body"><a href = "#Top" class = "body">Top of Page</a>&nbsp;|&nbsp;<a href = "#BasicFacts" class = "body">Basic Facts</a> &nbsp;|&nbsp;<a href = "#Pricing" class = "body">Pricing</a><% if screenwidth < 400 then %><br /><% end if %><% If category = "Inexperienced Female" Or Category = "Experienced Female" Then %><a href = "#BreedingRecord" class = "body">Breeding Record</a>&nbsp;|&nbsp;<% End If %><a href = "#Description" class = "body">Description</a>&nbsp;|&nbsp;<a href = "#Awards" class = "body">Awards</a>&nbsp;|&nbsp;<a href = "#Fiber" class = "body"><% If AdministrationID  = 2 then %>
Fibre 
<% else %>
Fiber 
<% end if %></a><br /><a href = "#Ancestry" class = "body">Ancestry</a>&nbsp;|&nbsp;<a href = "AdminPhotos.asp?ID=<%=ID%>#Photos" class = "body">Photos</a>&nbsp;</div>
</td>
    </tr>
    </table>

<% else %>
<br /><br />
<table  border = "0" height = "35" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = ""  align = "right">
<tr>
  <td >
    <table  border = "0" height = "35" width = "100%" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" >
    <tr>
       <td ><div class = "body">Jump To:<a href = "#Top" class = "body">Top of Page</a>&nbsp;|&nbsp;<a href = "#BasicFacts" class = "body">Basic Facts</a>&nbsp;|<% If category = "Unowned Animal" Then 
 else %>&nbsp;<a href = "#Pricing" class = "body">Pricing</a>&nbsp;|
 <% end if %>&nbsp;<% If category = "Unexperienced Female" Or Category = "Experienced Female" Then %><a href = "#BreedingRecord" class = "body">Breeding Record</a>&nbsp;|&nbsp;<% End If %><a href = "#Description" class = "body">Description</a>&nbsp;|&nbsp;<a href = "#Awards" class = "body">Awards</a>&nbsp;|&nbsp;<a href = "#Fiber" class = "body"><% If AdministrationID  = 2 then %>
Fibre 
<% else %>
Fiber 
<% end if %></a>&nbsp;|&nbsp;<a href = "#Ancestry" class = "body">Ancestry</a>&nbsp;
    <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color = "grey">Upload Images:</font> &nbsp;<a href = "AdminPhotos.asp?ID=<%=ID%>#ARI" class = "body">ARI Cert</a>&nbsp;|&nbsp;<a href = "AdminPhotos.asp?ID=<%=ID%>#Histogram" class = "body">Histogram</a>&nbsp;|&nbsp;<a href = "AdminPhotos.asp?ID=<%=ID%>#Video" class = "body">Video</a>&nbsp;|&nbsp;<a href = "AdminPhotos.asp?ID=<%=ID%>#Photos" class = "body">Photos</a>&nbsp;</div>
</td>
    </tr>
    </table>
  </td>
<td width = "8">&nbsp;
</td>
</tr>
</table>
<% end if %>