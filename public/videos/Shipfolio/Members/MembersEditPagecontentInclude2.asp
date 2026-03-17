 <% current = "AnimalFacts" %>
 <!--#Include file="MembersAnimalsTabsInclude.asp"-->
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width= "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit Information for <%=name %></div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "920" align = "center">
	<tr>
	  <td >	<a name="Add"></a>
<%
JustAdded= request.querystring("JustAdded")
if JustAdded =true then %>
  <b><Font color = "brown">Animal Added! Now take a moment to review your information below, or <a href = "MembersPhotos.asp?ID=<%=ID %>" class = "body">add photos</a>. Note, that your animal will not show up until you select the publish button below.</Font></b>
<% end if %>
<center><iframe src="/Membersistration/AnimalPublishFrame.asp?ID=<%=ID%>" frameborder =0 width = "800" height = "190" scrolling = "no" bgcolor ="white" align = "center"></iframe></center>
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  height = "300" width = "900">
<tr>
 <td class = "body" valign = "top" align = "right" width = "900">
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Membersistration/MembersGeneralStatsInclude.asp"-->
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Conn.asp"-->
<!--#Include virtual="/Membersistration/MembersPricingInclude.asp"-->
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Membersistration/MembersDescriptionInclude.asp"-->
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Membersistration/MembersAwardsInclude.asp"-->
<% if speciesID = 2 then %>
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Membersistration/MembersFiberInclude.asp"-->
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Membersistration/MembersAlpacaEPDInclude.asp"-->
<% end if %>
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Membersistration/MembersAncestryInclude.asp"--> 
<br><br>
</TD></TR></TABLE>	
</TD></TR></TABLE>	
</TD></TR></TABLE>	