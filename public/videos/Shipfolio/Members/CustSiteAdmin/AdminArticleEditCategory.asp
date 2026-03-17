<!DOCTYPE HTML>
<HTML>
<HEAD>
<Link rel="stylesheet" type="text/css" href="style.css">
<!--#Include virtual="/administration/AdminGlobalVariables.asp"--> 
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<%
Dim ArticleCategoryName(9999)
Dim ArticleCatID(9999)
Dim ArticleCategoryOrder(9999)
Dim ArticleCategoryshow(9999)
TotalCount=Request.Form("TotalCount") 
response.write("TotalCount=" & TotalCount)
rowcount  = 1
while (cint(rowcount)  < cint(TotalCount + 1))

ArticleCategoryNamecount = "ArticleCategoryName(" & rowcount & ")"	
ArticleCategoryName(rowcount)=Request.Form(ArticleCategoryNamecount) 

ArticleCatIDcount = "ArticleCatID(" & rowcount & ")"	
ArticleCatID(rowcount)=Request.Form(ArticleCatIDcount) 

ArticleCategoryOrdercount = "ArticleCategoryOrder(" & rowcount & ")"	
ArticleCategoryOrder(rowcount)=Request.Form(ArticleCategoryOrdercount) 

ArticleCategoryshowcount = "ArticleCategoryshow(" & rowcount & ")"	
ArticleCategoryshow(rowcount)=Request.Form(ArticleCategoryshowcount) 
rowcount  =rowcount  +1
Wend

 rowcount =1

  while (cint(rowcount)  < cint(TotalCount + 1))
response.write( ArticleCategoryOrder(rowcount) & "<BR>")
 rowcount= rowcount +1
wend

y = 1

For i = 1 to cint(TotalCount +1 )
y = y + 1
if y = 30 then
exit for
end if
a = ArticleCategoryOrder(i)

if i < cint(TotalCount) then
     i  = i + 1
    b = ArticleCategoryOrder(i)
   if len(a) > 0 then
    else
    a = 0 
    end if
    if len(b) > 0 then
    else
    b = 0 
    end if
    if cint(a) = cint(b) and len(b) > 0 then
        ArticleCategoryOrder(i) = b + 1
        swap = true
    end if
       if a > b then
           response.write("a = " & a)
    response.write("b = " & b)
   '   ArticleCategoryOrder(i-1) = b
   '   ArticleCategoryOrder(i) = a
        swap = true
    end if
    i  = i - 1


end if
if swap = true then
x =1
response.write( "<br>Swap:<BR>")
while (cint(x)  < cint(TotalCount + 1))
response.write( ArticleCategoryOrder(x) & "<BR>")
x=x +1
wend
swap = false
i = 1
end if
next



 rowcount =1
  response.write( "<br>After:<BR>")
 while (cint(rowcount)  < cint(TotalCount + 1))
response.write( ArticleCategoryOrder(rowcount) & "<BR>")
 rowcount= rowcount +1
wend

 rowcount =1
while (cint(rowcount)  < cint(TotalCount + 1))
str1 = ArticleCategoryName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ArticleCategoryName(rowcount)= Replace(str1, "'", "''")
End If
Query =  " UPDATE ArticleCategories Set Articlecategoryname = '" & ArticleCategoryName(rowcount) 

if len(ArticleCategoryOrder(rowcount)) > 0 then
Query =  Query & "', " 
Query =  Query & " ArticleCategoryOrder = " & ArticleCategoryOrder(rowcount) & ", " 
else
Query =  Query & "',  " 
end if
if len(ArticleCategoryshow(rowcount)) > 0 then
else
ArticleCategoryshow(rowcount)  = True
end if
Query =  Query & " ArticleCategoryShow= " & ArticleCategoryShow(rowcount) & " " 
Query =  Query & " where ArticlecatID = " & ArticleCatID(rowcount) & ";" 
response.write("Query=" & Query) 
if len(trim(ArticleCatID(rowcount))) < 1 then
else
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
end if

 rowcount= rowcount +1
wend


DataConnection.Close
Set DataConnection = Nothing 
response.Redirect("AdminArticleSetCategories.asp")
%>
</Body>
</HTML>