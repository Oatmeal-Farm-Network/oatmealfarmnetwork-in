<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<!--#Include virtual="/members/Payment/Stripe.asp"-->


<% 
    
    'response.write("Status=" & Status)
    Discount = 0
PremiumDiscount = 0
showcomplete = True

sql = "select People.*, address.*  from People, Address where People.AddressID = Address.AddressID and People.AddressID = Address.AddressID and people.PeopleID = " & session("PeopleID")
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
AddressApt = rs("AddressApt")
AddressCity= rs("AddressCity")
AddressState = rs("AddressState")
AddressZip = rs("AddressZip")
	
country_id = rs("country_id")
 AddressStreet = rs("AddressStreet")
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


dim membershipStripePrice
MembershipID = request.querystring("NewMembership")

'response.write("MembershipID=" & MembershipID )


If MembershipID = "2" then
    Membership = "Basic"
    SubscriptionID = 2
end if
If MembershipID = "3" then
    Membership = "Business"
    SubscriptionID = 3
end if

If MembershipID = "5" then
    Membership = "Global"
    SubscriptionID = 5
end if


if  Status="Test" then
sql = "select * from SubscriptionLevels where SubscriptionID = 2 " 'USA Basic Account
   ' response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        StripePriceID = rs("StripeAPIIDTest")
        SubscriptionMonthlyRate = rs("SubscriptionMonthlyRate")
    end if
	'response.write("BasicsPriceID =" & BasicsPriceID  )
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 3 " 'USA Business Account
    'response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        StripePriceID = rs("StripeAPIIDTest")
        SubscriptionMonthlyRate = rs("SubscriptionMonthlyRate")
    end if
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 5 " 'USA Global Account
  rs.Open sql, conn, 3, 3   
    if  Not rs.eof then 
        StripePriceID = rs("StripeAPIIDTest")
        SubscriptionMonthlyRate = rs("SubscriptionMonthlyRate")
    end if
    rs.close


end if
if  Status="Live" Then
sql = "select * from SubscriptionLevels where SubscriptionID = 2 " 'USA Basic Account
   ' response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        StripePriceID = rs("StripeAPIID")
        SubscriptionMonthlyRate = rs("SubscriptionMonthlyRate")
    end if
	'response.write("BasicsPriceID =" & BasicsPriceID  )
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 3 " 'USA Business Account
    'response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        StripePriceID = rs("StripeAPIID")
        SubscriptionMonthlyRate = rs("SubscriptionMonthlyRate")
    end if
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 5 " 'USA Global Account
  rs.Open sql, conn, 3, 3   
    if  Not rs.eof then 
        StripePriceID = rs("StripeAPIID")
        SubscriptionMonthlyRate = rs("SubscriptionMonthlyRate")
    end if
    rs.close
End if





sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close


%>
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

<div class="container d-flex justify-content-center roundedtopandbottom mx-auto " style = "max-width:460px; min-height: 200px">
  <div class="row">
  <div class="col">

<div>
   <div>
      



<blockquote>
	<br />
<h2>Your Order</h2>
<center>
<table width = 280 >
<tr><td class = "body"><%=membership %> Membership<br>
Order: <%=formatcurrency(SubscriptionMonthlyRate)%> / Month<br>
</td></tr></table>



	
	 <form action="/members/Payment/checkout-billing.asp" method="post">
     <input type="hidden" name="PeopleID" value="<%=PeopleID %>" /> 
     <input type="hidden" name="membership" value="<%=membership %>" /> 
    <input type="hidden" name="Membership_price" value="<%=SubscriptionMonthlyRate %>" /> 
    <input type="hidden" name="membershipStripePriceID" value="<%=StripePriceID %>" /> 

	 <input type="hidden" name="PeopleFirstName" value="<%=PeopleFirstName %>" />
	 <input type="hidden" name="PeopleLastName" value="<%=PeopleLastName %>" />
	 <input type="hidden" name="PeopleEmail" value="<%=PeopleEmail %>" />
	 <input type="hidden" name="PeoplePhone" value="<%=PeoplePhone %>"

     <div class="select"><br />
     <div> <button type="submit" class="submitbutton" name="plan_submit">Pay Now</button> </div><br />
     </div>
     </form>







     <form class="needs-validation w-100" novalidate name="UpdownForm" id="UpdownForm">
                       <br /><br /><h5> Change membership</h5> 

                    <div class="col-md-12 ">
                        
                        <div class="row">
                          <div class="col-md-12">
                              <div id="messageUpDown"></div>
                              <br />
                            <label for="cc-name">Subscription ID</label>
                            <input type="text" class="form-control" id="SubscriptionID1" name="SubscriptionID" placeholder="Subscription ID" value="<%=StripeSubscriptionID %>" required>
                            <input type="hidden" id="mode" name="mode"  value="UpDown" >
                           
                         
                              <table width="300px"><tr><td> Select Membership</td></tr>
                                  <tr>
                                      <td>
                                       <input name="ToMembership" id="ToMembership" value="<%=MonthlyRate %>">
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
                        <input type="hidden"  id="FinalStripeSubscriptionID" value="<%=StripeSubscriptionID %>" name="FinalStripeSubscriptionID">
                        <input type="hidden"  id="FinalMode" value="" name="FinalMode">
                       <button type="submit" id="plan_submit" class="roundedtopandbottomyellow" name="plan_submit" style="display:none">Save Details</button>
                   </form>






			
		

   </div>
</div>

<br /><br />

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
                    alert("Please select new membership!");
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



<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<!--#Include virtual="/members/membersFooter.asp"-->

</body>
</HTML>