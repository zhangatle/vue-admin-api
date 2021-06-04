<?php

namespace App\Http\Helpers;

use Illuminate\Http\JsonResponse;
use Symfony\Component\HttpFoundation\Response as FoundationResponse;

trait ApiResponse
{
    /**
     * @var int
     */
    protected $statusCode = 200;
    protected $token = '';

    /**
     * @return mixed
     */
    public function getStatusCode()
    {
        return $this->statusCode;
    }

    /**
     * @param $statusCode
     * @return $this
     */
    public function setStatusCode($statusCode): ApiResponse
    {
        $this->statusCode = $statusCode;
        return $this;
    }

    /**
     * @param $token
     * @return $this
     */
    public function setToken($token): ApiResponse
    {
        $this->token = $token;
        return $this;
    }

    /**
     * @param $data
     * @return JsonResponse
     */
    public function respond($data): JsonResponse
    {
        $response = response()->json($data, $this->getStatusCode());
        if ($this->token) {
            $response->headers->set('Authorization', 'Bearer ' . $this->token);
        }
        return $response;
    }

    /**
     * @param $message
     * @param array $data
     * @param null $code
     * @return mixed
     */
    public function status($message, array $data, $code = null)
    {
        if ($code) {
            $this->setStatusCode($code);
        }
        $status = [
            'message' => $message,
            'code' => $this->statusCode
        ];
        $data = array_merge($status, $data);
        return $this->respond($data);
    }

    /**
     * @param $message
     * @param int $code
     * @param string $status
     * @return mixed
     */
    public function failed($message, int $code = FoundationResponse::HTTP_BAD_REQUEST, string $status = 'error')
    {
        return $this->setStatusCode($code)->message($message, $status);
    }

    /**
     * @param $message
     * @param string $status
     * @return mixed
     */
    public function message($message, string $status = "success")
    {
        if(is_array($message)) {
            $message = implode(',', $message);
        }
        return $this->status($status, [
            'message' => $message
        ]);
    }

    /**
     * @param string $message
     * @return mixed
     */
    public function internalError(string $message = "Internal Error!")
    {
        return $this->failed($message, FoundationResponse::HTTP_INTERNAL_SERVER_ERROR);
    }

    /**
     * @param string $message
     * @return mixed
     */
    public function created(string $message = "created")
    {
        return $this->setStatusCode(FoundationResponse::HTTP_CREATED)
            ->message($message);
    }

    /**
     * @param $data
     * @param string $message
     * @return mixed
     */
    public function success($data, string $message = "success")
    {
        return $this->status($message, compact('data'));
    }

    /**
     * @param string $message
     * @return mixed
     */
    public function notFond(string $message = 'Not Fond!')
    {
        return $this->failed($message, Foundationresponse::HTTP_NOT_FOUND);
    }
}


