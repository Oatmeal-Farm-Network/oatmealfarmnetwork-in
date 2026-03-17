<!DOCTYPE HTML >
<HTML>
<HEAD>
<title>Edit Users</title>
<!--#Include virtual="/includefiles/globalvariables.asp"-->


</HEAD>
<body >


<%


CurrentPeopleID=Request.Form("CurrentPeopleID" ) 

If Len(CurrentPeopleID)  > 0 then
	Query =  "Delete From associationmembers where AssociationID=" & Session("AssociationID") & " and PeopleID = " &  CurrentPeopleID & "" '
	response.write(Query)
	Conn.Execute(Query) 
end if
Set Conn = Nothing
 
 Response.redirect("AssociationEditMembers.asp?DeletedUser=True")
 %>
 

 </Body>
</HTML>
