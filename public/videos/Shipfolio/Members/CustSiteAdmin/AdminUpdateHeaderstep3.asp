<!DOCTYPE HTML>
<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="style.css">
    <!--#Include File="AdminGlobalVariables.asp"--> 
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% HeaderMonth = request.form("HeaderMonth")
HeaderDay = request.form("HeaderDay")
HeadertimeOfday= request.form("HeadertimeOfday")
HeaderID= request.querystring("HeaderID")

Query =  " UPDATE SiteDesignHeaderImages Set "
if len(HeaderDay) > 0 then
Query =  Query & " HeaderDay = " &  HeaderDay & ", "
end if
if len(HeaderMonth) > 0 then
Query =  Query & " HeaderMonth=" & HeaderMonth & ","
end if

Query =  Query & " HeadertimeOfday='" & HeadertimeOfday & "' "
Query =  Query & " where HeaderID = " & HeaderID 

response.write("Query=" & Query )
Conn.Execute(Query)
response.redirect("AdminUpdateHeader.asp")
 %>
 </Body>
</HTML>
