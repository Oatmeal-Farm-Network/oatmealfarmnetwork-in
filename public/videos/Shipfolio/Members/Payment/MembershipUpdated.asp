<%
dim   Mode  
    Mode   =request.Querystring("Mode")


    %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<!--#Include virtual="/includefiles/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title>Membership Status Updated</title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">

<meta name="revisit-after" content="never"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<% homepage = true %>
</head>
<body >
<!--#Include virtual="/Header.asp"-->
<div class="container-fluid" style="background-color:Green" >
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">

       <br /><h1>
          <%if(Mode="Cancel") then
            Response.write("Your membership cancelled successfully")
              else
                 Response.write("Your membership updated successfully")
              end if
               %>
              </h1><br />
          </div>
        </div>
    </div>
    </div>
 </div>

 <% ' lg+ navigation  %>
    <div class="container-fluid" align = center style="max-width: 1000px; min-height: 600px; ">
       <div class = "row">
        <div class = "col - 6" align = "left">

 


   </div>
    </div>
    </div>
<!--#Include virtual="/Footer.asp"-->
</body></html>