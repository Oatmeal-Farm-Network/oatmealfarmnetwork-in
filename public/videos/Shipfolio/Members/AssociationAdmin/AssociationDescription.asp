<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<% MemberAccessLevel= Session("MemberAccessLevel")
AssociationID = Session("AssociationID")
PeopleID = Session("PeopleID")

HSpacer = "<div class = row ><div class=col-12 body style=min-height:20px></div></div>" 
      
 Set rs = Server.CreateObject("ADODB.Recordset")   

Query= " Select distinct Associations.* "
Query= Query & " from Associations, associationMembers "
Query= Query & " where Associations.AssociationID = associationMembers.AssociationID and Associations.AssociationID = " & AssociationID

rs.Open Query, conn, 3, 3


if not rs.eof then
    AssociationID = rs("AssociationID")
    AssociationName = rs("AssociationName")
    AssociationAcronym = rs("AssociationAcronym")
   
    AssociationDescription= rs("AssociationDescription")

    country_id= rs("country_id")
  
 end if
      
%>


</head>
<body >

<% Current3 = "Description" %> 
<!--#Include virtual="/members/AssociationAdmin/AssociationMembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->


<div class="container roundedtopandbottom">
    <div class="row" style="vertical-align: top">
      <div class="col"align ="center" style="align-content:center">
        <iframe src="AssociationDescriptionInclude.asp?AssociationID=<%=AssociationID %>" width="560" height="680px" scrolling="no" border="1" style="align-content:center"></iframe>
      </div>
    </div>
  </div>
<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body>
</html>