<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>



<!--#Include virtual="/members/Payment/Stripe.asp"-->
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<% Discount = 0
PremiumDiscount = 0
showcomplete = True

sql = "select People.*, address.country_id, country.* from People, Address, Country where People.AddressID = Address.AddressID and People.AddressID = Address.AddressID and address.country_id  = Country.country_id and people.PeopleID = " & session("PeopleID")
'response.write("sql=" & sql )
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
StripeSubscriptionID = rs("StripeSubscriptionID")
PeopleStripeCustomerID = rs("PeopleStripeCustomerID")

custAIStartService= rs("custAIStartService")  
custAIEndService= rs("custAIEndService")  
Membershiplevel = rs("SubscriptionLevel")  
StripeSubscriptionID = rs("StripeSubscriptionID")  
PeopleStripeCustomerID = rs("PeopleStripeCustomerID")  
StripeID = rs("StripeID")  

'response.write("Membershiplevel=" & Membershiplevel )
PeopleEmail = rs("PeopleEmail")
PeopleFirstName = rs("PeopleFirstName")
PeopleLastName = rs("PeoplelastName")
PeoplePhone = rs("PeoplePhone")

	
CurrencyCode = rs("CurrencyCode")
CurrentCurrency = rs("Currency")

country_id = rs("country_id")
 WebsitesID = rs("WebsitesID")
PeopleCell = rs("PeopleCell")
 PeopleFax= rs("Peoplefax")
Logo= rs("Logo")
Owners= rs("Owners")
PeopleTitleID = rs("PeopleTitleID") 
PeopleEmail= rs("PeopleEmail") 
rs.close
end if

file_name = "SetupAccountPlusstep3.asp"

script_name = request.servervariables("script_name")

str1 = script_name
str2 = "Join"
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 
str1 = sitePath
str2 = file_name
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 

str1 = sitePath
str2 = "/"
If InStr(str1,str2) > 0 Then
Region= Replace(str1,  str2, "")
End If 
'response.write("sitePath=" & sitePath & "<br>")




sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close


%>

      <style>
    /* Hide the up and down arrows */
    input[type="number"]::-webkit-inner-spin-button,
    input[type="number"]::-webkit-outer-spin-button {
      -webkit-appearance: none;
      margin: 0;
    }

    /* Optional: Style the input field as desired */
    input[type="number"] {
      padding: 5px;
      width: 150px;
    }
  </style>
</head>
<body >



<%


Current1="Account"
Current2 = "UpgradeorRenewYourMembership" 
Current3 = "Membership" 
Membershiplevel = 1
     showMarketplaces = True 
      websitesavailable = False   %> 
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include virtual="/members/MembersAccountJumpLinks.asp"-->


<div class="container roundedtopandbottom" >

  <div class="row"> <h1>Change Your Membership</h1> 
  <div class="col">


<div class="container d-flex justify-content-center mx-auto " >

  <div class="row">
  <div class="col">
    
      <div class="container" >
         <div class="row">
            <div class="col">
      

                  <% Error = request.querystring("Error")
                        If Error = "True" then %>
                    <b>Sorry, we encountered an issue with your card. Please double-check the card information and try again. If the problem persists, please contact your card issuer for assistance.</b><br />
                    <br />

                    <% Error = "False"
                        session("Error") = ""
                        end if %>
                          <br />
                           <% 
                               
                               CurrentSusbcriptionID = request.querystring("CurrentSusbcriptionID")
                               NewMembership= request.querystring("NewMembership")

                                formstring = "SetupAccountInDb.asp?CurrentSusbcriptionID=" & CurrentSusbcriptionID & "&NewMembership=" & NewMembership
                       ' response.write("formstring = " & formstring ) 

                              'response.write("<br>CurrentSusbcriptionID=" & CurrentSusbcriptionID )
                              'response.write("<br>NewMembership=" & NewMembership )
                               
                               sql = "select * from subscriptionlevels where SubscriptionID = " & CurrentSusbcriptionID
                                   ' response.write("sql=" & sql )
                                    Set rs = Server.CreateObject("ADODB.Recordset")
                                    rs.Open sql, conn, 3, 3   
                                    if  Not rs.eof then 
                                        CurrentSubscriptionTitle = rs("SubscriptionTitle")
                                	    CurrentSubscriptionMonthlyRate = rs("SubscriptionMonthlyRate")
                                    end if 

                                sql = "select * from subscriptionlevels where SubscriptionID = " & NewMembership 
                                   ' response.write("sql=" & sql )
                                    Set rs = Server.CreateObject("ADODB.Recordset")
                                    rs.Open sql, conn, 3, 3   
                                    if  Not rs.eof then 
                                        NewSubscriptionTitle = rs("SubscriptionTitle")
                                	    NewSubscriptionMonthlyRate = rs("SubscriptionMonthlyRate")
                                    end if 


                               %>
                          <table>
                              <tr>
                                  <td class ="body" style="text-align:right">Current Membership:&nbsp; </td>
                                   <td class ="body" > <%=CurrentSubscriptionTitle %> 
                                          <% if len(CurrentSubscriptionMonthlyRate ) > 1 then %>
                                         (<%=CurrencyCode %><%=CurrentSubscriptionMonthlyRate  %>)
                                      <% else %>
                                         (Free)
                                      <% end if %>

                                   </td>
                              </tr>
                               <tr>
                                  <td class ="body" style="text-align:right">Change to: &nbsp; </td>
                                  <td class ="body" > <%=NewSubscriptionTitle %> 
                                      <% if len(NewSubscriptionMonthlyRate) > 1 then %>
                                         (<%=CurrencyCode %><%=NewSubscriptionMonthlyRate %>)
                                      <% else %>
                                         (Free)
                                      <% end if %>

                                      <% ExtraCharge = formatcurrency(NewSubscriptionMonthlyRate) - formatcurrency(CurrentSubscriptionMonthlyRate)  %>

                                  </td>
                              </tr>
                          </table>
                           <br />
                              <% if len(NewSubscriptionMonthlyRate) > 1 then %>
                             <% else %>
                                 Before making the switch, take a moment to consider if you are certain about changing your membership to an intro level. You'll be losing access to a comprehensive range of valuable services and features afforded through your current membership.
                             <% end if %>

                      </div>
                    </div>
                    <div>
                        <div>
                         <center> <a href="https://buy.stripe.com/dR64gF9Iae8F0ne7st" target="_blank" class="roundedtopandbottomyellow body">Pay Now</a></center>

                        </div>
                    </div>
          </div>






    
         </div>
   </div>
</div>




<br /><br /><br />
<!--#Include virtual="/members/membersFooter.asp"-->

</body>
</HTML>