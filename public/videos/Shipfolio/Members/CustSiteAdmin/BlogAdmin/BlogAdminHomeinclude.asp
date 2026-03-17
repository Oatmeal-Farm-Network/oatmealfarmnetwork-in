<a name="CatID<%=BlogCatID %>"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
<H1><div align = "left"><%=BlogCategoryName%> Entries</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "960">
<table  width = "950" align = "center"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<%  sql2 =  "select * from Blog, blogcategories where Blog.BlogcatId = Blogcategories.BlogcatID and blog.BlogCatID  = " & BlogCatID  & "  order by BlogId desc"
order = "odd"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, Conn, 3, 3 
if rs2.eof then %>
There are currently no entries with this category.
<% else %>
<tr><td class = "body2" width = "570" align = "center"><b>Title</b></td>
<td class = "body2" width = "100" align = "center"><b>Display</b></td>
<td class = "body2" width = "100" align = "center"><b>Date</b></td>

<td class = "body2" align = "center" width = "80"><b>Options</b></td></tr>
</tr>
<% While Not rs2.eof 
 if order = "even" then
order = "odd" %>
<tr bgcolor = "#e6e6e6" height = "25">
<% else
     order = "even" %>
 <tr bgcolor = "White" height = "25">    
<% end if %>    
<td valign = "top" class = "body"><img src = "images/px.gif" width = "10" height = "1"><a href = "BlogAdminMaintenance2.asp?BlogID=<%=rs2("BlogID")%>" Class = "body"><%=rs2("BlogHeadline")%></a></td>
<td valign = "top" class = "body2" align ="center"><img src = "images/px.gif" width = "10" height = "1"><a href = "BlogAdminMaintenance2.asp?BlogID=<%=rs2("BlogID")%>" Class = "body"><%=rs2("BlogDisplay")%></a></td>
<td valign = "top" class = "body2" align = "right" ><%=rs2("BlogMonth")%>/<%=rs2("BlogDay")%>/<%=rs2("BlogYear")%><img src = "images/px.gif" width = "20" height = "1"></td>
<td class = "body" >
<img src = "images/px.gif" width = "20" height = "1">
<a href = "BlogAdminMaintenance2.asp?BlogID=<%=rs2("BlogID")%>" Class = "body">
<img src= "images/edit.gif" alt = "edit" height ="10" border = "0"></a> 
<a href = "BlogAdminArticleDelete.asp?ArticleID=<%=rs2("BlogID")%>" Class = "delete">
<img src= "images/delete.jpg" alt = "delete" height ="10" border = "0"></a>
    </td>
</tr>

<% 
rs2.movenext
Wend
end if
rs2.close

%>

</table>
</td>
</tr>
</table><br>