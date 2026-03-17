<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<%
    sql = "select People.*, address.*  from People, Address where People.AddressID = Address.AddressID and People.AddressID = Address.AddressID and people.PeopleID = " & session("PeopleID")
'response.write("sql=" & sql )
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
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
end if %>
	 
		<!-- Basic -->
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">	

		<title></title>	

	 		<!-- Mobile Metas -->
		<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1.0, shrink-to-fit=no">

		<!-- Web Fonts  -->
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800%7CShadows+Into+Light%7CPlayfair+Display:400&display=swap" rel="stylesheet" type="text/css">

		<!-- Vendor CSS -->
		
		<link rel="stylesheet" href="/StripeFile/bootstrap.min.css">	 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

		
	</head>
	<body   >
        <% Current1="Account"
Current2 = "UpgradeorRenewYourMembership" 
Current3 = "Membership" 
Current3 = "Subscriptions" 
     showMarketplaces = True 
      websitesavailable = False   %> 
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include virtual="/members/MembersAccountJumpLinks.asp"-->

<div class=" container roundedtopandbottom">
	<div class="col">
        <div class="row">
           
              <h1>Cancel Membership</h1> 


                 <div class="container" style="width: 400px;">
                    <div class ="row">
                      <div class ="col-12" >
                          
                           <% 
                               
                               CurrentSusbcriptionID = request.querystring("CurrentSusbcriptionID")
                               NewMembership= request.querystring("NewMembership")

                              ' response.write("<br>CurrentSusbcriptionID=" & CurrentSusbcriptionID )
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
                                  <td class ="body" style="text-align:right">Current Membership: </td>
                                   <td class ="body" > <%=CurrentSubscriptionTitle %> (<%=CurrentSubscriptionMonthlyRate %>)</td>
                              </tr>
                               <tr>
                                  <td class ="body" style="text-align:right">Change to: </td>
                                  <td class ="body" > <%=NewSubscriptionTitle %> 
                                      <% if len(NewSubscriptionMonthlyRate) > 1 then %>
                                         (<%=NewSubscriptionMonthlyRate %>)
                                      <% else %>
                                         (Free)
                                      <% end if %>
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
                     <div class ="row">
                      <div class ="col-12" >
                        <div id="message"></div>
                       </div>
                     </div>
                     <div class ="row">
                          <div class ="col-6" >
                                <br /><br />
                                 <form action="/members/MembersRenewSubscription.asp" method="post">
                                            
                                   <input class="submitbutton" type="submit" value="Go Back">
                               </form>

                               <br /><br /> <br /><br />
                          </div>
                      <div class ="col-6" >
  <br /><br />

                          <% if len(StripeSubscriptionID) > 0 then %> 
                             <form class="needs-validation" novalidate name="CancelSubmit" id="CancelSubmit">
                               
                                  <input type="hidden" class="form-control" id="SubscriptionID" name="SubscriptionID" placeholder="Subscription ID" value="<%=StripeSubscriptionID %>" >
                                  <input type="hidden" id="mode" name="mode"  value="Cancel" >
                                            
                                   <button class="submitbutton" type="submit" id="submit_data" onclick="CancelSubscription();return false; " value="submit">Proceed</button>
                            </form>
                          <% else %>
                                <form action="/members/Payment/MembersCancelSubsriptionNoID.asp" method="post">
                               
                                           
                                   <button class="submitbutton" type="submit" id="submit_data"  value="submit">Proceed</button>
                            </form>


                          <% end if %>
                           <br /><br /> <br /><br />
                        </div>
                    </div>
                    </div>
                     <br /><br /> <br /><br />
                
            </div>
     </div>
</div>

        <br /><br />

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
                            $('#message').html("<div class='text-success alert alert-success mt-2 mb-2'>Subscription canceled successfully</div>");
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

   
      
             </script>  

<!--#Include virtual="/members/membersFooter.asp"-->
	</body>
</html>
