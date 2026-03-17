<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<% 	  PWYCOffer= Request.form("PWYCOffer") %>
 <!--#Include virtual="/GlobalVariables.asp"-->
<title>Make a Pay What You Can Offer</title>
<meta name="Title" content="<%=Name%> - <%= BusinessName %>"/>
<meta name="description" content="<%=Name%> - <%=signularanimal %> For Sale by <%=BusinessName%> . <%=BusinessName%> is a <%=StateName%> <%=signularanimal %> ranch." />
<meta name="robots" content="index, follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1 day"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subject" content="<%=Category %> Animals " />
<link rel="stylesheet" type="text/css" href="/style.css">

<SCRIPT LANGUAGE="JavaScript">
function verify() {
var themessage = "Please fill out the following fields: \r";
if (document.form.FirstName.value=="") {
themessage = themessage + " -First Name \r";
}
if (document.form.LastName.value == "") {
    themessage = themessage + " -Last Name \r";
}

if (document.form.Fieldname2.value == "") {
    themessage = themessage + " -Email \r";
}

if (document.form.fieldX.value == "") {
    themessage = themessage + " -Math Question \r";
}

//alert if fields are empty and cancel form submit
if (themessage == "Please fill out the following fields: \r") {
document.form.submit();
}
else {
alert(themessage);
return false;
   }
}
//  End -->
</script>


<% 
sql = "select * from RanchSiteDesign where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof Then
MenuBackgroundColor = rs("MenuBackgroundColor")
MenuColor = rs("MenuColor")
MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
TitleColor = rs("TitleColor")
PageBackgroundColor = rs("PageBackgroundColor")
PageTextColor = rs("PageTextColor")
LayoutStyle = rs("LayoutStyle")
PageTextMouseOverColor = rs("PageTextMouseOverColor")
End If
rs.close 
%>
<style>
H1 {font: 24pt arial; color: <%=TitleColor %>}
H2 {font: 20pt arial; color: <%=TitleColor %>}
H3 {font: 18pt arial; color: <%=TitleColor %>}
.Body {font: 10pt arial; color: <%=PageTextColor %>}
A.Body {font: 10pt arial; color: <%=PageTextColor %>}
A.Body:hover { color: <%=PageTextMouseOverColor%>}
.Heading {font: 10pt arial; color: <%=MenuColor %>}
A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}
</style>
<%Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select  People.* from People where People.PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
WebLink = rs("WebLink")
PeopleFirstName = rs("PeopleFirstName")
PeopleMiddleInitial  = rs("PeopleMiddleInitial")
PeopleLastName= rs("PeopleLastName")
rs.close
End If 
%>
<!--#Include virtual="/Ranches/DetailDBInclude.asp"--> 
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<!--#Include file="RanchHeader.asp"-->
<a name = "top"></a>
<%Current3 = "Animals" %>
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<a name = "top"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Make an Offer Stud Breeding <%=Name%></div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center" width = "720" border = "0"><tr><td   valign="top" width = "420"  align = "left" class = "body">
	<% HidePWYC = True %>	<!--#Include file="StudGeneralStatsInclude.asp"-->
</td>
<td class = "body" valign = "top"  width = "300">
<table width = "300" ><tr><td align = "center" width = "300" >
<% if noimage = true then%>
		<%=click%>
<% else %>
	<IMG alt="main image" border=0  name=but1 src="<%=buttonimages(1)%>" align = "center" height = "200">
<% end if%>
</td></tr>

<% if len(ARIPhoto) > 1 or len(HistogramPhoto) > 1 then %>

     <tr><td>
     
     <% if len(ARIPhoto) > 1  then %>
       <a href = "<%=ARIPhoto%>" class= "body" target = "_blank"><img src = "images/ARIThumb.jpg" border = "0" height = "50"></a>
     <% end if %>
     <% if len(HistogramPhoto) > 1 then %>
      <a href = "<%=HistogramPhoto%>" class= "body" target = "_blank"><img src = "images/HistogramThumb.jpg" border = "0" height = "50"></a>
	<% end if %>
     </td>
     </tr>
    
     

<%

end if
	if not rsA.eof then 
	 rsA.movefirst
	counter = 0
	counttotal = 8 
	%>
	<tr><td width = "300" align = "center"><table>
	<% 
	While counter < counttotal and TotalPics > 1
	  counter = counter +1
	  'response.write(buttonimages(counter))
	  If Len(buttonimages(counter)) > 11 then
		if counter = 1 or counter = 5 then
		%>
            <tr>
        <% end if %>
		
			
			<td valign = "top" align = "center" class = "small">
			<font 
			onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
			onMouseOut="img<%=counter%>('but1')"  class = "menu">
			<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br><% If Len(buttontitle(counter)) > 2 Then %>
				<small><%=buttontitle(counter)%></small>
			<% End If %></font>
			</td>

	 <% counter = counter +1 %>

			<td valign = "top" align = "center" class = "small">

			<% If Len(buttonimages(counter)) > 2 then%>
			<font 
			onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
			onMouseOut="img<%=counter%>('but1')"  class = "menu">
			<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
			<% If Len(buttontitle(counter)) > 2 Then %>
				<small><%=buttontitle(counter)%></small>
			<% End If %>
			</font>
			<% End If %>
			</td>

<% if counter = 4 then
		%>
            </tr>
        <% end if %>
        <% end if %>
		<% wend %>
	  </table>
	  </td>
	  </tr>
 	 </table>
         <% end if %>	
		<!'--#Include virtual="/includefiles/ServiceSireInclude.asp"-->
</td>
</tr></table>

<blockquote>
<div align = "left">
Please enter your your contact information below then select the submit button. That will generate an e-mail that will be sent to the Alpaca's owner. It will then be up to the seller to contact you and for you and the seller to work out the details of the deal. <b>Livestock Of America is not responsible for the negotiation of the stud breeding.</b></div><br><br>
</blockquote>
<br>
<form  name=form method="post" action="PWYCOfferSendEmail.asp?ID=<%=ID %>&CurrentPeopleID=<%=CurrentPeopleID %>">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
				<tr> 
                  	<td colspan="4" align="center" width="536" class = "body"> 
                    		( &quot;*&quot; indicates required field)</i>
                <INPUT TYPE="hidden" NAME="AnimalName"  Value = "<%=Name%>" size="45">
					<INPUT TYPE="hidden" NAME="CurrentPeopleID"  Value = "<%=CurrentPeopleID%>" size="45">
                  	</td>
                </tr>
	
			<tr> 
			<td width="150" height="20" class = "body" align = "right" valign = "top">Offer:</td>
			<td width="450" height="20" class = "body" valign = "top" align = "left"> 
 					$<input NAME="PWYCOffer" value = "<%=PWYCOffer %>" type = "text"><b></b>
					
				 </td>
			</td>
		</tr>
		<tr> 
			<td width="150" height="20" class = "body" align = "right">First Name:*</td>
			<td width="450" height="20" class = "body" align = "left"> 
				<input name="FirstName" size = "40">
				 </td>
			</td>
		</tr>
		<tr> 
			<td width="150" height="20" class = "body" align = "right">Last Name:*</td>
			<td width="450" height="20" class = "body" align = "left"> 
 						<input name="LastName" size = "40">
				 </td>
			</td>
		</tr>
         	<tr> 
                	<td  height="20" class = "body" align = "right"> City: </td>
                	<td  height="20" class = "body" align = "left"> 
                    		<INPUT TYPE="text" NAME="Fieldname6" size="45">
                	</td>
            	</tr>
            	<tr> 
                	<td  height="20" class = "body" align = "right"> State:  </td>
                	<td  height="20" class = "body" align = "left">
                    		<INPUT TYPE="TEXT" NAME="Fieldname5" size="5">
							
					 &nbsp; &nbsp;Postal Code:  &nbsp;
                 		<INPUT TYPE="TEXT" NAME="Fieldname4" size="5">
                	</td>
            	</tr>
		
            	<tr> 
                	<td height="20" class = "body" align = "right">Email*: </td>
                	<td  height="20" class = "body" align = "left"> 
                    		<INPUT TYPE="TEXT" NAME="Fieldname2" size="45">
                    		 </td>
                	</td>
            	</tr>
				<tr> 
                	<td height="20" class = "body" align = "right">Phone#: </td>
                	<td  height="20" class = "body" align = "left"> 
                    		<INPUT TYPE="TEXT" NAME="Fieldname0" size="45">
                    		 </td>
                	</td>
            	</tr>
            	<tr> 
                	<td  height="1"  class = "body" align = "right" valign = "top">Comments:</td>
					<td class = "body" valign = "top" align = "left">
	                    	<TEXTAREA NAME="Fieldname1" cols="50" rows="10" wrap="file"></textarea>
                    		
                	</td>
            	</tr>
<tr>
     <td class = "body" colspan = "2">
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
            	  <b>Math Question</b>
            	  Please answer the simple question below so we know that you are a human.</td>
            	</tr> 
				<tr> 
                	<td height="20" class = "body2" align = "right"><img src = "<%=MIMage %>"></td>
                	<td  height="20" class = "body2" align = "left"> 
                	<INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>">
	                 		<INPUT TYPE="TEXT" NAME="fieldX" size="3">*
	     
                    </td>
            	</tr>
<tr>
	<td  align = "center" colspan = "2"><input NAME="Shoesize" size="1" type ="text" class="shoes">
		<input type=button value="Submit" class = "regsubmit2" onclick="verify();">


		</td>
</tr>
</table>
	</form>
</td>
	</tr>
</table>

</td>
	</tr>
</table>
<br /><br />
<!--#Include virtual="/Footer.asp"--> 

</body>
</html>