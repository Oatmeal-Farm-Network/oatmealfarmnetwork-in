<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
Current1="CustSites"
Current2 = "CustomHome" %> 
<!--#Include file="MembersHeader.asp"-->

<!-- #include file="membersFooter.asp" -->
 </Body>
</HTML>
