<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<!--#Include virtual="/Conn.asp"-->
<%
ServicesID = request.QueryString("ServicesID")
Add = request.Querystring("Add")
DeleteAttribute = request.Querystring("DeleteAttribute")
AddOption = request.Querystring("AddOption")
DeleteOption = request.Querystring("DeleteOption")
ServicesOptionsAttributesID = request.Querystring("ServicesOptionsAttributesID")
ServicesOptionID = request.Querystring("ServicesOptionID")
ServicesOptionsAttributesName= request.Form("ServicesOptionsAttributesName")
ServicesOptionsAttributesExtraCost= request.Form("ServicesOptionsAttributesExtraCost")
ServicesOptionOneTimeFee= request.Form("ServicesOptionOneTimeFee")
ServicesOptionTitle = request.Form("ServicesOptionTitle")
UpdateOneTimeFee = request.Form("UpdateOneTimeFee")




if len(ServicesOptionOneTimeFee) > 0 and len(ServicesOptionID) > 0 then
Query =  " UPDATE ServicesOptions Set "
Query = Query  & " ServicesOptionOneTimeFee= " & ServicesOptionOneTimeFee 
 Query = Query  & " where ServicesOptionID = " & ServicesOptionID
 response.Write("Query =" & Query  )
 
 
 response.Write("Query=" & Query )


Conn.Execute(Query) 
Conn.Close

response.Redirect("AdminServicesOptionFrame.asp?ServicesID=" & ServicesID & "#Options")
  
end if



if DeleteAttribute = "True" then
	Query =  "Delete * From ServicesOptionsAttributes where ServicesOptionsAttributesID  = " &  ServicesOptionsAttributesID  & ""



Conn.Execute(Query) 
Conn.Close

response.Redirect("AdminServicesOptionFrame.asp?ServicesID=" & ServicesID & "#Options")
end if 




if DeleteOption = "True" then
	Query =  "Delete * From ServicesOptions where ServicesOptionID = " &  ServicesOptionID & ""
	response.Write("query=" & query) 

Conn.Execute(Query) 

Query =  "Delete * From ServicesOptionsAttributes  where ServicesOptionID = " &  ServicesOptionID & ""
	response.Write("query=" & query) 

Conn.Execute(Query) 


Conn.Close

response.Redirect("AdminServicesOptionFrame.asp?ServicesID=" & ServicesID & "#Options")
end if 


if Add = "True" then
Query =  "INSERT INTO ServicesOptions (ServicesID, ServicesOptionTitle, ServicesOptionOneTimeFee)"  
Query =  Query & " Values (" & ServicesID & ", '" &  ServicesOptionTitle &  "', " &  ServicesOptionOneTimeFee  & ")"
response.Write("Query=" & Query )



Conn.Execute(Query) 
Conn.Close

response.Redirect("AdminServicesOptionFrame.asp?ServicesID=" & ServicesID & "#Options")
end if


if Addoption = "True" then
Query =  "INSERT INTO ServicesOptionsAttributes (ServicesOptionID, ServicesOptionsAttributesName"
if len( ServicesOptionsAttributesExtraCost) then
Query = Query & ", ServicesOptionsAttributesExtraCost"  
end if
Query = Query & ")"  

Query =  Query & " Values (" & ServicesOptionID & ", '" & ServicesOptionsAttributesName & "'"

if len(ServicesOptionsAttributesExtraCost) then
Query =  Query & ","  & ServicesOptionsAttributesExtraCost 
end if

Query =  Query &  ")"

response.Write("Query=" & Query )

Set DataConnection = Server.CreateObject("ADODB.Connection")

Conn.Execute(Query) 
Conn.Close
Set DataConnection = Nothing
response.Redirect("AdminServicesOptionFrame.asp?ServicesID=" & ServicesID & "#Options")
end if


%>
	

<table border = '0' leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = 'left' width = '430'>
<tr>
	<td class= "body" colspan = "4"><i><font color = "#404040">Manage below the different options available for this service such as "extra length" or "coating" and the attributes associated with those options such as "extra 2 inches" or "gloss coating".</font></i></td>
	</tr>
<tr>
<td class = "body" colspan = 4 ><h2>Add an Option</h2>
    <form name="AddOptionForm" method="post" action= 'AdminServicesOptionFrame.asp?ServicesID=<%=Servicesid %>&Add=True' >
    <table>
    <tr><td class = "body">Title</td>
    <td class = "body">Single Fee</td>
    </tr>
    <tr>
    <td class = "body"> <input type = "text" name="ServicesOptionTitle" value= "" ></td>
     <td class = "body" width = "145">
						Yes<input TYPE="RADIO" name="ServicesOptionOneTimeFee" Value = True >
						No<input TYPE="RADIO" name="ServicesOptionOneTimeFee" Value = False checked>
    </td>
    <td><input type=submit value = "Add Option" class="regsubmit2" ></td>
</tr>
</table>
</form>


</td>
</tr>
<% 
sql = "select * from ServicesOptions where ServicesID = " & ServicesID 
rs.Open sql, conn, 3, 3 
if not rs.eof then

while Not rs.eof 
attributeheadshow = False
ServicesOptionID = rs("ServicesOptionID")
ServicesOptionOneTimeFee=rs("ServicesOptionOneTimeFee")%>
    <tr>
<td class = "body" colspan = 4>
<table cellspacing = 0 cellpadding = 0>
<tr>
<td class = "body">
<form method="POST" action="AdminServicesOptionFrame.asp?ServicesID=<%=ServicesID %>&ServicesOptionID=<%=ServicesOptionID %>&UpdateOneTimeFee=True" ><H3>Option: <%=rs("ServicesOptionTitle") %>&nbsp;</h3>
</td>
 <td class = "body">
<font size = 2>Single Fee?
  <% if  ServicesOptionOneTimeFee = "Yes" Or ServicesOptionOneTimeFee = True Then %>
	Yes<input TYPE="RADIO" name="ServicesOptionOneTimeFee" Value = True checked onchange="submit();">
	No<input TYPE="RADIO" name="ServicesOptionOneTimeFee" Value = False onchange="submit();">
<% Else %>
	Yes<input TYPE="RADIO" name="ServicesOptionOneTimeFee" Value = True onchange="submit();">
	No<input TYPE="RADIO" name="ServicesOptionOneTimeFee" Value = False checked onchange="submit();">
<% End if%>
      </font> 
      </form>
</td>
<td class = "body">
       <form method="POST" action="AdminServicesOptionFrame.asp?ServicesID=<%=ServicesID %>&ServicesOptionID=<%=ServicesOptionID %>&DeleteOption=True" ><input type=submit value = "X" class = "regsubmit2"  <%=Disablebutton %> ></form> 
</td>
</tr>
       </table>


</td>
    </tr>

<% 
Set rss = Server.CreateObject("ADODB.Recordset")
sqls = "select * from ServicesOptionsAttributes where ServicesOptionID = " & ServicesOptionID 
rss.Open sqls, conn, 3, 3 
ServicesOptionsCount = rss.recordcount
if  ServicesOptionsCount > 0 and attributeheadshow = False then 
attributeheadshow = True
%>
    <TR><td class = "body" colspan = "4" ><b>Attributes:</b></td></TR>
    <Tr><td width = 10></td><td class = "body">Title</td>
    <td class = "body">Extra Cost</td>
    <td class = "body">Delete</td></Tr>
<% else
   if attributeheadshow = False then 
   attributeheadshow = True%>
    <TR><td class = "body" colspan = "4" ><b>Attributes:</b></td></TR>
    <Tr><td width = 10></td><td class = "body" width = '220' >Title</td>
    <td class = "body" ><div align = "left">Extra Cost</div></td>
    <td class = "body"></td></Tr>
 <% end if %>
 <% end if %>
<% if not rss.eof then %>

<% while not rss.eof
       ServicesOptionsAttributesID = rss("ServicesOptionsAttributesID")   %>
  <tr><td width = 10></td><td class = "body"><input type = "text" name="ServicesOptionsAttributesName" value= "<%=rss("ServicesOptionsAttributesName") %>" ></td>
  <td class = "body">$<input type = "text" name="ServicesOptionsAttributesExtraCost " value= "<%=rss("ServicesOptionsAttributesExtraCost") %>" size=5></td>

  <td align = 'center' ><form method="POST" action="AdminServicesOptionFrame.asp?ServicesID=<%=ServicesID %>&ServicesOptionsAttributesID=<%= ServicesOptionsAttributesID %>&ServicesOptionID=<%=ServicesOptionID %>&DeleteAttribute=True" > <input type=submit value = "X" class = "regsubmit2"  <%=Disablebutton %> ></form></td>
  </tr>
    
    
<% rss.movenext
wend %>

<% end if %>

<% rs.movenext
wend
rs.close


%>

    <tr>
<td colspan = 4><table border = 0  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<form name="AddOptionForm" method="post" action= 'AdminServicesOptionFrame.asp?ServicesOptionID=<%=ServicesOptionID%>&ServicesID=<%=Servicesid %>&AddOption=True' >
       
       
<tr><td width = 10></td>
<td class = "body" width = "200"> <input type = "text" name="ServicesOptionsAttributesName" value= "" ></td>
<td class = "body"> $<input type = "text" name="ServicesOptionsAttributesExtraCost" size= 5 value= "" >
 </td>
<td><input type=submit value = "Add Attribute" class="regsubmit2" >
</form>
</td>
</tr>
</table>
<% end if %>

</body>	