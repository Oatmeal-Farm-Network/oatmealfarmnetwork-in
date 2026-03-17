<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Hera Content Management System</title>
<meta name="Title" content="Alpaca Infinity Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<BODY  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
 <!--#Include virtual="/administration/AdminSecurityInclude.asp"--> 
<!--#Include virtual="/administration/BlogAdmin/BlogAdminGlobalVariables.asp"--> 
<!--#Include virtual="/administration/AdminHeader.asp"--> 
<% Current3 = "BlogHome"  %>
<!--#Include virtual="/administration/BlogAdmin/BlogAdminTabsInclude.asp"--> 
<% PageName="Blog" %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Blog (News)</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "960">
<table width = "960" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td class = "body" valign = "top">
<a name="Top"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Add a Blog Entry</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "960">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "940" align = "center">
<tr>
<td valign = "top">
 <form action= 'BlogAdminAddHeader.asp' method = "post">
<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
<input name="BlogID"  size = "60" value = "<%=BlogID%>" type = "hidden">
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "780" align = "center">
<tr>
<td class = "body" colspan = "2">
<h2>Step 1: Add Blog Entry Heading</h2>
</td>
</tr>
<tr>
<td  align = "right"   class = "body">
<b>Blog Entry Heading: </b>
</td>
<td  align = "left" valign = "top" class = "body">
<input name="Heading"  size = "60" value = "<%=PageTitle%>">
</td>
<td class = "body" align = "right">
<b>Date: </b></td>
<td>
<% BlogMonth = Month(now) 
BlogDay  = day(now)
BlogYear  =  Year(now)%>
<select size="1" name="BlogMonth">
<% if len(BlogMonth) > 0 then %>
<option value="<%=BlogMonth%>" selected><%=BlogMonth%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="1">Jan.(1)</option>
<option  value="2">Feb.(2)</option>
<option  value="3">March (3)</option>
<option  value="4">April (4)</option>
<option  value="5">May (5)</option>
<option  value="6">June (6)</option>
<option  value="7">July (7)</option>
<option  value="8">Aug. (8)</option>
<option  value="9">Sept. (9)</option>
<option  value="10">Oct. (10)</option>
<option  value="11">Nov. (11)</option>
<option  value="12">Dec. (12)</option>
</select>
/ <select size="1" name="BlogDay">
<% if len(BlogDay) > 0 then %>
<option value="<%=BlogDay%>" selected><%=BlogDay%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="1">1</option>
<option  value="2">2</option>
<option  value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
<option  value="8">8</option>
<option  value="9">9</option>
<option  value="10">10</option>
<option  value="11">11</option>
<option  value="12">12</option>
<option  value="13">13</option>
<option  value="14">14</option>
<option  value="15">15</option>
<option  value="16">16</option>
<option  value="17">17</option>
<option  value="18">18</option>
<option  value="19">19</option>
<option  value="20">20</option>
<option  value="21">21</option>
<option  value="22">22</option>
<option  value="23">23</option>
<option  value="24">24</option>
<option  value="25">25</option>
<option  value="26">26</option>
<option  value="27">27</option>
<option  value="28">28</option>
<option  value="29">29</option>
<option  value="30">30</option>
<option  value="31">31</option>
</select>
<select size="1" name="BlogYear">
<% if len(BlogMonth) > 0 then %>
<option value="<%=BlogYear%>" selected><%=BlogYear%></option>
<% else %>
<option value="<%=year(now)%>" selected><%=year(now)%></option>
<% end if %>

<% currentyear = year(date)  - 5
'response.write(currentyear)
For yearv=currentyear+1 To currentyear + 5%>
<option value="<%=yearv%>"><%=yearv%></option>
<% Next %></select>
</td>
  </tr>
  
  <tr>
<td  colspan = "4" align = "center">
<input type = "hidden" name="BlogCatID" value = "6">
<input type=submit value = "Submit"  size = "110" Class = "regsubmit2" >
</td>
</tr>
</table>


</td>
</tr>
</table>
</form>
<br><br>
</td>
</tr>
</table>

<br /><br />

<%
'**********************************************************
' Edit Articles
'**********************************************************
%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Existing Blog Entries</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960">
<table  width = "950" align = "center"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr><td class = "body2" width = "670" align = "center"><b>Title</b></td>
<td class = "body2" width = "100" align = "center"><b>Date</b></td>
<td class = "body2" align = "center" width = "80"><b>Options</b></td></tr>
</tr>
<%  
sql2 =  "select * from Blog order by BlogYear desc, blogMonth Desc, blogday desc"

order = "odd"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, Conn, 3, 3 
While Not rs2.eof 
 if order = "even" then
order = "odd" %>
<tr bgcolor = "#e6e6e6" height = "25">
<% else
     order = "even" %>
 <tr bgcolor = "White" height = "25">    
<% end if %>    
<td valign = "top" class = "body"><img src = "images/px.gif" width = "10" height = "1"><a href = "BlogAdminMaintenance2.asp?BlogID=<%=rs2("BlogID")%>" Class = "body"><%=rs2("BlogHeadline")%></a></td>
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

rs2.close

%>

</table>
</td>
</tr>
</table><br>
</td>
</tr>
</table>
</td>
</tr>
</table>
<br><br>

<!--#Include virtual="/administration/AdminFooter.asp"--> 
</Body>
</HTML>