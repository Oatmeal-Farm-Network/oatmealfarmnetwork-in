<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

</head>
<body >

<% Current3 = "Delete" 
Session("AssociationID") = ""	%> 
<!--#Include virtual="/members/AssociationAdmin/AssociationMembersHeader.asp"-->

<div class ="container roundedtopandbottom">
	<div class ="row">
		<div class = "col body">
			<H2>Recycle Association Account</H2>
			<% 
			AssociationID= Request.QueryString("AssociationID") 
			If Len(AssociationID) < 1 then
			AssociationID= Request.Form("AssociationID") 
			End If 
			If Len(AssociationID) < 1 then
			AssociationID= Session("AssociationID") 
			End If 
	
			if len(AssociationID) > 0 then
			else
			response.redirect("SiteAdminDeleteAccount.asp")
			end if
			Query =  "Delete From Associations where AssociationID = " & AssociationID & "" 
			'response.write("Query=" & Query )
			Conn.Execute(Query) 
			Conn.close
			set Conn = Nothing
			'response.Redirect("SiteAdminDeleteAccount.asp")
			%>

			<img src="DeleteAssociationAccount.jpeg" width ="220" align ="left" style="margin:10px" />	
			<br /><br />
			<b>Your association account has been tossed.</b><br />
			<a href="/members/default.asp" class ="body">Return to your Dashboard</a>

		</div></div></div>

	<!--#Include virtual="/Members/AssociationAdmin/AssociationFooter.asp"--> 
 </Body>
</HTML>
