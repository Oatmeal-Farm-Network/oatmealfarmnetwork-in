<%
   if Session("WebsiteAccess")= False And  Not (loginpage = True) then
         Response.Redirect("/administration/AdminLogin.asp")
   else
   Session("WebsiteAccess")= True
      end if
%>
