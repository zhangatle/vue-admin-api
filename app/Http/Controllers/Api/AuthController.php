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
        $user = User::query()->where(['phone' => $request->phone, 'password' => $request->password])->firstOrFail();
        $token = Auth::guard('api')->fromUser($user);
        if ($token) {
            if ($user->last_token) {
                try {
                    JWTAuth::setToken($user->last_token)->invalidate();
                } catch (TokenExpiredException $e) {
                    //因为让一个过期的token再失效，会抛出异常，所以我们捕捉异常，不需要做任何处理
                }
            }
            $user->last_token = $token;
            $user->save();
            return $this->setToken($token)->success('登录成功');
        }
        return $this->failed('账号或密码错误', 400);
    }
    /**
     * 返回当前登录用户信息
     * @return mixed
     */
    public function info()
    {
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
        if(User::query()->create($member)) {
            return $this->success('用户注册成功');
        } else {
            return $this->failed('用户注册失败');
        }
    }

    /**
     * 退出登录
     */
    public function logout() {

    }

    /**
     * 更改密码
     */
    public function changePassword() {

    }
}
