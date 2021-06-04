<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class ConfigController extends Controller
{
    public function list() {
        $res = '{"code":20000,"msg":"成功","data":{"sort":null,"offset":0,"limit":20,"total":8,"size":20,"pages":1,"current":1,"searchCount":true,"records":[{"id":8,"createTime":null,"createBy":null,"modifyTime":"2019-04-15 21:36:17","modifyBy":1,"cfgName":"api.aliyun.sms.region.id","cfgValue":"需要去申请咯","cfgDesc":"阿里云sms接口地域id"},{"id":7,"createTime":null,"createBy":null,"modifyTime":"2019-04-15 21:36:17","modifyBy":1,"cfgName":"api.aliyun.sms.access.secret","cfgValue":"需要去申请咯","cfgDesc":"阿里云sms接口access Secret"},{"id":6,"createTime":null,"createBy":null,"modifyTime":"2019-04-15 21:36:17","modifyBy":1,"cfgName":"api.aliyun.sms.access.key.id","cfgValue":"需要去申请咯","cfgDesc":"阿里云sms接口accesskey"},{"id":5,"createTime":null,"createBy":null,"modifyTime":"2019-04-15 21:36:17","modifyBy":1,"cfgName":"api.tencent.sms.sign","cfgValue":"需要去申请咯","cfgDesc":"腾讯sms接口签名参数"},{"id":4,"createTime":null,"createBy":null,"modifyTime":"2019-04-15 21:36:17","modifyBy":1,"cfgName":"api.tencent.sms.appkey","cfgValue":"需要去申请咯","cfgDesc":"腾讯sms接口appkey"},{"id":3,"createTime":null,"createBy":null,"modifyTime":"2019-04-15 21:36:17","modifyBy":1,"cfgName":"api.tencent.sms.appid","cfgValue":"需要去申请咯","cfgDesc":"腾讯sms接口appid"},{"id":2,"createTime":null,"createBy":null,"modifyTime":"2019-04-15 21:36:17","modifyBy":1,"cfgName":"system.file.upload.path","cfgValue":"/data/web-flash/runtime/upload","cfgDesc":"系统默认上传文件路径"},{"id":1,"createTime":null,"createBy":null,"modifyTime":"2019-04-15 21:36:07","modifyBy":1,"cfgName":"system.app.name","cfgValue":"web-flash","cfgDesc":"应用名称update by 2019-03-27 11:47:04"}],"filters":null},"success":true}';
        return $this->success(json_decode($res));
    }
}
