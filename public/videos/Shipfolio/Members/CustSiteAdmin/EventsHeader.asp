<% showname= Request.QueryString("showname") 
If Len(showname) > 2 Then 
   session("showname") = showname
Else
    showname = session("showname") 
End If 
%>

<table background = "images/EventsHeader.jpg" width = "800">
<tr>
  <td height = "65">&nbsp;</td></tr>
   <tr>
    <td width = "120" align = "center">
				<a href = "EditPage.asp?showname=<%=showname%>" class = "body"><b>List of Pages</b></a>  |
	 </td>
	   <td width = "120" align = "center" >
			<a href = "EventsAdd.asp" class = "body"><b>Add Events</b></a> |
	 </td>
     <td width = "120" align = "center">
<a href = "EventsMantainance.asp" class = "body"><b>Edit Events</b></a> |
	 </td>
	  <td width = "120" align = "center">
	<a href = "EventsDelete.asp" class = "body"><b>Delete Events</b></a> |
</td>
 <td width = "140" align = "center">
		<a href = "AdminEventsPhotos.asp" class = "body"><b>Upload Images</b></a> |
 </td>
<td align = "center">
		<a href = "Eventspagedata.asp?showname=<%=showname%>" class = "body"><b>Edit Events Description</b></a> 
 </td>
</tr>
</table>
<br>