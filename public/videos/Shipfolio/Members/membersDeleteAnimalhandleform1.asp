<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<meta name="robots" content="nofollow"/>
<% ID = request.querystring("ID") %>
<!--#Include file="MembersGlobalVariables.asp"-->
</HEAD>
<body >
<% Current3 = "Delete"%> 
<!--#Include file="MembersHeader.asp"-->

<div class ="container roundedtopandbottom">
<H1>Delete an Animal Listing</H1>
<%  
Set rs2 = Server.CreateObject("ADODB.Recordset")

AnimalID = request.form("AnimalID")
if len(AnimalID) > 0 then
else
AnimalID = request.querystring("AnimalID")
end if


if len(AnimalID) > 0 then
ID= AnimalID
else
'response.redirect("Default.asp")
end if


sql2 = "select * from Animals where animalID= " & AnimalID 
'response.write("sql2=" & sql2)
acounter = 1
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then 
Fullname = rs2("FullName")
Category = rs2("Category")
Description = rs2("Description")
end if
rs2.close 

sql2 = "select * from Photos where animalID= " & AnimalID 
'response.write("sql2=" & sql2)
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then 
Photo1 = rs2("Photo1")
end if


%>
<b>Are you sure that you want to delete this Animal listing?
 Once it is deleted, it's gone!</b><br><br>
     <% if len(Photo1)> 4 then %>
    <img src = "<%=Photo1 %>" width = 160 align = center />
    <% end if %>

			
               

			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				 <td align = "left" class = body2 colspan ="2">Name: <%=FullName%></td>
                </tr>


                <% if len(Description) > 3 then%>
                 <tr>
				 <td align = "left" class = body2 colspan ="2">Description<br />
                 <%=Description%></b><br />
                </tr>
                <% end if %>
                <td colspan = 1 align = right>
                    <br />
                    <button type="button" onclick="history.back()" class="regsubmit2">
                      Cancel
                  </button>

				</td>
				<td colspan = 1 align = left>
                      <br />
                   <form action= 'MembersDeleteAlpacahandleform.asp' method = "post">
				     <input type = "hidden" name="animalID" value= "<%=animalID %>">
					&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit value = "Delete"  class = "regsubmit2" >
                  </form>
				</td>

			  </tr>
		    </table>
 
<br />
		  
</div>
<!--#Include file="membersFooter.asp"-->
</Body>
</HTML>