<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<title>Andresen Group Content Management System</title>  
<!--#Include file="AdminGlobalVariables.asp"-->
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
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
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if 
%>
<!--#Include file="AdminHeader.asp"--> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
<tr><td class = "roundedtopandbottom" align = "left">
<!--#Include virtual="/Administration/ILoveAlpacasinclude.asp"--> 
</td></tr></table>
 <!--#Include file="AdminFooter.asp"--> 
 </Body>
</HTML>
