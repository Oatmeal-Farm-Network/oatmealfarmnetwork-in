<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">

<!--#Include file="membersGlobalVariables.asp"-->
<link href="/dist/css/bootstrap.min.css" rel="stylesheet">



<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 1;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 1;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 1;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>
</head>
<body >
<% Set rsA = Server.CreateObject("ADODB.Recordset")

screenwidth = request.querystring("screenwidth")

ProdID = request.QueryString("ProdID")
ServicesID= request.QueryString("ServicesID")
AddSendToCountry = request.Form("AddSendToCountry")
ShippingCost1= request.Form("ShippingCost1")
ShippingCost2= request.Form("ShippingCost2")
ShipID = request.Form("ShipID")

Update=request.QueryString("Update")
Delete=request.querystring("Delete")


Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'United States of America'" 
rsA.Open Query, conn, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (ProdID, ShippingToCountry)"  
Query =  Query & " Values (" &  ProdID & ", 'United States of America' )"

Conn.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Canada'" 

rsA.Open Query, conn, 3, 3  
If not rsA.eof Then
else
Query =  "INSERT INTO sfshipping (ProdID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ProdID & ", 'Canada' )"
'response.write("Query=" & Query )
Conn.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Mexico'" 

rsA.Open Query, conn, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (ProdID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ProdID & ", 'Mexico' )"

Conn.Execute(Query) 

end if 
rsA.close

Query =  "Select * From sfShipping where ProdID = " & ProdID & " and ShippingToCountry = 'Other'" 

rsA.Open Query, conn, 3, 3  
If not rsA.eof Then

else
Query =  "INSERT INTO sfshipping (ProdID, ShippingToCountry)"  
 Query =  Query & " Values (" &  ProdID & ", 'Other' )"
'response.write("Query=" & Query )
Conn.Execute(Query) 

end if 
rsA.close

if len(ShippingCost1) > 0 then
wordlength = Len(ShippingCost1)
For loopi=1 to wordlength
    spec = Mid(ShippingCost1, loopi, 1) 
     specchar = ASC(spec)
    if specchar < 46 or specchar > 57 then
    	ShippingCost1= Replace(ShippingCost1,  spec, " ")
   end if
 Next
end if

if len(ShippingCost2) > 0 then
wordlength = Len(ShippingCost2)
For loopi=1 to wordlength
    spec = Mid(ShippingCost2, loopi, 1) 
     specchar = ASC(spec)
    if specchar < 46 or specchar > 57 then
    	ShippingCost2= Replace(ShippingCost2,  spec, " ")
   end if
 Next
end if



ShippingCost1 = trim(ShippingCost1)

if Delete = "True" then
	Query =  "Delete From sfShipping where ShipID = " &  ShipID & "" 

 'response.write("Query=" & Query )
Conn.Execute(Query) 

if len(ProdID)> 0 then
   'response.Redirect("membersShippingFrame.asp?ProdID=" & ProdID & "&Update=True" )
else
   'response.Redirect("membersShippingFrame.asp?ServicesID=" & ServicesID & "&Update=True"  )
end if
end if

if Update = "True" then
if len(ShippingCost1) > 0 then
Query =  " UPDATE sfShipping Set ShippingCost1 = " &  ShippingCost1 & " "
Query =  Query & " where ShipID = " & ShipID & ";" 
'response.write("Query=" & Query)

Conn.Execute(Query) 
else
Query =  " UPDATE sfShipping Set ShippingCost1 = Null" 
Query =  Query & " where ShipID = " & ShipID & ";" 
'response.write("Query=" & Query)
Conn.Execute(Query) 

end if

if len(ShippingCost2) >0 then
Query =  " UPDATE sfShipping Set ShippingCost2 = " &  ShippingCost2 & " "
Query =  Query & " where ShipID = " & ShipID & ";" 
Conn.Execute(Query) 
else
Query =  " UPDATE sfShipping Set ShippingCost2 = Null "
Query =  Query & " where ShipID = " & ShipID & ";"
Conn.Execute(Query) 

end if

if len(ProdID)> 0 then
    'response.Redirect("membersShippingFrame.asp?ProdID=" & ProdID & "&Update=True"  )
else
    'response.Redirect("membersShippingFrame.asp?ServicesID=" & ServicesID & "&Update=True"  )
end if
end if

if len(AddSendToCountry) > 0 then
if len(ProdID)> 0 then
    Query =  "INSERT INTO sfshipping (ProdID, ShippingToCountry)"  
    Query =  Query & " Values (" &  prodID & ", '" & AddSendToCountry & "' )"
 ELSE
 Query =  "INSERT INTO sfshipping (ServicesID, ShippingToCountry)"  
    Query =  Query & " Values (" &  ServicesID & ", '" & AddSendToCountry & "' )"
end if
Conn.Execute(Query) 

end if

if len(ProdID)> 0 then
sql = "select * from sfShipping where ProdID=" & ProdID
else
sql = "select * from sfShipping where ServicesID=" & ServicesID
end if
		
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
 if rs.eof then 
 
 if len(ProdID)> 0 then 
Query =  "INSERT INTO sfshipping (ProdID)"  
Query =  Query & " Values (" &  prodID & ")"
else
Query =  "INSERT INTO sfshipping (ServicesID)"  
Query =  Query & " Values (" &  ServicesID & ")"
end if

Conn.Execute(Query) 

rs.close
end if

%>
<div class="container " >
<a name="Top"></a>

<div class="rows">
    <div class = "col-12">
      <% if Update = "True" then %>
       <font class="blink_text"><b>Your Shipping Changes Have Been Made.</b></font>
    <% end if %>


    
<% showaddcountry = True
if showaddcountry = True then%>


<% if len(ProdID)> 0 then %>
<form method="POST" action="membersShippingFrame.asp?prodid=<%= Prodid %>" >
<% else %>
<form method="POST" action="membersShippingFrame.asp?Servicesid=<%= Servicesid %>" >
<% end if %>
<b>Add Location:</b>  
<select name="AddSendToCountry" onchange="submit();" class ="roundedtopandbottom" style="height: 40px">
<option value="">Select a Country That You Ship To</option>

<% Query =  "Select name From Country order by name asc" 
rsA.Open Query, conn, 3, 3  
If not rsA.eof Then 
   while not rsA.eof  %>
    <option value="<%=rsA("name") %>"><%=rsA("name") %></option>
  <% rsA.MoveNext
    wend
  end if %>

</select></form>

<% end if %>
    <br /><br />
    </div>
  </div>
</div>




<table class="table" width = 100%>
  <thead>
    <tr>
      <th scope="col" align ="left">Country</th>
      <th scope="col" width= 150>Shipping Cost</th>
      <th scope="col" width = 120></th>
       <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
    <% sql = "select * from sfShipping where ProdID=" & ProdID
	   Set rs = Server.CreateObject("ADODB.Recordset")
       rs.Open sql, conn, 3, 3 
       while not rs.eof%>
        <tr><form method="POST" action="membersShippingFrame.asp?ProdID=<%= ProdID %>&Update=True" > 
          <th align = "left" class = "body"><%=rs("ShippingToCountry") %></th>
          <td>$<input name="ShippingCost1" type="number"  min="0" step="0.01" data-number-to-fixed="2"  maxlength="4" size="4" value="<%=rs("ShippingCost1")%>" class="roundedtopandbottom currency" id="c1" style="width: 100px; height: 30px"/>
          </td>
          <td> 
                <input name="ShipID" value="<%=rs("ShipID") %>" type = "hidden">
                <input type=submit value = "Submit" class = "roundedtopandbottomyellow"  <%=Disablebutton %> >
            </form>
          </td>
          <td align = "right" width = 20>
          <% if not rs("ShipID") = 2558 then %>
          <form method="POST" action="membersShippingFrame.asp?prodid=<%= Prodid %>&Delete=True" >
            <input name="shipID" value="<%=rs("ShipID") %>" type = "hidden">
            <input type=submit value = "Delete" class = "roundedtopandbottomyellow"  <%=Disablebutton %>  >
          </form>
          <% end if %>
          </td>
        </tr>

   <% rs.movenext 
      wend %>

  </tbody>
</table>


 
<div>
    <div  class = "body"><br />
    <blockquote><img src="images/Important_Triangle.png" height = 20 /> <b>If you do not set any shipping and handling costs then buyers will only be able to order your product in your home country, and at the standard base price.</b><br /><br />
    <font color = #404040>Note: If you enter shipping costs for some countries, and not other countries, then shipping to the excluded countries will not be available.</font><br>
    <br>
    <b>Helpful Link</b><br>
    <a href = "http://www.purolatorinternational.com/trade-regulations" target = "_blank" class = "body">www.purolatorinternational.com/trade-regulations</a> - learn about shipping to Canada.<br />


</div>
</div>

</div>
</Body>
</HTML>
