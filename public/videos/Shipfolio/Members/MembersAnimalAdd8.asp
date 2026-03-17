<!DOCTYPE HTML >

<HTML>
<HEAD>
 <title>Add an Animal Step 6</title>
<% AnimalID = request.querystring("AnimalID")
	
	%>
</HEAD>
<BODY >
<!--#Include file="MembersSecurityInclude.asp"-->
<!--#Include file="MembersGlobalvariables.asp"--> 

<% Current1 = "MembersHome"
Current2="MembersHome"
BladeSection = "accounts" 
pagename = BusinessName
%>
<!--#Include file="MembersHeader.asp"-->

<div class ="container roundedtopandbottom">





<%
	
AnimalID=  AnimalID	
	Set rs = Server.CreateObject("ADODB.Recordset")
sql = "select * from Photos where animalid = " & AnimalID
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3
If rs.eof Then
Query =  "INSERT INTO Photos (AnimalID)" 
Query =  Query & " Values (" &  AnimalID & ")"
Conn.Execute(Query) 
rs.close

sql = "select * from Photos where AnimalID = " & AnimalID
rs.Open sql, conn, 3, 3
End If 
FiberAnalysis = rs("FiberAnalysis")
Histogram= rs("Histogram")
ARI = rs("ARI")


AnimalVideo = rs("AnimalVideo")
If Len(rs("Photo1")) > 2 Then
File1= rs("Photo1")
else
File1 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("Photo2")) > 2 Then
File2= rs("Photo2")
else
File2 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("Photo3")) > 2 Then
File3= rs("Photo3")
else
File3 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("Photo4")) > 2 Then
File4= rs("Photo4")
else
File4 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("Photo5")) > 2 Then
File5= rs("Photo5")
else
File5 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("Photo6")) > 2 Then
File6= rs("Photo6")
else
File6 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("Photo7")) > 2 Then
File7= rs("Photo7")
else
File7 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("Photo8")) > 2 Then
File8= rs("Photo8")
else
File8 = "/uploads/ImageNotAvailable.jpg"
End If

If Len(rs("Photo9")) > 2 Then
File9= rs("Photo9")
else
File9 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo10")) > 2 Then
File10= rs("Photo10")
else
File10 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo11")) > 2 Then
File11= rs("Photo11")
else
File11 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo12")) > 2 Then
File12= rs("Photo12")
else
File12 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo13")) > 2 Then
File13= rs("Photo13")
else
File13 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo14")) > 2 Then
File14= rs("Photo14")
else
File14 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo15")) > 2 Then
File15= rs("Photo15")
else
File15 = "/uploads/ImageNotAvailable.jpg"
End If
If Len(rs("Photo16")) > 2 Then
File16= rs("Photo16")
else
File16 = "/uploads/ImageNotAvailable.jpg"
End If

If len(rs("PhotoCaption1")) > 1 then
PhotoCaption1 = rs("PhotoCaption1")
End If 
If len(rs("PhotoCaption2")) > 1 then
PhotoCaption2 = rs("PhotoCaption2")
End If 
If len(rs("PhotoCaption3")) > 1 then
PhotoCaption3 = rs("PhotoCaption3")
End If 
If len(rs("PhotoCaption4")) > 1 then
PhotoCaption4 = rs("PhotoCaption4")
End If 
If len(rs("PhotoCaption5")) > 1 then
PhotoCaption5 = rs("PhotoCaption5")
End If 
If len(rs("PhotoCaption6")) > 1 then
PhotoCaption6 = rs("PhotoCaption6")
End If 
If len(rs("PhotoCaption1")) > 1 then
PhotoCaption1 = rs("PhotoCaption1")
End If 
If len(rs("PhotoCaption7")) > 1 then
PhotoCaption7 = rs("PhotoCaption7")
End If 
If len(rs("PhotoCaption8")) > 1 then
PhotoCaption8 = rs("PhotoCaption8")
End If 
If len(rs("PhotoCaption9")) > 1 then
PhotoCaption9 = rs("PhotoCaption9")
End If 
If len(rs("PhotoCaption10")) > 1 then
PhotoCaption10 = rs("PhotoCaption10")
End If 
If len(rs("PhotoCaption11")) > 1 then
PhotoCaption11 = rs("PhotoCaption1")
End If 
If len(rs("PhotoCaption12")) > 1 then
PhotoCaption12 = rs("PhotoCaption12")
End If 
If len(rs("PhotoCaption13")) > 1 then
PhotoCaption13 = rs("PhotoCaption13")
End If 
If len(rs("PhotoCaption14")) > 1 then
PhotoCaption14 = rs("PhotoCaption14")
End If 
If len(rs("PhotoCaption15")) > 1 then
PhotoCaption15 = rs("PhotoCaption15")
End If 
If len(rs("PhotoCaption16")) > 1 then
PhotoCaption16 = rs("PhotoCaption16")
End If 

str1 = ARI
str2 = "''"
If InStr(str1,str2) > 0 Then
ARI= Replace(str1,  str2, "'")
End If  

'str1 = lcase(ARI)
'str2 = "uploads"
'str3 = "http://"
'If  InStr(str1,str2) > 0 and Not(InStr(str1,str3) > 0) Then
'ARI= "https://www.AlpacaInfinity.com/" &ARI
'End If 
'
'str1 = lcase(ARI) 
'str2 = "http://www.alpacainfinity.com"
'If InStr(str1,str2) > 0 Then
'ARI=  Replace(str1, str2 , "http://www.livestockoftheworld.com")
'End If  

	

str1 = Histogram
str2 = "''"
If InStr(str1,str2) > 0 Then
Histogram= Replace(str1,  str2, "'")
End If  
            
'str1 = lcase(Histogram)
'str2 = "uploads"
'str3 = "http://://www.livestockoftheworld.com/"
'If  InStr(str1,str2) > 0 and Not(InStr(str1,str3) > 0) Then
'Histogram= "https://www.livestockoftheworld.com/" & Histogram
'End If 
'str1 = lcase(Histogram) 
'str2 = "http://www.alpacainfinity.com"
'If InStr(str1,str2) > 0 Then
'Histogram  =  Replace(str1, str2 , "https://www.livestockoftheworld.com")
'End If  

str1 = FiberAnalysis
str2 = "''"
If InStr(str1,str2) > 0 Then
FiberAnalysis= Replace(str1,  str2, "'")
End If  

str1 = lcase(FiberAnalysis) 
str2 = "https://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
FiberAnalysis=  Replace(str1, str2 , "https://www.livestockoftheworld.com")
End If  

str1 = File1
str2 = "''"
If InStr(str1,str2) > 0 Then
File1= Replace(str1,  str2, "'")
End If  	 

str1 = File2
str2 = "''"
If InStr(str1,str2) > 0 Then
File2= Replace(str1,  str2, "'")
End If  	
			
str1 = File3
str2 = "''"
If InStr(str1,str2) > 0 Then
File3= Replace(str1,  str2, "'")
End If  	 
			
str1 = File4
str2 = "''"
If InStr(str1,str2) > 0 Then
File4= Replace(str1,  str2, "'")
End If  	 
			
str1 = File5
str2 = "''"
If InStr(str1,str2) > 0 Then
File5= Replace(str1,  str2, "'")
End If  	 
			
str1 = File6
str2 = "''"
If InStr(str1,str2) > 0 Then
File6= Replace(str1,  str2, "'")
End If  	
			
str1 = File7
str2 = "''"
If InStr(str1,str2) > 0 Then
File7= Replace(str1,  str2, "'")
End If  
			
str1 = File8
str2 = "''"
If InStr(str1,str2) > 0 Then
File8= Replace(str1,  str2, "'")
End If  

str1 = File9
str2 = "''"
If InStr(str1,str2) > 0 Then
File9= Replace(str1,  str2, "'")
End If  

str1 = File10
str2 = "''"
If InStr(str1,str2) > 0 Then
File10= Replace(str1,  str2, "'")
End If  

str1 = File11
str2 = "''"
If InStr(str1,str2) > 0 Then
File11= Replace(str1,  str2, "'")
End If  

str1 = File12
str2 = "''"
If InStr(str1,str2) > 0 Then
File12= Replace(str1,  str2, "'")
End If  

str1 = File13
str2 = "''"
If InStr(str1,str2) > 0 Then
File13= Replace(str1,  str2, "'")
End If  

str1 = File14
str2 = "''"
If InStr(str1,str2) > 0 Then
File14= Replace(str1,  str2, "'")
End If  

str1 = File15
str2 = "''"
If InStr(str1,str2) > 0 Then
File15= Replace(str1,  str2, "'")
End If  

str1 = File16
str2 = "''"
If InStr(str1,str2) > 0 Then
File16= Replace(str1,  str2, "'")
End If  


str1 = lcase(File1) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File1 =  Replace(str1, str2 , "http://www.LivestockOfTheworld.com")
End If  
str1 = lcase(File2) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File2 =  Replace(str1, str2 , "http://www.livestockoftheworld.com")
End If  
str1 = lcase(File3) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File3 =  Replace(str1, str2 , "http://www.livestockoftheworld.com")
End If  
str1 = lcase(File4) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File4 =  Replace(str1, str2 , "http://www.livestockoftheworld.com")
End If  
str1 = lcase(File5) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File5 =  Replace(str1, str2 , "http://www.livestockoftheworld.com")
End If  
str1 = lcase(File6) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File6 =  Replace(str1, str2 , "http://www.livestockoftheworld.com")
End If  
str1 = lcase(File7) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File7 =  Replace(str1, str2 , "http://www.livestockoftheworld.com")
End If  
str1 = lcase(File8) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
File8 =  Replace(str1, str2 , "http://www.livestockoftheworld.com")
End If  


str1 = lcase(File1) 
str2 = "livestockofamerica"
If InStr(str1,str2) > 0 Then
File1 =  Replace(str1, str2 , "livestockoftheworld")
End If  
str1 = lcase(File2) 
str2 = "livestockofamerica"
If InStr(str1,str2) > 0 Then
File2 =  Replace(str1, str2 , "livestockoftheworld")
End If  
str1 = lcase(File3) 
str2 = "livestockofamerica"
If InStr(str1,str2) > 0 Then
File3 =  Replace(str1, str2 , "livestockoftheworld")
End If  
str1 = lcase(File4) 
str2 = "livestockofamerica"
If InStr(str1,str2) > 0 Then
File4 =  Replace(str1, str2 , "livestockoftheworld")
End If  
str1 = lcase(File5) 
str2 = "livestockofamerica"
If InStr(str1,str2) > 0 Then
File5 =  Replace(str1, str2 , "livestockoftheworld")
End If  
str1 = lcase(File6) 
str2 = "livestockofamerica"
If InStr(str1,str2) > 0 Then
File6 =  Replace(str1, str2 , "livestockoftheworld")
End If  
str1 = lcase(File7) 
str2 = "livestockofamerica"
If InStr(str1,str2) > 0 Then
File7 =  Replace(str1, str2 , "livestockoftheworld")
End If  
str1 = lcase(File8) 
str2 = "livestockofamerica"
If InStr(str1,str2) > 0 Then
File8 =  Replace(str1, str2 , "livestockoftheworld")
End If  

rs.close
 str1 = Name
str2 = "''"
If InStr(str1,str2) > 0 Then
Name= Replace(str1,  str2, "'")
End If  

set rs2=nothing
set conn = nothing
Session("AnimalID") = AnimalID 

%>


<div class="container my-5">
    <H3>Done</H3><a name="Top"></a>
    <center>Your animal listing has been successfully be added.</center>
    <h1 class="mb-4">Photos & Other Uploads</h1>

    <div class="row">
        <div class="col-lg-8">
            <%
            ' ===================================================================
            '  DOCUMENTS SECTION
            ' ===================================================================
            if SpeciesID <> 22 and SpeciesID <> 19 and SpeciesID <> 15 and SpeciesID <> 14 and SpeciesID <> 13 then
            %>
                <div id="Registration" class="card mb-4">
                    <h5 class="card-header">Registration Certificate</h5>
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-md-3 text-center">
                                <% if len(ARI) > 1 then %>
                                    <a href="<%=ARI%>" target="_blank">
                                        <img src="images/ARIThumb.jpg" class="img-thumbnail" alt="Registration Thumbnail">
                                    </a>
                                    <a href="<%=ARI%>" target="_blank" class="d-block mt-2">View Certificate</a>
                                <% else %>
                                    <p class="text-muted">No Certificate</p>
                                <% end if %>
                            </div>
                            <div class="col-md-9">
                                <% if len(ARI) > 1 then %>
                                    <form action='membersARIRemove.asp' method="post">
                                        <input type="hidden" name="AnimalID" value="<%=AnimalID%>">
                                        <button type="submit" class="btn btn-danger">Remove</button>
                                    </form>
                                <% else %>
                                    <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersARIUpload.asp">
                                        <div class="input-group">
                            
                                            <input name="attach1" type="file" class="form-control">
                                            <button type="submit" class="btn btn-outline-secondary">Upload</button>
                                        </div>
                                    </form>
                                <% end if %>
                            </div>
                        </div>
                    </div>
                </div>

                <% if speciesID = 2 or speciesID = 4 or speciesID = 6 or speciesID = 10 or speciesID = 11 then %>
                    <div id="Histogram" class="card mb-4">
                        <h5 class="card-header">Histogram</h5>
                        <div class="card-body">
                             <div class="row align-items-center">
                                <div class="col-md-3 text-center">
                                    <% if len(Histogram) > 1 then %>
                                        <a href="<%=Histogram%>" target="_blank"><img src="images/HistogramThumb.jpg" class="img-thumbnail" alt="Histogram Thumbnail"></a>
                                        <a href="<%=Histogram%>" target="_blank" class="d-block mt-2">View Histogram</a>
                                    <% else %>
                                        <p class="text-muted">No Histogram</p>
                                    <% end if %>
                                </div>
                                <div class="col-md-9">
                                    <% if len(Histogram) > 1 then %>
                                        <form action='membersHistogramRemove.asp' method="post">
                                            <input type="hidden" name="AnimalID" value="<%=AnimalID%>">
                                            <button type="submit" class="btn btn-danger">Remove</button>
                                        </form>
                                    <% else %>
                                        <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersHistogramUpload.asp">
                                            <div class="input-group">
                                                <input name="attach1" type="file" class="form-control">
                                                <button type="submit" class="btn btn-outline-secondary">Upload</button>
                                            </div>
                                        </form>
                                    <% end if %>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="FiberAnalysis" class="card mb-4">
                        <h5 class="card-header">Fiber Analysis</h5>
                         <div class="card-body">
                             <div class="row align-items-center">
                                <div class="col-md-3 text-center">
                                    <% if len(FiberAnalysis) > 1 then %>
                                        <a href="<%=FiberAnalysis%>" target="_blank"><img src="images/FiberAnalysisThumb.jpg" class="img-thumbnail" alt="Fiber Analysis Thumbnail"></a>
                                        <a href="<%=FiberAnalysis%>" target="_blank" class="d-block mt-2">View Analysis</a>
                                    <% else %>
                                        <p class="text-muted">No Analysis</p>
                                    <% end if %>
                                </div>
                                <div class="col-md-9">
                                    <% if len(FiberAnalysis) > 1 then %>
                                        <form action='membersFiberAnaylsisRemove.asp' method="post">
                                            <input type="hidden" name="AnimalID" value="<%=AnimalID%>">
                                            <button type="submit" class="btn btn-danger">Remove</button>
                                        </form>
                                    <% else %>
                                        <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersFiberAnalysisUpload.asp">
                                            <div class="input-group">
                                                <input name="attach1" type="file" class="form-control">
                                                <button type="submit" class="btn btn-outline-secondary">Upload</button>
                                            </div>
                                            <div class="form-text mt-2">PDF or JPG formats only.</div>
                                        </form>
                                    <% end if %>
                                </div>
                            </div>
                        </div>
                    </div>
                <% end if %>
            <% end if %>
            
            <div id="Video" class="card mb-4">
                <h5 class="card-header">Video</h5>
                <div class="card-body">
                    <% if SubscriptionLevel < 3 then %>
                        <div class="alert alert-warning">
                            Basic memberships don't include video. <a href="MembersRenewSubscription.asp?BusinessID=<%=BusinessID%>" class="alert-link">Click here to upgrade.</a>
                        </div>
                    <% else %>
                        <% if len(AnimalVideo) > 4 then %>
                            <div class="ratio ratio-16x9 mb-3">
                                <%
                                ' This logic to resize the video is not reliable.
                                ' Modern embeds are responsive by default.
                                ' Keeping the original variable assignment but not the replace logic.
                                str1 = AnimalVideo
                                ' AnimalVideo = Replace(str1, "width", "width = 300 width") ' <-- This is commented out for better display
                                Response.Write(AnimalVideo)
                                %>
                            </div>
                            <form action='membersVideoRemove.asp' method="post">
                                <input type="hidden" name="AnimalID" value="<%=AnimalID%>">
                                <button type="submit" class="btn btn-danger">Remove Video</button>
                            </form>
                        <% else %>
                            <form method="POST" action="membersAnimalVideoupload.asp">
                                <div class="mb-3">
                                    <label for="videoEmbed" class="form-label">YouTube Embed Code</label>
                                    <textarea id="videoEmbed" name="TempVideo" rows="4" class="form-control"></textarea>
                                    <div class="form-text">Copy and paste the <b>embed</b> code from the YouTube video share options.</div>
                                </div>
                                <input name="AnimalID" value="<%=AnimalID%>" type="hidden">
                                <input name="PeopleID" value="<%=PeopleID%>" type="hidden">
                                <button type="submit" class="btn btn-primary">Submit Video</button>
                            </form>
                        <% end if %>
                    <% end if %>
                </div>
            </div>

            <div id="Photos">
                <h2 class="mb-3">Photos</h2>
                <div class="row row-cols-1 row-cols-sm-2 row-cols-xl-3 g-4">
                    <%
                    ' Photo Slot 1
                    currentphoto = 1
                    TempFile = File1
                    TempPhotoCaption = PhotoCaption1
                    %>
                    <div class="col">
                        </div>

                    <% if SubscriptionLevel > 1 then %>
                        <%
                        ' Photo Slot 2
                        currentphoto = 2
                        TempFile = File2
                        TempPhotoCaption = PhotoCaption2
                        %>
                        <div class="col">
                            </div>
                        <%
                        ' Photo Slot 3
                        currentphoto = 3
                        TempFile = File3
                        TempPhotoCaption = PhotoCaption3
                        %>
                        <div class="col">
                            </div>
                        <%
                        %>
                    <% end if %>
                </div>
            </div>

        </div>

        <div class="col-lg-4 order-lg-first">
            <div class="card sticky-top" style="top: 2rem;">
                 <h5 class="card-header">Upload Requirements</h5>
                 <div class="card-body">
                    <ul class="list-unstyled">
                        <li class="mb-2">Images must be under 1MB.</li>
                        <li class="mb-2"> Photos must be JPG, JPEG, or PNG.</li>
                        <% if SpeciesID <> 22 and SpeciesID <> 19 and SpeciesID <> 15 and SpeciesID <> 14 and SpeciesID <> 13 then %>
                            <li class="mb-2">Certificates and analyses can be PDF.</li>
                        <% end if %>
                    </ul>
                 </div>
            </div>
        </div>
    </div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


<META HTTP-EQUIV="Pragma" CONTENT="no-cache">

<!--#Include file="MembersFooter.asp"--> 
</Body>
</HTML>
