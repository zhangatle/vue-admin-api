<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class MessageSenderController extends Controller
{
    public function list() {
        $res = '{"code":20000,"msg":"成功","data":[{"id":1,"createTime":"2020-12-16 12:02:17","createBy":1,"modifyTime":null,"modifyBy":null,"name":"腾讯短信服务","className":"tencentSmsSender"},{"id":2,"createTime":"2020-12-16 12:02:17","createBy":1,"modifyTime":null,"modifyBy":null,"name":"默认邮件发送器","className":"defaultEmailSender"},{"id":3,"createTime":"2020-12-16 12:02:17","createBy":1,"modifyTime":null,"modifyBy":null,"name":"阿里云短信服务","className":"aliSmsSender"}],"success":true}';
        return $this->success(json_decode($res));
    }
}
