<!DOCTYPE HTML >
<HTML>
<HEAD>
<% Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if
%>
<link rel="stylesheet" type="text/css" href="/administration/style.css"> 
  <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<!--#Include file="AdminHeader.asp"--> 
<%  Current3 = "PageGroups"   %> 
<!--#Include virtual="/Administration/AdminPagesTabsInclude.asp"-->
<% 
TempPageGroupTitle=Request.Form("PageGroupTitle" ) 
TempPageGroupShow=Request.Form("PageGroupShow" ) 
TempPageGroupID=Request.Form("PageGroupID" ) 
TempPageGroupOrder= Request.Form("PageGroupOrder")
Update = Request.Form("Update")

 'response.Write("Update=" & Update)
str1 = TempPageGroupTitle
str2 = "'"
If InStr(str1,str2) > 0 Then
	TempPageGroupTitle= Replace(str1, "'", "''")
End If


If Update = "True" then
	Query =  " UPDATE Pagegroups Set PageGroupTitle = '" & TempPageGroupTitle & "' , " 
	Query =  Query & " PageGroupShow = " & TempPageGroupShow & ", " 
	if len(TempPageGroupOrder) > 0 then
	else
	TempPageGroupOrder = 1
	end if 
	Query =  Query & " PageGroupOrder = " & TempPageGroupOrder & " " 
	Query =  Query & " where PageGroupID = " & TempPageGroupID & ";" 

	sLocalSQL = "SELECT PageGroupTitle FROM Pagegroups WHERE PageGroupID = " & TempPageGroupID
End If 

'response.write("sLocalSQL=" & sLocalSQL)
'response.write("Query=" & Query)
If Len(Query) > 3 then
    	Set DataConnection = Server.CreateObject("ADODB.Connection")
        DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
    	DataConnection.Execute(Query) 
    	DataConnection.Close
	    Set DataConnection = Nothing 
end if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -10%>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Page Groups</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" height = "300" valign = "top">

Page Groups are a way to organize your pages. By grouping your pages they will show up correctly on menus and anywhere else that your page links are organized on your website.


<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "<%=screenwidth- 12 %>" >
	<tr>
	    <td width = "490">
	    <% 
Dim PageGroupID(100,100)
Dim PageGroupTitle(100,100)
Dim PageGroupShow(100,100)
Dim PageGroupOrder(100,100)


sql = "select * from Pagegroups  order by PageGroupOrder " 
'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		PageGroupID(CatCounter,0) = rs("PageGroupID")
		PageGroupTitle(CatCounter,0) = rs("PageGroupTitle")
		PageGroupShow(CatCounter,0) = rs("PageGroupShow")
		PageGroupOrder(CatCounter,0) = rs("PageGroupOrder")
		'response.write(PageGroupTitle(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0 %>

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "100%">
<tr><td  class = "body" valign = "top" colspan = "4">
<br />
<H2>Edit Existing Page Groups</H2>
</td>
</tr>
<tr>
<td bgcolor = "#abacab" height = "1" colspan = "4"></td>
</tr>	
<tr>
<td class = "body" align = "center"><b>Name</b></td>
<td class = "body" align = "center" width = "79" align = "center"><b>Order</b></td>
<td class = "body2" align = "center" width = '120'><b>Display Group</b></td>
<td></td>
</tr>
<% While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
<tr>
			<td class = "body"> <form action= 'AdminPagegroups.asp' method = "post" style="margin-bottom:0;" >
			<div style="display: inline;">
			
			<input name="Update" value ="True"  type = hidden>
			<input name="PageGroupTitle" value ="<%= PageGroupTitle(CatCounter,0) %>"  size = "30"></div>
			</td>
			<td>
			<select size="1" name="PageGroupOrder">	
				<option  value= "<%= PageGroupOrder(CatCounter,0) %>" selected><%= PageGroupOrder(CatCounter,0) %></option>
		<%	PGCounter = 0 
				While PGCounter < (FinalCatCounter +1) 
				PGCounter = PGCounter +1 
				if PGCounter =  PageGroupOrder(CatCounter,0) then
				else %>
                <option  value="<%= PGCounter %>"><%= PGCounter %></option>
                <% 
                end if
                Wend %>
		</select>
			
			</td>
		<td class = "body2" align = "center" width = '120'> 
<% if PageGroupShow(CatCounter,0) = "Yes" Or PageGroupShow(CatCounter,0) = True Then %>
True<input TYPE="RADIO" name="PageGroupShow" Value = "Yes" checked>
False<input TYPE="RADIO" name="PageGroupShow" Value = "No" >
<% Else %>
True<input TYPE="RADIO" name="PageGroupShow" Value = "Yes" >
False<input TYPE="RADIO" name="PageGroupShow" Value = "No" checked>
<% End If %>
</td>
<td class = "body"> 			
<input name="PageGroupID" value ="<%=PageGroupID(CatCounter,0)%>"  type="hidden">
<input type=submit value = "submit"  class = "regsubmit2" >
</form>
</td>
</tr>
<% wend %>
</table>
	    </td>

	    <td bgcolor = "#abacab" width = "1"></td>
	   <td  width = "10"></td>
	    <td  valign = "top" class = "body">
	    
	    
<form action= 'AdminPageGroupAddHandleForm.asp' method = "post">
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" width = "100%">
		<tr>
		<td  class = "body" valign = "top" colspan = "2"><br />
		<h2>Add a New Page Group</H2>
        </td>
      </tr>
      <tr>
        <td bgcolor = "#abacab" height = "1" colspan = "2"></td>
        </tr>
				<tr>
						<td width = "200" class = "body" align = "right">
							<div align = "right">New Page Group:</div>
					</td>
					<td class = "body">
							<input type= text name="NewPageGroup" size = "30">
					</td>
			</tr>
			<tr>
					<td  align = "center" valign = "middle" colspan = "2" class = "body">
						<center><input type=submit value = "Add Page Group" size = "110" class = "regsubmit2" ></center>
					</td>
			</tr>
			</table>
			</form>
<% if FinalCatCounter > 7 then %>
			<b></b>
<form action= 'AdminPageGroupDeleteHandleForm.asp' method = "post">
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" width = "100%">
<tr>
<td  class = "body" valign = "top" colspan = "2">
<h2>Delete a Page Group</H2>
</td></tr>
<tr><td bgcolor = "#abacab" height = "1" colspan = "2"></td></tr>
<tr><td width = "140" class = "body" align = "right">
<div align = "right">Page Group:</div>
</td>
<td class = "body" >
<select size="1" name="PageGroupID">	
<option  value= "" selected>Select a Page Group</option>
<%	CatCounter = 0 
While CatCounter < (FinalCatCounter ) 
CatCounter = CatCounter +1 
if not(PageGroupID(CatCounter,0)= 7) and not(PageGroupID(CatCounter,0)= 12) and  not(PageGroupID(CatCounter,0)= 13) and not(PageGroupID(CatCounter,0)= 15) and not(PageGroupID(CatCounter,0)= 18) and not(PageGroupID(CatCounter,0)= 19) and not(PageGroupID(CatCounter,0)= 20) then %>
<option  value="<%= PageGroupID(CatCounter,0) %>"><%= PageGroupTitle(CatCounter,0) %></option>
<% end if
Wend %>
</select>
</td></tr>
<tr><td  align = "center" valign = "middle" colspan = "2">
<input type=submit value = "Delete a Page Group" size = "110" class = "regsubmit2" >
</td></tr></table>
</form>
</td></tr></table><br><br><br>
<% end if %>
</td></tr></table>
</td></tr></table>
<br>
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>