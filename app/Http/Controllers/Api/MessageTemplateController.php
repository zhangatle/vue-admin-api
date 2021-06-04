<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class MessageTemplateController extends Controller
{
    public function list() {
        $res = '{"code":20000,"msg":"成功","data":{"sort":null,"offset":0,"limit":20,"total":4,"size":20,"pages":1,"current":1,"searchCount":true,"records":[{"id":4,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"code":"ALI_SMS_CODE","title":"阿里云短信验证码","content":"您的验证码${code}，该验证码5分钟内有效，请勿泄漏于他人！","cond":"测试发送阿里云短信","idMessageSender":3,"type":0,"messageSender":{"id":3,"createTime":"2020-12-16 12:02:17","createBy":1,"modifyTime":null,"modifyBy":null,"name":"阿里云短信服务","className":"aliSmsSender"},"remoteTplCode":null},{"id":3,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"code":"EMAIL_HTML_TEMPLATE_TEST","title":"测试发送模板邮件","content":"你好<strong>${userName}</strong>欢迎使用<font color=\"red\">${appName}</font>,这是html模板邮件","cond":"测试发送模板邮件","idMessageSender":2,"type":1,"messageSender":{"id":2,"createTime":"2020-12-16 12:02:17","createBy":1,"modifyTime":null,"modifyBy":null,"name":"默认邮件发送器","className":"defaultEmailSender"},"remoteTplCode":null},{"id":2,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"code":"EMAIL_TEST","title":"测试邮件","content":"你好:{1},欢迎使用{2}","cond":"测试发送","idMessageSender":2,"type":1,"messageSender":{"id":2,"createTime":"2020-12-16 12:02:17","createBy":1,"modifyTime":null,"modifyBy":null,"name":"默认邮件发送器","className":"defaultEmailSender"},"remoteTplCode":null},{"id":1,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"code":"REGISTER_CODE","title":"注册验证码","content":"【腾讯云】校验码{1}，请于5分钟内完成验证，如非本人操作请忽略本短信。","cond":"注册页面，点击获取验证码","idMessageSender":1,"type":0,"messageSender":{"id":1,"createTime":"2020-12-16 12:02:17","createBy":1,"modifyTime":null,"modifyBy":null,"name":"腾讯短信服务","className":"tencentSmsSender"},"remoteTplCode":null}],"filters":null},"success":true}';
        return $this->success(json_decode($res));
    }
}
