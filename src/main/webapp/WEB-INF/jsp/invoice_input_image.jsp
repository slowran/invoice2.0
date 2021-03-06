<%--
  Created by IntelliJ IDEA.
  User: 李浩然
  Date: 2017/5/26
  Time: 2:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>添加发票</title>

    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- bootstrap-wysiwyg -->
    <link href="../vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="../vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- starrr -->
    <link href="../vendors/starrr/dist/starrr.css" rel="stylesheet">
    <!-- bootstrap-daterangepicker -->
    <link href="../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">

    <style>
        .file {
            position: relative;
            display: inline-block;
            background: #D0EEFF;
            border: 1px solid #99D3F5;
            border-radius: 4px;
            padding: 4px 12px;
            overflow: hidden;
            color: #1E88C7;
            text-decoration: none;
            text-indent: 0;
            line-height: 20px;
        }
        .file input {
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
        }
        .file:hover {
            background: #AADFFD;
            border-color: #78C3F3;
            color: #004974;
            text-decoration: none;
        }
    </style>

    <script type="text/javascript">
        //定义id选择器
        function Id(id){
            return document.getElementById(id);
        }
        //入口函数，两个参数分别为<input type='file'/>的id，还有一个就是图片的id，然后会自动根据文件id得到图片，然后把图片放到指定id的图片标签中
        function changeToop(fileid,imgid){
            var file = Id(fileid);
            if(file.value==''){
                //设置默认图片
                Id("myimg").src='';
            }else{
                preImg(fileid,imgid);
            }
        }
        //获取input[file]图片的url Important
        function getFileUrl(fileId) {
            var url;
            var file = Id(fileId);
            var agent = navigator.userAgent;
            if (agent.indexOf("MSIE")>=1) {
                url = file.value;
            } else if(agent.indexOf("Firefox")>0) {
                url = window.URL.createObjectURL(file.files.item(0));
            } else if(agent.indexOf("Chrome")>0) {
                url = window.URL.createObjectURL(file.files.item(0));
            }
            var extIndex = file.value.lastIndexOf(".");
            var ext = file.value.substring(extIndex,file.value.length).toUpperCase();
            if (ext != ".JPG") {
                alert("只允许上传JPG格式的图片！");
                Id('upload_file').disabled = true;
                return "";
            }
            Id('upload_file').disabled = false;
            return url;
        }
        //读取图片后预览
        function preImg(fileId,imgId) {
            var imgPre =Id(imgId);
            imgPre.src = getFileUrl(fileId);
        }
    </script>
</head>

<body class="nav-md">
<div class="container body">
    <div class="main_container">
        <%@ include file="left_top.jspf"%>

        <!-- top navigation -->
        <%@ include file="right_top.jspf"%>
        <!-- /top navigation -->

        <!-- page content -->
        <div class="right_col" role="main">
            <div class="">
                <div class="page-title">
                    <div class="title_left">
                        <h3>添加发票</h3>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${has_authority}">
                        <div class="clearfix"></div>
                        <div class="row">
                            <div class="col-md-12 col-sm-12 col-xs-12">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <h2>增值税专用发票</h2>
                                        <ul class="nav navbar-right panel_toolbox">
                                            <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                        </ul>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content">
                                        <form action="addInvoiceByImage" method="post"
                                              enctype="multipart/form-data" class="form-horizontal">
                                            <input type="hidden" name="preAction" value="addInvoiceByImage">
                                            <input type="hidden" name="action" value="upload">
                                            <div class="form-group">
                                                <label class="control-label col-md-2" for="detail_num">
                                                    待添加的发票的明细数目
                                                    <span class="required">*</span>
                                                </label>
                                                <div class="col-md-6">
                                                    <input class="form-control has-feedback-left"
                                                           id="detail_num" name="detail_num" placeholder="发票的明细数目（请输入大于0的整数）" required="required"/>
                                                    <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                                                </div>
                                            </div>
                                            <div class="ln_solid"></div>
                                            <div class="form-group">
                                                <div class="col-md-3 col-md-offset-2">
                                                    <a class="file">点此上传一张图片
                                                        <input type="file" name="invoice_image" id="file_selector" class="btn btn-round"
                                                               placeholder="点此上传一张图片"
                                                               accept=".jpg" onchange="changeToop('file_selector', 'imagePreview');">
                                                    </a>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="submit" value="提交"
                                                           class="btn btn-round btn-success" id="upload_file" onclick="return checkInput(this.form);">
                                                    <script>
                                                        function checkInput(form) {
                                                            var value = form.detail_num.value;
                                                            if (value.indexOf('.') >= 0 || isNaN(Number(value))
                                                                || Number(value) < 1 || Number(value) > 16) {
                                                                alert("明细数目：请输入大于0的整数");
                                                                return false;
                                                            }
                                                            return true;
                                                        }
                                                    </script>
                                                </div>
                                            </div>
                                            <div class="ln_solid"></div>
                                            <div id="preview" class="col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2 col-xs-8 col-xs-offset-2">
                                                <img id="imagePreview" style="width: 1000px" src=''/>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <c:if test="${has_file}">
                            <div class="clearfix"></div>
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="x_panel">
                                        <div class="x_title">
                                            <h2>增值税专用发票</h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                                            </ul>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="x_content">
                                            <form:form commandName="invoice" action="addInvoiceByImage" method="post"
                                                       cssClass="form-horizontal form-label-left" onsubmit="return checkSubmitInvoice(${detail_num});">
                                                <input type="hidden" name="preAction" value="addInvoiceByImage">
                                                <input type="hidden" name="action" value="save">
                                                <div class="row">
                                                    <c:if test="${has_errors}">
                                                        <div class="form-group">
                                                            <p style="color: red;text-align: left; padding-left: 5%">
                                                                <strong>发票信息有误，请更改后重新提交！</strong>
                                                                <c:forEach var="error_message" items="${error_messages}">
                                                                    <br/>${error_message}
                                                                </c:forEach>
                                                            </p>
                                                        </div>
                                                        <div class="ln_solid"></div>
                                                    </c:if>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-2" for="invoiceCode">
                                                            发票代码
                                                            <span class="required">*</span>
                                                        </label>
                                                        <div class="col-md-2">
                                                            <form:input path="invoiceCode" id="invoiceCode" name="invoiceCode" maxlength="10" minlength="10"
                                                                        cssClass="form-control col-md-2" required="required" placeholder="请输入10位发票代码"
                                                                        value="${invoice.invoiceCode}" onchange="checkInvoiceCode();"/>
                                                        </div>
                                                        <label class="control-label col-md-2" for="invoiceId">
                                                            发票号码
                                                            <span class="required">*</span>
                                                        </label>
                                                        <div class="col-md-2">
                                                            <form:input path="invoiceId" id="invoiceId" name="invoiceId" maxlength="8" minlength="8"
                                                                        cssClass="form-control col-md-2" required="required" placeholder="请输入8位发票号码"
                                                                        value="${invoice.invoiceId}" onchange="checkInvoiceId();"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-6" for="single_cal4">
                                                            发票日期
                                                            <span class="required">*</span>
                                                        </label>
                                                        <div class="col-md-2">
                                                            <form:hidden path="invoiceDate" id="invoiceDate" name="invoiceDate" cssClass="form-control col-md-2 has-feedback-left"
                                                                         aria-describedby="inputSuccess2Status4" required="required"  />
                                                            <fieldset>
                                                                <div class="control-group">
                                                                    <div class="controls">
                                                                        <div class="xdisplay_inputx form-group has-feedback">
                                                                            <input type="text" class="form-control has-feedback-left" onchange="formatDate(this.value);"
                                                                                   id="single_cal4" aria-describedby="inputSuccess2Status4"/>
                                                                            <span class="fa fa-calendar-o form-control-feedback left"></span>
                                                                            <span id="inputSuccess2Status4" class="sr-only">(success)</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </fieldset>
                                                            <script>
                                                                function formatDate(value) {
                                                                    if (value.indexOf("-") < 0) {
                                                                        var tmp = value.split("/");
                                                                        var date = tmp[2] + "-" + tmp[0] + "-" + tmp[1];
                                                                        document.getElementById('invoiceDate').value = date;
                                                                        document.getElementById('single_cal4').value = date;
                                                                    } else {
                                                                        document.getElementById('invoiceDate').value = value;
                                                                    }
                                                                }
                                                            </script>
                                                        </div>
                                                    </div>
                                                    <div class="ln_solid"></div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-2" for="buyerName">
                                                            （购贷单位）名称
                                                            <span class="required">*</span>
                                                        </label>
                                                        <div class="col-md-6">
                                                            <form:input path="buyerName" id="buyerName" name="buyerName" list="buyerCompanyNames"
                                                                        cssClass="form-control col-md-6" required="required" onchange="fillBuyerId();"
                                                                        value="${invoice.buyerName}" placeholder="请输入购贷方名称"/>
                                                            <datalist id="buyerCompanyNames">
                                                                <c:forEach var="company" items="${companys}">
                                                                    <option>${company.key}</option>
                                                                </c:forEach>
                                                            </datalist>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-2" for="buyerId">
                                                            （购贷单位）纳税人识别号
                                                        </label>
                                                        <div class="col-md-6">
                                                            <form:input path="buyerId" id="buyerId" name="buyerId"
                                                                        cssClass="form-control col-md-6" 
                                                                        value="${invoice.buyerId}" placeholder="请输入购贷方纳税人识别号"/>
                                                        </div>
                                                    </div>
                                                    <div class="ln_solid"></div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-1">产品名称<span class="required">*</span></label>
                                                        <label class="control-label col-md-1">规格型号</label>
                                                        <label class="control-label col-md-1">单位</label>
                                                        <label class="control-label col-md-1">数量<span class="required">*</span></label>
                                                        <label class="control-label col-md-1">单价<span class="required">*</span></label>
                                                        <label class="control-label col-md-1">金额<span class="required">*</span></label>
                                                        <label class="control-label col-md-1">税率（小数）<span class="required">*</span></label>
                                                        <label class="control-label col-md-1">税额<span class="required">*</span></label>
                                                    </div>

                                                    <c:forEach var="i" begin="0" end="${detail_num-1}" step="1">
                                                        <div class="form-group">
                                                            <div class="col-md-1">
                                                                <form:input path="details[${i}].detailName" placeholder="产品名称"
                                                                            cssClass="form-control col-md-1" required="required"/>
                                                            </div>
                                                            <div class="col-md-1">
                                                                <form:input path="details[${i}].specification" placeholder="规格型号（可空）"
                                                                            cssClass="form-control col-md-1"/>
                                                            </div>
                                                            <div class="col-md-1">
                                                                <form:input path="details[${i}].unitName" placeholder="单位（可空）"
                                                                            cssClass="form-control col-md-1"/>
                                                            </div>
                                                            <div class="col-md-1">
                                                                <form:input path="details[${i}].quantity" placeholder="数量（整数）" name="quantity"
                                                                            id="quantity_${i}"
                                                                            cssClass="form-control col-md-1" required="required" onchange="checkQuantity(this);"/>
                                                            </div>
                                                            <div class="col-md-1">
                                                                <form:input path="details[${i}].unitPrice" placeholder="单价" onchange="checkMoney(this);" name="unitPrice"
                                                                            cssClass="form-control col-md-1" required="required" id="unitPrice_${i}"/>
                                                            </div>
                                                            <div class="col-md-1">
                                                                <form:input path="details[${i}].amount"  placeholder="金额" disabled="false" name="amount" id="amount_${i}"
                                                                            cssClass="form-control col-md-1" required="required" onchange="checkMoney(this);"/>
                                                            </div>
                                                            <div class="col-md-1">
                                                                <form:input path="details[${i}].taxRate" placeholder="税率" onchange="checkRate(this);" name="taxRate"
                                                                            cssClass="form-control col-md-1" required="required" id="taxRate_${i}"/>
                                                            </div>
                                                            <div class="col-md-1">
                                                                <form:input path="details[${i}].taxSum" placeholder="税额" disabled="false" name="taxSum" id="taxSum_${i}"
                                                                            cssClass="form-control col-md-1" required="required" onchange="checkMoney(this);"/>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                    <div class="ln_solid"></div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-5" for="totalAmount">
                                                            合计金额<span class="required">*</span>
                                                        </label>
                                                        <div class="col-md-1">
                                                            <form:input path="totalAmount" id="totalAmount" name="totalAmount" disabled="false"
                                                                        cssClass="form-control col-md-1" required="required" onchange="checkMoney(this);"
                                                                        value="${invoice.totalAmount}" placeholder="总金额"/>
                                                        </div>
                                                        <label class="control-label col-md-1" for="totalTax">
                                                            合计税额<span class="required">*</span>
                                                        </label>
                                                        <div class="col-md-1">
                                                            <form:input path="totalTax" id="totalTax" name="totalTax" disabled="false"
                                                                        cssClass="form-control col-md-1" required="required" onchange="checkMoney(this);"
                                                                        value="${invoice.totalTax}" placeholder="总税额"/>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-6" for="total">
                                                            税价合计<span class="required">*</span>
                                                        </label>
                                                        <div class="col-md-2">
                                                            <form:input path="total" id="total" name="total" disabled="false"
                                                                        cssClass="form-control col-md-2" required="required" onchange="checkMoney(this);"
                                                                        value="${invoice.total}" placeholder="税价合计金额"/>
                                                        </div>
                                                    </div>
                                                    <div class="ln_solid"></div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-2" for="sellerName">
                                                            （销贷单位）名称
                                                            <span class="required">*</span>
                                                        </label>
                                                        <div class="col-md-6">
                                                            <form:input path="sellerName" id="sellerName" name="sellerName" list="sellerCompanyNames"
                                                                        cssClass="form-control col-md-6" required="required" onchange="fillSellerId();"
                                                                        value="${invoice.sellerName}" placeholder="请输入销贷方名称"/>
                                                            <datalist id="sellerCompanyNames">
                                                                <c:forEach var="company" items="${companys}">
                                                                    <option>${company.key}</option>
                                                                </c:forEach>
                                                            </datalist>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-2" for="sellerId">
                                                            （销贷单位）纳税人识别号
                                                        </label>
                                                        <div class="col-md-6">
                                                            <form:input path="sellerId" id="sellerId" name="sellerId"
                                                                        cssClass="form-control col-md-6"
                                                                        value="${invoice.sellerId}" placeholder="请输入销贷方纳税人识别号"/>
                                                        </div>
                                                    </div>
                                                    <div class="ln_solid"></div>
                                                    <div class="form-group">
                                                        <label class="control-label col-md-2" for="remark">备注</label>
                                                        <div class="col-md-6">
                                                            <form:input path="remark" id="remark" name="remark"
                                                                        cssClass="form-control col-md-6"
                                                                        value="${invoice.remark}" placeholde="请输入备注（可空）"/>
                                                        </div>
                                                    </div>
                                                    <div class="ln_solid"></div>
                                                    <div class="form-group">
                                                        <div class="col-md-5 col-md-offset-3">
                                                            <input type="submit" class="btn btn-success" value="保存">
                                                            <input type="reset" class="btn btn-dark" value="重置">
                                                        </div>
                                                    </div>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <%@ include file="no_authority.jspf"%>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <!-- /page content -->

        <!-- footer content -->
        <%@ include file="footer.jspf"%>
        <!-- /footer content -->
    </div>
</div>

<!-- jQuery -->
<script src="../vendors/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="../vendors/fastclick/lib/fastclick.js"></script>
<!-- NProgress -->
<script src="../vendors/nprogress/nprogress.js"></script>
<!-- bootstrap-progressbar -->
<script src="../vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
<!-- iCheck -->
<script src="../vendors/iCheck/icheck.min.js"></script>
<!-- bootstrap-daterangepicker -->
<script src="../vendors/moment/min/moment.min.js"></script>
<script src="../vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
<!-- bootstrap-wysiwyg -->
<script src="../vendors/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js"></script>
<script src="../vendors/jquery.hotkeys/jquery.hotkeys.js"></script>
<script src="../vendors/google-code-prettify/src/prettify.js"></script>
<!-- jQuery Tags Input -->
<script src="../vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
<!-- Switchery -->
<script src="../vendors/switchery/dist/switchery.min.js"></script>
<!-- Select2 -->
<script src="../vendors/select2/dist/js/select2.full.min.js"></script>
<!-- Parsley -->
<script src="../vendors/parsleyjs/dist/parsley.min.js"></script>
<!-- Autosize -->
<script src="../vendors/autosize/dist/autosize.min.js"></script>
<!-- jQuery autocomplete -->
<script src="../vendors/devbridge-autocomplete/dist/jquery.autocomplete.min.js"></script>
<!-- starrr -->
<script src="../vendors/starrr/dist/starrr.js"></script>
<!-- Custom Theme Scripts -->
<script src="../build/js/custom.min.js"></script>
<script src="../js/func/checkInvoice.js"></script>
<c:if test="${not empty message}">
    <script type="text/javascript">
        alert('${message}');
    </script>
</c:if>
<script type="text/javascript">
    var companys = {};
    <c:forEach var="company" items="${companys}">
    companys['${company.key}'] = '${company.value}';
    </c:forEach>
    function fillBuyerId() {
        var name = document.getElementById('buyerName').value;
        var id = document.getElementById('buyerId').value;
        var isNew = true;
        var isContain = false;
        for (var n in companys) {
            if (n == name) {
                document.getElementById('buyerId').value = companys[n];
                isNew = false;
                break;
            }
            if (companys[n] == id) {
                isContain = true;
            }
        }
        if (isNew && isContain) {
            document.getElementById('buyerId').value = '';
        }
    }

    function fillSellerId() {
        var name = document.getElementById('sellerName').value;
        var id = document.getElementById('sellerId').value;
        var isNew = true;
        var isContain = false;
        for (var n in companys) {
            if (companys[n] == id) {
                isContain = true;
            }
            if (n == name) {
                document.getElementById('sellerId').value = companys[n];
                isNew = false;
                break;
            }
        }
        if (isNew && isContain) {
            document.getElementById('sellerId').value = '';
        }
    }
</script>

</body>
</html>


