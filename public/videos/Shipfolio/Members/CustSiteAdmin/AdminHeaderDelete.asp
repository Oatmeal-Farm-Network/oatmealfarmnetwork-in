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

Query =  " Delete from SiteDesignHeaderImages where HeaderID = " & HeaderID 

response.write("Query=" & Query )
Conn.Execute(Query)
response.redirect("AdminUpdateHeader.asp")
 %>
 </Body>
</HTML>
