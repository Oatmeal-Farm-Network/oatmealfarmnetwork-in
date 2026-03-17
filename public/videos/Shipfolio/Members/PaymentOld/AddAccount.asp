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
          </div>

        <div class="container" style="max-width: 400px; background-color: #dddddd">
				<div class="mt-2 pt-2 mb-4 pb-4 ">
                <div class="row">
                    <form class="needs-validation w-100" novalidate name="submit_form" id="submit_form">

                     <div id="Product"></div>
                        <div id="message"></div>
                        <div class="row">
                          <div class="col body">
                            <b>Name</b><br />
                            <input type="text" class="formbox" id="card_name" name="card_name" style="min-width:300px" value="" required>
                            <small class="text-muted"><br />Full name as displayed on card</small>
                          </div>
                        </div>
                          <div class ="row">
                            <div class ="col" style ="min-height:15px">

                            </div>
                        </div>
                        <div class="row">
                          <div class="col body">
                            <b>Credit Card Number</b><br />
                            <input type="text" class="formbox" id="cardNumber" name="cardNumber" style="min-width:300px" value=""  onkeypress="return validateNumber(event);" required />
                             <span id="errorCardNumber" class="text-danger"></span>
                          </div>
                        </div>
                          <div class ="row">
                            <div class ="col" style ="min-height:15px">

                            </div>
                        </div>
                        <div class="row">
                          <div class="col-4 body">
                           <b>Month</b> <font color ="#abacab">MM</font><br />
                            <input type="number" id="cardExpMonth" name="cardExpMonth" class="validate formbox" style="max-width:80px" maxlength="2" value=""  onkeypress="return validateNumber(event);" required />
                            <span id="errorCardExpMonth" class="text-danger"></span>
                          </div>
                           <div class="col-4 body">
                           <b>Year </b><font color ="#abacab">YYYY</font><br />
                             <input type="number" id="cardExpYear" name="cardExpYear" class="validate formbox" style="max-width: 80px" maxlength="4" value=""  maxlength="4" onkeypress="return validateNumber(event);" required />
                            <span id="errorCardExpYear" class="text-danger"></span>
                          </div>
                          <div class="col-4 body">
                            <b>CVV</b><br />
                            <input type="number" class="formbox validate" id="cardCVC" name="cardCVC" style="max-width: 80px" value="" onkeypress="return validateNumber(event);" required>
                            <span id="errorCardCvc" class="text-danger"></span>
                          </div>
                        </div>
                            <div class ="row">
                            <div class ="col" style ="min-height:15px">

                            </div>
                        </div>
                         <div class ="row">
                             <div class ="col" style ="min-height:15px">
                                 Your card will be charged <%=currencycode %> <%=ExtraCharge %> / month.

                                 <button class="submitbutton" type="submit" id="submit_data" value="submit"> <i class="fa fa-spinner fa-spin faloader" style="display:none"></i> Submit</button>
                            </div>
                        </div>

                       
             
                
 
                        <input type="hidden"  id="PeopleID" value="<%=PeopleID %>" name="PeopleID">
                        <input type="hidden"  id="membership" value="<%=membership %>" name="membership">
                        <input type="hidden"  id="Membership_price" value="<%=Membership_price %>" name="Membership_price">
                        <input type="hidden"  id="stripe_product_price" value="<%=membershipStripePriceID %>" name="stripe_product_price">
                       
                          <div class="mb-3">
                       
                            <input type="hidden"  id="name" placeholder="" value="<%=PeopleFirstName %>" name="name" >
                          </div>
                        <div class="mb-3">
                         
                          <input type="hidden"  id="email" name="email" value="<%=PeopleEmail%>")" >
                        </div>
                        
                        <div class="mb-3">
                        
                          <input type="hidden"  id="phone" name="phone" value="<%=PeoplePhone%>")">
                        </div>
                        <div class="custom-control custom-checkbox"  style="display:none">
                             <input type="checkbox" class="custom-control-input" id="agree"  name="agree" >
                           <label class="custom-control-label" for="agree">I agree terms and conditions</label>
                        
                        </div>
                        <!--<div class="custom-control custom-checkbox">-->
                        <!--  <input type="checkbox" class="custom-control-input" id="save-info">-->
                        <!--  <label class="custom-control-label" for="save-info">Save this information for next time</label>-->
                        <!--</div>-->
                       
                    </form>
                 
                    <form action="<%=formstring  %>" id="FrmSaveData" method="post">
                        <input type="hidden"  id="PeopleFirstName" value="<%=PeopleFirstName %>" name="PeopleFirstName">
                        <input type="hidden"  id="PeopleEmail" value="<%=PeopleEmail %>" name="PeopleEmail">
                        <input type="hidden"  id="PeoplePhone" value="<%=PeoplePhone %>" name="PeoplePhone">
                        <input type="hidden"  id="PeopleLastName" value="<%=PeopleLastName %>" name="PeopleLastName">


                        <input type="hidden"  id="FinalPeopleID" value="<%=PeopleID %>" name="FinalPeopleID">
                        <input type="hidden"  id="Finalmembership" value="<%=membership %>" name="Finalmembership">
                        <input type="hidden"  id="FinalMembership_price" value="<%=Membership_price %>" name="FinalMembership_price">
                        <input type="hidden"  id="FinalStripePriceKey" value="<%=membershipStripePriceID %>" name="FinalStripePriceKey">
                        <input type="hidden"  id="FinalStripeCustomerID" value="<%=FinalStripeCustomerID %>" name="FinalStripeCustomerID">
                        <input type="hidden"  id="FinalStripeSubscriptionID" value="<%=FinalStripeSubscriptionID %>" name="FinalStripeSubscriptionID">
                       <button type="submit" id="plan_submit" class="roundedtopandbottomyellow" name="plan_submit" style="display:none">Save Details</button>
                   </form>


                  </div>
                </div>
 		    </div>
    <br /><br />

         </div>
   </div>
</div>
    
         </div>
   </div>
</div>

<!-- Vendor -->
		<script src="/StripeFile/jquery.min.js"></script>		
		<script src="/StripeFile/jquery.validate.min.js"></script>		
		

        <script type="text/javascript" src="https://js.stripe.com/v2/"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-creditcardvalidator/1.0.0/jquery.creditCardValidator.js"></script>
    	<script type="text/javascript" language="javascript">  
            //$("#plan_submit").submit("click", function (e) {
            //    $("#FrmSaveData").submit(); 
            //});

            $("#submit_form").submit("click", function (e) {

                e.preventDefault();
                if ($(this).valid()) {
                    Stripe.setPublishableKey('<%=StripeAPIkey %>')
                    if (validateForm() == true) {
                        var striperesponse = Stripe.createToken(
                            {
                                number: $('#cardNumber').val(),
                                cvc: $('#cardCVC').val(),
                                exp_month: $('#cardExpMonth').val(),
                                exp_year: $('#cardExpYear').val(),
                            },
                            stripeResponseHandler,
                        )
                        return false
                    }
                }
            });

            function stripeResponseHandler(status, response) {

                if (response.error) {
                    $('#submit_data').attr('disabled', false)
                    $('#message').html("<div class='text-danger alert alert-danger mt-2 mb-2'>" + response.error.message + "</div>").show();
                    $('#ErrorMessage').val(response.error.message);

                } else {

                    var stripeToken = response['id'];
                    $('#submit_form').append(
                        "<input type='hidden' name='stripeToken' value='" + stripeToken + "' />",
                    )

                    var datastring = $("#submit_form").serialize();

                    jQuery('.faloader').css('display', '');
                    $.ajax({
                        type: "POST",
                        url: "PlaceOrder.asp",
                        cache: false,
                        dataType: "text",
                        data: datastring,
                        success: function (data1) {
                            debugger;
                            var myArray = data1.split("|");
                            var aStatus = "";
                            var CustomerID = "";
                            var SubscriptionID = "";
                            if (myArray.length > 0) {
                                aStatus = myArray[0];
                                CustomerID = myArray[1];
                                SubscriptionID = myArray[2];
                                $('#FinalStripeCustomerID').val(CustomerID);
                                $('#FinalStripeSubscriptionID').val(SubscriptionID);
                                $("#FrmSaveData").submit();
                            }
                            if (aStatus == "success") {
                                //    window.location.href   =  document.origin &"/SetupAccountInDb.asp?CustomerID=" + CustomerID + "&SubscriptionID=" & SubscriptionID + "&Error=" & response.error.message;
                                jQuery('.faloader').css('display', 'none');
                                //alert(data.order_id);
                                $('#message').html("<div class='text-success alert alert-success mt-2 mb-2'>Subscription Added Successfully</div>");
                                //window.setTimeout(function () {
                                //    document.location.href = "SetupAccountInDb.asp?CustomerID=" + CustomerID + "&SubscriptionID=" & SubscriptionID;
                                //}, 2000)

                            } else {
                                jQuery('.faloader').css('display', 'none');
                                $('#message').html("<div class='text-danger alert alert-danger mt-2 mb-2'>" + aStatus + "</div>");
                                $('#ErrorMessage').val(aStatus);
                            }
                        },
                        beforeSend: function (data) {

                        }
                    });

                }
            }


            function validateForm() {

                var validCard = 0
                var valid = false
                var cardCVC = $('#cardCVC').val()
                var cardExpMonth = $('#cardExpMonth').val()
                var cardExpYear = $('#cardExpYear').val()
                var cardNumber = $('#cardNumber').val()
                var emailAddress = $('#emailAddress').val()
                var customerName = $('#customerName').val()
                var customerAddress = $('#customerAddress').val()
                var customerCity = $('#customerCity').val()
                var customerZipcode = $('#customerZipcode').val()
                var customerCountry = $('#customerCountry').val()
                var password = $('#password').val()
                var phone_number = $('#phone_number').val()
                var validateName = /^[a-z ,.'-]+$/i
                var validateEmail = /^([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,6}$/
                var validateMonth = /^01|02|03|04|05|06|07|08|09|10|11|12$/
                var validateYear = /^2023|2024|2025|2026|2027|2028|2029|2030|2031$/
                var cvv_expression = /^[0-9]{3,3}$/

                $('#cardNumber').validateCreditCard(function (result) {

                    if (result.valid) {
                        $('#cardNumber').removeClass('require')
                        $('#errorCardNumber').text('')
                        validCard = 1
                    } else {
                        $('#cardNumber').addClass('require')
                        $('#errorCardNumber').text('Invalid Card Number')

                        validCard = 0
                    }
                })


                if (validCard == 1) {
                    if (!validateMonth.test(cardExpMonth)) {
                        $('#cardExpMonth').addClass('require')
                        $('#errorCardExpMonth').text('Invalid Data')
                        return valid = false
                    } else {
                        $('#cardExpMonth').removeClass('require')
                        $('#errorCardExpMonth').text('')
                        valid = true
                    }

                    if (!validateYear.test(cardExpYear)) {
                        $('#cardExpYear').addClass('require')
                        $('#errorCardExpYear').text('Invalid Data')
                        return valid = false
                    } else {
                        $('#cardExpYear').removeClass('require')
                        $('#errorCardExpYear').text('')
                        valid = true
                    }

                    if (!cvv_expression.test(cardCVC)) {
                        $('#cardCVC').addClass('require')
                        $('#errorCardCvc').text('Invalid Data')
                        return valid = false
                    } else {
                        $('#cardCVC').removeClass('require')
                        $('#errorCardCvc').text('')
                        valid = true
                    }

                }
                return valid
            }


            function validateNumber(event) {

                var charCode = event.which ? event.which : event.keyCode
                if (charCode != 32 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                    return false
                }
                return true
            }


        </script>  




<br /><br /><br />
<!--#Include virtual="/members/membersFooter.asp"-->

</body>
</HTML>