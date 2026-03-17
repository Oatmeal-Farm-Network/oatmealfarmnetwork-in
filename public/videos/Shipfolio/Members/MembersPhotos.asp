<!DOCTYPE html>
<%@ Language=VBScript %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">

<link rel="stylesheet" href="https://www.livestockoftheworld.com/members/Membersstyle.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="membersGlobalVariables.asp"-->
<% Current1="Animals"
Current2 = "EditAnimals" 
Current3 = "Photos" %> 
<!--#Include file="MembersHeader.asp"-->
<% subscriptionlevel = 4
' ===================================================================
'  PAGE SETUP & DATA FETCHING
' ===================================================================

' --- Helper Functions ---
Function GetNumericParam(paramName)
    Dim rawValue
    rawValue = Request.QueryString(paramName)
    If Len(rawValue) < 1 Then rawValue = Request.Form(paramName)
    If IsNumeric(rawValue) Then GetNumericParam = CLng(rawValue) Else GetNumericParam = 0
End Function

Function Sanitize(dbValue)
    If IsNull(dbValue) Or Len(dbValue) = 0 Then Sanitize = "" Else Sanitize = Replace(Trim(dbValue), "''", "'")
End Function

' --- Get Animal ID ---
Dim AnimalID
AnimalID = GetNumericParam("AnimalID")
If AnimalID = 0 Then AnimalID = GetNumericParam("AnimalID")

If AnimalID <= 0 Then
    Response.Write "<h1>Error: A valid Animal ID is required.</h1>"
    Response.End
End If
Session("AnimalID") = AnimalID

' --- Database Interaction ---
Dim ARI, Histogram, FiberAnalysis
Dim arrPhotos(16), arrCaptions(16)

sql = "SELECT a.*, p.AnimalID AS PhotoRecordID, p.Photo1, p.Photo2, p.Photo3, p.Photo4, p.Photo5, p.Photo6, p.Photo7, p.Photo8, p.Photo9, p.Photo10, p.Photo11, p.Photo12, p.Photo13, p.Photo14, p.Photo15, p.Photo16, p.PhotoCaption1, p.PhotoCaption2, p.PhotoCaption3, p.PhotoCaption4, p.PhotoCaption5, p.PhotoCaption6, p.PhotoCaption7, p.PhotoCaption8, p.PhotoCaption9, p.PhotoCaption10, p.PhotoCaption11, p.PhotoCaption12, p.PhotoCaption13, p.PhotoCaption14, p.PhotoCaption15, p.PhotoCaption16, p.ARI, p.Histogram, p.FiberAnalysis, p.AnimalVideo FROM Animals a LEFT JOIN Photos p ON a.AnimalID = p.AnimalID WHERE a.AnimalID = ?"

Const adInteger = 3
Const adParamInput = 1
Set cmd = Server.CreateObject("ADODB.Command")
Set cmd.ActiveConnection = conn
cmd.CommandText = sql
cmd.Parameters.Append cmd.CreateParameter("@AnimalID", adInteger, adParamInput, , AnimalID)
Set rs = cmd.Execute

If rs.EOF Then
    Response.Write "<h1>Error: Animal with AnimalID " & AnimalID & " not found.</h1>"
    rs.Close: Set rs = Nothing
    Set cmd = Nothing
    conn.Close: Set conn = Nothing
    Response.End
End If

If IsNull(rs("PhotoRecordID")) Then
    rs.Close
    Dim insertSQL
    insertSQL = "INSERT INTO Photos (AnimalID) VALUES (?)"
    Set cmd.CommandText = insertSQL
    cmd.Execute
    Set cmd.CommandText = sql
    Set rs = cmd.Execute
End If

' --- Populate Variables and Arrays ---
name = Sanitize(rs("FullName"))
SpeciesID = rs("SpeciesID")
NumberOfAnimals = rs("NumberOfAnimals")
BusinessID = rs("BusinessID") ' Needed for upgrade link


ARI = Sanitize(rs("ARI"))
Histogram = Sanitize(rs("Histogram"))
FiberAnalysis = Sanitize(rs("FiberAnalysis"))
AnimalVideo = Sanitize(rs("AnimalVideo"))

For i = 1 To 16
    arrPhotos(i) = Sanitize(rs("Photo" & i))
    arrCaptions(i) = Sanitize(rs("PhotoCaption" & i))
Next

rs.Close: Set rs = Nothing
Set cmd = Nothing
%>

<div class="container py-4">
    <h1>Photos & Other Uploads for <%=Server.HTMLEncode(name)%></h1>
    <hr>
    
    <div class="row flex-lg-row-reverse">
        <div class="col-lg-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Image Limitations</h5>
                    <ul>
                        <li>Images larger than 1MB will be rejected.</li>
                        <li>All photos must be in JPG, JPEG, or PNG format.</li>
                        <% If Not (SpeciesID = 22 Or SpeciesID = 19 Or SpeciesID = 15 Or SpeciesID = 14 Or SpeciesID = 13) Then %>
                            <li>Certificates and analyses may be in PDF format.</li>
                        <% End If %>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <section id="photos">
                <h2>Photos</h2>
                <hr class="mt-0">
                <% If SubscriptionLevel <= 1 Then %>
                <div class="alert alert-info">
                    Basic memberships only allow 1 image per listing. <a href="MembersRenewSubscription.asp?PeopleID=<%=PeopleID%>" class="alert-link">Click here to upgrade</a> for up to 16 images.
                </div>
                <% End If %>

                <div class="row">
                <% 
                Dim maxPhotos
                If SubscriptionLevel > 1 Then maxPhotos = 16 Else maxPhotos = 1
                
                For i = 1 To maxPhotos
                    Dim currentphoto, TempFile, TempPhotoCaption
                    currentphoto = i
                    TempFile = arrPhotos(i)
                    TempPhotoCaption = arrCaptions(i)
                    if TempPhotoCaption="0" then TempPhotoCaption = ""
                    Dim hasImage
                    hasImage = (Len(TempFile) > 5 And TempFile <> "/uploads/ImageNotAvailable.webp")
                %>
				<div class="col-md-12 mb-4">
					<div class="card h-100">
						<div class="card-header">
							<h5 class="mb-0">Image <%=currentphoto%></h5>
						</div>
						<div class="card-body">
							<div class="row align-items-center">
								<div class="col-sm-4 text-center">
									<% If hasImage Then %>
										<img src="<%=TempFile%>" class="img-thumbnail mb-2" style="max-height: 150px;" alt="Photo <%=currentphoto%>">
										<p class="fw-bold"><%=TempPhotoCaption%></p>
									<% Else %>
										<div class="d-flex align-items-center justify-content-center bg-light text-muted mb-2" style="height: 150px; border: 1px dashed #ccc;">
											No Image Uploaded
										</div>
									<% End If %>
								</div>
								<div class="col-sm-8">
									<form method="POST" enctype="multipart/form-data" action="MembersImageUploadX.asp?photonum=<%=currentphoto%>" class="mb-3">
										<label class="form-label small">Upload New Photo</label>
										<div class="input-group">
											<input name="attach1" type="file" class="form-control">
											<button type="submit" class="btn btn-secondary">Upload</button>
										</div>
									</form>
									
									<% If hasImage Then %>
										<hr>
										<div class="d-flex flex-wrap justify-content-start gap-2">
											<form action="MembersCaptionAdd.asp" method="post">
												<div class="input-group">
													<input type="text" name="Caption" value="<%=TempPhotoCaption%>" placeholder="Add caption" class="form-control" maxlength="30">
													<input type="hidden" name="CaptionID" value="<%=currentphoto%>">
													<input type="hidden" name="ID" value="<%=ID%>">
													<button type="submit" class="btn btn-outline-secondary">Save</button>
												</div>
											</form>
											<form action="MembersImageRemove.asp" method="post">
												<input type="hidden" name="ImageID" value="<%=currentphoto%>">
												<input type="hidden" name="ID" value="<%=ID%>">
												<button type="submit" class="btn btn-outline-danger">Remove</button>
											</form>
										</div>
									<% End If %>
								</div>
							</div>
						</div>
					</div>
				</div>
                <% Next %>
                </div>
            </section>
        </div>
    </div>
</div>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<!--#Include file="MembersFooter.asp"-->

 </body>
</html>
