<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <title>Harvest Hub Dashboard</title>
      <% MasterDashboard= True %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<% 
Current1 = "MembersHome"
Current2="MembersHome" %> 


<% 

BusinessTypeID = request.QueryString("BusinessTypeID")
file_name = "SetupAccountPlus.asp"

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


'response.write("Region=" & Region & "<br>")

sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close


BusinessWebsite = request.querystring("BusinessWebsite") 
'stepback = False
stepback = request.querystring("stepback") 

if len(BusinessWebsite) > 0 then
else
BusinessWebsite = request.form("BusinessWebsite") 
end if
Subscription = Request.querystring("Subscription") 

ReturnFileName = Request.querystring("ReturnFileName") 
Update = Request.querystring("Update") 
Message = request.querystring("Message")
Membership = request.querystring("Membership")
Owners = Request.querystring("Owners")
BusinessName = Request.querystring("BusinessName")
BusinessWebsite = Request.querystring("BusinessWebsite")
BusinessEmail  = Request.querystring("BusinessEmail")

EmailsMatch = Request.querystring("EmailsMatch")

SpecialChecterFound = Request.querystring("SpecialChecterFound")
ConfirmEmail = Request.querystring("ConfirmEmail")


Current = "Home"
Current3="Register"
MasterDashboard= True
%>
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>


<div class="container-fluid" >
  <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Setup Account</h1>
          </div>
        </div>
    </div>
    </div>
 </div>
<br />

<div class = "container roundedtopandbottom mx-auto" style="max-width:450px" >
<div class = "col" >
<form name=form method="post" action="SetupAccountPlusStep2.asp?BusinessTypeID=<%=BusinessTypeID %>&Subscription=<%=Subscription%>"> 


<% if EmailsMatch ="False" then %>
<font color = "maroon"><br /><b>Your email addresses do not match.</b></font>
<% end if %>

<div class="form-group"><br />
<% if len(BusinessTypeID) > 0 then
   sql = "select BusinessType from [dbo].[businesstypelookup] where BusinessTypeID = " & BusinessTypeID & ""
    rs.Open sql, conn, 3, 3   
    if  Not rs.eof then 
        CurrentBusinessType = rs("BusinessType")
    end if
    rs.close
 end if  
%>

    <label for="CurrentBusinessType">Organization Type:</label>
   <b><%=CurrentBusinessType %></b>


</div>


<div class="form-group"><br />
    <label for="BusinessName">Business / Org. Name <font color= "#abacab">(Optional)</font></label><br />
    <input type="Text" name="BusinessName"  class="formbox" id="BusinessName" Value ="<%=BusinessName%>" style="width: 400px" >
</div>


<div class="form-group"><br />
    <label for="BusinessWebsite">Website <font color= "#abacab">(Optional)</font></label><br />
    <input type="Text" name="BusinessWebsite" class="formbox" id="BusinessWebsite" Value ="<%=BusinessWebsite%>" style="width: 400px" >
</div>


<div class="form-group"><br />
<label for="BusinessEmail">Contact Email</label><br />
<input type="BusinessEmail" id="BusinessEmail" class="formbox" name="BusinessEmail" required style="width: 400px" >
</div>

<div class="form-group"><br />
 <label for="confirm_email">Confirm Email</label><br />
<input type="email" id="confirm_email" class="formbox" name="confirm_email"  required onkeyup="checkEmailMatch();" style="width: 400px" >
</div>

    
<script>
function checkEmailMatch() {
    var email = document.getElementById("email");
    var confirm_email = document.getElementById("confirm_email");

    if (email.value != confirm_email.value) {
        confirm_email.setCustomValidity("Email addresses do not match");
    } else {
        confirm_email.setCustomValidity("");
    }
}
</script>


<input name="BusinessID" type = "hidden"  value = "<%=BusinessID%>">
<input name="country_id" type = "hidden"  value = "<%=country_id%>">
<input name="Update"  type= "hidden" value = "<%=Update%>">
<input name="Membership"  type= "hidden" value = "<%=Membership%>">
<input name="BusinessTypeID"  type= "text" value = "<%=BusinessTypeID %>">
    
<br />
	<input type=submit value="Next" class = "regsubmit2">


	</form><br><br>
</div>
<br>
</div>
<br>
<!--#Include virtual="/Footer.asp"--> </body>
</HTML>