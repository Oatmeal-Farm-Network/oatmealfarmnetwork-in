<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="generator" content="Global Grange">
    <title>Harvest Hub</title>
<!--#Include file="Membersglobalvariables.asp"-->
      <link rel="stylesheet" href="https://www.harvesthub.world/members/MembersStyle.css">
<% 
 

sql = "select  * from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
	 PageTitle = rs("RanchHomeHeading")
    RanchHomeText = rs("RanchHomeText") & rs("RanchHomeText2")
	BusinessID   = rs("BusinessID")
	AddressID  = rs("AddressID")
	Logo = rs("Logo")
	Header = rs("Header")
	str1 = RanchHomeText
str2 = vblf
end if 



%>


</head>
<body >

<div class = "rows">
    <div class = "col-12 body" >
      <form action= 'MembersListingDescriptionHandleForm.asp' method = "post">
        <a name="ListingDescription"></a>
        <H1>Description</H1>
            <div align = "left"><font color ="maroon"><b>Your  Changes Have Been Made.</b></font></div>

Title<br>
 <input type = "text" name="PageTitle" value= "<%=PageTitle%>" class ="formbox" size ="60" ><br /><br />
  
     <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
    <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		
    <script language="javascript1.2" type="text/javascript">
        // attach the editor to the textarea with the identifier 'textarea1'.
        WYSIWYG.attach("ListingDescription", mysettings);
        mysettings.Width = "640px"
        mysettings.Height = "300px"
    </script>



        <TEXTAREA NAME="ListingDescription" ID="ListingDescription" cols="75" rows="92" wrap="file"><%=RanchHomeText%></textarea>
        <br /><small><b>Copy and Paste</b> - Copy and pasting does not work with some browsers; however, the hotkeys CTL + C (Copy) and CTL + V (Paste) will work.</small><br /><br />
	
        <input type = "hidden" name="category" Value = "<%=category%>">
		<input type = "hidden" name="PeopleID" Value = "<%=PeopleID%>">
		<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >
		<div align = "right"><input type="submit" class = "regsubmit2" value="Submit" ></div>
		<BR>
    </form>
   </div>
</div>



<%conn.close
set Conn = nothing %>

 </Body>
</HTML>
