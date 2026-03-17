<!DOCTYPE HTML>
<% ' Clean directory NEA 4/2012 %>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>  
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->

<%
Function GetPrevMonth(iThisMonth,iThisYear)
 GetPrevMonth=month(dateserial(iThisYear,iThisMonth,1)-1)
End Function

Function GetPrevMonthYear(iThisMonth,iThisYear)
 GetPrevMonthYear=Year(dateserial(iThisYear,iThisMonth,1)-1)
End Function

Function GetNextMonth(iThisMonth,iThisYear)
 GetNextMonth=month(dateserial(iThisYear,iThisMonth+1,1))
End Function

Function GetNextMonthYear(iThisMonth,iThisYear)
 GetNextMonthYear=year(dateserial(iThisYear,iThisMonth+1,1))
End Function


%>	


</HEAD>
<body >
    <!--#Include file="AdminHeader.asp"-->
    
    
     <script>
     document.write("self Width" + self.innerWidth + "<br>")
     document.write("screen Width" + screen.innerWidth + "<br>")
          document.write("Window Width" + window.innerWidth + "<br>");
</script>
    window.innerWidth 
     
 <table width = "<%=PageWidth %>" height = "100" cellpadding = 0 cellspacing = 0 bgcolor ="blue"><tr><td><%=PageWidth %><img src = "images/px.gif" height = "10" width ="10" /></td></tr></table>  
     <!--#Include file="AdminFooter.asp"--> 
</BODY>
</HTML>