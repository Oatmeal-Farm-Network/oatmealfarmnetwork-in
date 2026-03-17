<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Animals Ranches at Livestock Of America </title>
<META name="Title" content="Animals Ranches at Livestock Of America">
<META name="description" content="Find Animal Ranches from Animal ranches all over North America. Suri Animal ranches, Huacaya Animals ranches... " />
<meta name="robots" content="index,follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="index,follow"/>
<meta name="robots" content="All"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.Animalinfinity.com/Animalchamps/infinityknot.ico" /> 
<meta name="subject" content="Animal Ranches, Animal Farms" />
<meta name="author" content="The Andresen Group">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include virtual="/GlobalVariables.asp"-->
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include virtual="/Header.asp"-->
<% Current = "Ranches" %>
<% Current2 = "RanchHome" %>
<!--#Include file="RanchHeader2.asp"--> 
<!--#Include file="RanchTabsInclude.asp"--> 
<table width = "100%"  border = "0" cellpadding = "0" cellspacing = "0" class = "roundedtopandbottom">
<tr><td >
<h1>Ranches from All States & Provinces</h1>
<table border = "0" width = "100%"  align = "center" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
  <tr>
   <td valign = "top" class = "body">Click on the links below to view the ranches in each state:
<%
sql = "SELECT * from States order by StateName"
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
While Not rs.eof 
    StateName = rs("StateName")
StateAbbreviation = rs("StateAbbreviation")
StateHeaderImage = rs("StateHeaderImage")
StateDescription = rs("StateDescription")
StateFlag = rs("StateFlag")
Statebird = rs("Statebird")
StateSeal = rs("StateSeal")
Nicknames = rs("Nicknames") 
Moto = rs("Moto")
%>
<table border = "0" width = "600" height ="50" align = "center" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<tr>
<td width = "83" align = "center" >
<a href = "RanchState.asp?State=<%=StateAbbreviation%>" class = "Body" align = "center"><img src = "/uploads/states/<%=StateFlag %>" border = "0" align = "center" width = "70" border = "0" alt = "<%=StateName %> Animal Ranches"></a>
</td>
<td class = "menu2">	
<a href = "RanchState.asp?State=<%=StateAbbreviation%>" class = "body" align = "center"><h2><%=StateName %> Animal Ranches</h2></a><br>
State Motto: <i><%=Moto %></i>
<center><a href = "RanchState.asp?State=<%=StateAbbreviation%>" class = "body" align = "center">View <%=StateName%> Animal Ranches.</big></a></center>
</td>
<td width = "83" align = "center" >
<a href = "RanchState.asp?State=<%=StateAbbreviation%>" class = "body" align = "center" ><img src = "/uploads/states/<%=StateSeal %>" border = "0" align = "center" width = "50" alt = "<%=StateName %> Animal Ranches"></a>
</td></tr></table>
</div><% 
   rs.movenext
	wend
	rs.close
 %></td>
	</tr>
</table>
 </td>
	</tr>
</table>
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>

