<% 'GRAB LIST OF ANIMALS TO BE AUCTIONED**************************************************
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	    
    sql = "SELECT WebView.*, BreedingAuction.* FROM WebView, BreedingAuction WHERE Animals.ID = BreedingAuction.animalID and  startdate  < now  and  (enddate +1) >= now ORDER BY auctionorder, avalue " 
' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3  
If rs.eof Then %>
   <blockquote><font class = "body">We do not currently have any stud breedings available for auction. Please check back, we will start another auction soon!</font></blockquote>

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
				
	



<!--#Include virtual="/BreedingIndividualAnimalAuctionInclude.asp"-->
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