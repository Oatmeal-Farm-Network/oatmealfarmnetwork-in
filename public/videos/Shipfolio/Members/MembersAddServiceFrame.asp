<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include File="membersGlobalVariables.asp"--> 
<link href="/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/includefiles/style.css" rel="stylesheet">

<% HSpacer = "<div class = row ><div class=col-12 body style=min-height:20px></div></div>"

ServicesID = request.QueryString("ServicesID")
   ' response.write("ServicesID =" & ServicesID  )
ServicesPagelayoutID = request.QueryString("ServicesPagelayoutID")
if len(ServicesID) > 0 then
else
ServicesID = request.Form("ServicesID")
end if


ServicesID = request.form("ServicesID")
if len(ServicesID) > 0 then
else
ServicesID = request.querystring("ServicesID")
end if
UpsellPageID1 = request.form("UpsellPageID1")
UpsellPageID2 = request.form("UpsellPageID2")
UpsellPageID3 = request.form("UpsellPageID3")
UpsellPageID4 = request.form("UpsellPageID4")
Session("Step2") = False 
UpdateUpselling=request.QueryString("UpdateUpselling")

Session("PhotoPageCount") = 0
			
			
Set rst = Server.CreateObject("ADODB.Recordset")						
Set rsA = Server.CreateObject("ADODB.Recordset")

sql = "select * from Services where ServicesID=" & ServicesID

'response.write("sql=" & sql)


rsA.Open sql, conn, 3, 3 
if not rsA.eof then
ServicecategoryID=rsA("ServiceCategoryID")
ServiceSubcategoryID=rsA("ServiceSubCategoryID")
ServiceTitle = rsA("ServiceTitle")
ServicesDescription= rsA("ServicesDescription")
ServicePrice= rsA("ServicePrice")
if ServicePrice = "0" then ServicePrice = ""
ServicePhone = rsA("ServicePhone")
Servicewebsite = rsA("Servicewebsite")
Serviceemail = rsA("Serviceemail")

ServiceContactForPrice	= rsA("ServiceContactForPrice")
'ServiceShowPrice= rsA("ServiceShowPrice")
ServiceAvailable = rsA("ServiceAvailable")
Photo1 = rsA("Photo1")
Photo2 = rsA("Photo2")
Photo3 = rsA("Photo3")
Photo4 = rsA("Photo4")
Photo5 = rsA("Photo5")
Photo6 = rsA("Photo6")
Photo7 = rsA("Photo7")
Photo8 = rsA("Photo8")

PhotoCaption1 = rsA("PhotoCaption1")
PhotoCaption2 = rsA("PhotoCaption2")
PhotoCaption3 = rsA("PhotoCaption3")
PhotoCaption4 = rsA("PhotoCaption4")
PhotoCaption5 = rsA("PhotoCaption5")
PhotoCaption6 = rsA("PhotoCaption6")
PhotoCaption7 = rsA("PhotoCaption7")
PhotoCaption8 = rsA("PhotoCaption8")


end if
rsA.close

Set rsg = Server.CreateObject("ADODB.Recordset")
if len(ServicecategoryID)> 0 then
sqlg = "select * from servicescategories where ServiceCategoryID = " & ServicecategoryID

rsg.Open sqlg, conn, 3, 3 
if not rsg.eof then
ServicesCategory= rsg("ServicesCategory")
end if
rsg.close 
end if 


'response.write("ServicesubcategoryID=" & ServicesubcategoryID )
 if len(ServicesubcategoryID)> 0 then
sqlg = "select * from servicessubcategories where ServicessubcategoryID = " & ServicesubcategoryID
'response.write("sqlg=" & sqlg )
rsg.Open sqlg, conn, 3, 3 
if not rsg.eof then
ServiceSubCategoryName	= rsg("ServiceSubCategoryName")
end if
rsg.close 
end if 
%>
</HEAD>
<body background: white; border:0; padding:0; margin:0>
<div class ="container" style="background-color:white; border:0; padding:0; margin:0; width:90%">
<div class ="row" style="background-color:white; border:0; padding:0; margin:0">
    <div class ="col body">
        <form name="myform" method="post" action= 'MembersClassifiedAdPlaceStep3.asp?ServiceID=<%=ServicesID %>' target="_top">
        <input name="ServicesID" value="<%=ServicesID %>" type = "hidden">
        <input type = "hidden" name="ServiceCategoryID" value="<%=ServiceCategoryID %>">
             <h2 id="Details">Details</h2>
             <% changesmade = request.querystring("changesmade")
                if changesmade = "True" then %>
                <div>
	                <div style="background-color: floralwhite; min-height:60px">
                        <br /><b>&nbsp;&nbsp;&nbsp;Your Product Basic Facts Changes Have Been Made.</b><br>
	                </div>
                </div>
                <% end if %>


        Service Title<br />
        <input type = "text" name="ServiceTitle" value="<%=ServiceTitle %>" class = "formbox" style="width:330px; text-align:left" required>
    </div>
</div>
<%=HSpacer %>
<div class ="row">
    <div class ="col body">
	Category <b><%=ServicesCategory %></b>

  </div>
</div>
<%=HSpacer %>
<div class ="row">
    <div class ="col body">


    Sub-Category<br />			
	<select size="1" name="ServiceSubcategoryID" class = "formbox" style="width:350px; min-height:40px; text-align:left" required>
    <% if len(ServiceSubCategoryName) > 0 then %>
        <option name = "AID1" value="<%=ServiceSubcategoryID%>"><%=ServiceSubCategoryName %></option>
        <% else %>
        <option name = "AID1" value="">Select a sub-Category</option>
    <% end if %>
	
    <% count = 1
    sqlg = "select * from  servicessubcategories where ServiceCategoryID = " & ServiceCategoryID & " order by ServiceSubCategoryName "
    acounter = 1
	Set rsg = Server.CreateObject("ADODB.Recordset")
	rsg.Open sqlg, conn, 3, 3 
					
    while not rsg.eof	%>
    <option name = "AID1" value="<%=rsg("ServicesSubcategoryID") %>">
        <%=rsg("ServiceSubCategoryName") %>
    </option>
    <% 	rsg.movenext
    wend %>
    </select>
  </div>
</div>
<%=HSpacer %>
<div class ="row">
    <div class ="col body">
    Price / Rate <font color="#abacab">(Optional)</font><br />
 
<textarea name="ServicePrice" ID="ServicePrice" rows="2" class = "formbox" style="width:330px; text-align:left" ><%=ServicePrice%></textarea><br />
<% showavailable = Ttrue
if showavailable = True then %>
	Currently Available?
	<% if len(trim(ServiceAvailable)) > 0 then
       else
           ServiceAvailable = True
       end if
            
       if ServiceAvailable = 0 Or  ServiceAvailable = False Then %>
			Yes<input TYPE="RADIO" name="ServiceAvailable" Value = 1 >
			No<input TYPE="RADIO" name="ServiceAvailable" Value = 0 checked>
		<% Else %>
			Yes<input TYPE="RADIO" name="ServiceAvailable" Value = 1 checked>
			No<input TYPE="RADIO" name="ServiceAvailable" Value = 0 >
		<% End if%>
<% end if %>

    </div>
</div>
<%=HSpacer %>
<div class ="row">
    <div class ="col body">
Description <font color="#abacab">(Optional)</font><br />

 <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
    <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		
    <script language="javascript1.2" type="text/javascript">
        // attach the editor to the textarea with the identifier 'textarea1'.
        WYSIWYG.attach("ServicesDescription", mysettings);
        mysettings.Width = "400px"
        mysettings.Height = "300px"
    </script>
<textarea name="ServicesDescription" ID="ServicesDescription" rows="6" class="form-control"  ><%=ServicesDescription%></textarea>
<br>
	<div align ="right"><input type=submit value = "Submit" class = "roundedtopandbottom"  <%=Disablebutton %> >&nbsp;&nbsp;</div><br /><br />
    </form>


</div>
</div>
</div>
<% conn.close
set Conn = Nothing%>

	
 </Body>
</HTML>