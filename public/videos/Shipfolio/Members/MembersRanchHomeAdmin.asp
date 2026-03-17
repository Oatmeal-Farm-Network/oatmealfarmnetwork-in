<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="MembersGlobalVariables.asp"-->
<% 
sql = "select * from People where PeopleID = " & PeopleID
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3   
 if not rs.eof then
Header = rs("Header")
logo = rs("Logo")
RanchHomeText = rs("RanchHomeText")
RanchHomeImage1= rs("RanchHomeImage1")
ScreenBackground=rs("ScreenBackground")
end if

AddDesign = False
  sql = "select * from RanchSiteDesign where PeopleID = " & PeopleID
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3   
 if rs.eof then
    AddDesign = true
 end if
 rs.close
    
if AddDesign = true then
    	Query =  "INSERT INTO RanchSiteDesign (PeopleID)" 
		Query =  Query & " Values (" &  PeopleID  & ")"
		Conn.Execute(Query) 

end if
 sql = "select * from RanchSiteDesign where PeopleID = " & PeopleID
 Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3   
 if not rs.eof then
PageBackgroundColor= rs("PageBackgroundColor")
MenuBackgroundColor= rs("MenuBackgroundColor")
end if
rs.close	

UPdateColors=request.QueryString("UPdateColors")

if UPdateColors="True" then
MenuBackgroundColor = request.form("MenuBackgroundColor")
PageBackgroundColor  = request.form("PageBackgroundColor")

Query =  " UPDATE RanchSiteDesign Set LayoutStyle = '" & LayoutStyle & "', "
Query =  Query & " MenuBackgroundColor = '" & MenuBackgroundColor & "' ,"
Query =  Query & " PageBackgroundColor = '" & PageBackgroundColor & "'  "
Query =  Query & " where PeopleID = " & PeopleID 
Conn.Execute(Query) 

end if
%>
</HEAD>
<body >

<% 
Current1="RanchPages"
Current2 = "RanchHomePage" %> 
<!--#Include file="MembersHeader.asp"-->
  <div class="container">
   <div class="row">
     <div class="col-sm-12">
       <H1>Ranch Home Page</H1><a name="Top"></a>
     </div>
   </div>
<%
'response.write(session("custid"))


show = False

If show = True Then %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" background = "images/RanchsiteTabs4.jpg" height = "31">
    <tr>
	   <td width = "170" align = "center">
	       <a href = "/administration/RanchQuestLayout.asp" class = "whitemenu">Ranch Quest Site</a>
		</td>
		<td width = "10">&nbsp;</td>
		<td width = "170" align = "center">
	       <a href = "/administration/RanchSiteLayout.asp" class = "whitemenu">RanchSite</a>
		</td>
		<td width = "10">&nbsp;</td>
		<td width = "170" align = "center">
	       <a href = "/administration/Alpacainthesynclayout.asp" class = "whitemenu">Alpacas in the Sync</a>
		</td>
		<td width = "10">&nbsp;</td>
		<td width = "170" align = "center">
	       <a href = "/administration/SitePages.asp" class = "whitemenu">Site Pages</a>
		</td>
		  <td width = "90">&nbsp;
	
		</td>
	</tr>
	<tr>
	  <td bgcolor = "#57628D" colspan = "8" class = "whitemenu">
		Your Website Pages | <a href = "SitePages.asp" class = "whitemenu">List of Pages</a>  | <a href = "RanchHomeMembers.asp" class = "whitemenu">About Us</a> 

	
	  </td>
	 </tr>
</table>
<% End If %>
		
        
        <!--#Include virtual="/Members/membersRanchHomeinclude.asp"--> 
	  </td>
	 </tr>
</table>
</div> <%'Container%>


<!-- #include file="membersFooter.asp" -->
 </Body>
</HTML>
