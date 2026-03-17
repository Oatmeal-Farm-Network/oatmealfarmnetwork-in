<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<!DOCTYPE html>
<html lang="en">
	<head>

	 
		<!-- Basic -->
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">	

		<title></title>	

	 		<!-- Mobile Metas -->
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, shrink-to-fit=no">

		<!-- Web Fonts  -->
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800%7CShadows+Into+Light%7CPlayfair+Display:400&display=swap" rel="stylesheet" type="text/css">

		<!-- Vendor CSS -->
		  
		<style>
		#iframe1 {
			min-height:2950px
		}
		@media (min-width:991px) 
		{
			#iframe1 {
				min-height:2390px
			}
		}
        body{
            color: #000000;
        }
        .form-control.is-valid,.form-control.is-valid:focus{
            border-color: #1c92d0;
            box-shadow:0 0 0 0.2rem rgb(28 146 208 / 19%);
        }
        .custom-control-label,.custom-control-input.is-valid~.custom-control-label{  
            color:#1c92d0;
        }
        .custom-control-input.is-valid:checked~.custom-control-label::before{
            border-color: #1c92d0!important;
            background-color:#1c92d0!important;
        }
        .alert-success {
            color: #1c92d0!important;
            background-color: rgb(28 146 208 / 19%);
            border-color: rgb(28 146 208 / 19%);
        }
        .form-control.is-valid{
            background-image:unset;
        }
        .custom-select.is-valid, .was-validated .custom-select:valid{ background-image:unset;
         border-color: #1c92d0;
            box-shadow:0 0 0 0.2rem rgb(28 146 208 / 19%);
        }
		</style>
		
		<link rel="stylesheet" href="/StripeFile/bootstrap.min.css">		
		<link rel="stylesheet" href="/StripeFile/theme-elements.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

		
	</head>
	<body   >

		<div class="body" style="background-color: #ffffff;">
				 
				<div class="container">
				<div class="mt-2 pt-2 mb-4 pb-4">
                <div class="row">
                    <form class="needs-validation w-100" novalidate name="submit_form" id="submit_form">


                    <div class="col-md-5 order-md-2 mb-4 float-right">
                      
                       <hr class="mb-4">
                
                        <h4 class="mb-3">Payment</h4>
                        <div id="Product">PeopleID = <%=request.form("PeopleID") %>, <%=request.form("membership") %> Membership<br>Order: <%=formatcurrency(request.form("Membership_price"))%> / Month</div>
                        <div id="message"></div>
                        <div class="row">
                          <div class="col-md-6 mb-3">
                            <label for="cc-name">Name on card</label>
                            <input type="text" class="form-control" id="card_name" name="card_name" placeholder="Name on card" value="" required>
                            <small class="text-muted">Full name as displayed on card</small>
                          </div>
                          <div class="col-md-6 mb-3">
                            <label for="cc-number">Credit card number</label>
                            <input type="text" class="form-control" id="cardNumber" name="cardNumber" value="4242424242424242" placeholder="" onkeypress="return validateNumber(event);" required>
                             <span id="errorCardNumber" class="text-danger"></span>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col-md-4 mb-3">
                            <label for="cc-expiration">Expiry Month</label>
                            <input type="number" id="cardExpMonth" name="cardExpMonth" class="validate form-control" value="12" placeholder="MM" onkeypress="return validateNumber(event);" required>
                            <span id="errorCardExpMonth" class="text-danger"></span>
                          </div>
                           <div class="col-md-4 mb-3">
                            <label for="cc-expiration">Expiry Year</label>
                             <input type="number" id="cardExpYear" name="cardExpYear" class="validate form-control" value="2023" placeholder="Year" maxlength="4" onkeypress="return validateNumber(event);" required>
                            <span id="errorCardExpYear" class="text-danger"></span>
                          </div>
                          <div class="col-md-4 mb-3">
                            <label for="cc-cvv" class="pb-sm-4 pb-md-4 pb-lg-0 pb-xl-0">CVV</label>
                            <input type="number" class="form-control validate" id="cardCVC" name="cardCVC" value="123" placeholder="CVV" onkeypress="return validateNumber(event);" required>
                            <span id="errorCardCvc" class="text-danger"></span>
                          </div>
                        </div>
                        <hr class="mb-4">
                        <button class="btn btn-primary btn-lg btn-block" type="submit" id="submit_data" value="submit"> <i class="fa fa-spinner fa-spin faloader" style="display:none"></i> Submit</button>
                      
                    </div>
                    <div class="col-md-7 order-md-1">
                      <h4 class="mb-3">Profile</h4> 
 
                        <input type="hidden"  id="PeopleID" value="<%=request.form("PeopleID") %>" name="PeopleID">
                        <input type="hidden"  id="membership" value="<%=request.form("membership") %>" name="membership">
                        <input type="hidden"  id="Membership_price" value="<%=request.form("Membership_price") %>" name="Membership_price">
                        <input type="hidden"  id="stripe_product_price" value="<%=request.form("price_key") %>" name="stripe_product_price">
                       
                          <div class="mb-3">
                            <label for="firstName">First Name</label>
                            <input type="text" class="form-control" id="name" placeholder="" value="" name="name" required>
                          </div>
                        <div class="mb-3">
                          <label for="email">Email</label>
                          <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" value="" required>
                        </div>
                        
                        <div class="mb-3">
                          <label for="email">Phone</label>
                          <input type="number" class="form-control" id="phone" name="phone" value="" required>
                        </div>
                        <div class="custom-control custom-checkbox">
                             <input type="checkbox" class="custom-control-input" id="agree"  name="agree" required>
                           <label class="custom-control-label" for="agree">I agree terms and conditions</label>
                        
                        </div>
                        <!--<div class="custom-control custom-checkbox">-->
                        <!--  <input type="checkbox" class="custom-control-input" id="save-info">-->
                        <!--  <label class="custom-control-label" for="save-info">Save this information for next time</label>-->
                        <!--</div>-->
                       
                    </div>
                    </form>
                    <form action="SetupAccountInDb.asp" id="FrmSaveData" method="post">
                        <input type="hidden"  id="FinalPeopleID" value="<%=request.form("PeopleID") %>" name="FinalPeopleID">
                        <input type="hidden"  id="Finalmembership" value="<%=request.form("membership") %>" name="Finalmembership">
                        <input type="hidden"  id="FinalMembership_price" value="<%=request.form("Membership_price") %>" name="FinalMembership_price">
                        <input type="hidden"  id="FinalStripePriceKey" value="<%=request.form("price_key") %>" name="FinalStripePriceKey">
                        <input type="hidden"  id="FinalStripeCustomerID" value="" name="FinalStripeCustomerID">
                        <input type="hidden"  id="FinalStripeSubscriptionID" value="" name="FinalStripeSubscriptionID">
                       <button type="submit" id="plan_submit" class="roundedtopandbottomyellow" name="plan_submit" style="display:none">Save Details</button>
                   </form>
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
                $('#message').html("<div class='text-danger alert alert-danger mt-2 mb-2'>"+response.error.message+"</div>").show();
              } else { 
                  
                   var stripeToken = response['id'];
                    $('#submit_form').append(
                      "<input type='hidden' name='stripeToken' value='" + stripeToken + "' />",
                    )
           
                  var datastring = $("#submit_form").serialize();
            
                  jQuery('.faloader').css('display','');
                  $.ajax({  
                     type:"POST",  
                     url:"placeorder.asp",
                     cache : false,
                      dataType: "text",
                     data:datastring,  
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
                          //    window.location.href   =  document.origin &"/SetupAccountInDb.asp?CustomerID=" + CustomerID + "&SubscriptionID=" & SubscriptionID;
                            jQuery('.faloader').css('display','none');
                          //alert(data.order_id);
                           $('#message').html("<div class='text-success alert alert-success mt-2 mb-2'>Subscription Added Successfully</div>"); 
                           //window.setTimeout(function () {
                           //    document.location.href = "SetupAccountInDb.asp?CustomerID=" + CustomerID + "&SubscriptionID=" & SubscriptionID;
                           //}, 2000)
                            
                      }else{
                          jQuery('.faloader').css('display','none');
                              $('#message').html("<div class='text-danger alert alert-danger mt-2 mb-2'>" + aStatus +"</div>");  
                      }
                    },
                     beforeSend: function(data){  
                         
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


	</body>
</html>
