<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class TaskController extends Controller
{
    public function list() {
        $res = '{"code":20000,"msg":"成功","data":[{"id":1,"createTime":"2018-12-28 09:54:00","createBy":1,"modifyTime":"2019-03-27 11:47:11","modifyBy":-1,"name":"测试任务","jobGroup":"default","jobClass":"cn.enilu.flash.service.task.job.HelloJob","note":"测试任务,每30分钟执行一次","cron":"0 0/30 * * * ?","concurrent":false,"data":"{\n\"appname\": \"web-flash\",\n\"version\":1\n}\n            \n            \n            \n            \n            \n            \n            \n            \n            \n            \n            \n            ","execAt":"2019-03-27 11:47:00","execResult":"执行成功","disabled":false}],"success":true}';
        return $this->success(json_decode($res));
    }
}
