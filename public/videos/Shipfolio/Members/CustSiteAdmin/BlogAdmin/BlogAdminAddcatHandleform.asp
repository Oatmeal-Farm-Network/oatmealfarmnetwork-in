<%@ Language=VBScript %>
<HTML>
<HEAD>
<!--#Include virtual="/administration/BlogAdmin/BlogAdminGlobalVariables.asp"--> 
<Link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<%
Dim TempNewCategory
Dim TempCategoryType
TempNewCategory=Request.Form("NewCategory" ) 
TempCategoryType=Request.Form("CategoryType" ) 
str1 = Tempcategoryname
str2 = "'"
If InStr(str1,str2) > 0 Then
Tempcategoryname= Replace(str1, "'", "''")
End If
sql = "select * from BlogCategories order by BlogCategoryName desc "  
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
If not rs.eof  then
response.write("sql=" & sql)

if len(rs("BlogCategoryOrder")) > 0 then
newBlogCategoryOrder  = rs("BlogCategoryOrder")  + 1
else
newBlogCategoryOrder  = rs.recordcount + 1
end if
end if
rs.close

sql = "select * from BlogCategories where Blogcategoryname = '" & Tempcategoryname & "' "  
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
If rs.eof  then
str1 = TempNewCategory
str2 = "'"
If InStr(str1,str2) > 0 Then
TempNewCategory= Replace(str1, "'", "''")
End If
Query =  "INSERT INTO BlogCategories (BlogCategoryName, BlogCategoryDisplay, BlogCategoryOrder )" 
Query =  Query & " Values ('" &  TempNewCategory  & "' , Yes,  " &  newBlogCategoryOrder  & ")"
Conn.Execute(Query) 
End if
response.Redirect("BlogAdminCategories.asp")
%>
</Body>
</HTML>