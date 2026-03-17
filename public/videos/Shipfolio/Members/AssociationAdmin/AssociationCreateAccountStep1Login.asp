<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
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
<!--#Include virtual="/members/MembersHeader.asp"-->
<div class="container-fluid" >
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
           <h1>Create an Association Account</h1>
          </div>
        </div>
    </div>
    </div>
 </div>

<div class="container" style="min-height:800px">
  <div class = "row d-flex align-items-center justify-content-center"   >
    <div class = "col" style="max-width: 640px" valign="top">

    <big><b>Only employees of the livestock association should create an account.</b></big><br /><br />

    Registration only takes a minute and it's completely FREE! Your organization will enjoy many great benefits including:

    <ul>
    <li>Exposure worldwide.</li>
    <li>Account admin pages.</li>
    <li>Free directory listing.</li>
    </ul>
            <br />
        <form action="/members/AssociationAdmin/SetupAssociationAccountExistingmember.asp" method = "post">
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

           <div align = center><button type="submit" class="submitbutton" >Next</button></div>
        </form>
     </div>

    </div>
  </div>


<!--#Include virtual="/members/MembersFooter.asp"-->
</BODY>
</HTML>