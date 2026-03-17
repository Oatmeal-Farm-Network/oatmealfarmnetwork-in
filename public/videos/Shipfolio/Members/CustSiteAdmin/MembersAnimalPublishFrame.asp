<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<!--#Include file="Membersglobalvariables.asp"-->

<% screenwidth = request.querystring("screenwidth") %>
<link rel="stylesheet" type="text/css" href="MembersStyle.css"></head>
<body border = "0" cellspacing="0" cellpadding = "0" >

<table width = "100%" height = "200" border = "0" cellspacing="0" cellpadding = "0" bgcolor = "#e6e6e6">
<tr><td valign = "top">
<%


ID = request.querystring("ID")
SetStudLive= request.QueryString("SetStudLive")
If SetStudLive="True" then
Query =  " UPDATE Animals Set "
Query =  Query & " PublishStud = 1"
Query =  Query & " where ID = " & ID & ";" 
connLOA.Execute(Query) 
end if

If SetStudLive="False" then
Query =  " UPDATE Animals Set "
Query =  Query & " PublishStud = 0"
Query =  Query & " where ID = " & ID & ";" 
connLOA.Execute(Query) 
end if

SetForSaleLive= request.QueryString("SetForSaleLive")
If SetForSaleLive="True" then
Query =  " UPDATE Animals Set "
Query =  Query & " PublishForSale = 1"
Query =  Query & " where ID = " & ID & ";" 
connLOA.Execute(Query) 
end if

If SetForSaleLive="False" then
Query =  " UPDATE Animals Set "
Query =  Query & " PublishForSale = 0"
Query =  Query & " where ID = " & ID & ";" 
connLOA.Execute(Query) 
end if


Set rs2 = Server.CreateObject("ADODB.Recordset")
sql2 = "select PublishForSale, PublishStud, Category, speciesid  from Animals  where ID = " & ID 
'response.write("sql2=" & sql2 )
rs2.Open sql2, connLOA, 3, 3   
PublishForSale= rs2("PublishForSale")
PublishStud= rs2("PublishStud")
Category = rs2("Category")
Speciesid = rs2("Speciesid")
rs2.close
%><table border = "0" cellspacing="0" cellpadding = "0" align = "center" bgcolor = "#e6e6e6" ><tr>
     <td  align = "left" >
		<H2><div align = "left">Livestock Of The World Animal Status</div></H2>
        </td></tr>
        <tr><td align = "center" >
        <table><tr><td width = "450" class = "body">
        <b>For Sale Listing:</b> <% if PublishForSale= 1 then %>
          <b>Published</b>
           <form  name=form method="post" action="membersAnimalPublishFrame.asp?ID=<%=ID%>&SetForSaleLive=False">
        	<center><input type="Submit"  value="Un-Publish!"  class = "regsubmit2" ></center>
  		</form>
          <% else %>
          <b>Draft</b>
 <% 
 

  if subscriptionlevel = 3 then
  maxnumanimals = 5
    MaxnumPublishedStuds  = 5
  end if

  if subscriptionlevel = 4 then
  maxnumanimals = 20000
    MaxnumPublishedStuds  = 20000
  end if


    if subscriptionlevel = 5 then
  maxnumanimals = 25
    MaxnumPublishedStuds  = 25
  end if

 if accesslevel = 0 then
  maxnumanimals = 0
  MaxnumPublishedStuds  = 0
  end if
' response.write("numPublishedAnimals=" & numPublishedAnimals & "<br>")
' response.write("accesslevel=" & accesslevel & "<br>")
' response.write("subscriptionlevel=" & subscriptionlevel & "<br>")

          if (accesslevel=0) or (subscriptionlevel = 3 and numPublishedAnimals > 4) or (subscriptionlevel = 5 and numPublishedAnimals > 24) or  (subscriptionlevel = 0 and numPublishedAnimals > 0) or  (subscriptionlevel = 4 and numPublishedAnimals > 20000)  then %>

            <br><b>This Animal Cannot be Published.</b> Your current membership prevents you from publishing more than <%=maxnumanimals %> animals.<br />
            Select the button below to upgrade your membership:<br><br>
            <center><a href = "http://www.livestockoftheworld.com/members/MembersRenewSubscription.asp?PeopleID=<%=peopleID %>" class = "regsubmit2" target = "_blank"><font face="verdana" size = '2'>Renew or Upgrade Your Membership</font></a></center><br />
          <% else %>
           <form  name=form method="post" action="MembersAnimalPublishFrame.asp?ID=<%=ID%>&SetForSaleLive=True">
        	<center><input type="Submit"  value="Publish"  class = "regsubmit2" ></center>
  		</form>
        <% end if %>
        <%end if  %>
            
        </td> 
        
        
         <% 
if speciesid = 13 or speciesid = 14 or speciesid = 15 or speciesid = 20 then
else 

         
if trim(category) = "Experienced Male" or  trim(category) = "Experienced Males"  or trim(category) = "Inexperienced Male"or trim(category) = "Inexperienced Males"  then %>
  <td width = "1" ></td>
  <td  align = "center" width = "450" class = "body">
    <%   if (accesslevel=0) or (subscriptionlevel = 3 and numPublishedStuds  > 4) or (subscriptionlevel = 0 and numPublishedStuds > 0) or (subscriptionlevel = 5 and numPublishedStuds > 24) or  (subscriptionlevel = 4 and numPublishedStuds  > 2000)  then %>
            <br><b>This Stud Cannot be Published.</b> Your current membership prevents you from publishing more than <%=MaxnumPublishedStuds  %> Studs.<br />
            Select the button below to upgrade your membership:<br><br>
            <center><a href = "MembersRenewSubscription.asp?PeopleID=<%=peopleID %>" class = "regsubmit2" target = "_top"><font face="verdana" size = '2'>Renew or Upgrade Your Membership</font></a></center><br />
          <% else %>


       <b>Stud Listing:</b> <% if PublishStud= 1 then %>
           <b>Published</b>
             <form  name=form method="post" action="membersAnimalPublishFrame.asp?ID=<%=ID%>&SetStudLive=False">
        	<center><input type="Submit"  value="Un-Publish"  class = "regsubmit2" ></center>
  		</form>
          <% else %>
          <b>Draft</b><br />
            <form  name=form method="post" action="membersAnimalPublishFrame.asp?ID=<%=ID%>&SetStudLive=True">
        	<center><input type="Submit"  value="Publish"  class = "regsubmit2" ></center>
  		</form>
        <%end if  %>
                <%end if  %>
         </td>
  <% end if %> 
    <% end if %> 
        </tr>
        </table>
    </td>
  </tr></table> 
  
  </td></tr></table>  
</body>
</html>
