<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include File="membersGlobalVariables.asp"--> 
</head>
<body >
<!--#Include file="membersHeader.asp"--> 
	<br /><br />
<div class ="Container roundedtopandbottom">
<div class = row>
   <div class="col body">
	   <h1>Contact Global Grange Inc.</h1>
If you would like to learn more about Global Grange Inc. and our services please contact at:<br /><br />

		
<FORM NAME="ContactUsForm" ACTION="MembersContactUsConfirm.asp" METHOD="POST" onsubmit="javascript:return ValidForm(this)">	
	<input name="_recipients" type="hidden" value="ContactUs@GlobalGrange.world">
    	<input name="_subjectField" type="hidden" value="name">
	<input name="_subject" type="hidden" value=":&nbsp;Contact&nbsp;Us">
    	<input name="_replyToField" type="hidden" value="email">
	<input name="_requiredFields" type="hidden" value= 
		"First_Name,Last_Name,Business_Name,Email">
		
           			
<% Message = request.querystring("Message")
if len(Message) > 1 then%>
<font color = "maroon"><b><%=Message %></b></font>
<% end if %>
            			
<font color="maroon">*</font>First Name</br>
<INPUT TYPE="TEXT" NAME="FName" style="width: 300px; text-align: left" class='formbox'></br>

</div>
</div>
<%=HSpacer %>
<div class = row>
   <div class="col body">

<font color="maroon">*</font>Last Name</br>
<INPUT TYPE="TEXT" NAME="LName" style="width: 300px; text-align: left" class='formbox'></br>
</div>
</div>
<%=HSpacer %>
<div class = row>
   <div class="col body">

Business Name</br>
<INPUT TYPE="TEXT" NAME="BizName" style="width: 300px; text-align: left" class='formbox'></br>

</div>
</div>
<%=HSpacer %>
<div class = row>
   <div class="col body">
Email<br />
<INPUT TYPE="TEXT" NAME="Email" style="width: 300px; text-align: left" class='formbox'></br>

</div>
</div>
<%=HSpacer %>
<div class = row>
   <div class="col body">

<font color="maroon">*</font>Questions<br />
<TEXTAREA NAME="CommentText" cols="40" rows="3" class ="roundedtopandbottom" wrap="VIRTUAL"></textarea>
                    		
<% 
' begin random function
randomize

' random numbers is the varible that will contain a numeriv value
' between one and nine
random_number=int(rnd*10)
Select Case random_number
Case 0
 MIMage = "https://www.globallivestocksolutions.com/images/X987045.jpg"
Case 1 
 MIMage = "https://www.globallivestocksolutions.com/images/X583198.jpg"
 Case 2 
 MIMage = "https://www.globallivestocksolutions.com/images/X949256.jpg"
 Case 3 
 MIMage = "https://www.globallivestocksolutions.com/images/X096367.jpg"
 Case 4 
 MIMage = "https://www.globallivestocksolutions.com/images/X583198.jpg"
 Case 5 
 MIMage = "https://www.globallivestocksolutions.com/images/X912578.jpg"
Case 6 
 MIMage = "https://www.globallivestocksolutions.com/images/X234697.jpg"
Case 7 
 MIMage = "https://www.globallivestocksolutions.com/images/X781736.jpg"
Case 8 
 MIMage = "https://www.globallivestocksolutions.com/images/X987834.jpg"
Case 9 
 MIMage = "https://www.globallivestocksolutions.com/images/X983999.jpg"
End Select

' write the random number out to the browser

%>

</div>
</div>
<%=HSpacer %>
<div class = row>
   <div class="col body">
<b>Math Question</b><br />
Please answer the simple question below so we know that you are a human not a spambot.</br>
<img src = "<%=MIMage %>">
<INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>">
<INPUT TYPE="TEXT" NAME="fieldX" size="3" class = formbox><font color="maroon">*</font>
</div>
</div>
<%=HSpacer %>
<div class = row>
   <div class="col body">
<center><input type="submit" value="Submit" class = "regsubmit2"></center>
<INPUT TYPE="TEXT" NAME="Shoesize" size="1" class = "shoes">
</form><br />
</div>
</div>

</div>
<!--#Include file="membersFooter.asp"-->
</body>
</html>