<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<style>

.body {font-family : verdana, Arial, Helvetica, sans-serif;
	font-size : 13px;
	line-height : 16px;
	color : black;
	font-weight: normal;
}

A.body {font-family : verdana, Arial, Helvetica, sans-serif;
	font-size : 13px;
	line-height : 16px;
	color : brown;
	font-weight: 400;
	text-decoration :none;
}
A.body:Hover {
	color : black;
	text-decoration : none;
}


H2{
	font-family : Arial, Helvetica, sans-serif;
	font-size : 18px;
	color : black;
	line-height : 20px;
	font-weight : 400;
	margin-left: 0px;
	margin-bottom: 0px;
	margin-top: 0px;
	text-decoration : none;
}


.roundedtop
{
border-top:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
padding:5px 10px; 
box-shadow: 5px 5px 10px #ababab;
background-color: #EEDD99 ;
margin:0px;

border-top-left-radius:5px;
border-top-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
}

.roundedBottom
{
border-bottom:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
margin-top:0px;
 margin-bottom:10px;
 margin-right:0px;
 margin-left:0px;
padding:5px 10px; 
background:white;

box-shadow: 5px 5px 10px #ababab;
border-bottom-left-radius:5px;
border-bottom-right-radius:5px;
-moz-border-radius-bottomleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:5px; /* Firefox 3.6 and earlier */
}


.tabBottomOff
{
border-bottom:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
margin-top:0px;
 margin-bottom:10px;
 margin-right:0px;
 margin-left:0px;
padding:5px 10px; 
background:white;

box-shadow: 5px 5px 10px #ababab;
border-bottom-left-radius:5px;
border-bottom-right-radius:5px;
-moz-border-radius-bottomleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:5px; /* Firefox 3.6 and earlier */
}

.tabBottomOn
{
border-bottom:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
margin-top:0px;
 margin-bottom:10px;
 margin-right:0px;
 margin-left:0px;
padding:5px 10px; 
background:#EEDD99;

box-shadow: 5px 5px 10px #ababab;
border-bottom-left-radius:5px;
border-bottom-right-radius:5px;
-moz-border-radius-bottomleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:5px; /* Firefox 3.6 and earlier */
}

.tabtopoff
{
border-top:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
padding:5px 10px; 
box-shadow: 5px 5px 10px #ababab;
background-color: #EEDD99 ;
margin:0px;
background:white;
border-top-left-radius:5px;
border-top-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
}

.tabtopon
{
border-top:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
padding:5px 10px; 
box-shadow: 5px 5px 10px #ababab;
background-color: #EEDD99 ;
margin:0px;
background:#EEDD99;
border-top-left-radius:5px;
border-top-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
}


.AEtabtopoff
{
border-top:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
padding:5px 10px; 
box-shadow: 5px 5px 10px #ababab;
margin:0px;
border-top-left-radius:5px;
border-top-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
}

		.tooltip {
			border-bottom: 1px dotted #000000; color: #000000; outline: none;
			cursor: help; text-decoration: none;
			position: relative;
		}
		.tooltip span {
			margin-left: -999em;
			position: absolute;
		}
		.tooltip:hover span {
			border-radius: 5px 5px; -moz-border-radius: 5px; -webkit-border-radius: 5px; 
			box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.1); -webkit-box-shadow: 5px 5px rgba(0, 0, 0, 0.1); -moz-box-shadow: 5px 5px rgba(0, 0, 0, 0.1);
			font-family: Calibri, Tahoma, Geneva, sans-serif;
			position: absolute; left: 1em; top: 2em; z-index: 99;
			margin-left: 0; width: 250px;
		}
		.tooltip:hover img {
			border: 0; margin: -10px 0 0 -55px;
			float: left; position: absolute;
		}
		.tooltip:hover em {
			font-family: Candara, Tahoma, Geneva, sans-serif; font-size: 1.2em; font-weight: bold;
			display: block; padding: 0.2em 0 0.6em 0;
		}
		.classic { padding: 0.8em 1em; }
		.custom { padding: 0.5em 0.8em 0.8em 2em; }
		* html a:hover { background: transparent; }
		.classic {background: #EEDD99; border: 1px solid #eeeeee; }
		.critical { background: #FFCCAA; border: 1px solid #FF3334;	}
		.help { background: #9FDAEE; border: 1px solid #2BB0D7;	}
		.info { background: #EEDD99; border: 1px solid #eeeeee; }
		.warning { background: #FFFFAA; border: 1px solid #FFAD33; }

	
	
.pageroundedtop
{
border-top:1px solid #a1a1a1;
border-left:1px solid #a1a1a1;
border-right:1px solid #a1a1a1;
padding:5px 10px; 
box-shadow: 0px 0px 0px #ababab;
background-color: white ;
margin:0px;
border-top-left-radius:25px;
border-top-right-radius:25px;
-moz-border-radius-topleft:25px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:25px; /* Firefox 3.6 and earlier */
border-bottom-left-radius:5px;
border-bottom-right-radius:5px;
-moz-border-radius-bottomleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:5px; /* Firefox 3.6 and earlier */
}	


.Regsubmit2
{
background-color : #EEDD99;
border-bottom:1px solid #EEDD99;
border-left:1px solid #EEDD99;
border-right:1px solid #EEDD99;
margin-top:1px solid #EEDD99;
margin-bottom:10px;
margin-right:0px;
margin-left:0px;
padding:5px 10px; 
background:#EEDD99;
text-align: center;
box-shadow: 5px 5px 5px #ababab;
border-top-left-radius:5px;
border-top-right-radius:5px;
border-bottom-left-radius:5px;
border-bottom-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:5px; /* Firefox 3.6 and earlier */
}
 
 
.regsubmit2
{
background-color : #EEDD99;
border-bottom:1px solid #EEDD99;
border-left:1px solid #EEDD99;
border-right:1px solid #EEDD99;
margin-top:1px solid #EEDD99;
margin-bottom:10px;
margin-right:0px;
margin-left:0px;
padding:5px 10px; 
background:#EEDD99;
text-align: center;
box-shadow: 5px 5px 5px #ababab;
border-top-left-radius:5px;
border-top-right-radius:5px;
border-bottom-left-radius:5px;
border-bottom-right-radius:5px;
-moz-border-radius-topleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-topright:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomleft:5px; /* Firefox 3.6 and earlier */
-moz-border-radius-bottomright:5px; /* Firefox 3.6 and earlier */
}

</style>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="AdminGlobalVariablesNoBackground.asp"-->

<% PackageID = request.querystring("PackageID")
ShowOnAPackages= request.QueryString("ShowOnAPackages")

If ShowOnAPackages="True" then
Query =  " UPDATE Package Set  ShowOnAPackages = True" 
Query =  Query & " where PackageID = " & PackageID & ";" 
Conn.Execute(Query) 
end if

If ShowOnAPackages="False" then
Query =  " UPDATE Package Set  ShowOnAPackages = False" 
Query =  Query & " where PackageID = " & PackageID & ";" 
Conn.Execute(Query) 
end if

 sql = "select * from Package where PackageID = " & PackageID & " and PeopleID = " & Session("PeopleID") & " order by PackageID DESC"

    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
ShowOnAPackages = rs("ShowOnAPackages")
rs.close

%>


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr>
     <td class = "roundedtop" align = "left" >
		<H2><div align = "left">Package Status</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" >
<table><tr><td width = "250" class = "body">
<% if ShowOnAPackages= "True" then %>
  <b>Published</b>
   <form  name=form method="post" action="AdminPackagePublishFrame.asp?PackageID=<%=PackageID%>&ShowOnAPackages=False">
	<center><input type="Submit"  value="Un-Publish!"  class = "regsubmit2"  <%=Disablebutton %> ></center>
  		</form>
  <% else %>
  <b>Draft</b>
   <form  name=form method="post" action="AdminPackagePublishFrame.asp?PackageID=<%=PackageID%>&ShowOnAPackages=True">
	<center><input type="Submit"  value="Publish!"  class = "regsubmit2"  <%=Disablebutton %> ></center>
  		</form>
<%end if  %>
    
</td>  
</tr>
</table>
    </td>
  </tr></table>      
   </Body>
</HTML>
