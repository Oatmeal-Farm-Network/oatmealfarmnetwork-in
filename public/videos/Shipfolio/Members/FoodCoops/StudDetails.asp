<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<% Set rs = Server.CreateObject("ADODB.Recordset")
ID= Request.QueryString("ID") 
if len(ID) > 0 then
else
Response.redirect("default.asp") 
end if 
sql = "select People.PeopleID, animals.FullName from People, animals where People.PeopleID= animals.PeopleID and id = " & ID
rs.Open sql, conn, 3, 3
if not rs.eof then
CurrentPeopleID = rs("PeopleID")
name = trim(rs("FullName"))
else
end if 
rs.close
if len(CurrentPeopleID) > 0 then
else
response.Redirect("Default.asp")
end if
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessID   = rs("BusinessID")
AddressID  = rs("AddressID")
Logo = rs("Logo")
end if 
rs.close
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
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql, conn, 3, 3   
if not rs2.eof then
StateName = trim(rs2("StateName"))
StateAbbreviation = rs2("StateAbbreviation")
Nicknames = rs2("Nicknames") 
end if
rs2.close
end if
Name = Trim(Name)
if len(Name) > 1 then
For y=1 to Len(Name)
spec = Mid(Name, y, 1)
specchar = ASC(spec)
if specchar < 32 or specchar > 126 then
Name= Replace(Name,  spec, " ")
end if
Next
end if %>
<title><%=Name%> - <%=StateName%> Stud Services</title>
<meta name="Title" content="<%=Name%> - <%= BusinessName %>"/>
<meta name="description" content="<%=Name%>" />
<meta name="robots" content="index, follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="14 days"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subjects" content="<%=StateName %> Studs" />
<link rel="stylesheet" type="text/css" href="/style.css">
 <!--#Include virtual="/Ranches/DetailDBInclude.asp"--> 
<% 
sql = "select * from RanchSiteDesign where PeopleID= " & CurrentPeopleID
	rs.Open sql, conn, 3, 3
	If not rs.eof Then

		MenuBackgroundColor = rs("MenuBackgroundColor")
		MenuColor = rs("MenuColor")
		MenuFontMouseOverColor = rs("MenuFontMouseOverColor")
		TitleColor = rs("TitleColor")
		PageBackgroundColor = rs("PageBackgroundColor")
		PageTextColor = rs("PageTextColor")
		LayoutStyle = rs("LayoutStyle")
		PageTextMouseOverColor = rs("PageTextMouseOverColor")
End If
rs.close 
'if PageBackgroundColor= "Black" Then
'			TitleColor = "white"
'			PageTextColor = "white"
'		end if 
%>

<style>
		H1 {font: 24pt arial; color: <%=TitleColor %>}
		H2 {font: 20pt arial; color: <%=TitleColor %>}
		H3 {font: 18pt arial; color: <%=TitleColor %>}
		.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body {font: 10pt arial; color: <%=PageTextColor %>}
		A.Body:hover { color: <%=PageTextMouseOverColor%>}
			.Heading {font: 10pt arial; color: <%=MenuColor %>}
		A.Heading {font: 10pt arial; color: <%=MenuFontMouseOverColor %>}
</style>
<%	
sql = "select  People.* from People where People.PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
WebLink = rs("WebLink")
 PeopleFirstName = rs("PeopleFirstName")
PeopleMiddleInitial  = rs("PeopleMiddleInitial")
PeopleLastName	= rs("PeopleLastName")
rs.close
End If 
%>
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<!--#Include file="RanchHeader.asp"-->
<a name = "top"></a>
<%Current3 = "Herdsires" %>
 <!--#Include file="RanchPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 30 %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left"><%=Name%></div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"    width = "<%=screenwidth - 30 %>">
	<tr>
		<td>
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"  >
<tr>
<td>
<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center" width = "<%=screenwidth - 30 %>" border = "0"><tr><td   valign="top" width = "420"  align = "left" class = "body">
<!--#Include file="StudGeneralStatsInclude.asp"-->
</td>
<td class = "body" valign = "top"  width = "300">
<table width = "300" ><tr><td align = "center" width = "300" >
<% if noimage = true then%>
		<%=click%>
<% else %>
	<IMG alt="main image" border=0  name=but1 src="<%=buttonimages(1)%>" align = "center" height = "200">
<% end if%>
</td></tr>

<% if len(ARIPhoto) > 1 or len(HistogramPhoto) > 1 then %>

     <tr><td>
     
     <% if len(ARIPhoto) > 1  then %>
       <a href = "<%=ARIPhoto%>" class= "body" target = "_blank"><img src = "/images/ARIThumb.jpg" border = "0" height = "50"></a>
     <% end if %>
     <% if len(HistogramPhoto) > 1 then %>
      <a href = "<%=HistogramPhoto%>" class= "body" target = "_blank"><img src = "/images/HistogramThumb.jpg" border = "0" height = "50"></a>
	<% end if %>
    <% if len(FiberAnalysisPhoto) > 1 then %>
<a href = "<%=FiberAnalysisPhoto%>" class= "body" target = "_blank"><img src = "/images/FiberAnalysisThumb.jpg" border = "0" height = "50"></a>
<% end if %>
     </td>
     </tr>
 <%

end if
	if not rsA.eof then 
	 rsA.movefirst
	counter = 0
	counttotal = 8 
	%>
	<tr><td width = "300" align = "center"><table>
	<% 
	While counter < counttotal and TotalPics > 1
	  counter = counter +1
	  'response.write(buttonimages(counter))
	  If Len(buttonimages(counter)) > 11 then
		if counter = 1 or counter = 5 then
		%>
            <tr>
        <% end if %>
		
			
			<td valign = "top" align = "center" class = "small">
			<font 
			onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
			onMouseOut="img<%=counter%>('but1')"  class = "menu">
			<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br><% If Len(buttontitle(counter)) > 2 Then %>
				<small><%=buttontitle(counter)%></small>
			<% End If %></font>
			</td>

	 <% counter = counter +1 %>

			<td valign = "top" align = "center" class = "small">

			<% If Len(buttonimages(counter)) > 2 then%>
			<font 
			onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
			onMouseOut="img<%=counter%>('but1')"  class = "menu">
			<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
			<% If Len(buttontitle(counter)) > 2 Then %>
				<small><%=buttontitle(counter)%></small>
			<% End If %>
			</font>
			<% End If %>
			</td>

<% if counter = 4 then
		%>
            </tr>
        <% end if %>
        <% end if %>
		<% wend %>
	  </table>
	  </td>
	  </tr>
 	 </table>
         <% end if %>	
		<!'--#Include virtual="/includefiles/ServiceSireInclude.asp"-->
</td>
</tr></table>

<table>
			<tr>
					<td  valign = "top"   width = "<%=screenwidth - 30 %>"   >
<!--#Include file="AwardsInclude.asp"--> 
				<!--#Include file="FiberInclude.asp"--> 
				<!--#Include file="AncestryInclude.asp"--> 	
					</td>
				</tr>
			</table>
<br><br>
</td>
</tr>
</table>		 
<!--#Include file="AnimalCount.asp"--> 
</td>
</tr>
</table>
</td>
</tr>
</table>
<br />
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>