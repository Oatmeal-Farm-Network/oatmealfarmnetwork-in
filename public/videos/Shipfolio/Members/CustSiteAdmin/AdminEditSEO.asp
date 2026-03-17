<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<title>Andresen Group Content Management System</title>  
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
<SCRIPT LANGUAGE="JavaScript">

<!--    Begin
    var submitcount = 0;
    function checkSubmit() {

        if (submitcount == 0) {
            submitcount++;
            document.Surv.submit();
        }
    }


    function wordCounter(field, countfield, maxlimit) {
        wordcounter = 0;
        for (x = 0; x < field.value.length; x++) {
            if (field.value.charAt(x) == " " && field.value.charAt(x - 1) != " ") { wordcounter++ }  // Counts the spaces while ignoring double spaces, usually one in between each word.
            if (wordcounter > 250) { field.value = field.value.substring(0, x); }
            else { countfield.value = maxlimit - wordcounter; }
        }
    }

    function textCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
        { field.value = field.value.substring(0, maxlimit); }
        else
        { countfield.value = maxlimit - field.value.length; }
    }
//  End -->
</script>
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>

  <% 

PageLayoutID = request.QueryString("PageLayoutID")

If Len(PageLayoutID ) > 0 then
else
	PageLayoutID =Request.Form("PageLayoutID" ) 
End if

If Len(PageLayoutID ) > 0 then
else
	PageLayoutID  = session("PageLayoutID")
End if
str1 = PageLayoutID 
str2 = " "
If InStr(str1,str2) > 0 Then
	'PageName= Replace(str1,  str2, "")
End If  
%>

    <!--#Include file="AdminHeader.asp"--> 
    <% Current3 = "SEO" %>
<!--#Include file="AdminPagesTabsInclude.asp"-->

<% If Len(PageLayoutID) > 0 then
  sql = "select * from PageSEO where PageLayoutID=" & PageLayoutID & ";"
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Title = rs("Title")
Description = rs("Description")


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


rs.close
end if
dim PageLayoutIDlist(40000)
Dim PageNameList(40000)	
Dim LinkNameList(40000)	
	sql2 = "select Pagelayout.LinkName, Pagelayout.PageName, Pagelayout.PageLayoutID from Pagelayout, PageSEO where  PageAvailable = True and Pagelayout.PageLayoutId = PageSEO.PageLayoutId "	
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
    PageLayoutIDList(acounter) = rs2("PageLayoutID")
        LinkNameList(acounter) = rs2("LinkName")
		PageNameList(acounter) = rs2("PageName")
		acounter = acounter +1
		rs2.movenext
	Wend		

	rs2.close
    if len(Pagelayoutid) > 0 then
	sql2 = "select Linkname from Pagelayout, PageSEO where  Pagelayout.PageLayoutId = PageSEO.PageLayoutId and   PageSEO.PagelayoutId =  " & PagelayoutId & ""
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	if Not rs2.eof then 
        LinkName = rs2("Linkname")
	end if	
	
rs2.close
set rs2=nothing
end if
set conn = nothing
%>

<% if LinkName = "Links" then %>
 <!--#Include file="AdminLinksTabsInclude.asp"--> 
<% end if %>

<% if screenwidth < 989 then %>



<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth  %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
		<H2><div align = "left"><% = LinkName%> Page SEO</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" width = "100%"  valign = "top">
<form  action="AdminEditSEO.asp" method = "post">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "right">
			   <tr>
				 <td class = "body">
					<br>Select page:
					<select size="1" name="PageLayoutID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						'response.write(count)
					%>
						<option name = "AID1" value="<%=PageLayoutIDList(count)%>">
							<%=LinkNameList(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit"  class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
<br /><br />

<% if len(LinkName) > 1 then%>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600" align = "center">
	<tr>
		<td valign = "top">
			 <form action= 'AdminSEOPageHandleForm.asp' method = "post">
			<input name="PageLayoutID"  size = "60" value = "<%=PageLayoutID%>" type = "hidden">
			<input name="ID"  size = "60" value = "<%=ID%>" type = "hidden">

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -100%>">
  	<tr>
			<td  align = "right"   class = "body2">
					<b>Title:</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
					<input name="Title"  size = "90" value = "<%=Title%>"><font color = "#707070"> - Should be 8 words.</font> 
			</td>
		</tr>
		<tr>
			<td  align = "right"   class = "body2" valign = "top" >
					<b>Description:</b>
			</td>
			<td  align = "left" valign = "top" class = "body">
		
<textarea name="Description"  cols="90" rows="6"   class = "body"   onKeyDown="textCounter(this.form.Description,this.form.remLentext,265);" onKeyUp="textCounter(this.form.Description,this.form.remLentext,265);"><%=Description%></textarea>
<br>Characters remaining: <input type=box readonly name=remLentext size=3 value=265><br />
					
					<font color = "#707070"> - 265 char max. first 160 show up in search engine listings.</font> 
			</td>
		</tr>
		
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<input type=submit value = "Submit Changes"  Class = "regsubmit2" >
		</td>
		</tr>
		</table></form>
		<% end if %>
</td>
		</tr>
		</table>
		</td>
		</tr>
		</table>
		<br />
<!--#Include virtual="/administration/adminFooter.asp"-->

 </Body>
</HTML>
