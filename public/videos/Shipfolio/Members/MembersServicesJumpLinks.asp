
<%
ServicesID=request.form("ServicesID") 
If len(ServicesID) > 0 then
Else
ServicesID= Request.QueryString("ServicesID") 
End if 

If len(ServicesID) > 0 then
    ServiceID = ServicesID
else
    ServiceID=request.form("ServiceID") 
If len(ServiceID) > 0 then
Else
ServiceID= Request.QueryString("ServiceID") 
End if 

end if


if len(ServicesID) > 0 then
    
    sql = "select * from Services where ServicesID = " & ServicesID & ";" 
    'response.write("sql=" & sql )
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
    if not rs.eof then
        ServiceTitle = rs("ServiceTitle")
    end if
end if

%>
<a href = "#Top" class = "body"></a><br />
<div class="nav">

<div >
    <a class="jumplinks" href="MembersservicesHome.asp?ServicesID=<%=SeervicesID %>#top"><img src= "https://www.GlobalLivestockSolutions.com/icons/Services.svg" alt = "edit" height ="64" border = "0"></a>
</div>




<% if Current3 = "Summary" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="MembersservicesHome.asp?ServicesID=<%=SeervicesID %>"><b>List</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="MembersservicesHome.asp?ServicesID=<%=SeervicesID %>">List</a>
  </div>
<%end if %>



<% if not hidelinks = True then %>
<% if Current3 = "Add" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="membersServicesAddPage0.asp"><b>Add</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="membersServicesAddPage0.asp">Add</a>
  </div>
<%end if %>





 <% if len(ServiceID) > 1 then %>

 <% if Current3 = "Edit" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="MembersServicesEdit2.asp?ServicesID=<%=ServicesID %>"><b>Edit</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="MembersServicesEdit2.asp?ServicesID=<%=ServicesID %>">Edit</a>
  </div>
<%end if %>

<% if Current3 = "Photos" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="MembersServicesUploadPhotos.asp?ServicesID=<%=ServicesID %>"><b>Photos</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="MembersServicesUploadPhotos.asp?ServicesID=<%=ServicesID %>">Photos</a>
  </div>
<%end if %>

<% end if %>




<% end if %>

<% if Current3 = "Delete" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="membersServiceDeleteStep2.asp?ServicesID=<%=ServicesID %>"><b>Delete</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="membersServiceDeleteStep2.asp?ServicesID=<%=ServicesID %>">Delete</a>
  </div>
<%end if %>


    <% if Current3 = "Suggest" then %>
 <div class="jumplinkscellCurrent" style="min-width:118px; vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="MembersServicesSuggestCategory.asp?ServicesID=<%=ServicesID %>"><b>Suggest Category</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="min-width:118px; vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="MembersServicesSuggestCategory.asp?ServicesID=<%=ServicesID %>">Suggest Category</a>
  </div>
<%end if %>


</div>

<span class="border-bottom-3"></span>

<table width = "100%" class="body" ><tr><td class = "body"><h1><% =ServiceTitle %></h1></td></tr></table>
<span class="border-bottom-3"></span>

