<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title><%=WebSiteName %></title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>
<body >
<% Current3 = "AssociationLogin" %>
<!--#Include virtual="/Header.asp"-->
<div class="container-fluid" id="grad1">
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Association Sign In</h1>
          </div>
        </div>
    </div>
    </div>
 </div>
<%  AssociationError = request.querystring("AssociationError")%>	
<div class="container">
  <div class = "row d-flex  align-items-center justify-content-center"  >
    <div class = "col" style="max-width: 640px">
    <% if AssociationError="True" then %>
	    <b><font color = "maroon">Your username or password do not match our records. Please try again.</font></b><br>
    <% end if %>
        <br /><br />
<form action= '/Associationadmin/AssociationMembersLoginHandle.asp' method = "post">
<div class="form-group">
    <label for="UID">Email</label><br />
    <input type="Text" name="UID" class="formbox" id="UID" size="30" placeholder="Your farm account Email address.">
</div>

<div class="form-group"><br />
    <label for="Password">Password</label><br />
    <input type="Password" name="Password" class="formbox" size="30"  id="Password" placeholder="Your farm account password.">
</div>
<div>
    <br />
<center><input type=submit value = "Sign In"  class = "submitbutton" ></center>
</form>
  <br />  <br />
<h2>Your Organization is Not Registered? Create an Account.</h2>
Registration only takes a minute and it's completely FREE! Your organization will enjoy many great benefits including:

<ul>
<li>Exposure worldwide.</li>
<li>Account admin pages.</li>
<li>Free directory listing.</li>
</ul>
        <br />
    <form action="https://www.agricultureassociations.world/Join/AssociationSignupStep1.asp" method = "post">
      <select class="roundedtopandbottom" name="Region" style="min-height:35px; min-width: 300px">
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
        <option value="New Zealand">New Zealand</option>
        <option value="Russia">Russia</option>
        <option value="SaudiArabia">Saudi Arabia</option>
        <option value="South America">South America</option>
        <option value="South Pacific">South Pacific</option>
        <option value="UK">UK</option>
        <option value="USA">USA</option>
        <option value="Other">Other</option>
        </select>  

       <div align = center><button type="submit" class="submitbutton" >Sign Up</button></div>
    </form>
 </div>

    </div>
  </div>
</div>




<!--#Include virtual="/Footer.asp"-->
</BODY>
</HTML>