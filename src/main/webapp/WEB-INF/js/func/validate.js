function $$(id) {
    return  document.getElementById(id);
}

var defaultTextColor = "#888888";

function checkQueryForm() {
    var self = $$('selfName').value;
    var it = $$('itName').value;
    if (self == "0") {
        alert("请选择一个本方单位！");
        $$('selfName').focus();
        return false;
    } else if (it != "" && it == self) {
        alert("他方单位不能与本方单位相同！");
        return false;
    } else {
        return true;
    }
}

function checkLoginForm() {
    if (checkEmail() && checkVerificationCode()) {
        var pass = $$('password').value;
        $$('password').value = md5(pass);
        return true;
    } else {
        return false;
    }
}

function checkRegisterForm() {
    if (checkEmail() && checkPassword() && checkConfirmPassword()
            && checkName() && checkPhone() && checkVerificationCode()) {
        var pass = $$('password').value;
        $$('password').value = md5(pass);
        return true;
    } else {
        alert("某些信息输入不正确，请检查红字部分！");
        return false;
    }
}

function checkSendEmailForm() {
    if (checkEmail() && checkVerificationCode()) {
        return true;
    } else {
        alert("某些信息输入不正确，请检查红字部分！");
        return false;
    }
}

function checkResetPasswordForm() {
    if (checkEmail()  && checkPassword() && checkConfirmPassword() && checkVerificationCode()) {
        var pass = $$('password').value;
        $$('password').value = md5(pass);
        return true;
    } else {
        alert("某些信息输入不正确，请检查红字部分！");
        return false;
    }
}

function checkModifyInformationForm() {
    if (checkName() && checkPhone() && checkVerificationCode()) {
        return true;
    } else {
        alert("某些信息输入不正确，请检查红字部分！");
        return false;
    }
}

function checkAuthForm() {
    var users = document.getElementsByName("table_records");
    var checkNum = 0;
    for (var i = 0; i < users.length; i++) {
        if (users[i].checked) {
            checkNum++;
        }
    }
    if (checkNum == 0) {
        alert("请至少选择一个用户！");
        return false;
    } else {
        return confirm("共选择" + checkNum + "名用户，是否确定修改他们的权限？");
    }
}

function checkEmail() {
    var reg = /^\s*\w+(?:\.{0,1}[\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\.[a-zA-Z]+\s*$/;
    var emailStr = $$('email').value;
    if (emailStr != null && emailStr != '' && reg.test(emailStr)) {
        $$('email').style.color=defaultTextColor;
        return true;
    } else {
        $$('email').style.color="#FF0000";
        return false;
    }
}

function checkPassword() {
    var reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,24}$/;
    var first = $$('password').value;
    var second = $$('confirmPassword').value;
    if (reg.test(second) && first == second) {
        $$('password').style.color = defaultTextColor;
        $$('confirmPassword').style.color = defaultTextColor;
        return true;
    } else {
        $$('password').style.color="#FF0000";
        return false;
    }
}

function checkConfirmPassword() {
    var reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,24}$/;
    var first = $$('password').value;
    var second = $$('confirmPassword').value;
    if (reg.test(second) && first == second) {
        $$('password').style.color = defaultTextColor;
        $$('confirmPassword').style.color = defaultTextColor;
        return true;
    } else {
        $$('confirmPassword').style.color="#FF0000";
        return false;
    }
}

function checkName() {
    var nameStr = $$('name').value;
    if (nameStr.length > 0) {
        $$('name').style.color=defaultTextColor;
        return true;
    } else {
        $$('name').style.color="#FF0000";
        return false;
    }
}

function checkPhone() {
    var phoneStr = $$('phone').value;
    var reg = /^((13[0-9])|(15[^4])|(18[0-9])|(17[0-9])|(147))\d{8}$/;
    if (phoneStr.length == 11 && reg.test(phoneStr)) {
        $$('phone').style.color=defaultTextColor;
        return true;
    } else {
        $$('phone').style.color="#FF0000";
        return false;
    }
}

function checkVerificationCode() {
    var reg = /^[0-9a-zA-Z]*$/;
    var captchaStr =  $$('captcha').value;
    if (captchaStr.length == 6 && reg.test(captchaStr)) {
        $$('captcha').style.color=defaultTextColor;
        return true;
    } else {
        $$('captcha').style.color="#FF0000";
        return false;
    }
}
