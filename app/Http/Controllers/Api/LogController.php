<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class LogController extends Controller
{
    public function list() {
        $res = '{"code":20000,"msg":"成功","data":{"sort":null,"offset":0,"limit":20,"total":4,"size":20,"pages":1,"current":1,"searchCount":true,"records":[{"logtype":"业务日志","createtime":"2019-08-10 12:08:00","classname":"cn.enilu.flash.api.controller.cms.ArticleMgrController","method":"upload","createTime":"2019-08-10 00:00:00","logname":"编辑栏目","succeed":"成功","id":4,"message":"参数名称=system.app.name","userName":"管理员","regularMessage":"参数名称=system.app.name","userid":1},{"logtype":"业务日志","createtime":"2019-07-10 12:07:00","classname":"cn.enilu.flash.api.controller.cms.ArticleMgrController","method":"upload","createTime":"2019-07-10 00:00:00","logname":"编辑文章","succeed":"成功","id":3,"message":"参数名称=system.app.name","userName":"管理员","regularMessage":"参数名称=system.app.name","userid":1},{"logtype":"业务日志","createtime":"2019-06-10 12:06:00","classname":"cn.enilu.flash.api.controller.cms.ArticleMgrController","method":"upload","createTime":"2019-06-10 00:00:00","logname":"修改参数","succeed":"成功","id":2,"message":"参数名称=system.app.name","userName":"管理员","regularMessage":"参数名称=system.app.name","userid":1},{"logtype":"业务日志","createtime":"2019-05-10 12:05:00","classname":"cn.enilu.flash.api.controller.cms.ArticleMgrController","method":"upload","createTime":"2019-05-10 00:00:00","logname":"添加参数","succeed":"成功","id":1,"message":"参数名称=system.app.name","userName":"管理员","regularMessage":"参数名称=system.app.name","userid":1}],"filters":null},"success":true}';
        return $this->success(json_decode($res));
    }

    public function listLogin() {
        $res = '{"code":20000,"msg":"成功","data":{"sort":null,"offset":0,"limit":20,"total":2,"size":20,"pages":1,"current":1,"searchCount":true,"records":[{"createtime":"2019-05-12 01:05:56","createTime":"2019-05-12 13:36:56","logname":"登录日志","ip":"127.0.0.1","succeed":"成功","id":72,"message":null,"userName":"管理员","regularMessage":null,"userid":1},{"createtime":"2019-05-10 01:05:43","createTime":"2019-05-10 13:17:43","logname":"登录日志","ip":"127.0.0.1","succeed":"成功","id":71,"message":null,"userName":"管理员","regularMessage":null,"userid":1}],"filters":null},"success":true}';
        return $this->success(json_decode($res));
    }
}
