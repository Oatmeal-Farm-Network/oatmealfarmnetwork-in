<% SetLocale("en-us") %>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Skyline Alpacas - About Alpacas</title>
<META name="description" content="Skyline Alpacas, located in Portland, Oregon combines my first love, the fiber arts, with my new love, raising alpacas.">
<META name="keywords" content="About Alpacas, AOBA, Financial Aspects of Alpaca Ownership, Alpaca Ownership">
<meta name="author" content="WebArtists.biz">
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<body bgcolor = "white" border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="10" marginwidth="0" marginheight="0" >
<table    border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" width = "678" align = "center" bgcolor = "White"> 
    <tr>
		<td valign = "top">
			<!--#Include virtual="/test/Menu.asp"--> 
		</td>
		<td valign = "top">
		<table    border="0" cellspacing="0" cellpadding="0" leftmargin="10" topmargin="0" marginwidth="0" marginheight="0" bgcolor = "white"> 
				<tr>
					<td background = "images/Header.jpg" height = "106" width = "476" valign = "top" ><h1><i>alpacas for sale</i></h1>			
				
			</td>
		</tr>      
        
		</table>
<br>
	<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" bgcolor = "white">
		 <tr>
			<td class = "body">
				Click on an image to get more details.
			</td>
		</tr>
	<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     
	sql = "select * from WebView where Breed = 'Huacaya'" 
	' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
	While Not rs.eof %>          
         <tr><td width="3">&nbsp;</td>
     
          <%
             for x=1 to 1
                if rs.eof then%>
                    
                    <%exit for
                 end if 
                alpacaID = rs("Animals.ID")
                
                'if (rs("Price")) <100 then 
                 '  alpacasPrice=""
                'else 
                	alpacasPrice= rs("AValue")
                'end if
                'if len(Price) = 1 then
                '	if Price = "$" then
                '		Price = "<i>call for price</i>"
			'end if
	          'end if
		photoID = "x"
		photoID = rs("ListPageImage")

		if len(photoID) < 5 or IsEmpty(rs("ListPageImage")) then
                     photoID = "nophoto"
		end if
			

               	If photoID = "nophoto" then 
			     click =  " <form action=""Details.asp"" method=""post"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
                            "<input name=Detail type=image src=images/NotAvailable.jpg  border=0 height=""140"" >"
			Else
   			     click = "<form action=""Details.asp"" method=""post"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
                             "<input name=Detail type=image src= images/ListPage/"& photoID & "  border=0 height=""140"" >"               
                
                End If
                %> 
               <td align=center width = "100">                          
                               <%=click%>
			</td>
			 <td class= "body" width = "200">
                                <b> <%=Trim(rs("FullName"))%></b><br>
								<b><%=alpacasPrice%></b><br>
									<% if rs("Female") = true then %>
											<%=rs("Color")%> Female
									<% else %>
											<%=rs("Color")%> Male
									<% end if %>
									
									<%=rs("PriceComments")%><br>
                               <BR><%=hiddenInput%></font></b>
				</form>
			</td>
                
                      
              
             <% rs.movenext
             next %>
           </tr>
          <%     
         Wend %>
        
       </form>
       </table>



<%
 
  rs.close
  set rs=nothing
  set conn = nothing

%>
<img src = "images/filler.gif" alt = "Twilight Alpacas Filler">
		


		</td>
	</tr>
<!--#Include virtual="/test/Footer.asp"--> 
</table>
<!--#Include virtual="/test/Copyright.asp"--> 
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</html>

<%Function FormatPrice(price)
     pricelen=len(price)
     if pricelen>3 then
        price=left(price, pricelen-3) &  "," &  right(price, 3)
     end if
     FormatPrice=price   
End Function%>