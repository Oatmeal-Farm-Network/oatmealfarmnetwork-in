<html>

<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= WebSiteName %>  - I Love Alpacas</title>
<META name="description" content="<%= WebSiteName %> - I Love Alpacas">
<META name="keywords" content="<%=State%> Alpaca Ranch, <%= WebSiteName %>, <%= Slogan %>, <%= Breed %>Alpacas for sale, alpacas, alpaca,  female alpacas, male alpacas">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">

</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% PageTitle = "I Love Alpacas" %>
<!--#Include virtual="/NewsHeader.asp"-->
<img src = "images/Ilovealpacas.jpg"><br>


<table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" width = "600">
    <tr>
		<td class = "body" valign = "top" colspan = "4">
		

			Our beautiful girl Kimaree captures the hearts of every visitor with her beauty and charm. Below are images of Kimaree and her admiring fans:<br><br>
		</td>
	</tr>
	
			<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     
	sql = "SELECT * FROM additionalphotos WHERE ID=2000 order by PhotoOrder " 

	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 





While Not rs.eof 
			counter = counter +1	
			%>
			<tr>
			
			<%
             for x=1 To 2
				 if rs.eof then
					exit for
             end if 

			 ImageTitle = rs("ImageTitle")
Imagedescription = rs("Imagedescription")

str1 = ImageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageTitle= Replace(str1, "''", "'")
End If

str1 = ImageDescription
str2 = "''"
If InStr(str1,str2) > 0 Then
	 ImageDescription= Replace(str1, "''", "'")
End If

			 %>
				
					<td  class = "body" valign = "top">
				  <a href = "/uploads/Detailpage/<%=rs("Image") %>" target = "blank"><img src = "/uploads/Detailpage/<%=rs("Image") %>" width = "150" align = "left" border = "0"></a>
				  </td>
				  <td class = "body" valign = "top">
							<b><%=ImageTitle %></b><br>
							<%=Imagedescription %>
					</td>
				
             <% rs.movenext
             next %>
    </tr>
	<tr>
		<td colspan = "4">&nbsp;</td>
	</tr>
          <%     
         Wend %>
			
			
	</table>


	
<!--#Include virtual="/Footer.asp"-->


	
<!--Alpacas at Lone Ranch, Oregon, offers exquisite Alpacas for sale, trade, and breeding including highly desired maroon, black and grey alpacas and herdires.  The best website for Alpaca information and resources!">
<META name="keywords" content="alpacas, alpaca, ALPACAS, ALPACAS, Alpacas for sale, Peruvian Alpacas, Accoyo Alpacas, male alpacas, female alpacas, black, black alpacas, grey, grey alpacas, gray, gray alpacas, maroon, maroon alpacas, crias, color, ranch, alpaca ranching, ranching, farm, llama, llamas, Alpacas at Lone Ranch, Gold Beach, Oregon, breeding, sales, trading, stud service, family business, black herdsires, grey herdsires, maroon herdsires, breeder, investment -->
</body>
</html>