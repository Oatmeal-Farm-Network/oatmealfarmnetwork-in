<!DOCTYPE HTML>
<HTML>
<HEAD>
       <Link rel="stylesheet" type="text/css" href="style.css">
       <!--#Include file="adminglobalvariables.asp"--> 
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<%
Dim attrID(9999)
Dim attrName(9999)
Dim attrDisplayOrder(9999)
Dim attrControltype(9999)
Dim attrRequired(9999)
Dim attrAvailableToAllProds(9999)
Dim attrCatagoryId(9999)
Dim attrExtraCostAllowed(9999)
TotalCount=Request.Form("TotalCount") 
response.write("TotalCount=" & TotalCount)
rowcount  = 1
while (cint(rowcount)  < cint(TotalCount + 1))

attrIDcount = "attrID(" & rowcount & ")"	
attrID(rowcount)=Request.Form(attrIDcount) 

attrNamecount = "attrName(" & rowcount & ")"	
attrName(rowcount)=Request.Form(attrNamecount) 

attrDisplayOrdercount = "attrDisplayOrder(" & rowcount & ")"	
attrDisplayOrder(rowcount)=Request.Form(attrDisplayOrdercount) 

attrControltypecount = "attrControltype(" & rowcount & ")"	
attrControltype(rowcount)=Request.Form(attrControltypecount) 

attrRequiredcount = "attrRequired(" & rowcount & ")"	
attrRequired(rowcount)=Request.Form(attrRequiredcount) 

attrAvailableToAllProdscount = "attrAvailableToAllProds(" & rowcount & ")"	
attrAvailableToAllProds(rowcount)=Request.Form(attrAvailableToAllProdscount) 

attrCatagoryIdcount = "attrCatagoryId(" & rowcount & ")"	
attrCatagoryId(rowcount)=Request.Form(attrCatagoryIdcount) 

attrExtraCostAllowedcount = "attrExtraCostAllowed(" & rowcount & ")"	
attrExtraCostAllowed(rowcount)=Request.Form(attrExtraCostAllowedcount) 

rowcount  =rowcount  +1
Wend

 rowcount =1
 response.write( "before:<BR>")
  while (cint(rowcount)  < cint(TotalCount + 1))
response.write( attrDisplayOrder(rowcount) & "<BR>")
 rowcount= rowcount +1
wend

y = 1
sort = false
if sort = true then
For i = 1 to cint(TotalCount +1 )
y = y + 1
if y = 30 then
exit for
end if
a = attrDisplayOrder(i)

if i < cint(TotalCount) then
     i  = i + 1
    b = attrDisplayOrder(i)

    if cint(a) = cint(b) and len(b) > 0 then
        attrDisplayOrder(i) = b + 1
        swap = true
    end if
       if a > b then
           response.write("a = " & a)
    response.write("b = " & b)
   '   attrDisplayOrder(i-1) = b
   '   attrDisplayOrder(i) = a
        swap = true
    end if
    i  = i - 1


end if
if swap = true then
x =1
response.write( "<br>Swap:<BR>")
while (cint(x)  < cint(TotalCount + 1))
response.write( attrDisplayOrder(x) & "<BR>")
x=x +1
wend
swap = false
i = 1
end if
next
end if


 rowcount =1
  response.write( "<br>After:<BR>")
 while (cint(rowcount)  < cint(TotalCount + 1))
response.write( attrDisplayOrder(rowcount) & "<BR>")
 rowcount= rowcount +1
wend

 rowcount =1
while (cint(rowcount)  < cint(TotalCount + 1))
str1 = attrName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
ArticleCategoryName(rowcount)= Replace(str1, "'", "''")
End If
Query =  " UPDATE sfattributes Set attrName = '" & attrName(rowcount)  & "', " 


Query =  Query & " attrRequired = " & attrRequired(rowcount) & " ," 
Query =  Query & " attrAvailableToAllProds = " & attrAvailableToAllProds(rowcount) & " ," 
if len(attrCatagoryId(rowcount)) > 0 then
Query =  Query & " attrCatagoryId = " & attrCatagoryId(rowcount) & " ," 
end if
Query =  Query & " attrExtraCostAllowed = " & attrExtraCostAllowed(rowcount) & " ," 

Query =  Query & " attrControltype = '" & attrControltype(rowcount) & "' ," 
Query =  Query & " attrDisplayOrder = " & attrDisplayOrder(rowcount) & " " 

Query =  Query & " where attrID= " & attrID(rowcount) & ";" 
response.write("Query=" & Query) 
if len(trim(attrID(rowcount))) < 1 then
else
Conn.Execute(Query) 
end if

 rowcount= rowcount +1
wend


Conn.Close
Set Conn = Nothing 
response.Redirect("AdminProductsAttributesSet.asp?ChangesMade=True")
%>
 </Body>
</HTML>