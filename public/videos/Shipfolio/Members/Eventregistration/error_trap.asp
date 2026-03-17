<%
'@BEGINVERSIONINFO

'@APPVERSION: 50.3007.0.1

'@FILENAME: errortrap.asp
 
'

'@DESCRIPTION: traps asp errors

'@STARTCOPYRIGHT
'The contents of this file is protected under the United States
'copyright laws and is confidential and proprietary to
'LaGarde, Incorporated.  Its use or disclosure in whole or in part without the
'expressed written permission of LaGarde, Incorporated is expressly prohibited.
'
'(c) Copyright 2000, 2001 by LaGarde, Incorporated.  All rights reserved.
'@ENDCOPYRIGHT

'@ENDVERSIONINFO
%>

<%
'@BEGINCODE

	Sub CheckForError()

		Dim strErrorNumber
		Dim strErrorDescription
			
		If Err.number = 0 Then
			Exit Sub
		End If
		
		strErrorNumber = Err.number 
		strErrorDescription = Err.description
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>SF Error Trapping Page</title>
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
</head>

<body bgcolor="<%= C_BGCOLOR %>" link="<%= C_LINK %>" vlink="<%= C_VLINK %>" alink="<%= C_ALINK %>">

<table border="0" cellpadding="1" cellspacing="0" bgcolor="<%= C_BORDERCOLOR1 %>" width="<%= C_WIDTH %>" align="center">
  <tr>
    <td>
	  <table width="100%" border="0" cellspacing="1" cellpadding="3">
	    <tr>
          <td align="center" bgcolor="<%= C_BGCOLOR1 %>"><b><font face="<%= C_FONTFACE1 %>" color="<%= C_FONTCOLOR1 %>" SIZE="<%= C_FONTSIZE1 %>"><%= C_STORENAME %></font></b>
	      </td>
	    </tr>
	    <tr>
	      <td bgcolor="<%= C_BGCOLOR4 %>">
		    <p><font face="<%= C_FONTFACE4 %>" color="<%= C_FONTCOLOR4 %>" size="<%= C_FONTSIZE4 %>">StoreFront has encountered an error with the page you are attempting to view.</p>
		    <p>Please contact the webmaster of the site at <b><a href="mailto:<%= strEmailAddress %>?SUBJECT=StoreFront Error"><%=strEmailAddress%></a></b> and tell them that you've experienced an error in <b><%=strPageName%></b>.<br><br>
		    <b>The error number was:</b> <%= strErrorNumber %><br><br>
		    <b>The error message was:</b> <%= strErrorDescription %><br><br>
		    </p>
		    <p align="center">We apologize for the inconvenience.<br></p></font>
	      </td>
	      
                  <!--#include file="footer.txt"-->
	      </table>
        </td>
      </tr>
    </table>

  </body>
</html>
<%

	End Sub

'@ENDCODE
%>



