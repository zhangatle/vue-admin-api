<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AuthRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return false;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        switch ($this->method()) {
            case 'POST':
            {
                $return['password'] = ['bail', 'required', 'max:16', 'min:6'];
                if (strpos($this->route()->uri, 'login')) {
                    $return['phone'] = ['required', 'numeric', 'regex:/^1[3456789][0-9]{9}$/'];
                } else {
                    $return['phone'] = ['required', 'numeric', 'regex:/^1[3456789][0-9]{9}$/', 'unique:Users,phone'];
                }
                return $return;
            }
            default:
            {
                return [];
            }
        }
    }

    public function messages()
    {
        return [
            'phone.required' => '手机号不能为空',
            'phone.numeric' => '手机号错误',
            'phone.regex' => '手机号错误',
            'phone.unique' => '手机号已被注册',
            'password.required' => '密码不能为空',
            'password.max' => '密码长度不能超过16个字符',
            'password.min' => '密码长度不能小于6个字符'
        ];
    }
}
