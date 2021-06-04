<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class UserController extends Controller
{
    public function list() {
        $res = '{"sort":null,"offset":0,"limit":20,"total":2,"size":20,"pages":1,"current":1,"searchCount":true,"records":[{"birthday":"2017-12-31 00:00:00","modifyBy":1,"salt":"vscp9","roleid":"2,","sex":1,"deptid":3,"avatar":null,"dept":{"id":3,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"num":3,"pid":1,"pids":"[0],[1],","simplename":"运营部","fullname":"运营部"},"version":null,"createBy":null,"password":"fac36d5616fe9ebd460691264b28ee27","modifyTime":"2019-01-09 23:05:51","createTime":"2018-09-13 17:21:02","phone":"15022222222","sexName":"男","name":"网站管理员","roleName":"网站管理员","statusName":"启用","id":2,"account":"developer","email":"eniluzt@qq.com","status":1},{"birthday":"2017-05-05 00:00:00","modifyBy":1,"salt":"8pgby","roleid":"1","sex":2,"deptid":2,"avatar":null,"dept":{"id":2,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"num":2,"pid":1,"pids":"[0],[1],","simplename":"开发部","fullname":"开发部"},"version":2,"createBy":null,"password":"b5a51391f271f062867e5984e2fcffee","modifyTime":"2019-03-20 23:45:24","createTime":"2016-01-29 08:49:53","phone":"15021222222","sexName":"女","name":"管理员","roleName":"超级管理员","statusName":"启用","id":1,"account":"admin","email":"eniluzt@qq.com","status":1}],"filters":[{"join":"and","fieldName":"status","value":0,"operator":"GT"}]}';
        return $this->success(json_decode($res));
    }
}
