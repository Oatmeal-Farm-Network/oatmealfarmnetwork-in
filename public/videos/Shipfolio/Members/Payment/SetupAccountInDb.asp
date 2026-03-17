
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>



<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title><%=WebSiteName %></title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">

<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<% homepage = true %>


</head>
<body >
<% Current = "Home"
Current3="Register"
session("LoggedIn") = False%>
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include virtual="/members/MembersAccountJumpLinks.asp"-->

    <br />
     <div class = "container roundedtopandbottom" >
    <div>
      <div class = "body">
          <%
dim PeopleID1, membership, Membership_price, StripePriceKey, StripeCustomerID, StripeSubscriptionID

    PeopleID1   =request.form("FinalPeopleID")
    membership   =request.form ("Finalmembership")
    Membership_price   =request.form ("FinalMembership_price")
    StripePriceKey   =request.form ("FinalStripePriceKey")
    StripeCustomerID   =request.form ("FinalStripeCustomerID")
'response.write("<br>StripeCustomerID =" & StripeCustomerID )
    StripeSubscriptionID   =request.form ("FinalStripeSubscriptionID")
 'response.write("<br>StripeSubscriptionID=" & StripeSubscriptionID)

 CurrentSusbcriptionID = request.querystring("CurrentSusbcriptionID")
NewMembership= request.querystring("NewMembership")

   'response.write("CurrentSusbcriptionID=" & CurrentSusbcriptionID )

   'response.write("NewMembership=" & NewMembership )
          
        
         ErrorMessage = session("ErrorMessage")
         'response.write("ErrorMessage=" & ErrorMessage )
         If InStr(1, Session("ErrorMessage"), "Error", 1) > 0 Then
            ' The session variable contains the word "Error"
         '   Response.redirect("AddAccount.asp?Error=True&PeopleID=" & PeopleID1 & "&CurrentSusbcriptionID=" & CurrentSusbcriptionID & "&NewMembership=" & NewMembership & "&Membership_price=" & Membership_price & "&StripePriceKey=" & StripePriceKey & "&StripeCustomerID=" & StripeCustomerID & "&StripeSubscriptionID=" & StripeSubscriptionID & "&PeopleFirstName=" & PeopleFirstName & "&PeopleEmail=" & PeopleEmail & "&PeoplePhone=" & PeoplePhone & "&PeopleLastName=" & PeopleLastName)
        End If


        if len(PeopleID1)> 0 then
            sql = "Update People set Subscriptionlevel = " & Subscriptionlevel & " , accesslevel = 2, PeopleStripeCustomerID= '" & StripeCustomerID & "' , StripeSubscriptionID = '" & StripeSubscriptionID & "' where PeopleID = " & PeopleID1 & ""
            '  response.write("sql=" & sql)
           Conn.Execute(sql) 
           end if
             
             
             %>
            <h1>Order Completed</h1><br />
          <center>
          

               Congratulations! Your subscription has been successfully upgraded. You now have access to even more exciting features and benefits. 
               <br />   <br /> <br />   <br /> <br />   <br /> <br />   <br /> <br />   <br /> <br />   <br /> <br /> <br /> <br />   <br />


          </center>
            </div>
         </div>
 </div>

  <br />   <br />
<!--#Include virtual="/Footer.asp"-->
</body></html>