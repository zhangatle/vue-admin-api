<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class RoleController extends Controller
{
    public function list() {
        $res = '{"sort":null,"offset":0,"limit":20,"total":2,"size":20,"pages":1,"current":1,"searchCount":true,"records":[{"modifyBy":null,"deptName":"开发部","num":1,"deptid":2,"pid":1,"label":"网站管理员","version":null,"tips":"developer","createBy":null,"modifyTime":null,"pName":"超级管理员","createTime":null,"name":"网站管理员","id":2},{"modifyBy":null,"deptName":"One Piece集团","num":1,"deptid":1,"pid":0,"label":"超级管理员","version":1,"tips":"administrator","createBy":null,"modifyTime":null,"pName":"--","createTime":null,"name":"超级管理员","id":1}],"filters":null}';
        return $this->success(json_decode($res));
    }
}
