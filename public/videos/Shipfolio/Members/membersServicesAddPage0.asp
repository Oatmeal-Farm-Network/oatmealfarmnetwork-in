<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="LOTW">
    <title>Livestock Of The World</title>
<!--#Include file="MembersGlobalVariables.asp"-->
<% 
Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if
%>
</head>
<body >

<!--#Include file="MembersHeader.asp"-->
 <% Current3 = "Add"  %>
  <!--#Include File="MembersServicesJumpLinks.asp"--> 
<% 
Session("Step2") = False 
%>

<div class ="container roundedtopandbottom">
    <div>
      <div>
        <H2>Add a Service<a name="Add"></a></H2>
<% 
MissingServiceTitle = request.querystring("MissingServiceTitle")
Missingcategory = request.querystring("Missingcategory")
ServiceCategoryID= request.querystring("ServiceCategoryID")
ServiceTitle = request.querystring("ServiceTitle")

if len(ServicecategoryID)> 0 then
sqlg = "select * from servicescategories where ServiceCategoryID = " & ServiceCategoryID
Set rsg = Server.CreateObject("ADODB.Recordset")
rsg.Open sqlg, conn, 3, 3 
if not rsg.eof then
ServicesCategory = rsg("ServicesCategory")
end if
rsg.close 
end if 

if PageAlreadyExists = "True" then %>
<table width = '100%' align = 'center'><tr><td align = "left" class = "body"><font color = "maroon"><b>ERROR: A service titled <% = ServiceTitle%> already exists.</font></b></td></tr></table>
<% end if %>

<% if len(MissingServiceTitle) > 0 or len(Missingcategory) > 0 then %>
<table width = '100%' align = 'center'><tr><td align = "left" class = "body"><font color = "maroon"><b>Missing Information<ul>
<%  if len(MissingServiceTitle) > 0 then %>
<li>Please enter a Service Title</li>
<% end if %>
<%  if len(Missingcategory) > 0 then %>
<li>Please enter a category.</li>
<% end if %>



</ul></font></b></td></tr></table>
<% end if %>

<form name="myform" method="post" action= 'membersServicesAddPage.asp' >
	
<div class ="container">
  <div class ="row">
	<div class ="col"><br />
		Title<br />
			<input name="ServiceTitle" value="<%=ServiceTitle %>" size = "50" class = "formbox" style="width:330px; height: 35px; text-align:left" required>
            <br />
		 <font color = "gray">Max. length of 20 charecters</font>
	</div>
  </div>

<%=HSpacer  %>


  <div>
    <div>
		Category&nbsp;<br />
		<select size="1" name="ServiceCategoryID" class = "formbox" style="width:350px; min-height:40px; text-align:left" required>
		<% if len(ServicesCategory) > 0 then %>
			<option value="<%=ServiceCategoryID %>"><%=ServicesCategory %></option>
		<% else %>
			<option value=""></option>
		<% end if %>	
		<% count = 1
		sqlg = "select * from Servicescategories order by ServicesCategory "
		acounter = 1
		Set rsg = Server.CreateObject("ADODB.Recordset")
		rsg.Open sqlg, conn, 3, 3 
		while not rsg.eof	%>
		<option name = "AID1" value="<%=rsg("ServiceCategoryID") %>">
			<%=rsg("ServicesCategory") %>
		</option>
		<% 	rsg.movenext
		wend %>
		</select>
	</div>
</div>
<div>
	<div align ="center"><br />
		<input type=submit value = "Next" class = "regsubmit2"  <%=Disablebutton %> >
	</div>
</div>
</div>	</form>


	
 <br><br>

	</div>
</div>
</div>



<br>
<!--#Include file="membersFooter.asp"--> </Body>
</HTML>