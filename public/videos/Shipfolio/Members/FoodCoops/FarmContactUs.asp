<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<% Current = "Ranches"%>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<% SetLocale("en-us") 
CurrentPeopleID=Request.Form("CurrentPeopleID") 
if len(CurrentPeopleID) < 1 then
	PeopleID=Request.Form("PeopleID") 
end if

If Not Len(CurrentPeopleID)> 0 Then 
	CurrentPeopleID=Request.QueryString("CurrentPeopleID") 
End if

If CurrentPeopleID = "notselected" or len(CurrentPeopleID) < 1 Then
	'Response.Redirect("default.asp")
End if	

sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
PeopleEmail = rs("PeopleEmail")
	RanchHomeText = rs("RanchHomeText")
	BusinessID   = rs("BusinessID")
	AddressID  = rs("AddressID")
	Logo = rs("Logo")
	Header = rs("Header")
str1 = RanchHomeText
str2 = vblf
If InStr(str1,str2) > 0 Then
	RanchHomeText= Replace(str1, str2 , "</br>")
End If  
str1 = RanchHomeText
str2 = vbtab
If InStr(str1,str2) > 0 Then
	RanchHomeText= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  
end if 
rs.close
	if len(BusinessID) > 0 then
	else
	'response.Redirect("default.asp")
	end if
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
	BusinessName = rs("BusinessName")
end if 
rs.close
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
end if 
rs.close
if len(AddressState) > 1 then
 sql = "SELECT * from States where StateAbbreviation =  '" & AddressState & "'"
'response.write (sql)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql, conn, 3, 3   
if not rs2.eof then
StateName = trim(rs2("StateName"))
StateAbbreviation = rs2("StateAbbreviation")
Nicknames = rs2("Nicknames") 
end if
rs2.close
end if
%>
<title>Contact <%= BusinessName %> - <%=StateName %> Animal Sales</title>
<meta name="Title" content="Contact <%= BusinessName %> - <%=StateName %> Animal Sales"/>
<meta name="description" content="Contact <%= BusinessName %> - Animal in <%= AddressCity %>, <%= StateName %>. <%= BusinessName %> are ranchers. " />
<meta name="robots" content="index,follow">
<meta name="rating" content="Safe for kids">
<meta name="revisit-after" content="1">
<meta name="Googlebot" content="index,follow">
<meta name="robots" content="All">
<link rel="canonical" href="<%=currenturl %>?PeopleId=<%=CurrentPeopleID %>" />

<%	Set rs = Server.CreateObject("ADODB.Recordset")
Dim PageLayout2IDArray(1000)
Dim BlockNum
Dim PageHeadingArray(1000)
Dim EditImageArray(1000)
Dim PageTextArray(1000)
Dim ImageArray(1000)
Dim ImageCaptionArray(1000)
Dim ImageOrientationArray(1000)
Dim ImageLinkArray(1000)
Dim UploadTextArray(1000)
Dim UploadArray(10000)			
Pagename = "Contact Us"
PeopleID = CurrentPeopleID
 sql = "select PageLayoutID from RanchPageLayout where PageName = '" & Pagename & "' and PeopleID=" & PeopleID
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then
 PageLayoutID  = rs("PageLayoutID")
end if 
 If not rs.State = adStateClosed Then
  rs.close
End If  
	

 sql = "select RanchpageLayout.PageName, RanchpageLayout2.* from RanchpageLayout, RanchpageLayout2 where RanchpageLayout.PageLayoutID  = RanchpageLayout2.PageLayoutID  and RanchpageLayout.PageName = 'About Us' and RanchpageLayout.PeopleID = " & PeopleID & " order by BlockNum"
 
 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while not rs.eof
x = x + 1
PageLayoutID = rs("PageLayoutID")
	BlockNum = rs("BlockNum")

	PageLayout2IDArray(x) = rs("PageLayout2ID")

	PageHeadingArray(BlockNum) = rs("PageHeading")
	
	str1 = PageHeadingArray(BlockNum)
	str2 = "&nbsp;"
	If InStr(str1,str2) > 0 Then
		PageHeadingArray(BlockNum)= Replace(str1,  str2, " ")
	End If 

	str1 = PageHeadingArray(BlockNum)
	str2 = "''"
	If InStr(str1,str2) > 0 Then
		PageHeadingArray(BlockNum) = replace(str1,  str2, "'")
	End If 

	EditImageArray(BlockNum) = rs("EditImage")
	PageHeadingArray(BlockNum) = rs("PageHeading")
	PageTextArray(BlockNum) = rs("PageText")
	
	
	str1 = PageTextArray(BlockNum)
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTextArray(BlockNum)= Replace(str1,  str2, " ")
End If 

str1 = PageTextArray(BlockNum)
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTextArray(BlockNum)= Replace(str1,  str2, "'")
End If 


str1 = PageTextArray(BlockNum)
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageTextArray(BlockNum)= Replace(str1, str2 , vbCrLf)
End If  

	
	ImageArray(BlockNum) = rs("Image")
	ImageCaptionArray(BlockNum) = rs("ImageCaption")
	
	if ImageCaptionArray(BlockNum) = "0" then
   		ImageCaptionArray(BlockNum)= ""
	end if

	str1 =  ImageCaptionArray(BlockNum)
	str2 = "&nbsp;"
	If InStr(str1,str2) > 0 Then
		 ImageCaptionArray(BlockNum)= Replace(str1,  str2, " ")
	End If 

	str1 = ImageCaptionArray(BlockNum)
	str2 = "''"
	If InStr(str1,str2) > 0 Then
		ImageCaptionArray(BlockNum)= Replace(str1,  str2, "'")
	End If
	
str1 =  Trim(ImageCaptionArray(BlockNum))
	str2 = "0"
	If InStr(str1,str2) > 0 Then
		 ImageCaptionArray(BlockNum)= Replace(str1,  str2, "")
	End If 
 

	ImageOrientationArray(BlockNum) = rs("ImageOrientation")
	ImageLinkArray(BlockNum) = rs("ImageLink")
	
	str1 =  Trim(ImageLinkArray(BlockNum))
	str2 = "0"
	If InStr(str1,str2) > 0 Then
		 ImageLinkArray(BlockNum)= Replace(str1,  str2, "")
	End If 
UploadTextArray(BlockNum) = rs("UploadText")
UploadArray(BlockNum) = rs("Upload")
rs.movenext
wend
LastBlockNum = BlockNum
rs.close


%>	
</head>
<body >

<!--#Include virtual="/Header.asp"-->
<%Current3 = "Contact Us" %>
<div class="container-fluid" id="grad1" align = "center" >
    <div class = "row" align = "center" >
        <div class = "col body" >
            <h1>&nbsp;Contact <%=BusinessName%></h1>
            <br />
        </div>
   </div>
</div>
<div class="container-fluid" align = "center" >
<div class="row" align = "center">
  <div class="col" align = "center" >
  <% If Len(Logo) > 2 then

str1 = lcase(Logo)
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Logo= Replace(str1, str2 , "https://www.livestockoftheworld.com")
End If  

str1 = lcase(Logo)
str2 = "livestockofamerica.com"
If InStr(str1,str2) > 0 Then
Logo= Replace(str1, str2 , "livestockoftheworld.com")
End If  

str1 = lcase(Logo)
str2 = "http:"
If InStr(str1,str2) > 0 Then
	Logo= Replace(str1, str2 , "https:")
End If  
%>
	  <br />
<img src = "<%=Logo%>" align = "center"  width = "350">
<% End If %>

</div>
</div>
<div class="row" align = "center">
<div class="col" align = "center" >

<b><%=Businessname%></b><br>
<b><%=Owners%></b><br>
<% if len(PeopleWebsite) > 1 then %>
<a href = "http://<%=PeopleWebsite  %>" class = "body" target = "blank"><%=PeopleWebsite  %></a><br>
<% end if %>
<% If Len(PeoplePhone) > 1 Then %>
Phone: 	<%=PeoplePhone%><br>
<% End If %>
<% If Len(Peoplephone2) > 1 Then %>
Cell: 	<%=PeopleCell%><br>
<% End If %>
<% If Len(PeopleFAX) > 1 Then %>
Fax: 	<%=PeopleFAX%><br>
<% End If %>

<% if len(PeopleEmail) > 7 Then %>
<% Message = request.querystring("Message")
if len(Message) > 1 then%>
<font color = "maroon"><b><%=Message %></b></font>
<% end if %>
<form  name=form method="post" action="FarmContactUsSendEmail.asp">

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=2 cellspacing=0 >
<tr> 

<td width="320" align="center" colspan = 4 class = "body"> 
    <br />
	<INPUT TYPE="hidden" NAME="CurrentPeopleID"  Value = "<%=CurrentPeopleID%>" size="45">
</td>
</tr>
<tr> 
	<td  height="20" colspan = 4 class = "body" >
    * First Name<br />
    <input name="FirstName" size = "40" class = "formbox">
 </td>
</tr>
<tr> 
	<td height="60" class = "body" colspan = 4>
    * Last Name<br />
     <input name="LastName" size = "40" class = "formbox">
 </td>
</tr>
<tr> 
	<td height="60" class = "body" colspan = 4>
    State / Province<br />
  	<INPUT TYPE="TEXT" NAME="Fieldname5" size="40" class = "formbox">
</td>
</tr>

<tr> 
	<td height="60" class = "body" colspan = 4>
    Country<br />
  	<INPUT TYPE="TEXT" NAME="Country" size="40" class = "formbox">
</td>
</tr>

<tr> 
	<td  height="60" class = "body" colspan = 4 >
    Email<br />
  	<INPUT TYPE="TEXT" NAME="Fieldname2" size="40" class = "formbox">
  	 </td>
</tr>
<tr> 
	<td  height="60" class = "body" colspan = 4>
    Phone#<br />
  	<INPUT TYPE="TEXT" NAME="Fieldname0" size="40" class = "formbox">
  	 </td>
</tr>
<tr> 
	<td height="20" class = "body" colspan = 4>
    Questions<br />
	  <TEXTAREA NAME="Fieldname1" cols="44" rows="10" wrap="file" class = "formbox"></textarea>
</td>
</tr>
  <% 
' begin random function
randomize

' random numbers is the varible that will contain a numeriv value
' between one and nine
random_number=int(rnd*10)
Select Case random_number
Case 0
 MIMage = "https://www.Globallivestocksolutions.com/images/X987045.jpg"
Case 1 
 MIMage = "https://www.Globallivestocksolutions.com/images/X583198.jpg"
 Case 2 
 MIMage = "https://www.Globallivestocksolutions.com/images/X949256.jpg"
 Case 3 
 MIMage = "https://www.Globallivestocksolutions.com/images/X096367.jpg"
 Case 4 
 MIMage = "https://www.Globallivestocksolutions.com/images/X583198.jpg"
 Case 5 
 MIMage = "https://www.Globallivestocksolutions.com/images/X912578.jpg"
Case 6 
 MIMage = "https://www.Globallivestocksolutions.com/images/X234697.jpg"
Case 7 
 MIMage = "https://www.Globallivestocksolutions.com/images/X781736.jpg"
Case 8 
 MIMage = "https://www.Globallivestocksolutions.com/images/X987834.jpg"
Case 9 
 MIMage = "https://www.Globallivestocksolutions.com/images/X983999.jpg"
End Select

' write the random number out to the browser

%>
<tr><td class = "body" colspan = "4" width = 320>
  <br /><b>Math Question</b><br />
  Please answer the simple question below so we know that you are a human being.
  <br />
  </td>
</tr> 
<tr> 
	<td height="20" class = "body" align = "right" width = 70><img src = "<%=MIMage %>">
    <td width = 2></td>
	<td  height="20" class = "body" colspan = 2> 
	<INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>">
	 <INPUT TYPE="TEXT" NAME="fieldX" size="3">*
    
    </td>
</tr>
<tr> 
	<td align=center colspan="4" class = "body2">    
  	<input type="submit" value="Submit" class = "regsubmit2">
  	<INPUT TYPE="TEXT" NAME="Shoesize" size="1" class = "shoes">
	</td>
           	</tr>
	</table>
</form><br />
<% End If %>
 
  </div>
</div>
</div>


<!--#Include virtual="/Footer.asp"--> 
</body>
</html>