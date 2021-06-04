<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

/**
 * 栏目管理
 * Class ChannelController
 * @package App\Http\Controllers\Api
 */
class ChannelController extends Controller
{
    public function list() {
        $res = '{"code":20000,"msg":"成功","data":[{"id":1,"createTime":null,"createBy":null,"modifyTime":"2019-03-13 22:52:46","modifyBy":1,"name":"动态资讯","code":"news"},{"id":2,"createTime":null,"createBy":null,"modifyTime":"2019-03-13 22:53:11","modifyBy":1,"name":"产品服务","code":"product"},{"id":3,"createTime":null,"createBy":null,"modifyTime":"2019-03-13 22:53:37","modifyBy":1,"name":"解决方案","code":"solution"},{"id":4,"createTime":null,"createBy":null,"modifyTime":"2019-03-13 22:53:41","modifyBy":1,"name":"精选案例","code":"case"}],"success":true}';
        return $this->success(json_decode($res));
    }
}
