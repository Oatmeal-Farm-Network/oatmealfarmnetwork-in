<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <% MasterDashboard= True %>
    <!--#Include virtual="/Members/Membersglobalvariables.asp"-->
<title>Contact Us | Oatmeal Farm Network</title>
<meta name="description" content="Have questions or inquiries for Oatmeal Farm Network? Get in touch with us via phone, email, or our online contact form. Our team is here to assist you with any queries or feedback." />
<meta name="keywords" content="contact us, Oatmeal Farm Network, inquiries, questions, feedback, phone, email, contact form" />
<meta name="author" content="Oatmeal Farm Network" />
<meta property="og:title" content="Contact Us | Oatmeal Farm Network" />
<meta property="og:description" content="Have questions or inquiries for Oatmeal Farm Network? Get in touch with us via phone, email, or our online contact form. Our team is here to assist you with any queries or feedback." />
<meta property="og:type" content="website" />
<meta property="og:url" content="https://www.OatmealFarmNetwork.com/Contactus.asp" />
<meta property="og:image" content="https://www.OatmealFarmNetwork.com/images/globalgrange-contactus.jpg" />
<meta property="og:image:alt" content="Oatmeal Farm Network Contact Us" />
<meta property="og:site_name" content="Oatmeal Farm Network" />
<meta name="twitter:title" content="Contact Us | Oatmeal Farm Network" />
<meta name="twitter:description" content="Have questions or inquiries for Oatmeal Farm Network? Get in touch with us via phone, email, or our online contact form. Our team is here to assist you with any queries or feedback." />
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:image" content="https://www.OatmealFarmNetwork.com/images/globalgrange-contactus.jpg" />
<meta name="twitter:image:alt" content="Oatmeal Farm Network Contact Us" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
</head>
<body >
<!--#Include virtual="/Members/MembersHeader.asp"-->
 
 <% ' lg+ navigation  %>
    <div class="container-fluid " style="max-width: 1300px; min-height: 67px; background-color:white;">
 <div >
   <div class ="text-center parent-div">
    <h1>Contact Us</h1>
<br />	
<br />
<div class ="roundedtopandbottom nested-div mx-auto" style="max-width: 500px; min-height: 67px; ">
		
<FORM NAME="ContactUsForm" ACTION="ContactUsConfirm.asp" METHOD="POST" onsubmit="javascript:return ValidForm(this)">	
    	<input name="_subjectField" type="hidden" value="name">
	<input name="_subject" type="hidden" value=":&nbsp;Contact&nbsp;Us">
    	<input name="_replyToField" type="hidden" value="email">
	<input name="_requiredFields" type="hidden" value= 
		"First_Name,Last_Name,Business_Name,Email">
		
	           			
<% Message = request.querystring("Message")
FName=Request.querystring("FName")
LName=Request.querystring("LName")
BizName=Request.querystring("BizName")
Email=Request.querystring("Email")
CommentText=Request.querystring("CommentText")
if len(Message) > 1 then%>
<font color = "Red"><b><%=Message %></b></font><br />

<% end if %>
<small><br /></small>
<div align ="left"><font color="maroon">*</font>First Name</div>
<INPUT TYPE="TEXT" NAME="FName" value = "<%=FName %>" class = "FormBox" size="45" style="text-align:left">
<div align ="left"><font color="maroon">*</font>Last Name</div>
<INPUT TYPE="TEXT" NAME="LName" value = "<%=LName %>" class = "FormBox"size="45" style="text-align:left">
<div align ="left">Business Name</div>
    <INPUT TYPE="TEXT" NAME="BizName" value = "<%=BizName %>" class = "FormBox" size="45" style="text-align:left"></br>
<div align ="left">Email</div>
<INPUT TYPE="TEXT" NAME="Email" value = "<%=Email %>" class = "FormBox" size="45" style="text-align:left">
<div align ="left"><font color="maroon">*</font>Comments & Questions</div>
<TEXTAREA NAME="CommentText" cols="48" rows="6" wrap="VIRTUAL" style="text-align:left" ><%= CommentText%></textarea>
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

%></br>
<b>Math Question</b></br>
Please answer the simple question below so we know that you are a human not a robot.</br>
<center>
</br>
    
<table >
    <tr>
        <td>
            <img src = "<%=MIMage %>" align = "Left" height ="32px">
            <INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>" >
        </td>
        <td width ="100px" align ="center">
            <INPUT TYPE="TEXT" NAME="fieldX" size="3" >
        </td>
        <td >
           <input type="submit" value="Submit" class = "regsubmit2"></center>
<INPUT TYPE="TEXT" NAME="Shoesize" size="1" class = "shoes" style="display: none;">
        </td>
    </tr>
</table>    
</form><br /></div>
<br />
</div></div></div>

<br />
<!--#Include virtual="/Members/MembersFooter.asp"-->
</div>
</body>
</html>