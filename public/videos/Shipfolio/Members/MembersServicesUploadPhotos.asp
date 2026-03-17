<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include File="membersGlobalVariables.asp"--> 

<%
ServicesID = request.QueryString("ServicesID")
ServicesPagelayoutID = request.QueryString("ServicesPagelayoutID")
if len(ServicesID) > 0 then
else
ServicesID = request.Form("ServicesID")
end if
%>


<% ServicesID = request.form("ServicesID")
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
 if len(ServicecategoryID)> 0 then
sqlg = "select * from servicessubcategories where ServicesSubcategoryID = " & ServicesubcategoryID
'response.write("sqlg=" & sqlg )
rsg.Open sqlg, conn, 3, 3 
if not rsg.eof then
ServiceSubCategoryName	= rsg("ServiceSubCategoryName")
end if
rsg.close 
end if 
%>
</HEAD>

<body >
 <!--#Include File="MembersHeader.asp"--> 
 <% Current3 = "Photos"  %>
  <!--#Include File="MembersServicesJumpLinks.asp"--> 
<div class ="container roundedtopandbottom">
<div class="container  align-items-center justify-content-center">
  <div class = "row" >
    <div class = "col"  >
        <H1>Service Photos</H1>
<% currentphoto = 1
TempFile = Photo1
TempPhotoCaption = PhotoCaption1
 %>
<!--#Include file="MembersServicesUploadphotoincludefile.asp"-->
    </div>
 </div>
<% if subscriptionlevel > 3 then %>
  <div>
    <div>
<% currentphoto = 2
TempFile = Photo2
TempPhotoCaption = PhotoCaption2
 %>
<!--#Include file="MembersServicesUploadphotoincludefile.asp"-->
    </div>
 </div>
  <div>
    <div>
<% currentphoto = 3
TempFile = Photo3
TempPhotoCaption = PhotoCaption3
 %>
<!--#Include file="MembersServicesUploadphotoincludefile.asp"-->
    </div>
 </div>
  <div>
    <div>
<% currentphoto = 4
TempFile = Photo4
TempPhotoCaption = PhotoCaption4
 %>
<!--#Include file="MembersServicesUploadphotoincludefile.asp"-->
    </div>
 </div>
  <div>
    <div>
<% currentphoto = 5
TempFile = Photo5
TempPhotoCaption = PhotoCaption5
 %>
<!--#Include file="MembersServicesUploadphotoincludefile.asp"-->
    </div>
 </div>
  <div>
    <div>
<% currentphoto = 6
TempFile = Photo6
TempPhotoCaption = PhotoCaption6
 %>
<!--#Include file="MembersServicesUploadphotoincludefile.asp"-->
    </div>
 </div>
  <div>
    <div>
<% currentphoto = 7
TempFile = Photo7
TempPhotoCaption = PhotoCaption7
 %>
<!--#Include file="MembersServicesUploadphotoincludefile.asp"-->
    </div>
 </div>
  <div>
    <div>
<% currentphoto = 8
TempFile = Photo8
TempPhotoCaption = PhotoCaption8
 %>
<!--#Include file="MembersServicesUploadphotoincludefile.asp"-->
</div>
</div>
    <% end if %>
</div>
</div>



  <br>


<!--#Include file="MembersFooter.asp"--> </Body>
</HTML>