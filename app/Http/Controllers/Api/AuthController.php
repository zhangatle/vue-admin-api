<?php

namespace App\Http\Controllers\Api;

use App\Http\Requests\AuthRequest;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
use Tymon\JWTAuth\Facades\JWTAuth;

class AuthController extends Controller
{
    /**
     * @param AuthRequest $request
     * @return mixed
     */
    public function login(AuthRequest $request)
    {
        $user = User::query()->where(['account' => $request->account])->firstOrFail();
        $token = Auth::guard('api')->fromUser($user);
        if ($token) {
            if ($user->last_token) {
                try {
                    // 让旧的token过期
                    JWTAuth::setToken($user->last_token)->invalidate();
                } catch (TokenExpiredException $e) {
                    //因为让一个过期的token再失效，会抛出异常，所以我们捕捉异常，不需要做任何处理
                }
            }
            $user->last_token = $token;
            $user->save();
            return $this->setToken($token)->success(['token' => $token], '登录成功');
        }
        return $this->failed('账号或密码错误', 400);
    }

    /**
     * 返回当前登录用户信息
     * @return mixed
     */
    public function info()
    {
        $res = '{"permissions":["/loginLog/delLoginLog","/cms/articleEdit","/channel/remove","/log/detail","/loginLog/list","/fileMgr","/article/remove","/banner","/history","/channel","/mgr","/dict","/swagger","/banner/remove","/mgr/reset","/log","/menu/add","#","/menu/edit","/document","/dict/delete","/dict/add","/role/setAuthority","/cms","/role/add","/mgr/edit","/dept","/banner/edit","/task/update","/dept/delete","/message","/log/delLog","/sender/remove","/role/remove","/contacts","/file/upload","/sender/edit","/cfg","/template/remove","/cfg/update","/taskLog","/menu","/channel/edit","/cfg/delete","/task/add","/mgr/delete","/article","/cfg/add","/dept/detail","/mgr/setRole","/druid","/dept/list","/dict/list","/sender","/template/edit","/template","/mgr/unfreeze","/role/edit","/dict/update","/mgr/add","/loginLog","/dept/update","/optionMgr","/role","/dept/add","/task","/dict/detail","/menu/remove","/message/clear","/system","/task/delete"],"profile":{"avatar":null,"account":"admin","password":"b5a51391f271f062867e5984e2fcffee","salt":"8pgby","name":"管理员","birthday":"2017-05-05 00:00:00","sex":2,"email":"eniluzt@qq.com","phone":"15021222222","roleid":"1","deptid":2,"status":1,"version":2,"dept":"开发部","id":1,"createTime":"2016-01-29 08:49:53","createBy":null,"modifyTime":"2019-03-20 23:45:24","modifyBy":1,"roles":["超级管理员"]},"name":"管理员","role":"admin","roles":["administrator"]}';
        return $this->success(json_decode($res));
        $user = Auth::guard('api')->user();
        return $this->success($user);
    }

    /**
     * 注册接口
     * @param AuthRequest $request
     * @return mixed
     */
    public function register(AuthRequest $request)
    {
        $member = [
            'password' => $request->password,
            'phone' => $request->phone,

        ];
        if (User::query()->create($member)) {
            return $this->success('用户注册成功');
        } else {
            return $this->failed('用户注册失败');
        }
    }

    /**
     * 退出登录
     */
    public function logout()
    {

    }

    /**
     * 更改密码
     */
    public function changePassword()
    {

    }
}
