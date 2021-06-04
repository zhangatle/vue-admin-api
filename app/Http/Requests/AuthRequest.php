<?php

namespace App\Http\Requests;

/**
 * @property string account
 * @property string last_token
 */
class AuthRequest extends Request
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules(): array
    {
        switch ($this->method()) {
            case 'POST':
            {
                $return['password'] = ['bail', 'required', 'max:16', 'min:5'];
                if (strpos($this->route()->uri, 'login')) {
                    $return['account'] = ['required', 'string'];
                } else {
                    $return['account'] = ['required', 'string', 'unique:users,account'];
                }
                return $return;
            }
            default:
            {
                return [];
            }
        }
    }

    public function messages(): array
    {
        return [
            'account.required' => '用户名不能为空',
            'account.unique' => '用户名已被注册',
            'password.required' => '密码不能为空',
            'password.max' => '密码长度不能超过16个字符',
            'password.min' => '密码长度不能小于5个字符'
        ];
    }
}
