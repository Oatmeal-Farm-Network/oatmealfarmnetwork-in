<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />

<% 'response.redirect("https://www.harvesthub.world/Join/USA/Default.asp") %>
<title>Join The Global Grange Community</title>
<meta name="title" content="Join The Global Grange Community"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<% homepage = true %>
<!--#Include virtual="/Header.asp"-->
 <div class="container-fluid" id="grad1" >
    <div align = center>
     <div class = "container" style="max-width: 1400px; min-height: 67px; text-align: center;">
    <div>
      <div class = "body">
        <h1>Join Our Community</h1>
          </div>
        </div>
    </div>
    </div>
 </div>

<a name = "Top"></a>
<div class="container d-none d-md-block">
   <center><img src = "https://www.globallivestocksolutions.com/logos/GlobalFarmersMarketLogo.jpg" width = 80% alt = "Join" align ="center"/></center>
  <div class = " roundedtopandbottom row d-flex  align-items-center justify-content-center"  >


    <div class = "col " style="max-width: 440px">
        <% Message = Request.querystring("Message")
   If len(Message) > 1 then  %>
   <br /><h3><font color = maroon>Please select a Country / Region.</font></h3><br />
 <% end if %>

            <table width = 100%>
                <tr>
                  <td class = "body" valign = "top"><center>
                 <h2>Create an Account</h2>
               
                  <div align ="left"> Where you located?</div>
                    <form action="/Join/PassToRegion.asp" method = "post">
                     <!--#Include virtual="/includefiles/marketplacelistdropdowninclude.asp"--><br />

                         <div align = center><button type="submit" class="submitbutton" ><b>Sign Up</b><br /></button></div>
                    </form><br />
                    
                    </center> 
                  </td>
                  <% ShowAssociations = False
                    if ShowAssociations = True then  %>
                    <td class = "body" valign = "top">
                    <center><br />
                   <h2>Create an Association Account</h2>
                   
                   <form  name=Login method="post" action="AssociationSignupStep1.asp" style="max-width:255px">
                         Where is your association<br> (Club, Registry, etc)?<br>
                    <form action="/Join/PassToRegion.asp" method = "post">
                    <!--#Include virtual="/includefiles/marketplacelistdropdowninclude.asp"-->
                         <div align = center><button type="submit" class="submitbutton" ><b>Sign Up</b></button></div>
                    </form>
                   <b>It's Free!</b><br />
                   </center> 
                  </td>

                <% end if %>
                </tr>
            </table>
            <br /><br />
            <center>
<h3>Already Have an Account?</h3>
<center><a href = "/Login.asp" class = "body">Sign In here</a>.</center>
<br />

         <% if ShowAssociations = True then  %>
            <h3>Already Have an Association Account?</h3>
            <center><a href = "https://www.livestockassociations.com/associationadmin/associationLogin.asp" class = "body" target = "_blank">Sign In here</a>.</center>
            <br />
         <% end if %>
<br />
</center>



     </div>
  </div>
</div>
<% ' XS and SM navigation  %>
<div class="container  d-md-none">
  <div>
     <div >
<center><img src = "https://www.globallivestocksolutions.com/logos/Harvest-Hub-logo.png" width = 80% alt = "Join" align ="center"/></center>
         <br /> <br />

            <table width = 100% class ="roundedtopandbottom">
                <tr>
                  <td class = "body">
                     <% Message = Request.querystring("Message")
                       If len(Message) > 1 then  %>
                       <br /><h3><font color = maroon>Please select a Country / Region.</font></h3><br />
                     <% end if %>


                 <center><h2>Create a Business Account</h2> 
                   <form  name=Login method="post" action="PassToRegion.asp" style="max-width:200px">
                   Where is your farm located?<br>
                    <form action="/Join/PassToRegion.asp" method = "post">
                   <select class="form-select" name="Region">
                   <option selected></option>
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
                       

                    <br />
                         <div align = center><button type="submit" class="submitbutton" ><b>Sign Up</b></button></div>
                    </form>
                    <br /><br />
                    </center> 
                  </td>
                </tr>

                 <% if ShowAssociations = True then  %>
                <tr>
                    <td class = "body">
                    <center><h2>Create an Association Account</h2>                   
                   <form  name=Login method="post" action="AssociationSignupStep1.asp" style="max-width:200px">
                         Where is your association?<br>
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
                         <div align = center><button type="submit" class="regsubmit2" ><b>Sign Up</b></button></div>
                    </form>
                   <b>It's Free!</b>
                   </center> 
                   <br />
                   <br />
                  </td>
                </tr>
                <% end if %>
                <tr>
                    <td align ="center">
                        <br /><br />

                        <b>Already Have a Ranch Account?</b>
                        <center><a href = "https://www.livestockoftheworld.com/Login.asp" class = "body">Sign In here</a>.</center>
                        <br />
                           <% if ShowAssociations = True then  %>
                        <b>Already Have an Association Account?</b>
                        <center><a href = "https://www.livestockassociations.com/associationadmin/associationLogin.asp" class = "body" target = "_blank">Sign In here</a>.</center>
                        <br />
                            <% end if %>
                        <br />
                        </center>


                    </td>
                </tr>



            </table>
              <center>

        </div>
  </div>
</div>


<!--#Include virtual="/Footer.asp"-->