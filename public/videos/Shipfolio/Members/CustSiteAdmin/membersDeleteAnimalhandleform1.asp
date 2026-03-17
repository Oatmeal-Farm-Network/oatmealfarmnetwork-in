<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<meta name="robots" content="nofollow"/>
<% ID = request.querystring("ID") %>

</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&ID=<%=ID %>'  );" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<!--#Include file="adminGlobalVariables.asp"-->
<% Current1="Animals"
Current2 = "AnimalDelete"   %> 
<!--#Include file="AdminHeader.asp"--> 
<% Current3 = "DeleteAnimals"  %> 
<!--#Include file="AdminAnimalsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -32%>" class = "roundedtopandbottom">
<tr><td  align = "left">
<% conn.close
set conn = nothing %>
<!--#Include virtual="/ConnLOA.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -32%>" height = 300><tr><td class = "body" align = "left" valign = "top"><br />
<H1><div align = "left">Delete an Animal Listing</div></H1>
<%  
Set rs2 = Server.CreateObject("ADODB.Recordset")

ID = request.form("ID")
if len(ID) > 0 then
else
response.redirect("MembersdeleteAnimal.asp")
end if


sql2 = "select * from Animals, Photos where animals.ID= " & ID & " and animals.Id= photos.Id order by Fullname"
acounter = 1
rs2.Open sql2, connLOA, 3, 3 
if not rs2.eof then 
Fullname = rs2("FullName")
Category = rs2("Category")
Description = rs2("Description")
Photo1 = rs2("Photo1")
end if

%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top" >
<tr>
	<td class = "body2" valign = "top" align = "center" colspan = 2>
	<br /><b>Are you sure that you want to delete this Animal?
 Once a Animal listing is deleted, it's gone!</b><br><br>
	</td>
</tr>
<tr>
    <td>
     <% if len(Photo1)> 4 then %>
    <img src = "<%=Photo1 %>" width = 160 align = center />
    <% end if %>
    </td>
    <td class = body valign = top>		
			<form action= 'MembersDeleteAlpacahandleform.asp' method = "post">
				<input type = "hidden" name="ID" value= "<%=ID %>">
               

			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				 <td align = "right" class = body2 >Name:</td>
                 <td width = "10">&nbsp;</td>
                 <td class = body><b><%=FullName%></b></td>
                </tr>


                <% if len(Description) > 3 then%>
                 <tr>
				 <td align = "right" class = body2>Description:</td>
                 <td width = "10">&nbsp;</td>
                 <td  class = body><%=Description%></b></td>
                </tr>
                <% end if %>

				<td colspan = 3 align = center>
                <br />
					<input type=submit value = "Delete"  class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
   </td>
   </tr>
   </table>


		  </form>

		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
</Body>
</HTML>