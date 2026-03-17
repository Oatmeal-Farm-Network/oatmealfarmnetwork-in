<% SetLocale("en-us") %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<!--#Include file="MembersGlobalVariablesNoBackground.asp"-->
<link rel="stylesheet" type="text/css" href="Framestyle.css">

<% 
PackageID = request.querystring("packageid")
CustID = session("CustID")

Backgroundcolor = ""
BorderColor = ""
MouseoverColor  = ""
adImage	  = ""
HeaderTextFontType  = ""
HeaderTextFontColor  = ""
BodyTextFontType  = ""
BodyTextFontColor  = ""
LinkColor = ""
     
	sql = "SELECT  ListingDesign.*, package.PackageID from ListingDesign, Package where ListingDesign.ListingDesignID = package.ListingDesignID and PackageID= " & packageid
	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
	if Not rs.eof then
Backgroundcolor = rs("BackgroundColor")
BorderColor = rs("BorderColor")
adImage= rs("Image") 
MouseoverColor  = rs("LinkMouseoverColor") 
HeaderTextFontType = rs("HeaderTextFontType") 
HeaderTextFontColor  = rs("HeaderTextFontColor") 
BodyTextFontType  = rs("BodyTextFontType") 
BodyTextFontColor  = rs("BodyTextFontColor") 
LinkColor = rs("LinkColor") 
ListingDesignID  = rs("ListingDesignID")
rs.close
	Else
rs.close


Query =  "INSERT INTO ListingDesign (BackgroundColor, BorderColor,  LinkMouseoverColor, image, HeaderTextFontColor,  HeaderTextFontType, BodyTextFontType, BodyTextFontColor, LinkColor)" 
Query =  Query & " Values ('" &  BackgroundColor & "', "
Query =  Query &   " '" & BorderColor & "' , "
Query =  Query &   " '" & LinkMouseoverColor & "' , " 
Query =  Query &   " '" & adImage & "' , " 
Query =  Query &   " '" & HeaderTextFontColor & "' , " 
Query =  Query &   " '" & HeaderTextFontType & "' , " 
Query =  Query &   " '" & BodyTextFontType & "' , " 
Query =  Query &   " '" & BodyTextFontColor & "' , " 
Query =  Query &   " '" & LinkColor & "' )" 

Conn.Execute(Query) 
	
sql = "SELECT  ListingDesignID from ListingDesign order by ListingDesignID DESC"
Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3   

if Not rs.eof then
	ListingDesignID  = rs("ListingDesignID")
	Query =  " UPDATE Package Set ListingDesignID = " &  ListingDesignID & "" 
	Query =  Query & " where PackageID = " & PackageID & ";" 

Conn.Execute(Query) 

Conn.Close
set Conn = Nothing 
End If 
End If 

sql = "SELECT  ListingDesign.*, package.PackageID, package.MADLotID from ListingDesign, Package where ListingDesign.ListingDesignID = package.ListingDesignID and PackageID= " & packageid
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3   

MADLotID= rs("MADLotID")
DBHeaderTextColor = rs("HeaderTextColor")
DBLinkMouseoverColor = rs("LinkMouseoverColor")
DBBackgroundColor = rs("BackgroundColor")
DBBorderColor = rs("BorderColor")
DBImage	 = rs("Image")
DBHeaderTextFontType = rs("HeaderTextFontType")
DBHeaderTextFontColor = rs("HeaderTextFontColor")
DBBodyTextColor = rs("BodyTextColor")
DBBodyTextFontType = rs("BodyTextFontType")
DBBodyTextFontColor = rs("BodyTextFontColor") 
DBLinkColor = rs("LinkColor")

LinkMouseoverColor=Request.Form("LinkMouseoverColor" ) 
If Len(LinkMouseoverColor) > 1  then
	Session("LinkMouseoverColor") =LinkMouseoverColor
Else
	Session("LinkMouseoverColor") = DBLinkMouseoverColor
	LinkMouseoverColor = DBLinkMouseoverColor
End If

BackgroundColor=Request.Form("BackgroundColor" ) 
If Len(BackgroundColor) > 1  then
	Session("BackgroundColor") =BackgroundColor
Else
	Session("BackgroundColor") = DBBackgroundColor
	BackgroundColor = DBBackgroundColor
End If

BorderColor=Request.Form("BorderColor" ) 
If Len(BorderColor) > 1  then
	Session("BorderColor") =BorderColor
Else
	Session("BorderColor") = DBBorderColor
	BorderColor = DBBorderColor
End If

Image=Request.Form("Image" ) 
If Len(Image) > 1  then
	Session("Image") =Image
Else
	Session("Image") = DBImage
	Image = DBImage
End If

HeaderTextColor=Request.Form("HeaderTextColor" ) 
If Len(HeaderTextColor) > 1  then
	Session("HeaderTextColor") =HeaderTextColor
Else
	Session("HeaderTextColor") = DBHeaderTextColor
	HeaderTextColor = DBHeaderTextColor
End If

HeaderTextFontType=Request.Form("HeaderTextFontType" ) 
If Len(HeaderTextFontType) > 1  then
	Session("HeaderTextFontType") =HeaderTextFontType
Else
	Session("HeaderTextFontType") = DBHeaderTextFontType
	HeaderTextFontType = DBHeaderTextFontType
End If

HeaderTextFontColor=Request.Form("HeaderTextFontColor" ) 
If Len(HeaderTextFontColor) > 1  then
	Session("HeaderTextFontColor") =HeaderTextFontColor
Else
	Session("HeaderTextFontColor") = DBHeaderTextFontColor
	HeaderTextFontColor = DBHeaderTextFontColor
End If

BodyTextColor=Request.Form("BodyTextColor" ) 
If Len(BodyTextColor) > 1  then
	Session("BodyTextColor") =BodyTextColor
Else
	Session("BodyTextColor") = DBBodyTextColor
	BodyTextColor= DBBodyTextColor
End If

BodyTextFontType=Request.Form("BodyTextFontType" ) 
If Len(BodyTextFontType) > 1  then
	Session("BodyTextFontType") =BodyTextFontType
Else
	Session("BodyTextFontType") = DBBodyTextFontType
	BodyTextFontType= DBBodyTextFontType
End If

BodyTextFontColor =Request.Form("BodyTextFontColor" ) 
If Len(BodyTextFontColor ) > 1  then
	Session("BodyTextFontColor") =BodyTextFontColor 
Else
	Session("BodyTextFontColor") = DBBodyTextFontColor 
	BodyTextFontColor = DBBodyTextFontColor 
End If

LinkColor =Request.Form("LinkColor" ) 
If Len(LinkColor) > 1  then
	Session("LinkColor") =LinkColor
Else
	Session("LinkColor") = DBLinkColor
	LinkColor= DBLinkColor
End If %>

<% packageID = request.Form("PackageID")
If Len(packageID) > 0 Then 
Else
packageID = request.querystring("PackageID")
End If %>
<body  >
<table align = "center" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr>
	<td  valign = "top" >
	<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  height = "450" width = "650" bgcolor = "white">
	<tr>
		<td class ="body" colspan = "2" valign = "top">
			<blockquote>
			<h2>Select Your Package Ad Layout Settings</h2>
			Make changes to your settings below, and then select the preview button. <br>


<form method="POST" action="PackagesEditFrame.asp?packageid=<%=packageid%>" onSubmit="">
<input type="hidden" value = "<%=packageID%>" name = "packageid" >
<input type="hidden" value = "<%=LinkMouseoverColor%>" name = "LinkMouseoverColor" >
<input type="hidden" value = "<%=BorderColor%>" name = "BorderColor" >
<input type="hidden" value = "<%=HeaderTextFontType%>" name = "HeaderTextFontType" >
 <input type="hidden" value = "<%=HeaderTextFontColor%>" name = "HeaderTextFontColor" >
<input type="hidden" value = "<%=BodyTextFontType%>" name = "BodyTextFontType" >
<input type="hidden" value = "<%=BodyTextFontColor%>" name = "BodyTextFontColor" >
<input type="hidden" value = "<%=LinkColor%>" name = "LinkColor" >
<!--#Include virtual="/Conn.asp"-->
<%	
sql = "SELECT  ListingDesign.*, package.PackageID from ListingDesign, Package where ListingDesign.ListingDesignID = package.ListingDesignID and PackageID= " & packageid
	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
	if Not rs.eof then
Backgroundcolor = rs("BackgroundColor")
BorderColor = rs("BorderColor")
adImage= rs("Image") 
MouseoverColor  = rs("LinkMouseoverColor") 
HeaderTextFontType = rs("HeaderTextFontType") 
HeaderTextFontColor  = rs("HeaderTextFontColor") 
BodyTextFontType  = rs("BodyTextFontType") 
BodyTextFontColor  = rs("BodyTextFontColor") 
LinkColor = rs("LinkColor") 
rs.close
else
end if
LinkMouseoverColor = Session("LinkMouseoverColor")
BackgroundColor = Session("BackgroundColor")
BorderColor  = Session("BorderColor")
HeaderTextFontType = Session("HeaderTextFontType")
HeaderTextFontColor = Session("HeaderTextFontColor")
BodyTextFontType   = Session("BodyTextFontType")
BodyTextFontColor = Session("BodyTextFontColor")

	
%>
<tr>
	<td class = "body" align = "right">Background Color:</td>
	<td>	<select size="1" name="BackgroundColor" onchange="submit();">
			<% 			
			Checkcolor = BackgroundColor 
			tempcolor = Checkcolor
			%>
			<!--#Include file="ColornamesInclude.asp"--> 	
					<option value= "<%=BackgroundColor%>" selected><%=BackgroundColor%></option>
					<!--#Include file="ColorOptionsInclude.asp"--> 		
					</select>
				</td>
			 </tr>
			</form>
			 <form action= 'PackagesEditFrame.asp?packageid=<%=packageid%>' method = "post" onSubmit="">	 
			 <input type="hidden" value = "<%=packageID%>" name = "packageid" >
			<input type="hidden" value = "<%=LinkMouseoverColor%>" name = "LinkMouseoverColor" >
			<input type="hidden" value = "<%=BackgroundColor%>" name = "BackgroundColor" >
			<input type="hidden" value = "<%=HeaderTextFontType%>" name = "HeaderTextFontType" >
			<input type="hidden" value = "<%=HeaderTextFontColor%>" name = "HeaderTextFontColor" >
			<input type="hidden" value = "<%=BodyTextFontType%>" name = "BodyTextFontType" >
			<input type="hidden" value = "<%=BodyTextFontColor%>" name = "BodyTextFontColor" >
			<input type="hidden" value = "<%=LinkColor%>" name = "LinkColor" >
		<tr>
		<td class = "body" align = "right">Border Color:&nbsp;</td>
		<td>
			<select size="1" name="BorderColor" onchange="submit();">
				<% Checkcolor = BorderColor 
				tempcolor = Checkcolor%>
				<!--#Include file="ColornamesInclude.asp"--> 	

					<option value= "<%=BorderColor %>" selected ><%= tempcolor%></option>
					<!--#Include file="ColorOptionsInclude.asp"--> 		
	
					</select>
		</td>
	</tr>
	</form>
	 <form action= 'PackagesEditFrame.asp?packageid=<%=packageid%>' method = "post" onSubmit="">	 
			 <input type="hidden" value = "<%=packageID%>" name = "packageid" >
			 <input type="hidden" value = "<%=LinkMouseoverColor%>" name = "LinkMouseoverColor" >
	 <input type="hidden" value = "<%=BackgroundColor%>" name = "BackgroundColor" >
	 <input type="hidden" value = "<%=BorderColor%>" name = "BorderColor" >
	 <input type="hidden" value = "<%=HeaderTextFontType%>" name = "HeaderTextFontType" >
	 <input type="hidden" value = "<%=BodyTextFontType%>" name = "BodyTextFontType" >
	 <input type="hidden" value = "<%=BodyTextFontColor%>" name = "BodyTextFontColor" >
	 <input type="hidden" value = "<%=LinkColor%>" name = "LinkColor" >

	<tr><td class = "body" align = "right">Title Text Color:&nbsp;</td>
			<td><select size="1" name="HeaderTextFontColor" onchange="submit();">
					<% Checkcolor = HeaderTextFontColor 
					tempcolor = Checkcolor%>
						<!--#Include file="ColornamesInclude.asp"--> 	
					<option value= "<%=HeaderTextFontColor%>" selected><%= tempcolor%></option>
									<!--#Include file="ColorOptionsInclude.asp"--> 	
					</select>
		</td>
	</tr>
		</form>
	 <form action= 'PackagesEditFrame.asp?packageid=<%=packageid%>' method = "post" onSubmit="">	 
			 <input type="hidden" value = "<%=packageID%>" name = "packageid" >
			 <input type="hidden" value = "<%=LinkMouseoverColor%>" name = "LinkMouseoverColor" >
	 <input type="hidden" value = "<%=BackgroundColor%>" name = "BackgroundColor" >
	 <input type="hidden" value = "<%=BorderColor%>" name = "BorderColor" >
	 <input type="hidden" value = "<%=HeaderTextFontType%>" name = "HeaderTextFontType" >
	 	 <input type="hidden" value = "<%=HeaderTextFontColor%>" name = "HeaderTextFontcolor" >
	 <input type="hidden" value = "<%=BodyTextFontType%>" name = "BodyTextFontType" >
	 <input type="hidden" value = "<%=LinkColor%>" name = "LinkColor" >
	<tr>
		<td class = "body" align = "right">Body Text Color:&nbsp;</td>
		<td>
			<select size="1" name="BodyTextFontColor" onchange="submit();">
			<% Checkcolor = BodyTextFontColor 
			tempcolor = Checkcolor %>
		
			<!--#Include file="ColornamesInclude.asp"--> 	
					<option value= "<%=BodyTextFontColor%>" selected><%= tempcolor%></option>
						<!--#Include file="ColorOptionsInclude.asp"--> 		
					</select>
		</td>
	</tr>
		</form>
	 <form action= 'PackagesEditFrame.asp?packageid=<%=packageid%>' method = "post" onSubmit="">	 
			 <input type="hidden" value = "<%=packageID%>" name = "packageid" >

			 <input type="hidden" value = "<%=LinkMouseoverColor%>" name = "LinkMouseoverColor" >
	 <input type="hidden" value = "<%=BackgroundColor%>" name = "BackgroundColor" >
	 <input type="hidden" value = "<%=BorderColor%>" name = "BorderColor" >
	 <input type="hidden" value = "<%=HeaderTextFontType%>" name = "HeaderTextFontType" >
	 <input type="hidden" value = "<%=HeaderTextFontColor%>" name = "HeaderTextFontColor" >
	 <input type="hidden" value = "<%=BodyTextFontType%>" name = "BodyTextFontType" >
	 <input type="hidden" value = "<%=BodyTextFontColor%>" name = "BodyTextFontColor" >
<tr><td class = "body" align = "right">Link Color:</td>
		<td>
			<select size="1" name="LinkColor" onchange="submit();">
				<% Checkcolor = LinkColor 
				tempcolor = Checkcolor%>
				<!--#Include file="ColornamesInclude.asp"--> 	
					<option value= "<%=LinkColor %>" selected><%= tempcolor%></option>
						<!--#Include file="ColorOptionsInclude.asp"--> 	
					</select>
		</td>
	</tr>
	</form>
	 <form action= 'PackagesEditFrame.asp?packageid=<%=packageid%>' method = "post" onSubmit="">	 
		<input type="hidden" value = "<%=packageID%>" name = "packageid" >
	 <input type="hidden" value = "<%=BackgroundColor%>" name = "BackgroundColor" >
	 <input type="hidden" value = "<%=BorderColor%>" name = "BorderColor" >
	 <input type="hidden" value = "<%=HeaderTextFontType%>" name = "HeaderTextFontType" >
	 <input type="hidden" value = "<%=HeaderTextFontColor%>" name = "HeaderTextFontColor" >
	 <input type="hidden" value = "<%=BodyTextFontType%>" name = "BodyTextFontType" >
	 <input type="hidden" value = "<%=BodyTextFontColor%>" name = "BodyTextFontColor" >
	 <input type="hidden" value = "<%=LinkColor%>" name = "LinkColor" >
	<tr>
	<td class = "body" align = "right" >Link Mouseover Color:&nbsp;</td>
		<td >
			<select size="1" name="LinkMouseoverColor" onchange="submit();">
					<% Checkcolor = LinkMouseoverColor 
					tempcolor = Checkcolor%>
				<!--#Include file="ColornamesInclude.asp"-->
					<option value= "<%=LinkMouseoverColor%>" selected><%= tempcolor%></option>
						<!--#Include file="ColorOptionsInclude.asp"--> 	
					</select>
		</td></tr></form>
<tr>
   <td  colspan = "2" class = "body" >
<form action= 'PackageLayoutSubmit.asp' method = "post">	  
<input type="hidden" value = "<%=ListingDesignID%>" name = "ListingDesignID" >
<input type="hidden" value = "<%=packageID%>" name = "packageID" >
<blockquote><h2>Publishing Your Design</h2>
   When you are happy with your design, select the button below
   to make it final:</blockquote>
<a name = "publish"></a>	<center><input type=submit value = "Publish!" class = "regsubmit2"></center>
</form>
   </td>
  </tr>
</table>	
	   </td>
	   <td valign = "top" class = "body" bgcolor = "white" align = "center"><h2>Preview of Your Package Ad</h2>(note:  links are disabled in the preview)<iframe src ="PackageAdFrame.asp?packageid=<%=packageID%>&ListingDesignID=<%=ListingDesignID%>" width = "220" height = "511" scrolling="no" frameborder = "0"><br />      
			 <p>Your browser does not support iframes.</p>
			</iframe>
		</td>
	</tr>
</table>
</body>
</html>