<!DOCTYPE HTML >

<HTML>
<HEAD>
 <title>Add an Animal Step 6</title>

</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<!--#Include file="MembersSecurityInclude.asp"-->
<!--#Include file="MembersGlobalvariables.asp"--> 
<% 	Hidelinks = True
	Current3 = "AddAnimals"
	Current1 = "MembersHome"
Current2="MembersHome"
BladeSection = "accounts" 
pagename = BusinessName
	%> 
<!--#Include file="MembersHeader.asp"-->

<div class ="container roundedtopandbottom">
<%

Dim TotalCount
dim rowcount
	dim AwardYear(40000)
	dim Show(40000)
	dim AClass(40000)
	dim Placing(40000)
	dim AwardDescription(40000)

BusinessID = Request.querystring("BusinessID")

AnimalID=Request.Form("AnimalID")
if len(AnimalID) > 0 then
else
AnimalID = Request.querystring("AnimalID")
end if

If len(AnimalID) > 0 then
AnimalID= AnimalID
end if

SpeciesID=Request.Form("SpeciesID")
if len(SpeciesID) > 0 then
else
SpeciesID= Request.querystring("SpeciesID")
end if

NumberofAnimals=request.querystring("NumberofAnimals")







sql2 = "select * from awards where AnimalID = " &  AnimalID & ";" 
'response.Write("AnimalID=" & AnimalID)			
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
    If rs2.eof Then
'response.write(sql2)
TotalCount = 13
rowcount = 1
while (rowcount < 14)
	AwardYearcount = "AwardYear(" & rowcount & ")"
	Showcount = "Show(" & rowcount & ")"
	Placingcount = "Placing(" & rowcount & ")"
	AClasscount = "AClass(" & rowcount & ")"
	AwardDescriptioncount = "AwardDescription(" & rowcount & ")"

	AwardYear(rowcount)=Request.Form(AwardYearcount) 
	Show(rowcount)=Request.Form(Showcount) 
	Placing(rowcount)=Request.Form(Placingcount )
	AClass(rowcount)=Request.Form(AClasscount )
	AwardDescription(rowcount)=Request.Form(AwardDescriptioncount) 
	rowcount = rowcount +1
	
Wend

rowcount = 1

while (rowcount < 14)
	
	If  Len(AwardYear(rowcount)) < 2 Then
			AwardYear(rowcount) = "0" 
	End If 

	If  Len(Show(rowcount)) < 2  Then
		Show(rowcount) = "0" 
	End If 

	If Len(Placing(rowcount))< 2 Then
		Placing(rowcount) = "0" 
	End If 

	If Len(AwardDescription(rowcount))< 2 Then
		AwardDescription(rowcount) = "0" 
	End If 


	str1 = Show(rowcount)
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Show(rowcount)= Replace(str1, "'", "''")
	End If


str1 = Placing(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	Placing(rowcount)= Replace(str1, "'", "''")
End If


str1 = AwardDescription(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	AwardDescription(rowcount)= Replace(str1, "'", "''")
End If


	

Query =  "INSERT INTO Awards ( AnimalID, AwardYear, ShowName, Placing, Type, Awardcomments )" 
	Query =  Query + " Values (" &  AnimalID & ","
	Query =  Query &  " '" & AwardYear(rowcount) & "', " 
	Query =  Query &  " '" & Show(rowcount) & "', " 
	Query =  Query &  " '" & Placing(rowcount) & "', " 
		Query =  Query &  " '" &  AClass(rowcount) & "', " 
   Query =  Query &   " '" & AwardDescription(rowcount) & "' )" 

'response.write("Query=")	
'response.write(Query)	

Conn.Execute(Query) 

rowcount = rowcount +1

wend
end if 

sql2 = "select FullName, Quantity, category from Animals where AnimalID = " &  AnimalID & ";" 	
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
If not rs2.eof Then
  Name = rs2("FullName")
  category = rs2("category")
  Quantity = rs2("Quantity")
end if
%>

<div class="row">
        <div class="col-sm-12">
            <H3>Pricing</H3><a name="Top"></a>
 	        <form action= 'MembersAnimalAdd7.asp?wizard=True&BusinessID=<%=BusinessID %>&AnimalID=<%=AnimalID%>' method = "post" action="/articles/articles/javascript/checkNumeric.asp?ID=<%=siteID%>">
	        <input type = "hidden" name="AnimalID" Value = "<%=  animalID%>" >
        </div>
</div>
	<%= HSpacer %>
<div>
  <div> 
    For Sale?&nbsp;
     Yes<input TYPE="RADIO" name="ForSale" Value = "Yes" checked>
    No<input TYPE="RADIO" name="ForSale" Value = "No" > </td>
  </div>
</div>
	<%= HSpacer %>
<div>
    <div>Free?&nbsp;Yes<input TYPE="RADIO" name="Free" Value = "Yes" >
        No<input TYPE="RADIO" name="Free" Value = "No" checked > </td>
    </div>	
</div>
	<%= HSpacer %>
<div>
    <div>Price&nbsp;
   
        <%=CurrencyCode %><input type=number name='Price' size=10 maxlength=10 style="width: 200px; text-align: left" class='formbox' ><%=CurrencyType %>
    </div>
</div>
	<%= HSpacer %>
<div >
    <div>OBO?
    	<% if OBO = "Yes" Or OBO = True Then %>
			Yes<input TYPE="RADIO" name="OBO" Value = "Yes" checked>
			No<input TYPE="RADIO" name="OBO" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="OBO" Value = "Yes" >
			No<input TYPE="RADIO" name="OBO" Value = "No" checked>
		<% End If %><br />
    <small>OBO encourages potential buyers to make you an offer; however, that does not mean that you have to accept it.</small>
  </div>
</div>
	<%= HSpacer %>
<div> 
	<div>Discount&nbsp; 
	<select size="1" name="discount" style="width: 200px; text-align: left" class='formbox' >
		<option value="" selected></option>
		<option value="10">10%</option>
		<option value="20">20%</option>
		<option value="25">25%</option>
		<option value="30">30%</option>
		<option value="40">40%</option>
		<option value="50">50%</option>
		<option value="60">60%</option>
		<option value="70">70%</option>
		<option value="75">75%</option>
		<option value="80">80%</option>
		<option value="90">90%</option>
		<option value="100">100%</option>
	</select> 
    </div>
</div>
	<%= HSpacer %>
<div>
	<div>Price Comment&nbsp;<br>
	<textarea name="PriceComments" cols="45" rows="2" wrap="VIRTUAL" class ="formbox"><%= PriceComments%></textarea><br>
    <small>Include a short comment like "Great Price!" </small>
   </div>
</div>
<%= HSpacer %>

<% If InStr("2,8,17,49,51,62,63,80,82,90,91,96,98,102,103,107,117", category) > 0 and not speciesID = 28 and not speciesID = 29 and not speciesID = 2 Then %>
<div >
    <div>Embryos For Sale? 
		<% if Donor= "Yes" Or Donor = True Then %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" checked>
			No<input TYPE="RADIO" name="Donor" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" >
			No<input TYPE="RADIO" name="Donor" Value = "No" checked>
		<% End If %>
	</div>
 </div>
	<%= HSpacer %>
<div>
    <div>Embryo Price<br />
    $<input type=number style="width: 200px; text-align: left" class='formbox' name="EmbryoPrice" size=3 maxlength=6 Value= "<%= EmbryoPrice%>"> per embryo.
	</div>
</div>
	<%= HSpacer %>
<% end if

If NumberofAnimals < 2 and not InStr("2,8,17,43, 49,51,62,63,80,82,90,91,96,98,102,103,107,117", category) > 0 and not speciesID = 28 and not speciesID = 13 and not speciesID = 29 and not speciesID = 19 and not speciesID = 21 Then 
	If Len(StudFee) < 2 Then
		StudFee = ""
	End If %>
	<div>
		<div>Stud Fee<br />

			$<input type=number style="width: 200px; text-align: left" class='formbox' name='StudFee' size=10 maxlength=10 Value= "<%= StudFee%>">
		</div>
	</div>
		<%= HSpacer %>
    <div>
		<div>Semen For Sale?
		<% 	if Donor= "Yes" Or Donor = True Then %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" checked>
			No<input TYPE="RADIO" name="Donor" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="Donor" Value = "Yes" >
			No<input TYPE="RADIO" name="Donor" Value = "No" checked>
		<% End If %>
		<br>
		</div>
    </div>
	<%= HSpacer %>
    <div>
		<div>Semen price<br>
            $<input type=Number style="width: 200px; text-align: left" class='formbox' name="SemenPrice" size=3 maxlength=6 Value= "<%= SemenPrice%>"> per straw.
		</div>
	</div>
	<%= HSpacer %>
	<div >
		<div>Offer Pay What You Can Stud Breedings?
		<% 		
		if PayWhatYouCanStud = "Yes" Or PayWhatYouCanStud = True Then %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "Yes" checked>
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "No" >
		<% Else %>
			Yes<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "Yes" >
			No<input TYPE="RADIO" name="PayWhatYouCanStud" Value = "No" checked>
		<% End If %>
		<br>
		<small>
        By implementing Pay What You Can, potential buyers can make offers for Stud Breeding, but you aren't obliged to accept them.
        <br></small>  <br>
		</div>
	</div>

	
		
	<% Else %>
				<input type=hidden  name='StudFee'  Value= "">
	<% End If %>

	<% if Quantity < 2 and not speciesID = 2 then %>
	<div>
		<div >Foundation Animal?&nbsp;<br>

		Yes<input TYPE="RADIO" name="Foundation" Value = "Yes" >
			No<input TYPE="RADIO" name="Foundation" Value = "No" checked>  
        </div>
	</div>
	<%= HSpacer %>
	<% end if %>

<% if not SpeciesID = 33 and not SpeciesID = 19 and not SpeciesID = 13 and not SpeciesID = 21 and not SpeciesID = 28 and not SpeciesID = 29  and not SpeciesID = 30 and NumberofAnimals < 2 then %>

	<div>
		<div>1st Co-owner's Ranch Name&nbsp;<br>
        <input type=text name='CoOwnerBusiness1' value='<%=CoOwnerBusiness1%>' style="width: 320px; text-align: left" class='formbox'  >
        </div>
	</div>
	<%= HSpacer %>
	<div>
		<div>1st Co-owner's Name&nbsp;<br>
		 <input type=text name='CoOwnerName1' value='<%=CoOwnerName1%>' style="width: 320px; text-align: left" class='formbox'  > 
         </div>
	</div>
	<%= HSpacer %>
   	<div>
		<div>1st Co-owner link&nbsp;<br>
		http://<input type=text name='CoOwnerLink1' value='<%=CoOwnerLink1%>' style="width: 280px; text-align: left" class='formbox' >  
        </div>
	</div>
	<%= HSpacer %>
    <div>
		<div>2nd Co-owner's Ranch Name&nbsp;<br>
		<input type=text name='CoOwnerBusiness2' value='<%=CoOwnerBusiness2%>' style="width: 320px; text-align: left" class='formbox'  >
	</div>
		<%= HSpacer %>
	<div>
		<div>2nd Co-owner's Name&nbsp;<br>
		<input type=text name='CoOwnerName2' value='<%=CoOwnerName2%>' style="width: 320px; text-align: left" class='formbox'  >
        </div>
	</div>
		<%= HSpacer %>
	<div>
		<div>2nd Co-owner link&nbsp;<br>
		http://<input type=text name='CoOwnerLink2' value='<%=CoOwnerLink2%>' style="width: 280px; text-align: left" class='formbox' >
        </div>
	</div>
		<%= HSpacer %>
    <div>
		<div>3rd Co-owner's Ranch Name&nbsp;<br>
		<input type=text name='CoOwnerBusiness3' value='<%=CoOwnerBusiness3%>' style="width: 320px; text-align: left" class='formbox'  > 
        </div>
	</div>
		<%= HSpacer %>
	<div>
		<div>3rd Co-owner's Name&nbsp;<br>
		<input type=text name='CoOwnerName3' value='<%=CoOwnerName3%>' style="width: 320px; text-align: left" class='formbox'  >
        </div>
	</div>
		<%= HSpacer %>
	<div>
		<div>3rd Co-owner link&nbsp;<br>
		http://<input type=text name='CoOwnerLink3'  value='<%=CoOwnerLink3%>' style="width: 280px; text-align: left" class='formbox' >
        </div>
	</div>
<% end if %>

		<%= HSpacer %>
	<div>
		<div align = center><br />
            <Input type=Hidden name='SpeciesID' value = <%=SpeciesID%> >
			<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >
			<input type=submit Value = "Next" size = "110" class = "regsubmit2" ><br /><br />
			</form>
		</div>
</div>
</div>
</div>


<!--#Include file="MembersFooter.asp"--> 
</Body>
</HTML>
