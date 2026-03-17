<!DOCTYPE HTML>

<HTML>
<HEAD>
<!--#Include File="membersGlobalVariables.asp"--> 

<% ServicesID = request.querystring("ServicesID")
if len(ServicesID) > 0 then
else
ServicesID = request.form("ServicesID")
end if	 %>

</head>
<body >

<% Current1="Services"
Current2 = "DeleteService"%> 
<!--#Include file="membersHeader.asp"--> 
<% Current3 = "Delete"  %>
<!--#Include File="MembersServicesJumpLinks.asp"--> 
<div class = "container roundedtopandbottom" align = "center">
<div>
	<div >
<h2>Delete Service</h2>
<center>Are you sure that you want to delete this service?<br />
But careful. Once a service is deleted, it's gone!<br><br></center>

<% 			

if len(ServicesID) > 0 then
else
response.redirect("membersServiceDelete.asp")
end if	
	
Set rst = Server.CreateObject("ADODB.Recordset")						
Set rsA = Server.CreateObject("ADODB.Recordset")

sql = "select * from Services where ServicesID=" & ServicesID

'response.write("sql=" & sql)


rsA.Open sql, conn, 3, 3 
if not rsA.eof then
ServicecategoryID=rsA("ServiceCategoryID")
ServiceSubcategoryID=rsA("ServiceSubCategoryID")
ServiceTitle = rsA("ServiceTitle")
ServicesDescription= rsA("ServicesDescription")
ServicePrice= rsA("ServicePrice")
'ServiceShowPrice= rsA("ServiceShowPrice")
ServiceAvailable = rsA("ServiceAvailable")
Photo1 = rsA("Photo1")
Photo2 = rsA("Photo2")
Photo3 = rsA("Photo3")
Photo4 = rsA("Photo4")
Photo5 = rsA("Photo5")
Photo6 = rsA("Photo6")
Photo7 = rsA("Photo7")
Photo8 = rsA("Photo8")

PhotoCaption1 = rsA("PhotoCaption1")
PhotoCaption2 = rsA("PhotoCaption2")
PhotoCaption3 = rsA("PhotoCaption3")
PhotoCaption4 = rsA("PhotoCaption4")
PhotoCaption5 = rsA("PhotoCaption5")
PhotoCaption6 = rsA("PhotoCaption6")
PhotoCaption7 = rsA("PhotoCaption7")
PhotoCaption8 = rsA("PhotoCaption8")


end if
rsA.close

Set rsg = Server.CreateObject("ADODB.Recordset")
if len(ServicecategoryID)> 0 then
sqlg = "select * from servicescategories where ServiceCategoryID = " & ServicecategoryID

rsg.Open sqlg, conn, 3, 3 
if not rsg.eof then
ServicesCategory= rsg("ServicesCategory")
end if
rsg.close 
end if 


'response.write("ServicesubcategoryID=" & ServicesubcategoryID )
 if len(ServicesubcategoryID)> 0 then
sqlg = "select * from servicessubcategories where ServicesSubcategoryID = " & ServicesubcategoryID
'response.write("sqlg=" & sqlg )
rsg.Open sqlg, conn, 3, 3 
if not rsg.eof then
ServiceSubCategoryName	= rsg("ServiceSubCategoryName")
end if
rsg.close 
end if 
%>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" >

<form name="myform" method="post" action= 'MembersServiceDeleteHandleForm.asp?ServicesID=<%=ServicesID %>' >
<input name="ServicesID" value="<%=ServicesID %>" type = "hidden">

<tr><td align = "center" height = "100" valign = "top" width = "100%" >     
 <table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=3 cellspacing=5 align = "center">
   
  <tr>
	<td class = "body" valign = top width = "200"><div align = "right">
Service Title:
	</td>
		<td class ="body" align = "left" >
			<%=ServiceTitle %>
		</td>
	</tr>
<tr><td  class = "body" valign = top ><div align = "right">
			Category:
		</td>
		<td  align = "left" class = "body">
		<%=ServicesCategory %>
</td>
</tr>
<tr><td  class = "body" valign = top ><div align = "right">
Sub-Category:			
		</td>
		<td  align = "left" class = "body">
<%=ServiceSubCategoryName %>
</td>
</tr>
<tr><td  class = "body" valign = top ><div align = "right">
            Price / Rate:
		</td>
		<td class ="body" align = "left">
		<%=ServicePrice%>
</td></tr>
<tr><td  class = "body" valign = top ><div align = "right">
	        Services Description:
		</td>
		<td class ="body" align = "left">
		<%=ServicesDescription%>
</td></tr>

<tr>
	<td colspan = "2" align = "center">
		<input type=submit value = "Delete"  class = "submitbutton"  <%=Disablebutton %> ><br /><br />
	</td>
 </tr>
</table>
		  </form>
  </td>
</tr>
</table>


	</div>
	</div>
	</div>

<br /> <br><br>
<!--#Include file="membersFooter.asp"--> </Body>
</HTML>