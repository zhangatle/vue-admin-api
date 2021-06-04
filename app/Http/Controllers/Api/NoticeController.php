<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class NoticeController extends Controller
{
    public function list() {
        $res = '[{"id":1,"createTime":"2017-01-11 08:53:20","createBy":1,"modifyTime":"2019-01-08 23:30:58","modifyBy":1,"title":"欢迎光临","type":10,"content":"欢迎使用web-flash后台管理系统"},{"id":1,"createTime":"2017-01-11 08:53:20","createBy":1,"modifyTime":"2019-01-08 23:30:58","modifyBy":1,"title":"欢迎光临","type":10,"content":"欢迎使用web-flash后台管理系统"}]';
        return $this->success(json_decode($res));
    }
}
