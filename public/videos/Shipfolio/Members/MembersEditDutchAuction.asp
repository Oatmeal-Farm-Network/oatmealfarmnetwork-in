<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Livestock Of America Membersistration</title>
<meta name="Title" content="<%=Sitenamelong %> Membersistration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="never"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="MembersGlobalVariables.asp"-->
    <% 
   Current2="Auctions"
Current3 = "AuctionEdit"  %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<br>
<!--#Include file="MembersAuctionsTabsInclude.asp"-->
<%
AuctionDutchID = request.Form("AuctionDutchID")

if len(AuctionDutchID) < 1 then
AuctionDutchID = request.QueryString("AuctionDutchID")
end if

sql2 = "select * from AuctionDutch where PeopleId= '" & PeopleID & "' order by AuctionDutchID"
'response.write(sql2)
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if rs2.eof then 
numauctions = 0 
else
numauctions = rs2.recordcount
end if


if numauctions  = 0 then
%>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"  ><tr><td class = "roundedtop" align = "left"><H2><div align = "left">Edit a Dutch Auction</div></H2></td></tr>
 <tr><td class = "roundedBottom body" align = "center" valign = "top" height = "300">
Currently you do not have any auctions listed. To sign up for auctions please select <a href = "MembersAuctionAdd.asp" class = "body"><b>Add Auctions</b></a></td></tr></table>
        
<%	else


acounter = 1
Set rs3 = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
dim AuctionDutchIDArray(40000) 
dim AuctionLevel(40000)
dim AuctionDutchTitle(40000)
While Not rs2.eof  
AuctionDutchIDArray(acounter) = rs2("AuctionDutchID")
AuctionLevel(acounter) = rs2("AuctionLevel")

acounter = acounter +1
rs2.movenext
Wend		
	
		rs2.close
		set rs2=nothing

 If Len(AuctionDutchID) = 0 Then %>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" height = "300" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit a Dutch Auction Listing</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top">
			<form  action="EditDutchAuction.asp" method = "post" name = "edit1">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top">
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body" >
					<br>Select one of your dutch auctions:
					<select size="1" name="AuctionDutchID">
					<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
response.write(count)
%>
<option name = "AID1" value="<%=AuctionDutchIDArray(count)%>">
<%
sql3 = "select * from AuctionDutch, animals where  AuctionDutch.AnimalID1 = animals.ID and AuctionDutch.PeopleId= '" & PeopleID & "' order by Fullname, AuctionDutchID"
rs3.Open sql3, conn, 3, 3
if not rs3.eof then 
AuctionDutchTitle(acounter) = rs3("Fullname")
end if
rs3.close
 if len(AuctionDutchTitle(count)) > 0 then%>
<%= AuctionDutchTitle(count)%>
<% else %>
 Not Set Yet 
 <% end if %>
</option>
<% 	count = count + 1
					wend %>
					</select>
<input type=submit Value = "Submit" class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
<br><br><br>
</td>
</tr>
<tr><td></td></tr>
</table>
<% else  %>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"  ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Edit a Dutch Auction Listing</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top">

        <iframe src ="MembersEditDutchAuctionFrame.asp?AuctionDutchID=<%=AuctionDutchID %>" width="<%=screenwidth%>" height="660" frameborder = "0" scrolling = "no" valign = "top" align = "center" style="background-color:white">
			 <p>Your browser does not support iframes.</p>
		</iframe>
</td></tr>
</table>



<% End if %>
<% End if %>
<!--#Include virtual="/Footer.asp"-->

 </Body>
</HTML>
