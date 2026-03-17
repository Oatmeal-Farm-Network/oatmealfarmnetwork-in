<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="Global Grange Inc.">
    <title>Harvest Hub</title>
<!--#Include file="MembersGlobalVariables.asp"-->

<body >
<%
dim AnimalIDArray(10000)
dim AnimalNameArray(10000)
	
Current1="Animals"
Current2 = "EditAnimals"
Current3 = "Transfer"  %> 
<!--#Include file="MembersHeader.asp"-->


<% If not rs.State = adStateClosed Then
  rs.close
End If   	%>

<div class ="container roundedtopandbottom">
	<!--#Include file="MembersJumpLinks.asp"-->
<H1>Transfer Animal Ownership to Another Ranch</H1>

<div class ="container border" style="max-width:450px; align-content:center" >
<% 
 If not rs.State = adStateClosed Then
  rs.close
End If  
	sql2 = "select * from Animals where PeopleID = " & session("PeopleID") & " order by Fullname"
	acounter = 1
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sql2, conn, 3, 3 
	if rs.eof then %>

        Currently you do not have any animals entered. To add animals please select the <a href = "AdminAnimalAdd1.asp" class = "body">Add Alpaca</a> tab.

        
<%	else
	While Not rs.eof  
		AnimalIDArray(acounter) = rs("AnimalID")
		AnimalNameArray(acounter) = rs("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs.movenext
	Wend		
	
		rs.close
		set rs=nothing

	'TransferAnimal2.asp
 %>
	<br />
			<form  action="search_ranch.asp?BusinessID=<%=BusinessID%>" method = "post" name = "t1">
			  <div class ="row" >
				 <div class = "col">
					Animals<br />
					
					<select size="1" name="SearchAnimalID" required class="formbox">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=AnimalIDArray(count)%>">
							<%=AnimalNameArray(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</div>
			</div>
			<%=HSpacer %>

			<div class ="row" >
				 <div class = "col">

					<label for="ranchNameInput">Ranch Name Search</label><br />
					<input type="text" class="formbox" id="ranchNameInput" name="ranch_name" size="40" required>
       

				</div>
		    </div>
		   <div class ="row">
			   <div class="col" align = right>
			
				   <br />
					<input type=submit Value = "Submit" class = "regsubmit2" >
			  </div>
		    </div>
		  </form>

	<% end if %>
		<br />
</div><br /><br />
</div>

<!--#Include file="membersFooter.asp"-->

 </Body>
</HTML>
