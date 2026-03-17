<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--#Include virtual="/Members/Membersglobalvariables.asp"-->
<% SetLocale("en-us") 
BusinessID=Request.Form("BusinessID") 
If Not Len(BusinessID)>1 Then 
BusinessID=Request.QueryString("PeopleID") 
End if
If Not Len(BusinessID)>1 Then 
BusinessID=Request.QueryString("CurrentBusinessID") 
End if

BusinessID=Request.Form("BusinessID") 
If Not Len(BusinessID)>1 Then 
	BusinessID=Request.QueryString("BusinessID") 
End if


CurrentBusinessID = BusinessID
'response.write("CurrentBusinessID=" & CurrentBusinessID)
Query =  "Select  * from People, business, BusinessAccess where BusinessAccess.PeopleID = People.PeopleID and BusinessAccess.BusinessID=" & BusinessID 
'response.write("Query = " & Query )
rs.Open Query, conn, 3, 3
if not rs.eof then 
PeopleID=rs("PeopleID")
CurrentPeopleID = PeopleID



PeopleFirstName = rs("PeopleFirstName")
PeopleLastName = rs("PeopleLastName")
PeopleEmail = rs("PeopleEmail")
WebsitesID  = rs("WebsitesID")
PeoplePhone = rs("PeoplePhone")
PeopleFax = rs("PeopleFax")
PeopleShowaddress = rs("PeopleShowaddress")
BusinessID = rs("BusinessID")
Logo = rs("Logo")

end if
rs.close


Query =  "Select  * from Business where BusinessID=" & BusinessID 
'response.write("Query = " & Query )
rs.Open Query, conn, 3, 3
if not rs.eof then 
PageTitle = rs("RanchHomeHeading")
RanchHomeText = rs("RanchHomeText") & rs("RanchHomeText2")

BusinessName = rs("BusinessName")
BusinesswebsiteID = rs("BusinesswebsiteID")
BusinessEmail = rs("BusinessEmail")
BusinessHours = rs("BusinessHours")
PhoneID= rs("PhoneID")
BusinessAddressID = rs("AddressID")
BusinessLogo = rs("BusinessLogo")

BusinessLinkedIn= rs("BusinessLinkedIn")
BusinessFacebook= rs("BusinessFacebook")
BusinessX= rs("BusinessX")
BusinessInstagram= rs("BusinessInstagram")
BusinessPinterest= rs("BusinessPinterest")
BusinessTruthSocial= rs("BusinessTruthSocial")
BusinessBlog= rs("BusinessBlog")
BusinessYouTube= rs("BusinessYouTube")
BusinessOtherSocial1= rs("BusinessOtherSocial1")
BusinessOtherSocial2= rs("BusinessOtherSocial2")
'response.write("PeopleShowaddress=" & PeopleShowaddress )
end if

rs.close

if len(WebsitesID ) >1 then
Query =  "Select  * from websites where WebsitesID=" & WebsitesID 
'response.write("Query = " & Query )
rs.Open Query, conn, 3, 3
if not rs.eof then 
    FarmWebsite = rs("FarmWebsite")
end if
    rs.close
end if

if len(BusinessLogo) < 4 then
else
   Logo=BusinessLogo
end if







%>
<meta property="og:image" content="<%=PeopleBusinessLogo %>" />
<title><%= BusinessName %></title>
<meta name="title" content="<%= PeopleName %>">
<meta name="robots" content="nofollow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="never">
<meta name="Googlebot" content="nofollow">
<meta name="robots" content="none">


<link rel="canonical" href="<%=currenturl %>" />
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="<%= PeopleName %> - Profile at AgriculturePeoples.world" />
<meta property="og:description" content="<%=left(PeopleDescription, 160)%>" />
<meta property="og:url" content="<%=currenturl %>" />
<meta property="og:site_name" content="Livestock Of The World" />

<meta property="og:image:alt" content="<%=PeopleName %>" />
<meta property="og:image:width" content="300" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content="<%=left(PeopleDescription, 160)%>[&hellip;]" />
<meta name="twitter:title" content=<%= PeopleName %>" />



<script>
<!--
    function filter(imagename, objectsrc) {
        if (document.images)
            document.images[imagename].src = eval(objectsrc + ".src")
    }
//-->
</script>

<script language="JavaScript">
    function IsEmpty(aTextField) {
        if ((aTextField.value.length == 0) ||
   (aTextField.value == null)) {
            return true;
        }
        else { return false; }
    }


    function ValidForm(form) {
        if (IsEmpty(form.FirstName)) {
            alert('You have not entered your first name')
            form.FName.focus();
            return false;
        }

        if (IsEmpty(form.LastName)) {
            alert('You have not entered your last name')
            form.LName.focus();
            return false;
        }


        if (IsEmpty(form.Fieldname2)) {
            alert('Please entered an Email address')
            form.Email.focus();
            return false;
        }

        return true;
    }
</script>

</HEAD>
<body >

   <!--#Include virtual="/members/membersHeader.asp"-->

<!--#Include virtual="/includefiles/RanchPagesTabsInclude.asp"-->
<br />

<div class="container-fluid" style="min-height: 67px; margin: 0 auto;">
  <div class="row justify-content-center">
    <!-- Left Column: Business Info & Text -->
    <div class="col-lg-7 col-md-7 col-sm-12" style="background-color:white; padding: 20px;">
      <% if len(BusinessName) >1 then %>
        <h2><Center><%=BusinessName %></Center></h2>
      <% end if %>
<%
' ASP logic for address and contact details
if len(BusinessAddressID)< 3 then
else
AddressID = BusinessAddressID
end if

if len(addressID) >1 then
Query =  "Select  * from Address where AddressID=" & BusinessAddressID
'response.write("Query = " & Query )
rs.Open Query, conn, 3, 3
if not rs.eof then
AddressStreet = rs("AddressStreet")
AddressApt= rs("AddressApt")
AddressCity = rs("AddressCity")
StateIndex = rs("StateIndex")
AddressZip = rs("AddressZip")
AddressCountry = rs("AddressCountry")
country_id = rs("country_id")
rs.close
end if
end if

 if rs.state >1 then rs.close

if len(country_id) >1 then
Query =  "select * from Country where country_id =" & country_id
'response.write("Query = " & Query )
rs.Open Query, conn, 3, 3
if not rs.eof then
    CountryName = rs("name")
end if
    rs.close
end if



'response.write("StateInde = " & StateIndex )
if len(StateIndex) >1 then
Query =  "select * from state_province where StateIndex =" & StateIndex
'response.write("Query = " & Query )
rs.Open Query, conn, 3, 3
if not rs.eof then
    StateName = rs("name")
end if
    rs.close
end if %>

        <% if len(AddressStreet1) > 1 then %>
                        <%= AddressStreet %><br />
                <% end if %>
                <% if len(AddressApt) > 1 then %>
                        <%= AddressApt %><br />
                <% end if %>
                <%=AddressCity %>,&nbsp;<%=StateName %>
<% if len(CountryName) > 1 then %>
 &nbsp;<%=CountryName %>
<% end if %>
                &nbsp;<%=AddressZip %>
                <br />

                    <% if len(PeoplePhone) > 1 then %>
                        Phone: <%=PeoplePhone %><br />
                <% end if %>

                <% if len(PeopleFax) > 1 then %>
                        Fax: <%=PeopleFax %><br />
                    <% end if %>


                <% if len( FarmWebsite) > 1 then
                    str1 = lcase(FarmWebsite)
                    str2 = "https://"
                    If InStr(str1,str2) >1 Then
                        FarmWebsite2=  Replace(str1, str2 , "")
                    else

                      FarmWebsite2 = FarmWebsite
                      FarmWebsite = "https://" & FarmWebsite
                    End If

                    %>
                <a href = "<%= FarmWebsite  %>" class = "body" target = "blank"><%= FarmWebsite2  %></a><br>
                <% end if %>

                    <%
                    If len(BusinessLinkedIn) > 9 then %>
                    <a href="<%=BusinessLinkedIn %>" target="_blank" class="body"><img src="https://www.OatmealFarmNetwork.com/icons/LinkedIcon.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessFacebook)  > 9 then %>
                    <a href="<%=BusinessFacebook %>" target="_blank" class="body"><img src="https://www.OatmealFarmNetwork.com/icons/facebook.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessX)  > 9 then %>
                    <a href="<%=BusinessX %>" target="_blank" class="body"><img src="https://www.OatmealFarmNetwork.com/icons/TwitterX.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessInstagram)  > 9 then %>
                    <a href="<%=BusinessInstagram %>" target="_blank" class="body"><img src="https://www.OatmealFarmNetwork.com/icons/instagramicon.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessPinterest)  > 9 then %>
                    <a href="<%=BusinessPinterest %>" target="_blank" class="body"><img src="https://www.OatmealFarmNetwork.com/icons/PinterestLogo.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessTruthSocial)  > 9 then %>
                    <a href="<%=BusinessTruthSocial %>" target="_blank" class="body"><img src="https://www.OatmealFarmNetwork.com/icons/Truthsocial.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessBlog) > 9 then %>
                    <a href="<%=BusinessBlog %>" target="_blank" class="body"><img src="https://www.OatmealFarmNetwork.com/icons/BlogIcon.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessYouTube)  > 9 then %>
                    <a href="<%=BusinessYouTube %>" target="_blank" class="body"><img src="https://www.OatmealFarmNetwork.com/icons/YouTube.jpg" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessOtherSocial1)  > 9 then %>
                    <a href="<%=BusinessOtherSocial1 %>" target="_blank" class="body"><img src="https://www.OatmealFarmNetwork.com/icons/GeneralSocialIcon.png" height=" 20" /></a>
                    <% end if %>

                    <%If len(BusinessOtherSocial2)  > 9 then %>
                    <a href="<%=BusinessOtherSocial2 %>" target="_blank" class="body"><img src="https://www.OatmealFarmNetwork.com/icons/GeneralSocialIcon.png" height=" 20" /></a>
                    <% end if %>
<br />
<h2 ><%=PageTitle %></h2>
 <div class ="body"><%=RanchHomeText%></div>
</div>
    <!-- Right Column: Contact Form -->
    <div class="col-lg-5 col-md-5 col-sm-12 body" style="background-color:white; padding: 20px;">
        <% if len(PeopleEmail) > 7 Then %>
        <br /><br /><br />
        <a name="Contact"></a>
<h3><center>Contact <%=PeopleName%></center></h3>
<font color = "<%=PageTextColor%>">

<% Message = request.querystring("Message")
if len(Message) > 1 then%>
<font color = "maroon"><b><%=Message %></b></font>
<% end if %>

<form  name=form method="post" action="PeopleContactUsSendEmail.asp?BusinessID=<%=BusinessID %>" onsubmit="javascript:return ValidForm(this)">

<INPUT TYPE="hidden" NAME="AnimalName"  Value = "<%=Name%>" size="45">
    <INPUT TYPE="hidden" NAME="CurrentPeopleID"  Value = "<%=CurrentPeopleID%>" size="45">
<br />
First Name<br />
<input name="FirstName" class = "formbox">
<br />Last Name<br />
 <input name="LastName" class = "formbox">
<br />Email<br />
    <INPUT TYPE="TEXT" NAME="Fieldname2" class = "formbox">
<br />Phone <font color="#abacab">(Optional)</font> <br />

    <INPUT TYPE="TEXT" NAME="Fieldname0" class = "formbox">
<br />Comments / Questions <font color="#abacab">(Optional)</font><br />

      <TEXTAREA NAME="Fieldname1" rows="13" wrap="file" class = "formbox"></textarea>
<br />
 <%
' begin random function
randomize

' random numbers is the varible that will contain a numeriv value
' between one and nine
random_number=int(rnd*10)
Select Case random_number
Case 0
  MIMage = "https://www.OatmealFarmNetwork.com/images/X987045.jpg"
Case 1
  MIMage = "https://www.OatmealFarmNetwork.com/images/X583198.jpg"
  Case 2
  MIMage = "https://www.OatmealFarmNetwork.com/images/X949256.jpg"
  Case 3
  MIMage = "https://www.OatmealFarmNetwork.com/images/X096367.jpg"
  Case 4
  MIMage = "https://www.OatmealFarmNetwork.com/images/X583198.jpg"
  Case 5
  MIMage = "https://www.OatmealFarmNetwork.com/images/X912578.jpg"
Case 6
  MIMage = "https://www.OatmealFarmNetwork.com/images/X234697.jpg"
Case 7
  MIMage = "https://www.OatmealFarmNetwork.com/images/X781736.jpg"
Case 8
  MIMage = "https://www.OatmealFarmNetwork.com/images/X987834.jpg"
Case 9
  MIMage = "https://www.OatmealFarmNetwork.com/images/X983999.jpg"
End Select

' write the random number out to the browser

%>
<br />
    <b>Math Question</b>
      Please answer the simple question below so we know that you are a human.
<br />
    <img src = "<%=MIMage %>">
    <INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>">
    <INPUT TYPE="TEXT" NAME="fieldX" size="2" class = "formbox2">*
<br />

    <input type="hidden" value="<%=PeopleName %>" name = "PeopleName">
    <input type="hidden" value="<%=PeopleEmailaddress %>" name = "PeopleEmailaddress">
        <input type="hidden" value="<%=BusinessName %>" name = "BusinessName">


    <br />
    <div align = center><input type="submit" value="Submit" class = "regsubmit2" align = center></div>
    <INPUT TYPE="TEXT" NAME="Shoesize" size="1" class = "shoes">


</form><br />
        <% End If %></font>


    </div>
  </div>
</div>

<br />

<style>
    /* Custom styles for the form elements */
    .formbox {
        width: 100%; /* Make input fields and textareas take full width of their parent */
        box-sizing: border-box; /* Include padding and border in the element's total width and height */
        padding: 8px; /* Add some internal padding for better appearance */
        margin-bottom: 10px; /* Space between form elements */
        border: 1px solid #ccc; /* Subtle border */
        border-radius: 4px; /* Slightly rounded corners */
    }

    /* Adjust the size attribute on inputs to be removed as width: 100% will control it */
    input[type="text"].formbox,
    textarea.formbox {
        /* The size attribute is no longer needed when width: 100% is applied */
        /* For example, removed size="30" from text inputs and cols="32" from textarea */
    }

    /* Style for the submit button */
    .regsubmit2 {
        padding: 10px 20px;
        background-color: #507033; /* A green color */
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }

    .regsubmit2:hover {
        background-color: #3d5427; /* Darker green on hover */
    }

    /* Style for the hidden shoesize input, ensuring it doesn't affect layout */
    .shoes {
        display: none; /* Hide this field completely */
    }
</style>
<!--#Include virtual="/members/membersFooter.asp"-->
</body>
</html>