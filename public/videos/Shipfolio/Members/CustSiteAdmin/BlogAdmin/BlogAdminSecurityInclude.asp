<%
   if Session("WebsiteAccess")= False And  Not (loginpage = True) then
            Response.Redirect("AdminLogin.asp")
      end if
%>
