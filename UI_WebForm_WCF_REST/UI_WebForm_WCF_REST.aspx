<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="UI_WebForm_WCF_REST.aspx.cs" Inherits="_UI_WebForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    
<!--jquery-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<!--Bootstrap-->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/3.3.7/cerulean/bootstrap.min.css" rel="stylesheet" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <style>
        ul{ list-style-type: none; margin:0; padding: 0; }
        .panel-default > .panel-heading-custom { background: Salmon; color: #fff; }    /* override panel-default background color */
    </style>
</head>

<body>
<form id="form1" runat="server">
    <input type="hidden" name="action" id="action" value="" />

<asp:Panel ID="pnInput" runat="server">
    <div id="Input-Panel">
        <div class="modal-header">
            <button type="button" class="close"></button>
            <h4 class="modal-title">UI_WebForm_WCF_REST</h4>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-info">
                    <div class="panel-heading">
                        <div class="panel-title pull-left">Target / Method</div>
                        <div class="panel-title pull-right">
                            <input type="radio" name="radio1" value="GET" checked="checked" /> GET &nbsp;&nbsp;
                            <input type="radio" name="radio1" value="POST"   /> POST &nbsp;&nbsp;
                            <input type="radio" name="radio1" value="PUT"    /> PUT  &nbsp;&nbsp;
                            <input type="radio" name="radio1" value="DELETE" /> DELETE
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="panel-body">
                        <textarea class="form-control" rows="1" name="TargetURL" id="TargetURL">http://localhost:39901/EmployeeService.svc/GetEmployeeById/?id=1</textarea>
                    </div>
                    </div>
                </div>
            </div>
                
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-primary">
                    <div class="panel-heading">Headers 
                        <div class="panel-title pull-left">Target / Method</div>
                        <div class="panel-title pull-right">
                            <input type="radio" name="radio2" value="clear" /> clear &nbsp;&nbsp;
                            <input type="radio" name="radio2" value="text"  /> text &nbsp;&nbsp;
                            <input type="radio" name="radio2" value="json" checked="checked" /> json &nbsp;&nbsp;
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="panel-body">
                        <textarea class="form-control" rows="2" name="httpHeader" id="httpHeader">content-type: application/json; charset=utf-8</textarea>
                    </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                    <div class="panel-heading panel-heading-custom">Post Data</div>
                    <div class="panel-body">
                        <textarea class="form-control" rows="3" name="PostData" id="PostData"></textarea>
                    </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <button id="submit" type="submit" class="btn btn-success btn-block">Submit</button>
            </div>
        </div>
    </div>
</asp:Panel>

<asp:Panel ID="pnHTML" runat="server">
    <div id="Out-Panel">
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Get / Post - Results</h3>
            </div>
            <div class="panel-body">
                Target URL: <asp:Label ID="lblURL" runat="server"></asp:Label>
                <br /><br />
                <asp:TextBox id="txtResult" Rows="20" runat="server" TextMode="MultiLine" style="width: 100%"></asp:TextBox>
            </div>
        </div>
    </div>
</asp:Panel>
    
<script type="text/javascript">
    $(function () {

        $(":radio[name='radio1']").change(function () {
            var headerContentType = $(this).filter(':checked').val();
            if (headerContentType === 'GET') {
                $(TargetURL).val("http://localhost:39901/EmployeeService.svc/GetEmployeeById/?id=1");
                $(PostData).val("");
            }
            if (headerContentType === 'POST') {
                $(TargetURL).val("http://localhost:39901/EmployeeService.svc/PutEmployee");
                $(PostData).val('{"EmployeeID":1,"Address":"507 - 20th Ave. E. Apt. 2A","BirthDate":"\/Date(-664732800000-0800)\/","City":"Seattle","Country":"USA","Extension":"5467","FirstName":"Nancy11","HireDate":"\/Date(704703600000-0700)\/","HomePhone":"(206) 555-9857","LastName":"Davolio","Notes":"Education includes a BA in psychology from Colorado State University in 1970.","PostalCode":"98122","Region":"WA","Title":"Sales Representative"}');
            }
            if (headerContentType === 'PUT') {
                $(TargetURL).val("http://localhost:39901/EmployeeService.svc/PostEmployee");
                $(PostData).val('{"EmployeeID":1,"Address":"507 - 20th Ave. E. Apt. 2A","BirthDate":"\/Date(-664732800000-0800)\/","City":"Seattle","Country":"USA","Extension":"5467","FirstName":"Nancy11","HireDate":"\/Date(704703600000-0700)\/","HomePhone":"(206) 555-9857","LastName":"Davolio","Notes":"Education includes a BA in psychology from Colorado State University in 1970.","PostalCode":"98122","Region":"WA","Title":"Sales Representative"}');
            }
            if (headerContentType === 'DELETE') {
                $(TargetURL).val("http://localhost:39901/EmployeeService.svc/DeleteEmployee");
                $(PostData).val("");
            }
        });

        $(":radio[name='radio2']").change(function () {
            var headerContentType = $(this).filter(':checked').val();
            if (headerContentType === 'clear') $(httpHeader).val("");
            if (headerContentType === 'text') $(httpHeader).val("content-type: text/plain; charset=utf-8");
            if (headerContentType === 'json') $(httpHeader).val("content-type: application/json; charset=utf-8");
        });

        $("#submit").click(function () {
            $('#header').val(httpHeader);   //headers
            $('#action').val('submit');     //postback-submit
        });

    });
</script>

</form>
</body>
</html>
