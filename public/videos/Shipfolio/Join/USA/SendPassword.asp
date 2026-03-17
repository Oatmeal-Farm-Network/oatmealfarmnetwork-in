<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<!--#Include virtual="/includefiles/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title><%=WebSiteName %></title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">

<meta name="revisit-after" content="never"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<% homepage = true %>

<style>
.container-wrapper {
  position: relative;

  display: flex;
  justify-content: center;
  align-items: center;
}

.roundedtopandbottombrown {
  border-top: 1px solid #CC9966;
  border-left: 1px solid #CC9966;
  border-right: 1px solid #CC9966;
  border-bottom: 1px solid #CC9966;
  padding: 0px 10px;
  margin: 0px;
  background: white;
  background-color: white;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
  border-bottom-left-radius: 8px;
  border-bottom-right-radius: 8px;
  -moz-border-radius-topleft: 8px; /* Firefox 3.6 and earlier */
  -moz-border-radius-topright: 8px; /* Firefox 3.6 and earlier */
  -moz-border-radius-bottomleft: 8px; /* Firefox 3.6 and earlier */
  -moz-border-radius-bottomright: 8px; /* Firefox 3.6 and earlier */
  box-shadow: 1px 1px 14px #CC9966;
 /**/ max-width: 500px; /* Set the maximum width to 500px */
  width: 100%; /* Ensure the container takes up the available width */
}
</style>

</head>
<body >

    <!--#Include virtual="/Header.asp"-->
<div class="container-fluid"  >
    <div align = "center">
    <div>
      <div class = "body">
       <br /><h1>Retrieve Your Password</h1><br />
          </div>
        </div>
    </div>
 </div>
<br />
   <div class="container-wrapper">
    <div class="container roundedtopandbottom">
      <div class="row">
        <div class="col" align="center" style="max-width:400px">
             <img src ="/images/SendPassword.jpg" width ="320" align ="left"/> 
        </div>
        <div class="col" align="left" style="max-width:400px"> 
          <br />
          To retreive your password, enter your farm account email below:<br><br>
          <form action="SendpasswordStep2.asp" method="post">
            <div align = left>Email<br />
            <input name="Email" size="42" value="" class="formbox"></div><br>
            <input type="submit" value="Send" class="submitbutton"><br><br><br>
          </form>
        </div>
        <div class="col" >
            
        </div>
      </div>
    </div>



  </div>
    <br><br><br>

<!--#Include virtual="/Footer.asp"-->
</body></html>