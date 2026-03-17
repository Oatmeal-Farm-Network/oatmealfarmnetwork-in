<% 'Global Variables
Dim IDArray(999999)
Dim alpacaName(999999)
%>
<!--#Include virtual="/Conn.asp"-->
<%
AssociationID = session("AssociationID")
if Len(Session("AssociationID")) < 1 then
Session("AssociationID") = Request.Cookies("AssociationID")
AssociationID = session("AssociationID")
end if  %>
<!--#Include virtual="/associationadmin/associationSecurityInclude.asp"-->
<!--#Include virtual="/associationadmin/AssociationMobileWidthInclude.asp"-->
<%
AssociationID = session("AssociationID")
if Len(Session("AssociationID")) < 1 then
Session("AssociationID") = Request.Cookies("AssociationID")
AssociationID = session("AssociationID")
end if  
%>
<title>Association Administration</title>
<meta name="robots" content="nofollow"/>
<meta name="Googlebot" content="nofollow"/>
<% if screenwidth > 1000 then%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% else %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% end if %>