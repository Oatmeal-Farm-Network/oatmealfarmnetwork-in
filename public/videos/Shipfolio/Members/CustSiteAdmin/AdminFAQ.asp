<!DOCTYPE HTML>
<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<body >
<!--#Include file="AdminSecurityInclude.asp"--> 
<!--#Include file="AdminGlobalVariables.asp"--> 
<% Current3 = "FAQ" 
ShowComingAttractions = False					
sql2 = "select * from Pagelayout where  PageAvailable = True and PageName = 'FAQ'"	
'response.write(sql2)
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then						
ShowComingAttractions = True	
PagelayoutID=rs2("Pagelayoutid")
PageName = rs2("PageName")
PageTitle = rs2("PageTitle")

str1 = PageTitle
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1, str2 , vbCrLf)
End If  
str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, " ")
End If 
str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "'")
End If 
PageText = rs2("PageText")
str1 = PageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1, str2 , vbCrLf)
End If  
str1 = PageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, " ")
End If 
str1 = PageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "'")
End If 
end if %>
<!--#Include file="AdminHeader.asp"-->	
<!--#Include file="AdminpagesTabsInclude.asp"--> 			
<% if mobiledevice = False then %>

<a name="Add"></a>
<table width = "960" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body" valign = "top">


<a name="Top"></a>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add a FAQ Entry</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "940" align = "center">
	<tr>
		<td valign = "top">
			 <form action= 'AdminFAQAddQuestion.asp' method = "post">
			<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
		<input name="FAQID"  size = "60" value = "<%=FAQID%>" type = "hidden">
		<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "960" align = "center">
  		<tr>
			<td  align = "right"   class = "body2">
				<b>Question: </b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Question"  size = "60" >
			</td>
	  </tr>
	  <tr>
		<td  align = "right"   class = "body2" valign = "top">
				<b>Answer:</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
				 <script language="javascript1.2" type="text/javascript">
				     // attach the editor to the textarea with the identifier 'textarea1'.

				     WYSIWYG.attach("Answer", mysettings);
 </script>
					<TEXTAREA NAME="Answer" ID="Answer" cols="75" rows="10" wrap="file"></textarea>
			</td>
	 </tr>
	  <tr>
		<td  colspan = "2" align = "center">
			<input type=submit value = "Add"  size = "110" Class = "regsubmit2" >
		</td>
	</tr>
</table>


</td>
</tr>
</table>
</form>
<br><br>
</td>
</tr>
</table>

<br /><br />

<%
'**********************************************************
' Edit Articles
'**********************************************************
%>
<a name="Update"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Existing FAQ Entries</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960">
<table  width = "950" align = "center"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<%  

'conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
'	   "Data Source=" & server.mappath(DatabasePath) & ";" & _
'	   "User Id=;Password=;" 
sql2 =  "select * from FAQ order by FAQId desc"

order = "odd"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, Conn, 3, 3 
FAQCount = 0
While Not rs2.eof 
FAQCount = FAQCount + 1
FAQID = rs2("FAQID")
%>
 <form action= 'AdminFAQUpdateQuestion.asp' method = "post">

<% if order = "even" then
order = "odd" %>
<tr bgcolor = "#e6e6e6">
<% else
	     order = "even" %>
	 	<tr bgcolor = "White">    
	<% end if %>    
	<td valign = "top" class = "body2" align = "right"><b>Question:&nbsp;</b></td>
<td valign = "top" class = "body"><input name="Question"  value="<%=rs2("Question")%>" size = "60" ></td></tr>
<tr>
	<td valign = "top" class = "body2" align = "right"><b>Answer:&nbsp;</b></td><td valign = "top" class = "body">
	
	 <script language="javascript1.2" type="text/javascript">
	     // attach the editor to the textarea with the identifier 'textarea1'.

	     WYSIWYG.attach("Answer<%=FAQID%>", mysettings);

 </script>

		<TEXTAREA NAME="Answer" ID="Answer<%=FAQID%>" cols="95" rows="16" wrap="file"><%=rs2("answer")%></textarea>

</td></tr>
	  <tr>
		<td  colspan = "2" align = "center"> 	    
		<input name="FAQID"  size = "60" value = "<%=FAQID%>" type = "hidden">
			<input type=submit value = "Update"  size = "110" Class = "regsubmit2" >
		</td>
	</tr>
	</form>
<% 
rs2.movenext
Wend		
	
rs2.close

%>

</table>
</td>
</tr>
</table><br>
</td>
</tr>
</table>

<% else %>


<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "100%">
<tr><td  class="body">
		<H2><div align = "left">F.A.Q.
</div></H2>
</td></tr>
<tr><td class = "body" align = "center" width = "100%" valign = "top" >
	 <a name="Top"></a><form action= 'AdminPageHandleForm.asp' method = "post"		
			<input name="PageName"  size = "60" value = "<%=PageName%>" type = "hidden">
			<input name="ID"  size = "60" value = "<%=ID%>" type = "hidden">
			<input name="ReturnPage"  size = "60" value = "AdminFAQ.asp" type = "hidden">

				<b>Page Title:</b><br />
				<input name="PageTitle"  size = "40" value = "<%=PageTitle%>"><br />
				<b>Page Description:</b><br />
			<TEXTAREA NAME="PageText" ID="PageText" cols="30" rows="12" wrap="file"><%=PageText%></textarea><br />
			<center><input type=submit value = "Update" Class = "regsubmit2" ></center>

</form>
</td>
</tr>
<tr>
		<td class = "body" valign = "top">
	<a name="Add"></a>	

<H1><div align = "left">Add a FAQ Entry</div></H1>

 <form action= 'AdminFAQAddQuestion.asp' method = "post">
<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
<input name="FAQID"  size = "60" value = "<%=FAQID%>" type = "hidden">
<b>Question: </b><br />
<input name="Question"  size = "40" ><br />
<b>Answer:</b><br />
<TEXTAREA NAME="Answer" ID="Answer" cols="30" rows="12" wrap="file"></textarea><br />
<input type=submit value = "Add"  size = "110" Class = "regsubmit2 body" >
</form>
<br><br>
</td>
</tr>

<%
'**********************************************************
' Edit Articles
'**********************************************************
%>
 <tr><td class = "body" >
<a name="Update"></a>
		<H1><div align = "left">Existing FAQ Entries</div></H1>
<%  

'conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
'	   "Data Source=" & server.mappath(DatabasePath) & ";" & _
'	   "User Id=;Password=;" 
sql2 =  "select * from FAQ order by FAQId desc"

order = "odd"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, Conn, 3, 3 
FAQCount = 0
While Not rs2.eof 
FAQCount = FAQCount + 1
FAQID = rs2("FAQID")
%>
 <form action= 'AdminFAQUpdateQuestion.asp' method = "post">
 	<b>Question:</b><br />
	<input name="Question"  value="<%=rs2("Question")%>" size = "40" ><br />
    <b>Answer:</b><br />
	<TEXTAREA NAME="Answer" ID="Answer<%=FAQID%>" cols="30" rows="12" wrap="file"><%=rs2("answer")%></textarea>
	<input name="FAQID"  size = "60" value = "<%=FAQID%>" type = "hidden">
	<center><input type=submit value = "Update"  Class = "regsubmit2 body" ></center>
</form>
<% 
rs2.movenext
Wend		
	
rs2.close

%>


</td>
</tr>
</table>
<br><br><br>
<% end if %>
 <br>
 <!--#Include virtual="/administration/adminFooter.asp"--> 
 
</BODY>
</HTML>
