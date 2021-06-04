<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class UserController extends Controller
{
    public function list() {
        $res = '{"code":20000,"msg":"成功","data":[{"id":1,"num":1,"pid":0,"pids":"[0],","simplename":"总公司","fullname":"One Piece集团","children":[{"id":2,"num":2,"pid":1,"pids":"[0],[1],","simplename":"开发部","fullname":"开发部","label":"开发部"},{"id":3,"num":3,"pid":1,"pids":"[0],[1],","simplename":"运营部","fullname":"运营部","label":"运营部"},{"id":4,"num":4,"pid":1,"pids":"[0],[1],","simplename":"战略部","fullname":"战略部","label":"战略部"}],"label":"总公司"}],"success":true}';
        return $this->success(json_decode($res));
    }
}
