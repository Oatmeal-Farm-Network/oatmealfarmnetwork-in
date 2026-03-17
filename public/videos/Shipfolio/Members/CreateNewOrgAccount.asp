<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <title>Harvest Hub Dashboard</title>
      <% MasterDashboard= True %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<%'response.write("BusinessType=" & BusinessType)'

BladeSection = "users"
pagename = "addaccount"
Current1 = "MembersHome"
Current2="MembersHome"
BladeSection = "accounts" 
 %> 
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->

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

websitesignupcount = 0

website = request.querystring("website") 
'stepback = False
stepback = request.querystring("stepback") 

if len(website) > 0 then
else
website = request.form("website") 
end if
Subscription = Request.querystring("Subscription") 

ReturnFileName = Request.querystring("ReturnFileName") 
Update = Request.querystring("Update") 
PeopleID = request.querystring("PeopleID")
Message = request.querystring("Message")
Membership = request.querystring("Membership")
PeopleFirstName = request.querystring("PeopleFirstName") 
PeopleLastName = request.querystring("PeoplelastName") 
Owners = Request.querystring("Owners")
BusinessName = Request.querystring("BusinessName")
BusinessWebsite = Request.querystring("BusinessWebsite")
PeopleEmail  = Request.querystring("PeopleEmail")

EmailsMatch = Request.querystring("EmailsMatch")

SpecialChecterFound = Request.querystring("SpecialChecterFound")
ConfirmEmail = Request.querystring("ConfirmEmail")
%>



<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>



<div class = "container roundedtopandbottom mx-auto" style="max-width:450px" >
<div class = "col" >
    <h1>Add An Account (Busines / Organization)</h1>


<form name=form method="post" action="SetupAccountPlusstep2.asp?BusinessTypeID=<%=BusinessTypeID %>&Subscription=<%=Subscription%>"> 

<% if (len(PeopleFirstName) < 1 or len(PeopleLastName) < 1 or len(PeopleEmail)) and stepback = "True" then %>
<font color = "maroon"><b>You are mising some needed information.</b></font>
<% end if %>

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

    <label for="BusinessTypeID">Account Type</label>
    <select name="BusinessTypeID" class="form-control" required style: "width =50px">
    <%  if len(CurrentBusinessType) > 1 then %>
        <option value=<%=BusinessTypeID %> selected><%=CurrentBusinessType %></option>
    <% else %>
        <option ></option>
    <% end if %>

<% sql = "select * from [dbo].[businesstypelookup] order by BusinessType"
    rs.Open sql, conn, 3, 3   
    while Not rs.eof %>
       <option value="<%=rs("BusinessTypeID")%>"><%=rs("BusinessType")%></option>
    
    <% rs.movenext
    wend
    rs.close
    
    %>

</select>  

</div>


<div class="form-group"><br />
    <label for="BusinessName">Business / Org. Name <font color= "#abacab">(Optional)</font></label><br />
    <input type="Text" name="BusinessName"  class="formbox" id="BusinessName" Value ="<%=BusinessName%>" size="50">
</div>


<div class="form-group"><br />
    <label for="BusinessWebsite">Website <font color= "#abacab">(Optional)</font></label><br />
    <input type="Text" name="BusinessWebsite" class="formbox" id="BusinessWebsite" Value ="<%=BusinessWebsite%>" size ="50">
</div>



  

<input name="website" type = "hidden"  value = "<%=website%>">
<input name="Update"  type= "hidden" value = "<%=Update%>">
<input name="Membership"  type= "hidden" value = "<%=Membership%>">

<br />
	<input type=submit value="Next" class = "regsubmit2">


	</form><br><br>
</div>
<br>
</div>
<br>
<!--#Include virtual="/members/MembersFooter.asp"--> </body>
</HTML>