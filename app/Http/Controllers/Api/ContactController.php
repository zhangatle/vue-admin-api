<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class ContactController extends Controller
{
    public function list() {
        $res = '{"code":20000,"msg":"成功","data":{"sort":null,"offset":0,"limit":20,"total":1,"size":20,"pages":1,"current":1,"searchCount":true,"records":[{"id":1,"createTime":"2019-07-31 17:44:27","createBy":null,"modifyTime":"2019-07-31 17:44:27","modifyBy":null,"userName":"张三","mobile":"15011111111","email":"test@qq.com","remark":"测试联系，哈哈哈"}],"filters":null},"success":true}';
        return $this->success(json_decode($res));
    }
}
