<?php

namespace App\Http\Helpers;

use ErrorException;
use Exception;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Symfony\Component\HttpKernel\Exception\MethodNotAllowedHttpException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Symfony\Component\HttpKernel\Exception\UnauthorizedHttpException;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;

class ExceptionReport
{
    use ApiResponse;

    /**
     * @var Exception
     */
    public $exception;
    /**
     * @var Request
     */
    public $request;

    /**
     * @var
     */
    protected $report;

    /**
     * ExceptionReport constructor.
     * @param Request $request
     * @param Exception $exception
     */
    function __construct(Request $request, Exception $exception)
    {
        $this->request = $request;
        $this->exception = $exception;
    }

    /**
     * @var array
     */
    //当抛出这些异常时，可以使用我们定义的错误信息与HTTP状态码
    //可以把常见异常放在这里
    public $doReport = [
        AuthenticationException::class => ['未登录或登录状态失效', 401],
        ModelNotFoundException::class => ['该模型未找到', 404],
        AuthorizationException::class => ['没有此权限', 403],
        ValidationException::class => [],
        UnauthorizedHttpException::class => ['未登录或登录状态失效', 401],
        TokenInvalidException::class => ['未登录或登录状态失效', 401],
        NotFoundHttpException::class => ['没有找到该页面', 404],
        MethodNotAllowedHttpException::class => ['访问方式不正确', 405],
        ErrorException::class => ['服务器内部错误', 500],
        QueryException::class => ['参数错误', 400],
    ];

    public function register($className, callable $callback)
    {

        $this->doReport[$className] = $callback;
    }

    /**
     * @return bool
     */
    public function shouldReturn()
    {
        foreach (array_keys($this->doReport) as $report) {
            if ($this->exception instanceof $report) {
                $this->report = $report;
                return true;
            }
        }

        return false;

    }

    /**
     * @param Exception $e
     * @return static
     */
    public static function make(\Throwable $e)
    {

        return new static(\request(), $e);
    }

    /**
     * @return mixed
     */
    public function report()
    {
        if ($this->exception instanceof ValidationException) {
            return $this->failed(current($this->exception->errors()), $this->exception->status);
        }
        $message = $this->doReport[$this->report];
        return $this->failed($message[0], $message[1]);
    }

    public function prodReport()
    {
        return $this->failed('服务器错误', '500');
    }
}

