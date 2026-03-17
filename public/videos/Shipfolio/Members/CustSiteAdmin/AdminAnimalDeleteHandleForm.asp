<!DOCTYPE HTML>
<HTML>
<HEAD>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">
 <!--#Include File="AdminGlobalVariables.asp"--> 
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include File="AdminHeader.asp"--> 
 <%   if mobiledevice = False and screenwidth > 600 then %>
   <!--#Include file="AdminAnimalsTabsInclude.asp"-->
<%
end if
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Delete an Animal Listing</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "960">

<table width = "900" height = "100"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
<tr><td class = "body" valign = "top" width = "900" align = "center">
<%dim ID
ID=Request.Form("ID" ) 

Query =  "Delete * From MaleData where ID = " +  ID + "" 
Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>
<!--#Include virtual="/Conn.asp"-->
<% 
Found = false
sql2 = "select LOAID from Animals where ID =  " & ID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof  then
LOAID = rs2("LOAID")
end if
rs2.close

if rs.state> 0 then
rs.close
end if
Conn.close
set Conn = Nothing %>
<!--#Include virtual="/ConnLOA.asp"-->

<% 'Response.write("LOAID=!" & LOAID & "!")
if len(trim(LOAID)) > 0 then					
sql = "select * from Animals where PeopleID= " &  session("AIID") & " and (ID = " &   LOAID  & " ) ;"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, ConnLOA, 3, 3  
If (Not rs.eof) and len(trim(LOAID)) > 0 Then
Found = True
End if		 
rs.close
end if


if Found = True then
Query2 = "Delete  From Ancestors where ID = " &  LOAID & "" 
ConnLOA.Execute(Query2) 

Query2 = "Delete  From Animals where ID = " &  LOAID & "" 
ConnLOA.Execute(Query2) 

Query2 = "Delete  From FemaleData where ID = " & LOAID & "" 
ConnLOA.Execute(Query2) 

Query2 = "Delete  From Fiber where ID = " &  LOAID & "" 
ConnLOA.Execute(Query2) 

Query2 = "Delete  From Photos where ID = " &  LOAID & "" 
ConnLOA.Execute(Query2) 
	
Query2 = "Delete  From Pricing where ID = " &  LOAID & "" 
ConnLOA.Execute(Query2) 

Query2 = "Delete From MaleData where ID = " &  LOAID & "" 
ConnLOA.Execute(Query2) 
end if %>

<!--#Include virtual="/Conn.asp"-->

<% Query =  "Delete * From Ancestors where ID = " +  ID + "" 
Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>
<!--#Include virtual="/Conn.asp"-->
<% 
Query =  "Delete * From Animals where ID = " +  ID + "" 
Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>
<!--#Include virtual="/Conn.asp"-->
<%  

Query =  "Delete * From FemaleData where ID = " +  ID + "" 
Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>
<!--#Include virtual="/Conn.asp"-->
<% 

Query =  "Delete * From Fiber where ID = " +  ID + "" 
Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>
<!--#Include virtual="/Conn.asp"-->
<% 

Query =  "Delete * From Photos where ID = " +  ID + "" 
Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>
<!--#Include virtual="/Conn.asp"-->
<% 
	
Query =  "Delete * From Pricing where ID = " +  ID + "" 
Conn.Execute(Query) 
Conn.close
set Conn = Nothing %>

<div align = "center"><br><br>
<b>Your animal has successfully been deleted.</b></div>
<br>
			<br><a  class = "Links" href="AdminAnimalDelete.asp">Click here to delete another animal.</a><br>
			<br><a  class = "Links" href="Default.asp">Click here to return to the administration home page.</a>
			<br><br>
		</td>
	</tr>
</table>

<br><br>	</td>
	</tr>
</table><br><br>
<!--#Include File="AdminFooter.asp"--> </Body>
</HTML>
