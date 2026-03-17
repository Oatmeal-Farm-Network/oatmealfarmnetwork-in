<!--#Include virtual="/stripefile/Stripe.asp"-->
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
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

		
	</head>
	<body   >

		<div class="body" style="background-color: #ffffff;">
				 
				<div class="container">
				<div class="mt-2 pt-2 mb-4 pb-4">
                <div class="row">
                    <form class="needs-validation w-100"    novalidate name="CancelSubmit" id="CancelSubmit">


                    <div class="col-md-5 order-md-2 mb-4">
                      
                     <h5> Cancel Membership</h5> 
                
                       
                        <div id="message"></div>
                        <div class="row">
                          <div class="col-md-6 mb-3">
                            <label for="cc-name">Subscription ID</label>
                            <input type="text" class="form-control" id="SubscriptionID" name="SubscriptionID" placeholder="Subscription ID" value="" >
                           <input type="hidden" id="mode" name="mode"  value="Cancel" >
                          </div></div>
                          </div>
                       
                        <button class="btn btn-primary btn-lg btn-block" type="submit" id="submit_data" onclick="CancelSubscription();return false; " value="submit"> <i class="fa fa-spinner fa-spin faloader" id="spinCancel"  style="display:none"></i> Submit</button>
                   <hr class="mb-4">
                            </form>

                   
                   <form class="needs-validation w-100"    novalidate name="UpdownForm" id="UpdownForm">
                       <br /><br /><h5> Change membership</h5> 

                    <div class="col-md-12 ">
                        
                        <div class="row">
                          <div class="col-md-12">
                              <div id="messageUpDown"></div>
                              <br />
                            <label for="cc-name">Subscription ID</label>
                            <input type="text" class="form-control" id="SubscriptionID1" name="SubscriptionID" placeholder="Subscription ID" value="" required>
                            <input type="hidden" id="mode" name="mode"  value="UpDown" >
                           
                         
                              <table width="300px"><tr><td> Select Membership</td></tr>
                                  <tr>
                                      <td>
                                       <select name="ToMembership" id="ToMembership">
                                           <option value="">Select</option> 
                                        <option value="<%=BusinessPrice %>">Business</option>
                                        <option value="<%=GlobalPrice %>">Global</option></select>
                                      </td>
                                       
                                  </tr>

                              </table>
                             <br />
                             
                          </div>
                        
                        <button class="btn btn-primary btn-lg btn-block" type="submit" id="btnUpdownForm" value="submit" onclick="UpDownSubscription();return false; "> <i class="fa fa-spinner fa-spin faloader" id="spinUpdown" style="display:none"></i> Submit</button>
                   </form>

                      <form action="SetupAccountInDb.asp" id="FrmSaveData" method="post">
                        <input type="hidden"  id="FinalPeopleID" value="" name="FinalPeopleID">
                        <input type="hidden"  id="Finalmembership" value="" name="Finalmembership">
                        <input type="hidden"  id="FinalMembership_price" value="" name="FinalMembership_price">
                        <input type="hidden"  id="FinalStripePriceKey" value="" name="FinalStripePriceKey">
                        <input type="hidden"  id="FinalStripeCustomerID" value="" name="FinalStripeCustomerID">
                        <input type="hidden"  id="FinalStripeSubscriptionID" value="" name="FinalStripeSubscriptionID">
                        <input type="hidden"  id="FinalMode" value="" name="FinalMode">
                       <button type="submit" id="plan_submit" class="roundedtopandbottomyellow" name="plan_submit" style="display:none">Save Details</button>
                   </form>
                  </div>
                </div>
 
		    </div> 
		</div>



		<!-- Vendor -->
		 
        	<script src="/stripefile/jquery.min.js"></script>		
		<script src="/stripefile/jquery.validate.min.js"></script>		
		
         	<script type="text/javascript" language="javascript">  
            //$("#plan_submit").submit("click", function (e) {
            //    $("#FrmSaveData").submit(); 
            //});

             
            function CancelSubscription() {
                
                var SubscriptionID = $("#SubscriptionID").val();
                if (SubscriptionID.length == 0) {
                    alert("Please enter Subscription ID");
                    $("#SubscriptionID").focus();
                    return false;
                }
                var datastring = $("#CancelSubmit").serialize();
                $("#spinCancel").show(); 
                $.ajax({
                    type: "POST",
                    url: "SubscriptionManageCode.asp",
                    cache: false,
                    dataType: "text",
                    data: datastring,
                    success: function (data1) {
                        debugger;


                        if (data1 == "success") {
                            //    window.location.href   =  document.origin &"/SetupAccountInDb.asp?CustomerID=" + CustomerID + "&SubscriptionID=" & SubscriptionID;
                            $("#spinCancel").hide(); 
                            //alert(data.order_id);
                            $('#message').html("<div class='text-success alert alert-success mt-2 mb-2'>Subscription cancel Successfully</div>");
                            $("#FinalStripeSubscriptionID").val(SubscriptionID);
                            $("#FinalMode").val('Cancel');                            
                            $("#FrmSaveData").submit(); 

                        } else {
                            jQuery('.faloader').css('display', 'none');
                            $('#message').html("<div class='text-danger alert alert-danger mt-2 mb-2'>" + data1 + "</div>");
                            return false;
                        }
                    },
                    
                });

            }
          
            function UpDownSubscription() {
                
                var SubscriptionID = $("#SubscriptionID1").val();
                if (SubscriptionID.length == 0) {
                    alert("Please enter Subscription ID");
                    $("#SubscriptionID1").focus();
                    return false;
                }
                var ToMembership = $("#ToMembership").val();
                if (ToMembership.length == 0) {
                    alert("Please select new membership");
                    $("#ToMembership").focus();
                    return false;
                }
                var SelectedMembership = $("#ToMembership option:selected").text();
                var datastring = $("#UpdownForm").serialize();
                $("#spinUpDown").show(); 
                $.ajax({
                    type: "POST",
                    url: "SubscriptionManageCode.asp",
                    cache: false,
                    dataType: "text",
                    data: datastring,
                    success: function (data1) {
                        debugger;
                        var myArray = data1.split("|");
                        var aStatus = myArray[0];
                        $("#spinUpDown").hide(); 
                        if (aStatus == "success") {
                            $('#messageUpDown').html("<div class='text-success alert alert-success mt-2 mb-2'>Membership Updated Successfully</div>");
                            $("#FinalStripeSubscriptionID").val(SubscriptionID);
                            $("#FinalStripePriceKey").val(ToMembership);
                            $("#Finalmembership").val(SelectedMembership);
                            
                            $("#FinalMode").val('Update');     
                            $("#FrmSaveData").submit(); 
                        } else {
                            jQuery('.faloader').css('display', 'none');
                            $('#messageUpDown').html("<div class='text-danger alert alert-danger mt-2 mb-2'>" + aStatus + "</div>");
                            return false;
                        }
                    },
                });
            }
       
   
      
             </script>  


	</body>
</html>
