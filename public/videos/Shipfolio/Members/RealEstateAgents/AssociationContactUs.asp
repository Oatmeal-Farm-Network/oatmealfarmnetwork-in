<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<% SetLocale("en-us") 
AssociationID=Request.Form("AssociationID") 
If Not Len(AssociationID)> 0 Then 
	AssociationID=Request.QueryString("AssociationID") 
End if
If len(AssociationID) < 1 then
	'Response.Redirect("/Alpacaassociations/default.asp")
End if	
CurrentassociationID = AssociationID
'response.write("CurrentassociationID=" & CurrentassociationID)
Query =  "Select distinct * from Associations where AssociationID=" & CurrentAssociationID 
rs.Open Query, conn, 3, 3
if not rs.eof then 
AssociationName = rs("AssociationName")
AssociationAcronym = rs("AssociationAcronym")
Associationwebsite = rs("Associationwebsite")
AssociationEmailaddress = rs("AssociationEmailaddress")
AssociationStreet1 = rs("AssociationStreet1")
AssociationStreet2= rs("AssociationStreet2")
AssociationCity = rs("AssociationCity")
AssociationState = rs("AssociationState")
AssociationZip = rs("AssociationZip")
AssociationCountry = rs("AssociationCountry")
AssociationPhone = rs("AssociationPhone")
Logo = rs("AssociationLogo")
AssociationLogo = Logo
AssociationDescription= rs("AssociationDescription")
AssociationContactName = rs("AssociationContactName")
AssociationPassword= rs("AssociationPassword")
AssociationContactPosition= rs("AssociationContactPosition")
AssociationContactEmail= rs("AssociationContactEmail")
AssociationShowaddress = rs("AssociationShowaddress")
AssociationDescription = rs("AssociationDescription")
'response.write("AssociationShowaddress=" & AssociationShowaddress )
end if
%>
<meta property="og:image" content="<%=AssociationLogo %>" />
<title><%= AssociationName %></title>
<meta name="title" content="<%= AssociationName %>">
<meta name="robots" content="follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="never">
<meta name="Googlebot" content="follow">
<meta name="robots" content="none">


<link rel="canonical" href="<%=currenturl %>" />
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="<%= AssociationName %> - Profile at LivestockOfTheWorld.com" />
<meta property="og:description" content="<%=left(AssociationDescription, 160)%>" />
<meta property="og:url" content="<%=currenturl %>" />
<meta property="og:site_name" content="Livestock Of The World" />

<meta property="og:image:alt" content="<%=AssociationName %>" />
<meta property="og:image:width" content="300" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content="<%=left(AssociationDescription, 160)%>[&hellip;]" />
<meta name="twitter:title" content=<%= AssociationName %>" />




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
            alert('You have not entered an E-mail address')
            form.Email.focus();
            return false;
        }

        return true;
    }
</script>

</HEAD>
<body >


<% 
session("LoggedIn") = False%>
<!--#Include virtual="/Header.asp"-->

<div class="container-fluid" id="grad1">
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>&nbsp;<%=AssociationName%></h1><br />
          </div>
        </div>
    </div>
    </div>
 </div>



<div class="container-fluid" align = center style="max-width: 1000px; min-height: 67px; ">
      <div class = "row">
        <div class = "col body">
            <br />
<% If Len(Logo) > 2 then%>
<div class="featured-image" align = center><img src = "<%=Logo%>"  alt="<%=AssociationName%>" width = "400"></div>
<% End If %>




<% if len(AssociationStreet1) > 1 then %>
    <%= AssociationStreet1 %><br />
<% end if %>
<% if len(AssociationStreet2) > 1 then %>
    <%= AssociationStreet2 %><br />
<% end if %>
<%=AssociationCity %>&nbsp;<%=AssociationState %> 
    <% if len(AssociationCountry) > 1 then %>
      &nbsp; <%=AssociationCountry%>
     <% end if %>
&nbsp;<%=AssociationZip %>
<br />
<% If Len(AssociationPhone) > 1 Then %>
Phone <%=AssociationPhone%><br>
<% End If %>

<% if len(AssociationWebsite) > 1 then %>
<a href = "http://<%=AssociationWebsite  %>" class = "body" target = "blank"><%=AssociationWebsite  %></a><br>
<% end if %>

<br />

<div align = "left"><%=AssociationDescription %></div><br /><br />

<a name="Contact"></a>
<h3><center>Contact <%=AssociationName%></center></h3>
<font color = "<%=PageTextColor%>">
<% if len(AssociationEmailaddress) > 7 Then %>
<% Message = request.querystring("Message")
if len(Message) > 1 then%>
<font color = "red"><b><%=Message %></b></font>
<% end if %>
<table align = center width = 480>
<tr>
   <td class = body>
<form  name=form method="post" action="AssociationContactUsSendEmail.asp" onsubmit="javascript:return ValidForm(this)">

<INPUT TYPE="hidden" NAME="AnimalName"  Value = "<%=Name%>" size="45">
	<INPUT TYPE="hidden" NAME="CurrentAssociationID"  Value = "<%=CurrentAssociationID%>" size="45">
<br />
First Name<font color = maroon>*</font><br />
<input name="FirstName" size = "40" class = "formbox">
<br />Last Name<font color = maroon>*</font><br />
 <input name="LastName" size = "40" class = "formbox">
<br />Email<font color = maroon>*</font> <br />
  	<INPUT TYPE="TEXT" NAME="Fieldname2" size = "40" class = "formbox">
<br />Phone# <br />
 
  	<INPUT TYPE="TEXT" NAME="Fieldname0" size = "40" class = "formbox">
<br />Questions<br />

	  <TEXTAREA NAME="Fieldname1" cols="42" rows="13" wrap="file" class = "formbox"></textarea>
<br />
  <% 
' begin random function
randomize

' random numbers is the varible that will contain a numeriv value
' between one and nine
random_number=int(rnd*10)
Select Case random_number
Case 0
 MIMage = "https://www.GlobalLivestockSolutions.com/images/X987045.jpg"
Case 1 
 MIMage = "https://www.GlobalLivestockSolutions.com/images/X583198.jpg"
 Case 2 
 MIMage = "https://www.GlobalLivestockSolutions.com/images/X949256.jpg"
 Case 3 
 MIMage = "https://www.GlobalLivestockSolutions.com/images/X096367.jpg"
 Case 4 
 MIMage = "https://www.GlobalLivestockSolutions.com/images/X583198.jpg"
 Case 5 
 MIMage = "https://www.GlobalLivestockSolutions.com/images/X912578.jpg"
Case 6 
 MIMage = "https://www.GlobalLivestockSolutions.com/images/X234697.jpg"
Case 7 
 MIMage = "https://www.GlobalLivestockSolutions.com/images/X781736.jpg"
Case 8 
 MIMage = "https://www.GlobalLivestockSolutions.com/images/X987834.jpg"
Case 9 
 MIMage = "https://www.GlobalLivestockSolutions.com/images/X983999.jpg"
End Select

' write the random number out to the browser

%>
<br />
    <b>Math Question</b>
      Please answer the simple question below so we know that you are a human.
<br />
	<img src = "<%=MIMage %>">
	<INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>">
	<INPUT TYPE="TEXT" NAME="fieldX" size="3" class = "formbox">*
<br />
     
    <input type="hidden" value="<%=AssociationName %>" name = "AssociationName">
    <input type="hidden" value="<%=AssociationEmailaddress %>" name = "AssociationEmailaddress">

    
	<div align = center><input type="submit" value="Submit" class = "regsubmit2" align = center></div>           
  	<INPUT TYPE="TEXT" NAME="Shoesize" size="1" class = "shoes">


</form><br />
       <% End If %></font>


</div></div></div>
<!--#Include virtual="/Footer.asp"-->
</body>
</html>