<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Livestock of America Referral Program</title>
<meta name="Title" content="Livestock of America Referral Program"/>
<meta name="robots" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>


<SCRIPT LANGUAGE="JavaScript">
    function verify() {
        var themessage = "Please fill out the following fields: \r";
        if (document.form.FirstName.value == "") {
            themessage = themessage + " - First Name \r";
        }

        if (document.form.LastName.value == "") {
            themessage = themessage + " - Last Name \r";
        }


        if (document.form.Fieldname2.value == "") {
            themessage = themessage + " - Email Address \r";
        }

        //alert if fields are empty and cancel form submit
        if (themessage == "Please fill out the following fields: \r") {
            document.form.submit();
        }
        else {
            alert(themessage);
            return false;
        }
    }
    //  End -->
</script>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="MembersGlobalVariables.asp"-->
<% Current2 = "Referral Program"  %> 
<!--#Include file="MembersHeader.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" class = "roundedtopandbottom" ><tr><td align = "left" class = "body">
<h1>Referral Program</h1>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" class = "roundedtopandbottom" ><tr><td align = "left" class = "body">
Refer friends to Livestock Of America and both you and your friend will earn two extra months on your memberships and <b>you will earn cash!</b> Every time that you refer a friend to Livestock of America and they sign up for a paid membership or website we will send you money, based upon what they sign up for. We feel it’s the least we can do to say thank you for helping spread the word about the fastest growing livestock marketplace on the web!<br />
<br />
Every time that someone that you refer signs up we will credit both of your accounts an extra two months of membership for free, and at the end of each month we will send you <b>cold hard cash!</b> Well, actually it will be sent by check or Paypal, but you get the idea.<br/><br />
<table class = "roundedtopandbottom" align = "center">
<tr><td class="body2" align = "center" width=  "180"><b>Membership<br />Level</b></td>
<td class="body2" align = "center" width=  "180" valign = "top"><b>You Get</b></td></tr>
<tr><td class="body2" align = "center">Platinum</td>
<td class="body2" align = "center">$10.00</td></tr>
<tr><td class="body2" align = "center">Ruby</td>
<td class="body2" align = "center">$20.00</td></tr>
<tr><td class="body2" align = "center">Emerald</td>
<td class="body2" align = "center">$30.00</td></tr>
<tr><td class="body2" align = "center">Diamond</td>
<td class="body2" align = "center">$40.00</td></tr></table>
<br />
<b>The Small Print</b><br>
<small>This offer is not valid outside of the United States of America and Canada. Payments will be paid via paypal or check. Offer only available to people with Livestock Of America memberships. Livestock Of America reserves the right to terminate and/or modify this offer at any time without prior notice.</small><br /><br />
</td></tr></table><br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" class = "roundedtopandbottom" ><tr><td align = "left" class = "body">

<h2>Refer a Friend & Send Them an Email</h2>

To refer a friend to join Livestock Of America please fill out the form below to send them an email:
<form  name="form" method="post" action="ReferaFriendSendEmail.asp">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "650" align = "center"><tr><td colspan = "2" align="center" w class = "body2" > 
( &quot;*&quot; indicates required field)</i><br>
</td></tr>
<tr><td width="300" height="20" class = "body2" align = "right">Friends First Name:</td>
<td width="350" height="20" class = "body" align = "left"> 
<input name="FirstName" size = "40"/> * </td></tr>
<tr><td  height="20" class = "body2" align = "right">Friends Last Name:</td>
<td  height="20" class = "body" align = "left"> 
<input name="LastName" size = "40"/> * </td></tr>
<tr><td height="20" class = "body2" align = "right">Friends Email: </td>
 <td  height="20" class = "body" align = "left"> 
<INPUT TYPE="TEXT" NAME="Fieldname2" size="45"/>
</td></tr>
<tr><td  align = "center" colspan = "2">
	<input type="button" value="Submit" onclick="verify();" class = "regsubmit2"/>
</form>
</td></tr></table>

</td></tr></table>
<br>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" class = "roundedtopandbottom" ><tr><td align = "left" class = "body">
<h2>Referrals</h2>

<%    
 sql = "select  referrals.*, Businessname, People.PeopleFirstName, People.PeopleLastName from referrals, people, business where referrals.RefferingPeopleID = people.peopleID and people.businessid = business.businessId and peopleid=" & Session("PeopleID") & " order by ReferralPaymentDate"
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
if rs.eof then %>
So far no one has signed up and listed you as a referral.


<% else  
	rowcount = 1

Recordcount = rs.RecordCount +1
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
	<tr>
		<th class = "body2" width = "450" align = "center"><b>Ranch</b></th>
		<th class = "body2" width = "80" align = "center"><b>Payment Amount</b></th>
		<th  class = "body2" align = "center"><b>Payment Type</b></th>
<th  class = "body2" align = "center"><b>Payment Date</b></th>
<th  class = "body2" align = "center">&nbsp;</th>
	</tr>
	<tr>
	<td height = "3"></td></tr>
<% While  Not rs.eof         
  If row = "even" Then 
 row = "odd" %>
		<tr >
<% Else 
row = "even"%>
<tr bgcolor = "#e6e6e6">
<%	End If %>
<td class = "body2" valign = "top" align = "center" >
	<a href = "SiteMembersEditUser.asp?UserID=<%= rs("RefferingPeopleID")%>#BasicFacts" class = "body"><%= rs("BusinessName")%> -  (<%= rs("PeoplefirstName")%>&nbsp;<%= rs("PeoplelastName")%>)</a>
</td>
<td  class= "body2" align = "center">
<%=formatcurrency(rs("ReferralPaymentAmount"), 2)%>
</td>
<td  class= "body2" align = "center">
<%= rs("ReferralPaymentFormat")%>
</td>
<td  class= "body2" align = "center">
<%= rs("ReferralPaymentDate")%>
</td>
<td class = "body"><a href = "SiteMembersReferalpayments.asp?Delete=True&ReferralID=<%=rs("ReferralID")%>" class = "body">Delete</a></td></tr>
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
end if
	rs.close
  set rs=nothing
  set conn = nothing
%>
</td></tr></table>

</td></tr></table>

<!--#Include file="Footer.asp"-->
</body>
</html>