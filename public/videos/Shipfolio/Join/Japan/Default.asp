<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% Title= "Livestock Of Japan"
Description = "Join Livestock Of Japan. An online marketplace for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep."
currenturl = "https://www.LivestockOfTheWorld.com/join/Japan/"
Image = ""
 %>

<title><%=Title %></title>
<META name="description" content="<%=Description %>">
<meta name="author" content="Livestock Of The World">
<!--#Include Virtual="/includefiles/GlobalVariables.asp"-->

<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="join Livestock Of Japan." />
<meta property="og:description" content=<%=Description %> />
<meta property="og:url" content="<%=currenturl %>" />
<meta property="og:site_name" content="Livestock Of The World" />
<meta property="og:image" content="<%=Image %>" />
<meta property="og:image:width" content="550" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content=<%=Description %> />
<meta name="twitter:title" content="Livestock Of Japan" />

<link rel="canonical" href="<%=currenturl %>" />

<meta http-equiv="Content-Language" content="en-us">
<% website = request.querystring("website") %>
</head>
<body >
<!--#Include virtual="/Header.asp"--> 

<a name = "Top"></a>
<div class="container d-flex align-items-center justify-content-center">
  <div class = "row" >
    <div class = "col">
     <div style="max-width:200px">   Marketplace
           <form action="/Join/PassToRegion.asp" method = "post">
             <!--#Include virtual="/includefiles/marketplacelistdropdowninclude.asp"-->
            <center><button type="submit" class="regsubmit2" >Submit</button></center>
            </form>
            </div> 

<div class="container d-flex align-items-center justify-content-center">
  <div class = "row">
    <div class = "col body">
        <a name = "Top"></a><br /><br />
        <center><img src ="https://www.globallivestocksolutions.com/Logos/LOJLogo.jpg" width = 300 align = center alt = "Livestock Of Japan" /></center>
        <H1><center>Livestock Of Japan is Coming Soon!<center></h1>
        Livestock Of Japan is not available yet. Please fill out the form below and we will let you know as soon as the site is available.
         <br><br>
    </div>
  </div>
</div>


<table width = 480 >
<tr>
   <td>
	
<FORM NAME="ContactUsForm" ACTION="RegionalContactUsConfirm.asp" METHOD="POST" onsubmit="javascript:return ValidForm(this)">	
	<input name="_recipients" type="hidden" value="johna@The ANDRESEN<b>GROUP</b>">
    	<input name="_subjectField" type="hidden" value="name">
	<input name="_subject" type="hidden" value=":&nbsp;Contact&nbsp;Us">
    	<input name="_replyToField" type="hidden" value="email">
	<input name="_requiredFields" type="hidden" value= 
		"First_Name,Last_Name,Business_Name,Email">
		
           			
<% Message = request.querystring("Message")
if len(Message) > 1 then%>
<font color = "maroon"><b><%=Message %></b></font><br />
<% end if %>
            			
First Name<font color="maroon">*</font></br>
<INPUT TYPE="TEXT" NAME="FName" style="width: 200px; text-align: left" class='formbox'></br>
Last Name<font color="maroon">*</font></br>
<INPUT TYPE="TEXT" NAME="LName" style="width: 200px; text-align: left" class='formbox'></br>
Business Name</br>
<INPUT TYPE="TEXT" NAME="BizName" style="width: 200px; text-align: left" class='formbox'></br>
Email<br />
<INPUT TYPE="TEXT" NAME="Email" style="width: 200px; text-align: left" class='formbox'></br>
Questions<font color="maroon">*</font><br />
<TEXTAREA NAME="CommentText" cols="40" rows="3" class="form-control" wrap="VIRTUAL"></textarea>
                    		
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
<br /><b>Math Question</b>
Please answer the simple question below so we know that you are a human not a spambot.</br>
<img src = "<%=MIMage %>">
<INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>">
<INPUT TYPE="TEXT" NAME="fieldX" size="3" class = formbox><font color="maroon">*</font>

<center><input type="submit" value="Submit" class = "regsubmit2"></center>
<INPUT TYPE="TEXT" NAME="Shoesize" size="1" class = "shoes">
</form><br />
    </td>
   </tr>
</table>
         </div>
  </div>
</div>
<!--#Include virtual="/Footer.asp"-->