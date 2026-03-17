<!DOCTYPE HTML>
<HTML>
<HEAD>
<Link rel="stylesheet" type="text/css" href="style.css">
<!--#Include virtual="/administration/BlogAdmin/BlogAdminGlobalVariables.asp"--> 
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<%
Dim BlogCategoryName(9999)
Dim BlogCatID(9999)
Dim BlogCategoryOrder(9999)
Dim BlogCategoryDisplay(9999)
TotalCount=Request.Form("TotalCount") 
response.write("TotalCount=" & TotalCount)
rowcount  = 1
while (cint(rowcount)  < cint(TotalCount + 1))

BlogCategoryNamecount = "BlogCategoryName(" & rowcount & ")"	
BlogCategoryName(rowcount)=Request.Form(BlogCategoryNamecount) 

BlogCatIDcount = "BlogCatID(" & rowcount & ")"	
BlogCatID(rowcount)=Request.Form(BlogCatIDcount) 

BlogCategoryOrdercount = "BlogCategoryOrder(" & rowcount & ")"	
BlogCategoryOrder(rowcount)=Request.Form(BlogCategoryOrdercount) 

BlogCategoryDisplaycount = "BlogCategoryDisplay(" & rowcount & ")"	
BlogCategoryDisplay(rowcount)=Request.Form(BlogCategoryDisplaycount) 

rowcount  =rowcount  +1
Wend

 rowcount =1
 response.write( "before:<BR>")
  while (cint(rowcount)  < cint(TotalCount + 1))
response.write( BlogCategoryOrder(rowcount) & "<BR>")
 rowcount= rowcount +1
wend

y = 1

For i = 1 to cint(TotalCount +1 )
y = y + 1
if y = 30 then
exit for
end if
a = BlogCategoryOrder(i)

if i < cint(TotalCount) then
     i  = i + 1
    b = BlogCategoryOrder(i)

    if cint(a) = cint(b) and len(b) > 0 then
        BlogCategoryOrder(i) = b + 1
        swap = true
    end if
       if a > b then
           response.write("a = " & a)
    response.write("b = " & b)
   '   BlogCategoryOrder(i-1) = b
   '   BlogCategoryOrder(i) = a
        swap = true
    end if
    i  = i - 1


end if
if swap = true then
x =1
response.write( "<br>Swap:<BR>")
while (cint(x)  < cint(TotalCount + 1))
response.write( BlogCategoryOrder(x) & "<BR>")
x=x +1
wend
swap = false
i = 1
end if
next



 rowcount =1
  response.write( "<br>After:<BR>")
 while (cint(rowcount)  < cint(TotalCount + 1))
response.write( BlogCategoryOrder(rowcount) & "<BR>")
 rowcount= rowcount +1
wend

 rowcount =1
while (cint(rowcount)  < cint(TotalCount + 1))
str1 = BlogCategoryName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
BlogCategoryName(rowcount)= Replace(str1, "'", "''")
End If
Query =  " UPDATE BlogCategories Set Blogcategoryname = '" & BlogCategoryName(rowcount) 

if len(BlogCategoryOrder(rowcount)) > 0 then
Query =  Query & "', " 
Query =  Query & " BlogCategoryOrder = " & BlogCategoryOrder(rowcount) & ", " 
else
Query =  Query & "',  " 
end if
Query =  Query & " BlogCategoryDisplay= " & BlogCategoryDisplay(rowcount) & " " 
Query =  Query & " where BlogcatID = " & BlogCatID(rowcount) & ";" 

if len(trim(BlogCatID(rowcount))) < 1 then
else
Conn.Execute(Query) 
end if
rowcount= rowcount +1
wend

Conn.Close
Set Conn = Nothing 
response.Redirect("BlogAdminCategories.asp?ChangesMade=True")
%>
 </Body>
</HTML>