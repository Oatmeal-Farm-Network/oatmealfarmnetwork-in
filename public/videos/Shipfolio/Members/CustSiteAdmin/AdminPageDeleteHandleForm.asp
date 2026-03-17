<!DOCTYPE HTML>
<HTML>
<HEAD>
<% 

Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if
%>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwGalleryIDth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
    

<% Current3 = "DeleteServices" %> 
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include virtual="/Members/CustSiteAdmin/AdminPagesTabsInclude.asp"-->
   	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete a Page</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "960"  height = "200" valign = "top" >   
<table height = "300" align = "center">
	<tr>
		<td class = "body" align = "center" valign = "top">
        <br><br><br>
<%

dim ServiceTitle

ServiceTitle=Request.Form("ServiceTitle" ) 
PageType=Request.Form("PageType" ) 
PageLayoutID=Request.Form("PageLayoutID") 


if PageType = "Service" then
Query =  "Delete * From Services where PagelayoutID = " &  PagelayoutID & "" 
Connn.Execute(Query) 
end if

if len(PageLayoutID) > 0 then
	Query =  "Delete * From PageLayout where PageLayoutID = " &  PageLayoutID & "" 
	Conne.Execute(Query) 

	Query =  "Delete * From PageLayout2 where PageLayoutID = " &  PageLayoutID & "" 
	Conn.Execute(Query) 
	
end if
 %>
<div align = "center"><H2>
<%
     response.write("The page has successfully been deleted.")
  %></H2>


			<br>
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
<br />
 <!--#Include virtual ="/Members/MembersFooter.asp"--> 

</Body>
</HTML>
