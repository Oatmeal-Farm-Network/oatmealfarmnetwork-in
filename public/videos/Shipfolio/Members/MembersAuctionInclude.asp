<% 'GRAB LIST OF ANIMALS TO BE AUCTIONED**************************************************
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	    
    sql = "SELECT WebView.*, Auction.* FROM WebView, Auction WHERE Animals.ID = Auction.animalID and startdate  < now  and  (enddate +1) >= now ORDER BY auctionorder, Price " 
' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3  
  
If Active = false Then 
 

%>
  <img src = "images/auctionimage.jpg" align = "right"> <blockquote><font class = "body"><h2>We do not currently have an auction.</h2>  Please check back later. We will be holding quarterly auctions, our next one will be in April, 2008. <br><br>  
    If you are interested in listing one or more of your animals with us, please <a href = "contactus.asp" class = "body">contact us.</a> We would be happy to answer any of your questions and help you auction your alpacas. <br><br>
	
	
	<b>Renate &amp; Richard Gyuro<br>
          Alpacas at Lone Ranch<br></B>
		  P.O. Box 128<br>
          Eagle Point, Oregon 97524<br>
          Phone and Fax: (541) 826-7411<br>
		  </font>
          <a href="mailto:richard@alpacasontheweb.com" class = "body">
          richard@alpacasontheweb.com</a><br>
</font></blockquote>

<% Else %>
<%'DETERMINE THE CATAGORY FOR THE ANIMALS**************************************************
	if  not rs.eof  Then
		category = rs("category") 
		 If category = "Maiden" or category = "Female Cria"  or category = "Dam" or category = "Female Yearling" Then
			DetailType = "Dam"
		Else 
			DetailType = "Sire"
		End if
	End If 

'GET THE ID **************************************************	
	 OldID = ""
      counter = 0
		if  not rs.eof  then
			ID = rs("Animals.ID")
	   end if%>
		
		
        

<%
If rs.eof Then %>
   <blockquote><font class = "body">We do not currently have any Alpacas available for auction. Please check back, we will have some soon!</font></blockquote>

<% Else 
While Not rs.eof 

		CurrentID = rs("Animals.ID")
		
		rs.movenext
		last = false
		if rs.eof  then
			last = true
		else
			NextID = rs("Animals.ID")
			if CurrentID <> NextID then
				last = true
			end if
		end if
		rs.moveprevious
		
		
		ID = rs("Animals.ID")
		Unique =false
		if ID <> OldID then
			Unique =True
		end if

		
		if Unique = true then
		
		OldID= rs("Animals.ID")
			counter = counter +1	
			
		 alpacaID = rs("Animals.ID")
               'response.write( alpacaID)
			   %>	 
				
	



<!--#Include virtual="/IndividualAnimalAuctionInclude.asp"-->
      <% End if	%>       

	 <% 
					
			 rs.movenext
           %>
          <%  Wend %>
</form>
<%
 
  rs.close
  set rs=nothing
  set conn = nothing

%>
<%End If %>
<%End If %>