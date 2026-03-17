<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Add Members</title>
       <link rel="stylesheet" type="text/css" href="/Membersistration/style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include file="MembersGlobalvariables.asp"--> 

<%
AssociationID= Request.QueryString("AssociationID")
If Len(AssociationID) < 1 then
AssociationID= Request.Form("AssociationID") 
End If

Message = request.Form("Message") 
AssociationMemberID= request.Form("AssociationMemberID")
MemberFirstName= request.Form("MemberFirstName")
MemberLastName= request.Form("MemberLastName")
MemberEmail= request.Form("MemberEmail")
MemberPosition= request.Form("MemberPosition")
MemberAccessLevel= request.Form("MemberAccessLevel")
MemberPassword = request.Form("MemberPassword")
custPasswd2=Request.Form("pw2")
MemberEmail2=Request.Form("email2")



'response.write("MemberFirstName=" & MemberFirstName)
'response.write("CustLastName=" & CustLastName)
'response.write("MemberEmail=" & MemberEmail)

Proceed="False"
if len(MemberFirstName) < 1 then
  Message= Message & "&FirstnameEmpt=true"
end if 


if len(CustLastName) < 1 then
  Message=Message & "<br>Please enter a last name."
end if 


if len(MemberEmail) < 6 then
  Message=Message & "<br>Please enter a valid email address."
end if 

if MemberEmail = MemberEmail2  then
else
   Message= Message &  "<br>The <b>email addresses</b> that you entered do not match."
  MemberEmail=""
end if

if len(MemberPassword) > 6 then
  Proceed = "True"
else
  Proceed="False"
  Message= Message &  "<br>The password that you entered is not long enough."
end if 	

	

if len(MemberPassword) < 6 then
  Message=Message & "<br>Please enter a valid password."
end if 


if len(MemberPassword) > 6 and Proceed = "True" then
  Proceed = "True"
else
  Proceed="False"
end if 
'response.write("Proceed1=" & Proceed)


if custPasswd = custPasswd2 and Proceed = "True" then
  Proceed = "True"
else
  Proceed="False"
end if 

if MemberEmail = MemberEmail2 and Proceed = "True" then
  Proceed = "True"
else
  Proceed="False"
end if 

 

response.write("custPasswd=" & custPasswd)
response.write("custPasswd2=" & custPasswd2)

if MemberPassword = custPasswd2 then
else
   Message= Message &  "<br>The <b>passwords</b> that you entered do not match."
end if 


response.write("Proceed=" & Proceed)	

if Proceed="True" then



Query =  "INSERT INTO AssociationMembers (MemberFirstName, AssociationID, MemberAccessLevel, MemberLastName, MemberPassword, MemberPosition, MemberEmail)" 
	Query =  Query & " Values ('" &  MemberFirstName & "', "
    Query =  Query &  " " & session("associationID") & "," 
    Query =  Query &  " " & MemberAccessLevel & " ," 
    Query =  Query &  " '" & MemberLastName & "'," 
    Query =  Query &  " '" & MemberPassword & "'," 
    Query =  Query &  " '" & MemberPosition & "'," 
  	Query =  Query &  " '" & MemberEmail & "' )" 


response.write(Query)	


Conn.Execute(Query) 

 

End if

if Proceed = "False" then
  Response.redirect("addMembers.asp?associationid=" & AssociationID )
else
  Response.redirect("addMembers.asp?associationid=" & AssociationID )
end if
%>

</Body>
</HTML>
