<% SetLocale("en-us") 

CustID=Request.QueryString("CustID") 

%>
<html>

<head>
<!--#Include file="GlobalVariables.asp"-->

<% conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			sql = "select  SfCustomers.* from SFCustomers where SFCustomers.custID= " & CustID
				'response.write(sql)
				rs.Open sql, conn, 3, 3
				If not rs.eof then
				 WebLink = rs("WebLink")
				 'response.write(WebLink)
				
					artistHomeImage = rs("artisanHomeImage")
					artistHomeHeading = rs("artisanHomeHeading")
				   custFirstName = rs("custFirstName")
				    custSlogan = rs("custSlogan")
				   custMiddleInitial  = rs("custMiddleInitial")
					custLastName  = rs("custLastName")
					custCompany   = rs("custCompany")
					custAddr1  = rs("custAddr1")
					custAddr2  = rs("custAddr2")
					custCity  = rs("custCity")
					custState   = rs("custState")
					custZip   = rs("custZip")
					custCountry   = rs("custCountry")
					custPhone   = rs("custPhone")
					custPhone2   = rs("custPhone2")
					custFAX   = rs("custFAX")
					Logo   = rs("Logo")
					Header   = rs("Header")
	
					CustEmail   = rs("CustEmail")



					str1 = WebLink
					str2 = "http://"
					If InStr(str1,str2) > 0 Then
							WebLink= Replace(str1,  str2, "")
					End If 

				rs.close
			End If 
			%>
<title>Contact <%= custCompany %></title>
<meta name="description" content="<%= custCompany %> Contact Us Page at SOJAA.com">
<META name="keywords" content="<%= custCompany %>, <%= custCompany %> Alpacas, <%= Slogan %>, <%= Breed %>Alpacas, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="BarnStyle.css">



</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >

<!--#Include file="Header.asp"-->
<!--#Include file="scripts.asp"-->
<!--#Include file="artistHeader.asp"-->
 <table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"   width = "625">
	<tr>
	     <td class = "body"  colspan = "2" align ="center">		
		  <h1>Contact <%= custFirstName %>&nbsp;<%= custLastName %></h1>
		  </td>
	</tr>
	<tr>
						<td   height = "1"   bgcolor = "#620000" ><img src = "images/px.gif". height = "1"></td>
					</tr>
			
	<tr>
	   <td class = "body">
		  Below is my contact information, you can also use the form at the bottom of this page to get a hold of me:
		</td>
	</tr>
	<tr>
		<td  class = "body" valign = "top">
			
				<table>
					<tr>
					  <td width = "50">&nbsp;</td>
					  <td class = "body">
				
							<h2><%=custCompany%></h2>
							<% If Len(custSlogan) > 1 Then %>
				          <b><%= custSlogan%></b><br>
					  <% end if %>
							
							<% If Len(Weblink) > 1 Then %>
									<a href = "http://<%=Weblink%>" class = "body" target = "blank"><%=Weblink%></a><br>
							<% End If %>
							<% If Len(custPhone) > 1 Then %>
									<% If Len(custphone2) > 1 Then %>
										Phone 1: 
									<% End If %>	
										<%=custPhone%><br>
							<% End If %>
							<% If Len(custphone2) > 1 Then %>
									Phone 2: 	<%=custPhone2%><br>
							<% End If %>
							<% If Len(custFAX) > 1 Then %>
									Fax: 	<%=custFAX%><br>
							<% End If %>
							<% If Len(custAddr1) > 1 Then %>
									<%=custAddr1%><br>
							<% End If %>
							<% If Len(custAddr2) > 1 Then %>
									<%=custAddr2%><br>
							<% End If %>
							<% If Len(custCity) > 1 Then %>
									<%=custCity%>,&nbsp;
							<% End If %>
							<%=custState%>&nbsp;<%=custCountry%>&nbsp;<%=custZip%><br>
							</td>
						</tr>
					</table>
		</td>
		</tr>
		<tr>
		<td>
		<% if len(custEmail) > 7 Then %>
		    <!--#Include file="Contactartist.asp"--> 
       <% End If %>
		  </td>
	</tr>
</table>
	</td>
	</tr>
</table>
 <!--#Include file="Footer.asp"--> 
</body>
</html>

