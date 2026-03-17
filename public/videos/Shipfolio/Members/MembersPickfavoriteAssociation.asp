<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<!--#Include file="MembersGlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> Online Animal Marketplace</title>
<meta name="Title" content="Create Account - <%=WebSiteName %> Online Animal Marketplace">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="Livestock Of The World">


</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>


<% 
FavoriteassociationID = request.form("FavoriteassociationID")
peopleid = request.querystring("peopleid")

if FavoriteassociationID = 0 then

if len(peopleid) > 0   then 

Query =  "Update Associationmembers set favorite = 0 where PeopleID = " & peopleid & " and associationid = " & FavoriteassociationID & " "

Conn.Execute(Query)  

Query =  "Update People set FavoriteAssocitaionID = " & FavoriteassociationID & " where PeopleID = " & peopleid 
response.write("Query=" & Query )

Conn.Execute(Query)  

end if


else
if len(FavoriteassociationID) > 0 and len(peopleid) > 0   then 

Query =  "Update Associationmembers set favorite = 1 where PeopleID = " & peopleid & " and associationid = " & FavoriteassociationID & " "

Conn.Execute(Query)  

Query =  "Update People set FavoriteAssocitaionID = " & FavoriteassociationID & " where PeopleID = " & peopleid 
response.write("Query=" & Query )

Conn.Execute(Query)  

end if
end if
 
response.redirect("MembersAssociations.asp?PeopleID=" & peopleid & "&changesmade=true" )  %>


</body>
</html>
