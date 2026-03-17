<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> Online Animal Marketplace</title>
<meta name="Title" content="Create Account - <%=WebSiteName %> Online Animal Marketplace">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="Global Grange inc.">
</head>
<body>
<% PeopleID = 4991
membership  = "Business"
	sql = "select * from Country where name = 'USA'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close



sql = "select distinct * from SubscriptionLevels where Region = 'USA' and SubscriptionTitle = '" & membership & "'"

rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
OrderTotal = rs("SubscriptionMonthlyRate") 
end if
rs.close
%>





<div align ="center">
<br /><br /><br /><br />

PeopleID = <%=PeopleID %> <br>
<%=membership %> Membership<br>
Order: <%=formatcurrency(OrderTotal)%> / Month<br>

<form action="" method="post" target = "_blank">

<input type="submit" class ="roundedtopandbottomyellow" value ="Pay Now" height = 130px border="0" name="Pay Now" >
</form>
</div>
</body>
</html>