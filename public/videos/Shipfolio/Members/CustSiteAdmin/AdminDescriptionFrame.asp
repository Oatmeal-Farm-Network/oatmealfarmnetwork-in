<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 1;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 1;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 1;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>
</head>
<body>

<% dim	IDArray(9999) 
dim	alpacaName(9999)
category = request.QueryString("category")
ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if
%>
<% If Len(ID) > 0 then %>
	<!--#Include virtual="/Administration/Transfers/GatherAnimalData.asp"-->
	<!--#Include virtual="/Administration/Transfers/TransferMovedata.asp"-->
<% end if %>
 <!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 
<%
if len(Description) > 1 then
For loopi=1 to Len(Description)
    spec = Mid(Description, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
    	Description= Replace(Description,  spec, " ")
   end if
 Next
end if

str1 = Description
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1, str2 , vbCrLf)
	
End If  


str1 = Description
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1,  str2, " ")
End If 

str1 = Description
str2 = "''"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1,  str2, "'")
End If 


%>
<SCRIPT LANGUAGE="JavaScript">

<!-- Begin
   var submitcount=0;
   function checkSubmit() {

      if (submitcount == 0)
      {
      submitcount++;
      document.Surv.submit();
      }
   }


function wordCounter(field, countfield, maxlimit) {
wordcounter=0;
for (x=0;x<field.value.length;x++) {
      if (field.value.charAt(x) == " " && field.value.charAt(x-1) != " ")  {wordcounter++}  // Counts the spaces while ignoring double spaces, usually one in between each word.
      if (wordcounter > 250) {field.value = field.value.substring(0, x);}
      else {countfield.value = maxlimit - wordcounter;}
      }
   }

function textCounter(field, countfield, maxlimit) {
  if (field.value.length > maxlimit)
      {field.value = field.value.substring(0, maxlimit);}
      else
      {countfield.value = maxlimit - field.value.length;}
  }
//  End -->
</script>
<% screenwidth = screenwidth - 220 %>
<form action= 'AdminDescriptionHandleForm.asp' method = "post">

 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr>
    <td class = "body" >
<a name="Description"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr>
    <td class = "roundedtop" align = "left"><H2><div align = "left">Description</</div></H2>
    </td>
</tr>
<tr >
<td class = "roundedBottom"> 
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Description Changes Have Been Made.</b></font></div>
<% end if %>
    <table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" >
    <tr> 
       <td class = "body" valign = "top">
       <% if mobiledevice = True or screenwidth < 600 then %>
      <TEXTAREA NAME="Description"  cols="42" rows="20" wrap="file"  class = "regsubmit2 body"><%=Description%></textarea>  
 <% else %>

 
       <br />
       <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
		<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		
    <script language="javascript1.2" type="text/javascript">
// attach the editor to the textarea with the identifier 'textarea1'.

WYSIWYG.attach("PageText", mysettings);
mysettings.Width =  <%=screenwidth - 70 %> +  "px"
mysettings.Height = "300px"
 </script>
<TEXTAREA NAME="Description" ID="PageText" cols="75" rows="12" wrap="file"><%=Description%></textarea>
<br /><font class = "body"><b>Copy and Paste</b> - Copy and pasting does not work with some browsers; however, the hotkeys CTL + C (Copy) and CTL + V (Paste) will work.</font>
 <% end if %>
	
</td>
     </tr>      
     </table>
     <table border = "0" width = "100%" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
     <tr>
<td align = "center">
<input type = "hidden" name="category" Value = "<%=category%>">
		    <input type = "hidden" name="ID" Value = "<%=ID%>">
			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >
			<div align = "right">
			   <center> <input type="submit" class = "regsubmit2" value="Submit Description Changes"  ></center>
			</div>
		 </td>
		 <td class = "roundedbottom" align = "center"></td>
	  </tr>
      </table>
</tr>    
   
</table>
</table>
</form>

<% 

str1 = StudDescription
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1, str2 , vbCrLf)
	
End If  


if len(StudDescription) > 1 then
For loopi=1 to Len(StudDescription)
    spec = Mid(StudDescription, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
    	StudDescription= Replace(StudDescription,  spec, " ")
   end if
 Next
end if


str1 = StudDescription
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1,  str2, " ")
End If 

str1 = StudDescription
str2 = "''"
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1,  str2, "'")
End If 

StudServicesPage = True
If StudServicesPage = True And category = "Experienced Male" Or category = "Inexperienced Male" then%>
<br />
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr>
    <td class = "body" >
<a name="studdescription"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr>
    <td class = "roundedtop" align = "left"><h2>Stud Breeding Description (Appears only on Your Stud Services Page)</h2>
    </td>
</tr>
<tr >
<td class = "roundedBottom">
<% studchangesmade = request.querystring("studchangesmade")
if studchangesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Stud Description Changes Have Been Made.</b></font></div>
<% end if %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center"  >
<tr>
		<td bgcolor = "#abacab" height = "1" ></td>
	</tr>
	</table>
 <table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" >
    <tr> 
       <td class = "body" valign = "top">
	<form action= 'AdminStudDescriptionHandleForm.asp' method = "post">
	
	<input type = "hidden" name="ID" Value = "<%=  ID%>">
	<table>
    <tr >
		<td class = "body" valign = "top">
<% if mobiledevice = True or screenwidth < 600 then %>

 <textarea name="StudDescription"  ID="StudDescription" cols="32" rows="12"   class = "regsubmit2 body"  ><%= StudDescription%></textarea>
  <% else %>


 <script language="javascript1.2" type="text/javascript">
     // attach the editor to the textarea with the identifier 'textarea1'.

     WYSIWYG.attach("StudDescription", mysettings);
      mysettings.Width =  <%=screenwidth - 80 %> +  "px"
     mysettings.Height = "300px"
 </script>
 <textarea name="StudDescription"  ID="StudDescription" cols="75" rows="12"   class = "body"  ><%= StudDescription%></textarea>

	<% end if %>




</td>
</tr>
	<tr>
	<td  align = "center">
    <input type = "hidden" name="category" Value = "<%=category%>">
			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >
			<center><input type=submit Value = "Submit Stud Description Changes" size = "110" class = "regsubmit2" ></center>
			
		</td>
</tr>
</table>
</td>
</tr>
</table></form>
<% End If %>
</body>
</html>