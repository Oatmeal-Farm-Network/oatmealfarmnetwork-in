<!DOCTYPE HTML>
<HTML>
<head>
<!--#Include File="membersGlobalVariables.asp"--> 
</head>
<body >
 <!--#Include File="MembersHeader.asp"--> 
 <% Current3 = "Summary" 
 Hidelinks = False %>
  <!--#Include File="MembersServicesJumpLinks.asp"--> 
<div class ="container roundedtopandbottom">
<h2>My Services</h2>

<%'Services **************************************** %>
     <%  sql = "select * from Services where BusinessID = " & session("BusinessID") & " order by ServiceTitle"
	   Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3  
        if rs.eof then %>
             <a href = "membersServicesAddPage0.asp" class = "body">Add a Service</a>.
        <% else    
            rowcount = 1
        %>
  <table width =" 100%">
      <tr>
         <td class ="text-left body">Service</td>
             <td class="text-left body d-none d-md-table-cell" align ="left">Available</td>
        <td class="text-left body d-none d-md-table-cell" align ="left">Price / Rate</td>
        <td class="body text-right" style="max-width:90px"><div align = right>Options&nbsp;&nbsp;&nbsp;&nbsp;</div></td>
      </tr>
     <tr >
	    <td colspan="4" style="background-color: #abacab; min-height: 1px"></td>
      </tr>
      <%	
	While Not rs.eof  
	  ServicesID = rs("ServicesID") 
      ServiceTitle = rs("ServiceTitle")
	  ServicesID = rs("ServicesID")
      ServicesPrice = rs("ServicePrice")
      ServiceAvailable = rs("ServiceAvailable")
%>
      <tr>
        <td><a href = "MembersServicesEdit2.asp?ServicesID=<%= ServicesID %>#BasicFacts" class = "body"><%=ServiceTitle%></a></td>
        <td><a href = "MembersServicesEdit2.asp?ServicesID=<%= ServicesID %>#BasicFacts" class = "body"><%=ServiceAvailable%></a></td>

        <td class="body d-none d-md-table-cell"><%=ServicesPrice %></td>
        <td class="text-right" style="min-width:110px"><div align = right> 
            <a href = "MembersServicesEdit2.asp?ServicesID=<%= ServicesID %>#BasicFacts" class = "body">&nbsp;&nbsp;<img src= "images/edit.svg" alt = "edit" height ="26" border = "0"></a>
		|&nbsp;<a href = "MembersServicesEdit2.asp?ServicesID=<%= ServicesID %>" class = "body"><img src = "images/Photos.svg" height = "26" border = "0" alt = "Upload Photos"></a>
        |&nbsp;<a href = "membersServiceDeleteStep2.asp?ServicesID=<%= ServicesID %>" class = "body"><img src= "images/Delete.svg" alt = "edit" height ="26" border = "0"></a></div>
        </td>
      </tr>
           <tr >
	    <td colspan="4" style="background-color: #dddddd; min-height: 1px"></td>
      </tr>
<%	rs.movenext
Wend		

end if
rs.close %>
</table>

</div>
  <!--#Include File="MembersFooter.asp"-->
</Body>
  </HTML>