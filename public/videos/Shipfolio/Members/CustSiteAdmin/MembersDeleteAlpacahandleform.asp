<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<% ID = request.querystring("ID") %>

</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&ID=<%=ID %>'  );" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<!--#Include file="adminGlobalVariables.asp"-->
<% Current1="Animals"
Current2 = "AnimalDelete"   %> 
<!--#Include file="adminHeader.asp"-->

<% conn.close
set conn = nothing %>
<!--#Include virtual="/ConnLOA.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td  align = "left">
<H1><div align = "left">Delete an Animal</div></H1>
</td></tr>
 <tr><td  align = "center">
<table width = "<%=screenwidth %>" height = "200"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center">
<tr><td class = "body" valign = "top"  align = "center">
<% 
dim ID
ID=request.Form("ID")
Query =  "Delete  From Ancestors where ID = " &  ID & "" 
'response.write("Query=" & Query )
connLOA.Execute(Query) 
Query =  "Delete  From Awards where ID = " &  ID & "" 
connLOA.Execute(Query) 
Query =  "Delete  From Animals where ID = " &  ID & "" 
connLOA.Execute(Query) 
Query =  "Delete  From FemaleData where ID = " &  ID & "" 
connLOA.Execute(Query) 
Query =  "Delete  From Fiber where ID = " & ID & "" 
connLOA.Execute(Query) 
Query =  "Delete From Photos where ID = " &  ID & "" 
connLOA.Execute(Query) 
Query =  "Delete From Pricing where ID = " &  ID & "" 
connLOA.Execute(Query) 
Query =  "Delete From MaleData where ID = " &  ID & "" 
connLOA.Execute(Query) 
Query =  "Delete From EPDAlpacas where animalID = " &  ID & "" 
connLOA.Execute(Query) 
Query =  "Delete From EPDcattle where ID = " &  ID & "" 
connLOA.Execute(Query) 
Query =  "Delete From EPDsheep where ID = " &  ID & "" 
connLOA.Execute(Query) 

response.redirect("MembersdeleteAnimal.asp?deletedone=true")
%>
<% 'response.write("Your animal has successfully been deleted.") %></H2>
<% 
connLOA.Close
Set connLOA = Nothing %>
<br><br><a  class = "body" href="membersDeleteanimal.asp">Click here to delete another animal.</a><br>
<br><a  class = "body" href="Default.asp">Click here to go to My Account home page.</a>
<br></td></tr></table>
</td></tr></table>
<br>
 <!--#Include virtual="/Footer.asp"--> 
</Body>
</HTML>
