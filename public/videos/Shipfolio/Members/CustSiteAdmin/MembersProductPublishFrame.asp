<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<!--#Include virtual="/connloa.asp"-->

<% screenwidth = request.querystring("screenwidth") %>
<link rel="stylesheet" type="text/css" href="MembersStyle.css"></head>
<body border = "0" cellspacing="0" cellpadding = "0" >

<table width = "100%" bgcolor = "#e6e6e6" height = "200" border = "0" cellspacing="0" cellpadding = "0" >
<tr><td valign = "top">

<%
ProdID= request.querystring("ProdID")
SetProductLive= request.QueryString("SetProductLive")

If SetProductLive="True" then
Query =  " UPDATE sfProducts Set "
Query =  Query & " PublishProduct = 1"
Query =  Query & " where ProdID = " & ProdID & ";" 
connloa.Execute(Query) 
end if

If SetProductLive="False" then
Query =  " UPDATE sfProducts Set "
Query =  Query & " PublishProduct = 0"
Query =  Query & " where ProdID = " & ProdID & ";" 
connloa.Execute(Query) 
end if

 Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select Subscriptionlevel, accesslevel from people  where PeopleID = " & session("AIID")
rs2.Open sql2, connloa, 3, 3   
Subscriptionlevel= rs2("Subscriptionlevel")
accesslevel = rs2("accesslevel")
rs2.close

sql2 = "select PublishProduct  from sfProducts  where ProdID = " & ProdID 
'response.write("sql2=" & sql2 )
rs2.Open sql2, connloa, 3, 3   
PublishProduct= rs2("PublishProduct")
rs2.close
%><table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = 100% ><tr>
     <td  align = "left" >
		<H2><div align = "left">Product Status</div></H2>
        </td></tr>
        <tr><td align = "center" >
        <table><tr><td width = "450" class = "body">
         <big>For sale listing: </big><% if PublishProduct= 1 then %>
           <big><b>Published</b></big>
           <form  name=form method="post" action="membersproductPublishFrame.asp?prodID=<%=prodID%>&SetProductLive=False">
        	<center><input type="Submit"  value="Un-Publish Your Product"  class = "regsubmit2" ></center>
  		</form>
          <% else %>
          <big><b>Unpublished Draft</b></big>
 <% 
 

  if subscriptionlevel = 3 then
  maxnumproducts = 5
  MaxnumPublishedProducts  = 5
  end if

  if subscriptionlevel = 4 then
  maxnumproducts = 20000
  MaxnumPublishedProducts  = 20000
  end if


    if subscriptionlevel = 5 then
  maxnumproducts = 25
 MaxnumPublishedProducts  = 25
  end if

if accesslevel = 0 or subscriptionlevel = 0 then
  maxnumproducts = 0
  MaxnumPublishedProducts = 0
  accesslevel = 0 
end if


 'response.write("numPublishedProducts=" & numPublishedProducts )
          if (accesslevel = 0) or (subscriptionlevel = 3 and numPublishedProducts > 4) or (subscriptionlevel = 5 and numPublishedProducts > 24) or  (subscriptionlevel = 0 and numPublishedProducts > 0) or  (subscriptionlevel = 4 and numPublishedProducts > 20000)  then

          if accesslevel = 0 then  %>

            <br><b>This product Cannot be Published.</b> Your membership has expired. Select the button below to renew your membership:<br><br>
            <center><a href = "http://www.livestockoftheworld.com/members/MembersRenewSubscription.asp?PeopleID=<%=AIID %>" class = "regsubmit2" target = "_body"><font face="verdana" size = '2'>Renew Your Membership</font></a></center><br />

        <% else %>

                <br><b>This product Cannot be Published.</b> Your current membership prevents you from publishing more than <%=maxnumproducts %> products. Select the button below to upgrade your membership:<br><br>
            <center><a href = "http://www.livestockoftheworld.com/members/MembersRenewSubscription.asp?PeopleID=<%=AIID %>" class = "regsubmit2" target = "_body"><font face="verdana" size = '2'>Renew or Upgrade Your Membership</font></a></center><br />


        <% end if %>

          <% else %>
           <form  name=form method="post" action="MembersproductPublishFrame.asp?prodID=<%=prodID%>&SetProductLive=True">
        	<center><input type="Submit"  value="Publish Your Product"  class = "regsubmit2" ></center>
  		</form>
        <% end if %>
        <%end if  %>
            
       
        </tr>
        </table>
    </td>
  </tr></table> 
  
  </td></tr></table>  
</body>
</html>
