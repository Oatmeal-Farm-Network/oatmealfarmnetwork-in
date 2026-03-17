<!DOCTYPE HTML >
<html>
<head>
<!--#Include file="Membersglobalvariables.asp"--> 
<a name="Top"></a>
<div class="content-area">
    <div class="content-wrapper">

        <form action='MembersStyleFonts.asp?PeopleID=<%=PeopleID %>' method="post">
            
            <div class="container-fluid p-0">
                <div class="row justify-content-center">
                    
                    <div class="col-12 col-lg-10 p-4">

                        <div class="card mb-4" style="background-color: <%=MenuBackgroundColor%>; background-image: url('<%=PageBackgroundImage%>'); border: 1px solid rgba(255, 255, 255, 0.2);">
                            <div class="card-header" style="background-color: transparent; border-bottom: 1px solid rgba(255, 255, 255, 0.1);">
                                <span style="font-size: <%=TitleSize%>px; color: <%=TitleColor%>; font-family: '<%=TitleFont%>';">
                                    <% if TitleWeight ="Bold" then%><b><% end if %>Page Headings<% if TitleWeight ="Bold" then%></b><% end if %>
                                </span>
                            </div>
                            <div class="card-body">

                                <div class="row mb-3 align-items-center">
                                    <div class="col-sm-4 text-sm-end body2">
                                        <label for="TitleFont" class="col-form-label body2">Font Face: <span style="font-family: <%=TitleFont%>">Current Font</span></label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select size="1" name="TitleFont" id="TitleFont" class="form-select formbox">
                                            <option value="<%=TitleFont%>" style="font-family: <%=TitleFont%>" selected><%=TitleFont%></option>
                                            <option value="Arial" style="font-family: Arial">Arial</option>
                                            <option value="Century Gothic" style="font-family: Century Gothic">Century Gothic</option> 
                                            <option value="Comic Sans" style="font-family: Comic Sans">Comic Sans</option>
                                            <option value="Copperplate Gothic Light" style="font-family: Copperplate Gothic Light">Copperplate Gothic Light</option>
                                            <option value="Courier New" style="font-family: Courier New">Courier New</option>
                                            <option value="Georgia" style="font-family: Georgia">Georgia</option>
                                            <option value="Gill Sans" style="font-family: Gill Sans">Gill Sans</option>
                                            <option value="Lucida Console" style="font-family: Lucida Console">Lucida Console</option>
                                            <option value="Lucida Sans Unicode" style="font-family: Lucida Sans Unicode">Lucida Sans Unicode</option>              
                                            <option value="Palatino Linotype" style="font-family : Palatino Linotype">Palatino Linotype</option>
                                            <option value="Tahoma" style="font-family: Tahoma">Tahoma</option> 
                                            <option value="Times New Roman" style="font-family: Times New Roman">Times New Roman</option>
                                            <option value="Trebuchet MS" style="font-family: Trebuchet MS">Trebuchet MS</option>       
                                            <option value="Verdana" style="font-family: Verdana">Verdana</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row mb-3 align-items-center">
                                    <div class="col-sm-4 text-sm-end body2">
                                        <label for="TitleColor" class="col-form-label body2">Font Color</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select size="1" name="TitleColor" id="TitleColor" class="form-select formbox">
                                            <option value="<%=TitleColor%>" selected><%=TitleColor%></option>
                                              
                                        </select>
                                    </div>
                                </div>

                                <div class="row mb-3 align-items-center">
                                    <div class="col-sm-4 text-sm-end body2">
                                        <label for="TitleSize" class="col-form-label body2">Font Size</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select size="1" name="TitleSize" id="TitleSize" class="form-select formbox">
                                            <option value="<%=TitleSize%>" selected><%=TitleSize%></option>
                                            <option value="12">12</option> 
                                            <option value="14">14</option>
                                            <option value="16">16</option>
                                            <option value="18">18</option>
                                            <option value="20">20</option> 
                                            <option value="22">22</option> 
                                            <option value="24">24</option> 
                                            <option value="26">26</option> 
                                        </select>
                                    </div>
                                </div>

                                <div class="row mb-3 align-items-center">
                                    <div class="col-sm-4 text-sm-end body2">
                                        <label for="TitleWeight" class="col-form-label body2">Font Weight</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select size="1" name="TitleWeight" id="TitleWeight" class="form-select formbox">
                                            <option value="<%=TitleWeight%>" selected><%=TitleWeight%></option>
                                            <option value="Normal">Normal</option> 
                                            <option value="Bold">Bold</option> 
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-4" style="background-color: <%=PageBackgroundColor%>; border: 1px solid rgba(255, 255, 255, 0.2);">
                            <div class="card-header bodytext" style="background-color: transparent; border-bottom: 1px solid rgba(255, 255, 255, 0.1);">
                                Body Text <a href="#" class="bodytext">Body Text Link</a>
                            </div>
                            <div class="card-body">

                                <div class="row mb-3 align-items-center">
                                    <div class="col-sm-4 text-sm-end body2">
                                        <label for="PageTextFont" class="col-form-label body2">Page Text Font</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select size="1" name="PageTextFont" id="PageTextFont" class="form-select formbox">
                                            <option value="<%=PageTextFont%>" style="font-family: <%=PageTextFont%>" selected><%=PageTextFont%></option>
                                            <option value="Arial" style="font-family: Arial">Arial</option>
                                            <option value="Century Gothic" style="font-family: Century Gothic">Century Gothic</option>  
                                            <option value="Comic Sans" style="font-family: Comic Sans">Comic Sans</option>
                                            <option value="Copperplate Gothic Light"  style="font-family: Copperplate Gothic Light">Copperplate Gothic Light</option>
                                            <option value="Courier New"  style="font-family: Courier New">Courier New</option>
                                            <option value="Georgia"  style="font-family: Georgia">Georgia</option>
                                            <option value="Gill Sans"  style="font-family: Gill Sans">Gill Sans</option>
                                            <option value="Lucida Console"  style="font-family: Lucida Console">Lucida Console</option>
                                            <option value="Lucida Sans Unicode"  style="font-family: Lucida Sans Unicode">Lucida Sans Unicode</option>              
                                            <option value="Palatino Linotype" style="font-family : Palatino Linotype">Palatino Linotype</option>
                                            <option value="Tahoma"  style="font-family: Tahoma">Tahoma</option> 
                                            <option value="Times New Roman"  style="font-family: Times New Roman">Times New Roman</option>
                                            <option value="Trebuchet MS"  style="font-family: Trebuchet MS">Trebuchet MS</option>       
                                            <option value="Verdana"  style="font-family: Verdana">Verdana</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row mb-3 align-items-center">
                                    <div class="col-sm-4 text-sm-end body2">
                                        <label for="PageTextColor" class="col-form-label body2">Color</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select size="1" name="PageTextColor" id="PageTextColor" class="form-select formbox">
                                            <option value="<%=PageTextColor%>" selected><%=PageTextColor%></option>
                                              
                                        </select>
                                    </div>
                                </div>

                                <div class="row mb-3 align-items-center">
                                    <div class="col-sm-4 text-sm-end body2">
                                        <label for="PageTextFontSize" class="col-form-label body2">Page Text Size</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select size="1" name="PageTextFontSize" id="PageTextFontSize" class="form-select formbox">
                                            <option value="<%=PageTextFontSize%>" selected><%=PageTextFontSize%></option>
                                            <option value="8">8</option>   
                                            <option value="9">9</option>   
                                            <option value="10">10</option> 
                                            <option value="11">11</option>
                                            <option value="13">13</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row mb-3 align-items-center">
                                    <div class="col-sm-4 text-sm-end body2">
                                        <label for="PageTextHyperlinkColor" class="col-form-label body2">Link Color</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select size="1" name="PageTextHyperlinkColor" id="PageTextHyperlinkColor" class="form-select formbox">
                                            <option value="<%=PageTextHyperlinkColor%>" selected><%=PageTextHyperlinkColor%></option>
                                            </select>
                                    </div>
                                </div>

                                <div class="row mb-3 align-items-center">
                                    <div class="col-sm-4 text-sm-end body2">
                                        <label for="PageTextMouseOverColor" class="col-form-label body2">Link Mouseover Color</label>
                                    </div>
                                    <div class="col-sm-8">
                                        <select size="1" name="PageTextMouseOverColor" id="PageTextMouseOverColor" class="form-select formbox">
                                            <option value="<%=PageTextMouseOverColor%>" selected><%=PageTextMouseOverColor%></option>
                                            </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="text-center mt-4 mb-5">
                            <input type="submit" value="SUBMIT" class="regsubmit2">
                        </div>

                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>