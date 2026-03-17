<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<% if len(AssociationID) > 1 then
	response.redirect("AssociationdeleteAccountStep2.asp")
end if
	
dim AssociationIDArray(5000) 
dim AssociationNameArray(5000) 
dim AssociationAcronymArray(5000) 	


	%>

</head>
<body >

<% Current3 = "Dashboard" %> 
<!--#Include virtual="/members/AssociationAdmin/AssociationMembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->

<%  

sql2 = "select associationmembers.AssociationID,  AssociationName, AssociationAcronym from associations, associationmembers where accesslevel > 1 and associations.AssociationID = associationmembers.AssociationID and associationmembers.PeopleID = " & PeopleID

'sql2 = "select * from Associations order by AssociationName"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
if rs2.eof then
  Noaccount = True
else
 Noaccount = False
end if
While Not rs2.eof  
AssociationIDArray(acounter) = rs2("AssociationID")
AssociationNameArray(acounter) = rs2("AssociationName")
AssociationAcronymArray(acounter) = rs2("AssociationAcronym")
acounter = acounter +1
rs2.movenext
Wend %>

<div class ="container; roundedtopandbottom" >
	<div class ="col">
		<div class ="row" style="min-height:200px; vertical-align: top;" >
			<H2>Delete Association Account</H2>
<% if Noaccount = True then %>
<h2>Currently you are not listed as the admin with any association accounts.</h2>

<% else %>
	<form action= 'AssociationDeleteAccountStep2.asp' method = "post">
		Association Account:<br />
<div class ="container" align =" center">
	<div class ="row">
		<div class ="col-md-10" style="max-width:400px" >

		<select size="1" name="AssociationID">
		<% count = 0
		while count < acounter
		%>
		<option name = "AID1" value="<%=AssociationIDArray(count)%>">
		<%=AssociationNameArray(count)%> (<%=AssociationAcronymArray(count)%>)
		</option>
		<% count = count + 1
		wend %>
		</select>
	  </div>
	  <div class ="col-md-2"  style="max-width:130px">
		<input type=submit value = "Delete" class = "regsubmit2" >
	   </div>
	</div>
</div>
</form>

<% end if %>

			<br /><br /><br /><br /><br />
	</div>
</div>
	</div>
<!--#Include virtual="/Members/AssociationAdmin/AssociationFooter.asp"--> 
	
	</Body>
</HTML>