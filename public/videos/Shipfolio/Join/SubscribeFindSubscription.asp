<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Join Livestock Of America</title>
<META name="description" content="Join Livestock Of America. Livestock Of America is an online marketplace for horses, cattle, dogs, donkeys, goats, chickens, turkeys, rabbits, llamas, alpacas, pigs, and sheep.">
<meta name="author" content="Livestock of America">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include Virtual="/GlobalVariables.asp"-->
<%
dispresults="No"
CQAccount=request("CQAccount")
CQPhone=request("CQPhone")
CQEmail=request("CQEmail")
CQLName=request("CQLName")
dispresults=request("dispresults")
Membership =request("Membership")
%>
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% Current = "WebDesign" %>
<!--#Include virtual="/Header.asp"--> 
<% Current2 = "Testimonials" 
Current3="Join"%>
<!--#Include virtual="/AGHeader.asp"--> 
<TABLE width="<%=screenwidth %>" border="0" cellspacing="5" cellpadding="5" align="center" class = "roundedtopandbottom">
<tr><td class = "body" valign = "top">
<h1>Look Up Your Subscription</h1>
<TABLE width="700" border="0" cellspacing="5" cellpadding="5" align="center">
<% peopleid = request.querystring("peopleid")
        If len(PeopleID) > 0 then
        dispresults = "Yes"
        end if
        
         if NOT dispresults = "Yes" then %>
			<FORM action="/Join/SubscribeFindSubscription.asp?Membership=<%=Membership %>" method="Post" >
				<tr>
					<td colspan="2" align="center" class= "body">
					Search for your account by one of the following:
<% showaccount = false
if showaccount = True then %>
				<tr>
					<td align="right" class= "body2">
					CQ Account ID:
					</td>
                    <td align="center" class= "body">
					<input type="text" name="CQAccount" class= "body">
					</td>
				</tr>
<% end if %>
                <tr>
					<td align="right" class= "body2">
					Phone:
					</td>
                    <td align="center" class= "body">
					<input type="text" name="CQPhone" class= "body">
					</td>
				</tr>
                <tr>
					<td align="right" class= "body2">
					Email:
					</td>
                    <td align="center" class= "body">
					<input type="text" name="CQEmail" class= "body">
					</td>
				</tr>
				<tr>
					<td align="right" class= "body2">
					Last Name:
					</td>
                    <td align="center" class= "body">
					<input type="text" name="CQLName" class= "body">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
					<input type="hidden" name="dispresults" value="Yes">
					<input type="submit" value="Find Your Account Information" class = "regsubmit2">
					</td>
				</tr>
			</form>
<% end if 

SQL="SELECT * FROM People, Business WHERE People.businessid= Business.Businessid and  peopleid=0"

 if dispresults="Yes" then
			if LEN(CQAccount) > 0 then
			SQL="SELECT * FROM People, Business WHERE People.businessid= Business.Businessid and  CQID="&INT(CQAccount)
			end if
			if LEN(CQPhone) > 0 then
			SQL="SELECT * FROM People, Business WHERE People.businessid= Business.Businessid and instr(lcase(peoplephone), '" & StripFromPhone(CQPhone) & "')"
			end if
			if LEN(CQEmail) > 0 then
			SQL="SELECT * FROM People, Business WHERE People.businessid= Business.Businessid and trim(lcase(peopleEmail))='" & trim(lcase(CQEmail)) & "'"
			end if
			if LEN(CQLName) > 0 then
			SQL="SELECT * FROM People, Business WHERE People.businessid= Business.Businessid and instr(lcase(peoplelastname), '" & CQLName & "')  ORDER BY PeopleLastName, PeopleFirstName"
			end if
            
            if len(Peopleid) > 0 then
            SQL="SELECT * FROM People, Business WHERE People.businessid= Business.Businessid and  peopleid="&INT(PeopleID)
            end if

'response.write("SQL=" & SQL )
rs.Open SQL, conn, 3, 3 
IF rs.eof then
%>
<tr><td colspan="2" align="center" >
	<br>The information you entered cannot be found in our records. Please try again.<br><br>
	If you have tried several methods, it is likely you do not have a current account. <br>If you believe this to be in error please <a href ="/contactus.asp" class = "body">Contact us</a>. 
		<br><br>
</td></tr>
<% else 
     PeopleId = rs("PeopleId")
     CQHardcopy = rs("CQHardcopy")
     CQOnline = rs("CQOnline")
      LOASubscriptionLevel = rs("SubscriptionLevel")
%>
<TR><TD valign="top" align="left" xpos="0">
	<TABLE border="0" cellpadding="0" cellspacing="2" width="100%">
	<%DO UNTIL rs.eof
        peopleID = rs("peopleID")
  %>
		<TR><TD align="right" width="100" >
			Owner:
		</TD>
		<TD align="left" >
		<%=rs("PeopleFirstName")%>&nbsp;<%=rs("PeopleLastName")%>
		</td>
		<TD align="left" >
		<%=rs("BusinessName")%>
</td></tr>
<tr><td align="center" nowrap class = "body2" colspan = "3">
<% 
'response.write("PeopleID=" & peopleid)
CQEndDate = rs("CQEndDate") 
'response.write("CQEndDate=" & CQEndDate)
str1 = CQEndDate 
str2 = "00"
If InStr(str1,str2) > 0 Then
CQEndDate = Replace(str1, str2 , "")
End If 

if len(CQEndDate) > 4 then 
'difference =  DateDiff("d",now, CQEndDate)
%>
Expiration Date:  <%=LEFT(MonthName(Month(CQEndDate)),3)%>&nbsp;<%=Day(CQEndDate)%>, <%=Year(CQEndDate)%>
<% else 
expired = true%>
Status: Not Active
<% end if %>
</td>
</TR>
<tr>
<td colspan="3" align="center" >
<table border = 0 cellpadding = 2 width = 400 align = 'center'>
<tr><td class = "body">
</td>
<td class = "body">

</td>
<td>
<form action="/setupaccount.asp?Membership=<%=Membership %>&peopleid=<%=peopleID %>&Renew=True" method="Post">
		<input type="hidden" name="dispresults" value="No">
		<input type="submit" value="Renew" class = "regsubmit2">
        </form>
</td>
</tr>
</table>
	</td>
</tr>
</td></tr>
<%rs.movenext
	LOOP%>
</table>
</td></tr>
<% 	end if %>
<form action="/SubscribeFindSubscription.asp?Membership=<%=membership %>&Renew=True" method="Post">
<tr>
	<td colspan="2" align="center" >
		<input type="hidden" name="dispresults" value="No">
		<input type="submit" value="Return to Account Search" class = "regsubmit2">
	</td>
</tr>
</form>
<% end if %>
</table>
</td></tr></table>
<%
FUNCTION FormatPhone(x)

Select Case LEN(x)
	Case 5
		x= LEFT(x,1)&"-"&Right(x,4)	
	Case 6
		x= LEFT(x,2)&"-"&Right(x,4)	
	Case 7
		x= LEFT(x,3)&"-"&Right(x,4)	
	Case 8
		x= LEFT(x,1)&"-"&MID(x,2,3)&"-"&Right(x,4)	
	Case 9
		x= LEFT(x,2)&"-"&MID(x,3,3)&"-"&Right(x,4)	
	Case 10
		x= LEFT(x,3)&"-"&MID(x,4,3)&"-"&Right(x,4)	
	Case 11
		x= LEFT(x,1)&"-"&MID(x,2,3)&"-"&MID(x,5,3)&"-"&Right(x,4)	
	Case 12
		x= LEFT(x,2)&"-"&MID(x,3,3)&"-"&MID(x,6,3)&"-"&Right(x,4)	
	Case 13
		x= LEFT(x,3)&"-"&MID(x,4,3)&"-"&MID(x,7,3)&"-"&Right(x,4)	
	Case 14
		x= LEFT(x,4)&"-"&MID(x,5,3)&"-"&MID(x,8,3)&"-"&Right(x,4)	
	 Case Else
		x=x
END SELECT
FormatPhone=x
END FUNCTION

Function StripFromPhone(x)
If LEN(x) > 0 then
x= replace(x,"-","")
x= replace(x,".","")
x= replace(x," ","")
x= replace(x,"(","")
x= replace(x,")","")
x= replace(x,"#","")
end if
StripFromPhone=x
END Function
Current = "Subscribe" %>
</td></tr></table>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>