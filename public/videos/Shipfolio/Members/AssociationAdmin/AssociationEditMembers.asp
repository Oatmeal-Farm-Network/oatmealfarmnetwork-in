<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">

<!--#Include virtual="/members/MembersGlobalVariables.asp"-->



<SCRIPT LANGUAGE="JavaScript">
    function verify() {
        var themessage = "Please fill out the following fields: \r";
        if (document.form.PeopleFirstName.value == "") {
            themessage = themessage + " - Contact First Name \r";
        }

        if (document.form.PeoplelastName.value == "") {
            themessage = themessage + " - Contact Last Name \r";
        }


        if (document.form.PeopleEmail.value == "") {
            themessage = themessage + " - Contact Email \r";
        }

        if (document.form.ConfirmEmail.value == "") {
            themessage = themessage + " - Confirm Email \r";
        }

        if (document.form.PeopleEmail.value != document.form.ConfirmEmail.value) {
            themessage = themessage + " -Please check your email addresses; the confirmation entry does not match. \r";
        }

        if (document.form. associationmembersPassword.value == "") {
            themessage = themessage + " - Contact Password \r";
        }

        if (document.form. associationmembersPassword2.value == "") {
            themessage = themessage + " - Confirm Password \r";
        }

        if (document.form. associationmembersPassword.value != document.form. associationmembersPassword2.value) {
            themessage = themessage + " -Please check your Passwords; the confirmation entry does not match. \r";
        }


        //alert if fields are empty and cancel form submit
        if (themessage == "Please fill out the following fields: \r") {
            document.form.submit();
        }
        else {
            alert(themessage);
            return false;
        }
    }
    //  End -->
</script>
<style>
  /* override bootstrap styles */
 .grey {
  background-color: #dddddd;
}
  </style>

</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->

<div class="container roundedtopandbottom">
<div class="row" >
      <div class="col">


<H1>Edit Association User Accounts</H1>
<form action="AssociationAddMembers.asp" method="post">
    <button type="submit" class="regsubmit2">Add</button>
</form>


  <% DeletedUser = Request.querystring("DeletedUser")
     if DeletedUser = "True" then%>     
        <b>The user has been removed.</b><br /><br />
<%   end if %>

</div>
</div>





<%
if cint(session(AccessLevel)) > 1 then
sql = "select associations.*, People.*, associationmembers.MemberPosition from  associations,  associationmembers, People where associationmembers.AssociationID =  associations.AssociationID and associationmembers.PeopleID =  People.PeopleID  and associationmembers.AssociationID="  & session("AssociationID") 
else
sql = "select associations.*, People.*, associationmembers.MemberPosition from  associations,  associationmembers, People where associationmembers.AssociationID =  associations.AssociationID and associationmembers.PeopleID =  People.PeopleID  and associationmembers.AssociationID="  & session("AssociationID") 
end if
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1
dim PeopleIDArray(800)
dim PeopleFirstNameArray(800)
dim PeoplelastNameArray(800)
dim PeopleEmailArray(800)
dim PositionArray(800)
dim AccessLevelArray(800)

Recordcount = rs.RecordCount +1
%>


<% showaccesslevel = True
order = "odd"	
recordcount = 0
if not rs.eof then %>

  <% if CurrentMemberAccessLevel = 3 then %>
	 <H2>Edit an Existing Entry</H2>
  <% else %>
  <% end if %>


  <div class="row grey" >
      <div class="col-3" align = center>
      <b>Name</b>
    </div>
   <div class="col-2 d-none d-lg-block" align = center>
     <b>Position</b>
    </div>
      <div class="col-3 d-none d-lg-block" align = center>
     <b>Email</b>
    </div>
     <div class="col-3"  align = center>
      <b>Access Level</b>
    </div>
    <div class="col-1 grey"  align = center>
      <b></b>
    </div>
 </div>

<% else %>
<div>
	<div align = "center" class = "body" >
		Currently, your organization's account has no members associated with it. To add users select the <a href="AddMembers.asp" class = "body">Add Users</a> tab.
	</div>
</div>

<% end if %>
<form action= 'Membershandleform.asp' method = "post">
<% While  Not rs.eof  
 recordcount = recordcount + 1       
PeopleIDArray(rowcount) = rs("PeopleID")
PeopleFirstNameArray(rowcount) = rs("PeopleFirstName")
PeoplelastNameArray(rowcount) = rs("PeoplelastName")
PeopleEmailArray(rowcount) = rs("PeopleEmail")
PositionArray(rowcount) = rs("MemberPosition")
AccessLevelArray(rowcount) = rs("AccessLevel")
if AccessLevelArray(rowcount) = 1 then
   Accessleveltitle = "Basic User"
else
   Accessleveltitle = "Administrator"
end if


'response.write("AccessLevelArray(rowcount)=" & AccessLevelArray(rowcount) )
if order = "even" then
    order = "odd" %>
 <div class="row" bgcolor="#abacab">  
<% else
	order = "even" %>
  <div class="row">  
<% end if %>



    <div class="col-3">
      <a href = "AssociationMembersEditUser.asp?UserID=<%= PeopleIDArray(rowcount) %>" class = "body"> <%= PeopleFirstNameArray(rowcount)%> , <%= PeoplelastNameArray(rowcount)%></a>
    </div>
    <div class="col-2 d-none d-lg-block ">
     <%=PositionArray(rowcount)%>
    </div>
     <div class="col-3 d-none d-lg-block ">
     <%= PeopleEmailArray(rowcount)%>
    </div>
     <div class="col-3" >
      <%=Accessleveltitle%>
    </div>
    <div class="col-1 text-nowrap" style="Max-width: 100px" align ="right">
    <a href = "AssociationMembersEditUser.asp?UserID=<%= PeopleIDArray(rowcount) %>" class = "body">&nbsp;&nbsp;<img src= "https://www.globallivestocksolutions.com/images/edit.svg" alt = "edit" height ="18" border = "0"></a>
    |&nbsp;<a href = "DeleteMemberStep1.asp?CurrentPeopleID=<%=PeopleIDArray(rowcount)%>" class = "body"><img src= "https://www.globallivestocksolutions.com/images/delete.svg" alt = "edit" height ="18" border = "0"></a><br>
    </div>
 </div><br />
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	
%><br />

</div>
<br /><br /><br /><br />
<!--#Include virtual ="/Members/MembersFooter.asp"--> 

</Body>
</HTML>