<!doctype html>
<html>
<head>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

  </head>
<body >
<% Current1="Account"
Current2 = "Add User" %>
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->


<div class ="container roundedtopandbottom">
<H1>Delete a User Account</H1>
<%  
Set rs = Server.CreateObject("ADODB.Recordset")

CurrentPeopleID = request.form("CurrentPeopleID")
if len(CurrentPeopleID) > 0 then
else
CurrentPeopleID = request.querystring("CurrentPeopleID")
end if

    sql = "SELECT * FROM People where PeopleID = " & CurrentPeopleID 
    'response.write("slq=" & sql )
    acounter = 1
    rs.Open sql, conn, 3, 3 
    if  Not rs.eof then 
        AccessLevel = rs("AccessLevel")  
        Email = rs("PeopleEmail")
        FirstName = rs("PeopleFirstName")
        LastName = rs("PeoplelastName")
        Phone = rs("PeoplePhone")
        Password = rs("PeoplePassword")
        AddressID = rs("AddressID")
     rs.close
     end if
%>
<b>Are you sure that you want to delete this member account?
 Once it is deleted, it's gone!</b><br><br>
  <% if len(Photo1)> 4 then %>
    <img src = "<%=Photo1 %>" width = 160 align = center />
  <% end if %>

			
               

			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				 <td align = "left" class = body2 colspan ="2">Name: <%=FirstName%>&nbsp; <%=LastName%></td>
                </tr>
                    <tr>
				 <td align = "left" class = body2 colspan ="2">Email: <%=Email%></td>
                </tr>


                <td colspan = 1 align = right>
                    <br />
                   <form action= 'AssociationEditMembers.asp' method = "post">
				     <input type = "hidden" name="CurrentPeopleID" value= "<%=CurrentPeopleID %>">
					<input type=submit value = "Cancel"  class = "submitbutton" >
                  </form>
				</td>
				<td colspan = 1 align = left>
                      <br />
                   <form action= 'MembersDeletehandleform.asp' method = "post">
				     <input type = "hidden" name="CurrentPeopleID" value= "<%=CurrentPeopleID %>">
					&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit value = "Remove"  class = "submitbutton" >
                  </form>
				</td>

			  </tr>
		    </table>
 
<br />
	<br /><br />	  
</div>
    <br /><br /><br /><br /><br />


<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body>
</html>