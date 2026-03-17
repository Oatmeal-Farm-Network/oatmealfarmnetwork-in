<!DOCTYPE html>
<html lang="en">
<!--#Include virtual="/globalvariables.asp"--> 
<link rel="stylesheet" type="text/css" href="FrameStyle.css">
 <style>

body {
	background-image : url("");
	background-size: 1900px 900px;
	background-color : white;
	background-repeat : no-repeat;
	background-attachment:fixed;
	background-position:center;
	background-position:top;
	}	

</style>
<%
  CurrentpeopleID  = Request.QueryString("CurrentPeopleID")
    sql = "select AddressID from People where PeopleID = " & CurrentPeopleID & ";"
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3
    if not rs.eof then
       AddressID = rs("AddressID")
      end if
  rs.close  
  
  sql = "select  * from Address where AddressID= " & AddressID
	rs.Open sql, conn, 3, 3
	If not rs.eof then
		PeopleLocationStreet = rs("AddressStreet")
		PeopleLocationApt = rs("AddressApt")
		PeopleLocationCity = rs("AddressCity")
		PeopleLocationState = rs("AddressState")
		PeopleLocationZip = rs("AddressZip")
		PeopleLocationCountry = rs("AddressCountry")
	 	end if
   rs.close


 PeopleAddress =  PeopleLocationStreet &  " " & PeopleLocationCity & ", " & PeopleLocationState & " " & PeopleLocationZip & " " & PeopleLocationCountry
 'PeopleAddress = "1600 Amphitheatre Pky, Mountain View, CA"
		
 %>
  <head>
    <meta charset="utf-8" />
    <script src="//maps.google.com/maps?file=api&amp;v=2.x&amp;key=AIzaSyBNTQRAs9CE8N1bWyKq59-V9-nExB8hp-M" type="text/javascript"></script>
    <script type="text/javascript">

        var map = null;
        var geocoder = null;


        function showAddress(address) {
            if (geocoder) {
                geocoder.getLatLng(
          address,
          function(point) {
              if (!point) {
                  alert(address + " not found");
              } else {
                  map.setCenter(point, 13);
                  var marker = new GMarker(point);
                  map.addOverlay(marker);

                
              }
          }
        );
            }
        }

        function initialize() {
            if (GBrowserIsCompatible()) {
                map = new GMap2(document.getElementById("map_canvas"));
                map.setCenter(new GLatLng(37.4419, -122.1419), 13);
                geocoder = new GClientGeocoder();
            }
            showAddress(Form.address.value); return false
        }

       
    </script>
    


  </head>

  <body onload="initialize()" onunload="GUnload()" bgcolor = "white" background = ""><form action="#" name="Form" onsubmit="showAddress(this.address.value); return false"><input type="hidden" size="60" name="address" value="<%= PeopleAddress%>" />
      <div id="map_canvas" style="width: 200px; height: 300px"></div>
    </form></body>
</html>


