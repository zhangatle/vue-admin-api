<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class MessageController extends Controller
{
    public function list() {
        $res = '{"code":20000,"msg":"成功","data":{"sort":null,"offset":0,"limit":20,"total":1,"size":20,"pages":1,"current":1,"searchCount":true,"records":[{"id":1,"createTime":"2019-06-10 21:20:16","createBy":null,"modifyTime":null,"modifyBy":null,"tplCode":"REGISTER_CODE","content":"【腾讯云】校验码1032，请于5分钟内完成验证，如非本人操作请忽略本短信。","receiver":"15011112222","type":0,"state":2}],"filters":null},"success":true}';
        return $this->success(json_decode($res));
    }
}
