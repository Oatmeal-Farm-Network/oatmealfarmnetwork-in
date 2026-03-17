<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% Title= "Livestock Of The World"
Description = "Join Livestock Of The World. An online marketplace for horses, cattle, dogs, donkeys, goats, chickens, turkeys, emus, rabbits, llamas, alpacas, pigs, and sheep."
currenturl = "https://www.LivestockOfTheWorld.com/join/The World/"
Image = ""
 %>

<title><%=Title %></title>
<META name="description" content="<%=Description %>">
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include Virtual="/GlobalVariables.asp"-->

<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="join Livestock Of The World." />
<meta property="og:description" content=<%=Description %> />
<meta property="og:url" content="<%=currenturl %>" />
<meta property="og:site_name" content="Livestock Of The World" />
<meta property="og:image" content="<%=Image %>" />
<meta property="og:image:width" content="550" />
<meta name="twitter:card" content="summary" />
<meta name="twitter:description" content=<%=Description %> />
<meta name="twitter:title" content="Livestock Of The World" />

<link rel="canonical" href="<%=currenturl %>" />

<meta http-equiv="Content-Language" content="en-us">
<% website = request.querystring("website") %>
</head>
<body >
<!--#Include virtual="/Header.asp"--> 

<a name = "Top"></a>
<div class="container d-flex align-items-center justify-content-center" >
  <div class = "row" >
    <div class = "col" style="max-width: 650px">
<h1>Create a Ranch Account</h1>
  <b>Prices start at Free.</b> Where is your ranch?<br>
       <form action="/Join/PassToRegion.asp" method = "post">
        <select class="form-select" name="Region">
        <option selected>Country / Region</option>
        <option value="Africa">Africa</option>
        <option value="Asia">Asia</option>
        <option value="Australia">Australia</option>
        <option value="Canada">Canada</option>
        <option value="Caribbean">Caribbean</option>
        <option value="Central America">Central America</option>
        <option value="Europe">Europe</option>
        <option value="Japan">Japan</option>
        <option value="Mexico">Mexico</option>
        <option value="MiddleEast">Middle East</option>
        <option value="New Zealand">New Zealand</option>
        <option value="Russia">Russia</option>
        <option value="South America">South America</option>
        <option value="South Pacific">South Pacific</option>
        <option value="UK">UK</option>
        <option value="USA">USA</option>
        <option value="Other">Other</option>

        </select>  
        <center><button type="submit" class="regsubmit2" >Submit</button></center>
</form>
<br />
<h3>Already Have a Ranch Account?</h3>
<center><a href = "https://www.livestockoftheworld.com/Login.asp" class = "body">Sign In here</a>.</center>
<br />


 <h1>Create an Association Account</h1>



 We have two types of accounts:
 <ul>
<li><B>Ranch accounts.</B> For individuals and ranch / farm business.</li>
<li><B>Association Accounts.</B> For Clubs, Registrars, and other types of Associations.</li>
</ul>
In order to set up an Association account you need to have a ranch account.

<% Message = Request.querystring("Message")
   If len(Message) > 1 then  %>
   <h3><font color = maroon>Please select a Country / Region.</font></h3>
 <% end if %>

Have a Ranch Account?
<form  name=Login method="post" action="AssociationRanchHandlelogin.asp" >
   
<div class = "row">
  <div class = "col" style="max-width:460px">

  <% Fail = request.QueryString("Fail")
if Fail = "True" then %>	

<b><font color=maroon>Sign In Failed. The email / password combination that you tried failed. Please try again.</font></b><br />
	<% end if %>	
<br />
Log into your account below:<br />
    Email&nbsp;<br />
    <input name="Email" Value =""  size = "25" class = "formbox" maxlength = "61"  ><br /><br>
    Password&nbsp;</br>
    <input name="password" type = password Value ="" size = "25" maxlength = "61" class = "formbox"></br><br>
    <center><input type="submit" class = "regsubmit2" value="Submit"  ></center><br>
    <br>
	Forgot your password? <a href = "sendpassword.asp?Screenwidth=<%=Screenwidth %>" class = "body">Click Here.</a><br>
	
</form>
</div></div>
<br />
<br />
Where is your organization:<br>
       <form action="/Join/AssociationsPassToRegion.asp" method = "post">
        <select class="form-select" name="Region">
        <option selected>Country / Region</option>
        <option value="Africa">Africa</option>
        <option value="Asia">Asia</option>
        <option value="Australia">Australia</option>
        <option value="Canada">Canada</option>
        <option value="Caribbean">Caribbean</option>
        <option value="Central America">Central America</option>
        <option value="Europe">Europe</option>
        <option value="Japan">Japan</option>
        <option value="Mexico">Mexico</option>
        <option value="MiddleEast">Middle East</option>
        <option value="New Zealand">New Zealand</option>
        <option value="Russia">Russia</option>
        <option value="South America">South America</option>
        <option value="South Pacific">South Pacific</option>
        <option value="UK">UK</option>
        <option value="USA">USA</option>
        <option value="Other">Other</option>

        </select>  
        <center><button type="submit" class="regsubmit2" >Submit</button></center>
</form>


<h3>Already Have an Association Account?</h3>
<center><a href = "https://www.livestockassociations.com/associationadmin/associationLogin.asp" class = "body" target = "_blank">Sign In here</a>.</center>
<br />
<br />
         </div>
  </div>
</div>

<!--#Include virtual="/Footer.asp"-->