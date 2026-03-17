<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--#Include file="AssociationGlobalVariables.asp"-->
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
<title><%= AssociationName %></title>
<meta name="title" content="<%= AssociationName %>">
<meta name="robots" content="nofollow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="never">
<meta name="Googlebot" content="nofollow">
<meta name="robots" content="none">
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
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?AssociationID=<%=AssociationID %>&Screenwidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>

<% Current = "CreateAccount"
Current3="Directory"
CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False%>
<% 
Current1 = "AssociationHome"
Current2="AssociationHome" %> 
<!--#Include file="AssociationHeader.asp"-->

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<tr><td class = "roundedtopandbottom" align = "left" valign = "top" width = "100%">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<% If Len(Logo) > 2 then%>
<tr><td colspan = "2" align = "center"><img src = "<%=Logo%>" align = "center"  height = "120"></td></tr>
<% End If %>
<tr><td align = "left">
<H1><div align = "left"><%=AssociationName%></div></H1>


<% if len(AssociationStreet1) > 1 then %>
    <%= AssociationStreet1 %><br />
<% end if %>
<% if len(AssociationStreet2) > 1 then %>
    <%= AssociationStreet2 %><br />
<% end if %>
<%=AssociationCity %> &nbsp;<%=AssociationState %> 
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

<%=AssociationDescription %><br /><br />
</td></tr>
<tr><td align = "left">
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  >
<tr><td  class = "body" valign = "top">
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" width = '100%' >

<tr>
<td class = "body2" colspan = "2" align = 'center'>




</td></tr></table>
</td></tr>
<tr><td class = "body2">
<a name="Contact"></a>
<h3><center>Contact <%=AssociationName%></center></h3>

<font color = "<%=PageTextColor%>">
<% if len(AssociationEmailaddress) > 7 Then %>
<% Message = request.querystring("Message")
if len(Message) > 1 then%>
<font color = "red"><b><%=Message %></b></font>
<% end if %>
<form  name=form method="post" action="AssociationContactUsSendEmailAdmin.asp" onsubmit="javascript:return ValidForm(this)">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 width = "500">
<tr> 
<td colspan="4" align="center" width="470" class = "body"> 
  	<center>( &quot;*&quot; indicates required field)</i></center>
<INPUT TYPE="hidden" NAME="AnimalName"  Value = "<%=Name%>" size="45">
	<INPUT TYPE="hidden" NAME="CurrentAssociationID"  Value = "<%=CurrentAssociationID%>" size="45">
</td>
</tr>
<tr> 
	<td width="200" height="20" class = "body2" align = "right">First Name:*</td>
	<td  height="20" class = "body2" align = "left"> 
<input name="FirstName" size = "40" class = "formbox">
 </td>
	</td>
</tr>
<tr> 
	<td  height="20" class = "body2" align = "right">Last Name:*</td>
	<td  height="20" class = "body2" align = "left"> 
 <input name="LastName" size = "40" class = "formbox">
 </td>
	</td>
</tr>
<tr> 
	<td height="20" class = "body2" align = "right">Email:* </td>
	<td  height="20" class = "body" align = "left"> 
  	<INPUT TYPE="TEXT" NAME="Fieldname2" size = "40" class = "formbox">
  	 </td>
	</td>
</tr>
<tr> 
	<td height="20" class = "body2" align = "right">Phone#: </td>
	<td  height="20" class = "body" align = "left"> 
  	<INPUT TYPE="TEXT" NAME="Fieldname0" size = "40" class = "formbox">
  	 </td>
</tr>
<tr> 
	<td  height="1"  class = "body2" align = "right" valign = "top">Questions:</td>
	<td class = "body" valign = "top" align = "left">
	  <TEXTAREA NAME="Fieldname1" cols="42" rows="13" wrap="file" class = "formbox"></textarea>
	</td>
</tr>
  <% 
' begin random function
randomize

' random numbers is the varible that will contain a numeriv value
' between one and nine
random_number=int(rnd*10)
Select Case random_number
Case 0
 MIMage = "/images/X987045.jpg"
Case 1 
 MIMage = "/images/X583198.jpg"
 Case 2 
 MIMage = "/images/X949256.jpg"
 Case 3 
 MIMage = "/images/X096367.jpg"
 Case 4 
 MIMage = "/images/X583198.jpg"
 Case 5 
 MIMage = "/images/X912578.jpg"
Case 6 
 MIMage = "/images/X234697.jpg"
Case 7 
 MIMage = "/images/X781736.jpg"
Case 8 
 MIMage = "/images/X987834.jpg"
Case 9 
 MIMage = "/images/X983999.jpg"
End Select

' write the random number out to the browser

%>
<tr><td class = "body" colspan = "2">
    <b>Math Question</b>
      Please answer the simple question below so we know that you are a human.
</td></tr> 
<tr> 
	<td height="20" class = "body2" align = "right"><img src = "<%=MIMage %>"></td>
	<td height="20" class = "body"> 
	<INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>">
	<INPUT TYPE="TEXT" NAME="fieldX" size="3" class = "formbox">*
    </td>
</tr>
<tr> 
	<td align=center colspan="4" width="550" class = "body2">
     
    <input type="hidden" value="<%=AssociationName %>" name = "AssociationName">
    <input type="hidden" value="<%=AssociationEmailaddress %>" name = "AssociationEmailaddress">

    
	<input type="submit" value="Submit" class = "regsubmit2">           
  	<INPUT TYPE="TEXT" NAME="Shoesize" size="1" class = "shoes">
	</td>
           	</tr>
	</table>
</form><br />
       <% End If %></font>
  </td>
	</tr>
</table>

</td>

	</tr>
</table>

</td>
</tr>
</table>
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>