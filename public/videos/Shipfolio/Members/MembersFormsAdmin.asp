<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<%  PageName = "Registry" %>
<!--#Include file="MembersEventGlobalVariables.asp"-->
<title>Forms</title>
<meta http-equiv="Content-Language" content="en-us">
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
 
<script type="text/javascript" src="/usableforms.js"></script>
<script language="JavaScript" src="/calendar_us.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript" src="jquery.numeric.js"></script>

<script type="text/javascript">function EventTypeFormSubmit() {document.EventTypeForm.submit();}</script>
<script type="text/javascript">function EventServicesFormSubmit() {document.EventServicesForm.submit();}</script>


</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >

<% Current = "Members" %>
<!--#Include file="MembersEventsHeader.asp"-->
<% Current = "Forms" %>
<!--#Include file="OverviewHeader.asp"-->
<!--#Include file="Scripts.asp"--> 

<%
EventID = request.querystring("EventID")

If Request.Querystring("UpdateForms" ) = "True" Then
  PageLayoutID= Request.Form("PageLayoutID") 
PageText= Request.Form("Description") 
PageLayout2ID= Request.Form("PageLayout2ID") 


Query =  " UPDATE EventPageLayout2 Set PageText = '" &  PageText & "' "
Query =  Query & " where PageLayoutID = " & PageLayoutID & " and EventID = " & EventID & ";" 

'response.write("Query = " & Query)
Conn.Execute(Query) 
end if


%>
<!'--#Include file="FormsHeader.asp"--> 
<% PageTitleText = "Forms Overview"  %>
<% Current = "Forms" %>
<!--#Include file="970Top.asp"-->

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 width = "950" align = "center">
	<tr>
	   
 <td valign = "top">  
 

<% 

sql = "select * from EventPageLayout, EventPageLayout2  where EventPageLayout.PageLayoutID = EventPageLayout2.PageLayoutID and PageName = 'Forms' and  EventPageLayout.EventID =  " & EventID & " Order by  EventPageLayout.PageLayoutID Desc"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then	
	Description = rs("PageText")
	PageLayoutID = rs("PageLayoutID")
	PageLayout2ID = rs("PageLayout2ID")
	Upload =  rs("Upload")
	'response.write("ipload=" & Upload )
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

	
End If 


%>




<form  name=Formsform method="post" action="FormsMembers.asp?EventID=<%=EventID%>&UpdateForms=True">
 <table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "950" align = "center" >
 <tbody>
	<tr>
<td class= "body2"  width = "500" valign = "top"> 
<%
'*******************************************************************************************
'WYSIWYG Scripts
'*******************************************************************************************
%>  
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 

<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>
<table border = "0"  cellpadding=0 cellspacing=0 width = "500" align = "center" >
	<tr>
	   <td  valign = "top" ><br><b>Forms Description</b></td>
	</tr>
	<tr><td class = "body2" bgcolor = "#abacab" height = "1"></td></tr>
	<tr><td class = "body2"  height = "1">Include a bit of text about what the 
		forms are for and why they are handy.</td></tr>
<tr><td>

		<script language="javascript1.2">
  		// attach the editor to the textarea with the identifier 'textarea1'.
  		 WYSIWYG.attach("textarea1");
		</script> 
<br>
	  <textarea name="Description" cols="60" rows="6" wrap="VIRTUAL" id = "textarea1"><%= Description%></textarea> </td></tr>
	 <tr><td align = "center">
	<input type = "hidden"  name ="PageLayoutID"  value ="<%=PageLayoutID%>">
	<input type = "hidden"  name ="EventID"  value ="<%=EventID%>">
	<input type = "hidden"  name ="EventSubTypeID"  value ="<%=EventSubTypeID%>">
	<input type="submit"  value="Submit" class = "Regsubmit2" ><br>
	</form>
	</td>
	</tr>
</table>

	</td>
	<td width = "450" valign = "top" class = "body">
	<table width = "450" cellpadding = "0" cellspacing = "0">
	<tr>
	   <td  valign = "top" ><br><b>Upload Forms</b></td>
	</tr>
	<tr><td class = "body2" bgcolor = "#abacab" height = "1"></td></tr>
	<tr><td class = "body2" height = "1">Upload forms below <b>(PDF, DOC, Or EXL 
		formats only)</b>:<br><br></td></tr>
	<tr><td class = "body">

<%
dim PageLayout2IDarray(20)
dim Uploads(20) 
i = 0
sql = "select * from  EventPageLayout2  where PageLayoutID =" & PageLayoutID & "  order by BlockNum"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while Not rs.eof 
  i = i + 1
	Uploads(i) =  rs("Upload")
	PageLayout2IDarray(i) = rs("PageLayout2ID")
rs.movenext
wend
totalcount = i

if len(Uploads(i-1)) > 1 then
Query =  "INSERT INTO EventPageLayout2 (EventID, BlockNum, PageLayoutID )" 
			Query =  Query & " Values (" &  EventID & ", " 
			Query =  Query &  " " &  i + 1 & ", " 
  			Query =  Query &  " " & PageLayoutID & " )" 

		Conn.Execute(Query)

end if 

i = 0
while i < totalcount 
i = i + 1 %>
	
		<% if len(Uploads(i))> 1 then %>
	
		<table width = "440" cellpadding = "0" cellspacing = "0">	<form action= 'RemoveUpload.asp' method = "post">
		<tr><td class = "body" width = "260"><%=right(Uploads(i), len(Uploads(i)) - 9)%></td>
			<td class = "body"><input type = "hidden" name="PageLayout2ID" value= "<%=PageLayout2IDarray(i) %>" >
			<input type = "hidden" name="filename" value= "FormsMembers.asp" >
			<input type=submit value="Remove Form" class = "regsubmit2">
			</td>
		</tr>
		</table>
		</form>
   <% else %>
   <form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadaDownload.asp?PageLayoutID=<%=PageLayoutID%>&filename=<%=filename%>&EventID=<%=EventID%>&BlockNum=<%=i%>&filename2=FormsMembers.asp" >
		<input type = "hidden" name="filename2" value= "/Membersistration/eventregistration/FormsMembers.asp" >					
		<input name="attach1" type="file" size=35 class = "regsubmit2">
		<input  type=submit value="Upload" class = "regsubmit2">
		</form>
   
		<% end if %>

<% wend %>


		</td>
	</tr>
</table>

	</td>
	</tr>
</table>

	</td>
	</tr>
</table>

<!--#Include file="970Bottom.asp"-->

		<!--#Include file="Footer.asp"-->
		
		</Body>
		</html>