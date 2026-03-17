<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="LOTW">
    <title>Livestock Of The World</title>
<!--#Include file="MembersGlobalVariables.asp"-->

  <script type='text/javascript'>
      function checkInput(event) {
          //Get the keyPressed
          var keyPressed = event.keyCode || event.which;
          if (keyPressed < 48 || keyPressed > 57) { return false; }
      }
</script>

<% 
Current3 = "Add"
Current1 = "MembersHome"
Current2="MembersHome"
BladeSection = "accounts" 
pagename = BusinessName %> 
<!--#Include file="MembersHeader.asp"-->

<div class = "container roundedtopandbottom">
<div class="row">
        <div class="col-sm-12">
            <H3>Basics</H3><a name="Top"></a>
        </div>
</div>

<% 
BusinessID=Request.QueryString("BusinessID")
MissingQuantity=Request.QueryString("MissingQuantity")
MissingSpecies=Request.QueryString("MissingSpecies") 
NumberofAnimals = Request.QueryString("NumberofAnimals")
SpeciesID = Request.QueryString("SpeciesID") 
NameMissing = Request.QueryString("NameMissing")
Duplicate = Request.QueryString("Duplicate")
Name = Request.QueryString("Name")
SpeciesName = Request.QueryString("SpeciesName")
NumberofAnimals = Request.QueryString("NumberofAnimals")
%>


<% if Duplicate="True"  then %>
<div class="row">
  <div class="col-12 BODY"  >
       <font color="maroon">You already have a <%=SpeciesName %> listing titled "<%=Name %>".<br /></font><br />
       <%Name = "" %>
  </div>
</div>

<% end if %>


<% if NameMissing="True" or MissingQuantity="True" then %>
<div class="row">
  <div class="col-12 BODY"  >
       <font color="maroon"><b>Please fill in the missing information below:<br /></font>
  </div>
</div>

<% end if %>
 <%= HSpacer %>

<form  name=form method="post" action="MembersAnimalAdd1B.asp?wizard=True&BusinessID=<%=BusinessID %>">

<div class="row">
  <div class="col-12 BODY"  >
  <% if NameMissing="True" then %>
    <font color="maroon"><b>* Name / Title:</b></font>
  <% else %>
      <font color ="maroon">*</font> # Name / Title
  <% end if %>
  </div>
</div>
<div class="row">
  <div class="col-12 body"   >
     <input name="Name" class = "formbox" size = "30" value="<%=Name%>" style="width: 400px; text-align: left" required><br />
      <% if Subscriptionlevel = 1 then %>
       <i><small>Note: This is either the animal's name or a title describing your animal.</small></i>
      <% else %>
             <i><small>Note: This is either the animal's name or a title describing your animal or animals.</small></i>
      <% end if %>
  </div>
</div>

 <%= HSpacer %>

<% if Subscriptionlevel =0 then %>
    <input type="hidden" id="NumberofAnimals" name="NumberofAnimals" value ="1" >
<% else %>
<div class="row">
  <div class="col-12 BODY"  >
<% if MissingQuantity="True" then %>
    <font color="maroon"><b>* # Animals in Listing:</b></font>
  <% else %>
      <font color ="maroon">*</font> # Animals in Listing
  <% end if %>
  </div>
</div>
<div class = Row>

  <div class="col-12">
<input type="number" class = formbox id="NumberofAnimals" name="NumberofAnimals" min="1" max="9000000" value="<%=NumberofAnimals%>" required>
    </div>
</div>
<div class="row">
  <div class="col-12">
        <i><small>Note: If you list only 1 animal you will be able to add alot more information!</small></i>
  </div>
</div>
<% end if %>

<div class="row body">
  <div class="col-12 body" >
    <% if MissingSpecies="True" then %>
    <font color="maroon"><b>* Species</b></font>
  <% else %>
      <font color ="maroon">*</font> Species
  <% end if %>
  </div>
</div>
<div class = Row>
  <div class="col-12">

<% 
Set rs = Server.CreateObject("ADODB.Recordset")

 if len(SpeciesID) > 0 then 
    sql = "select Species from SpeciesAvailable where SpeciesID = " & SpeciesID & " Order by Species "
    rs.Open sql, conn, 3, 3   
    if not rs.eof then	
        SpeciesName = rs("Species")
    end if
    rs.close
    else if len(Preferedspecies) > 0  then 
    if rs.state> 0 then
    rs.close
    end if

     sql = "select Species from SpeciesAvailable where  SpeciesID = " & Preferedspecies & " Order by Species "
 

     rs.Open sql, conn, 3, 3   
        if not rs.eof then	
            Preferedspeciesname = rs("Species")
        end if
    rs.close
    end if

    
end if %>


<% if rs.state = 1 then
    rs.close
   end if%>
<select size="1" name="SpeciesID" class = 'formbox'  style="width: 400px; text-align: left" required>
<% if len(SpeciesName) > 1 then %>
    <option value= "<%=SpeciesID%>" selected><%=Speciesname%></option>
<% else %>
     <option value= "" selected>--</option>
<% end if %>

<% if len(SpeciesID) < 1 and len(Preferedspecies) < 1 then %>
        <option  value= "" selected></option>
<% end if %>


<option  value= "2" >Alpacas</option>
<option  value= "23" >Bees</option>
<option  value= "9" >Bison</option>
<option  value= "34" >Buffalo</option>
<option  value= "18" >Camel</option>
<option  value= "8" >Cattle</option>
<option  value= "13" >Chickens</option>
<option  value= "25" >Crocodiles / Alligators</option>
<option  value= "21" >Deer</option>
<option  value= "3" >Dogs</option>
<option  value= "7" >Donkeys (includes Mules & Hinnies)</option>
<option  value= "15" >Ducks</option>
<option  value= "19" >Emu</option>
<option  value= "22" >Geese</option>
<option  value= "6" >Goats</option>
<option  value= "26" >Guinea Fowl</option>
<option  value= "5" >Horses</option>
<option  value= "4" >Llamas</option>
<option  value= "27" >Musk Ox</option>
<option  value= "28" >Ostriches</option>
<option  value= "29" >Pheasants</option>
<option  value= "30" >Pigeons</option>
<option  value= "12" >Pigs</option>
<option  value= "31" >Quails</option>
<option  value= "11" >Rabbits</option>
<option  value= "10" >Sheep</option>
<option  value= "33" >Snails</option>
<option  value= "14" >Turkeys</option>
<option  value= "17" >Yak</option>

</select>

</div>
</div>




<div class="row">
  <div class="col-12">	
  <br />
    <center><input type="submit" value = "Next" class="regsubmit2" ></center>
</form>
<br /><br />
</div>
</div>
</div>
<br /><br />

<!--#Include file="MembersFooter.asp"--> 
</Body>
</HTML>