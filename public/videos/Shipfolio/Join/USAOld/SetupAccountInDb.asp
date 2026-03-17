<%
dim PeopleID1, membership, Membership_price, StripePriceKey, StripeCustomerID, StripeSubscriptionID

    PeopleID1   =request.form("FinalPeopleID")
    membership   =request.form ("Finalmembership")
    Membership_price   =request.form ("FinalMembership_price")
    StripePriceKey   =request.form ("FinalStripePriceKey")
    StripeCustomerID   =request.form ("FinalStripeCustomerID")
    StripeSubscriptionID   =request.form ("FinalStripeSubscriptionID")



    %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<!--#Include virtual="/includefiles/globalvariables.asp"-->
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
<!--#Include virtual="/Header.asp"-->
<div class="container-fluid" style="background-color:Green" >
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>You are subscribed successfully for <%=membership %> membership @ <%=Membership_price %>/month </h1><br />
          PeopleID=<%=PeopleID1 %><br />
          StripeCustomerID=<%=StripeCustomerID %><br />
          StripeSubscriptionID=<%=StripeSubscriptionID %><br />
          </div>
        </div>
    </div>
    </div>
 </div>

 <% ' lg+ navigation  %>
    <div class="container-fluid" align = center style="max-width: 1000px; min-height: 600px; ">
       <div class = "row">
        <div class = "col - 6" align = "left">

 

   </div>
    </div>
    </div>
<!--#Include virtual="/Footer.asp"-->
</body></html>