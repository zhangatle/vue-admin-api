<?php

use App\Http\Controllers\Api\ArticleController;
use App\Http\Controllers\Api\BannerController;
use App\Http\Controllers\Api\ChannelController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ContactController;
use App\Http\Controllers\Api\DepartmentController;
use App\Http\Controllers\Api\DictController;
use App\Http\Controllers\Api\FileController;
use App\Http\Controllers\Api\LogController;
use App\Http\Controllers\Api\MenuController;
use App\Http\Controllers\Api\MessageController;
use App\Http\Controllers\Api\MessageSenderController;
use App\Http\Controllers\Api\MessageTemplateController;
use App\Http\Controllers\Api\NoticeController;
use App\Http\Controllers\Api\RoleController;
use App\Http\Controllers\Api\TaskController;
use App\Http\Controllers\Api\UserController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);

Route::middleware(['auth:api', 'cors'])->group(function (){
    Route::get('info', [AuthController::class, 'info']);
    Route::get('logout', [AuthController::class, 'logout']);
    Route::post('changePassword', [AuthController::class, 'changePassword']);
    // cms
    Route::get('article/list', [ArticleController::class, 'list']);
    Route::post('article', [ArticleController::class, 'save']);
    Route::delete('article', [ArticleController::class, 'delete']);
    Route::get('article', [ArticleController::class, 'get']);

    Route::get('banner/list', [BannerController::class, 'list']);
    Route::post('banner', [BannerController::class, 'save']);
    Route::delete('banner', [BannerController::class, 'delete']);

    Route::get('channel/list', [ChannelController::class, 'list']);
    Route::post('channel', [ChannelController::class, 'save']);
    Route::delete('channel', [ChannelController::class, 'delete']);

    Route::get('contact/list', [ContactController::class, 'list']);
    Route::get('file/list', [FileController::class, 'list']);
    // message
    Route::get('message/list', [MessageController::class, 'list']);
    Route::post('message', [MessageController::class, 'save']);
    Route::delete('message', [MessageController::class, 'delete']);

    Route::get('message/sender/list', [MessageTemplateController::class, 'list']);
    Route::post('message/sender', [MessageTemplateController::class, 'save']);
    Route::delete('message/sender', [MessageTemplateController::class, 'delete']);

    // system
    Route::get('department/list', [DepartmentController::class, 'list']);
    Route::get('department/tree', [DepartmentController::class, 'tree']);
    Route::post('department', [DepartmentController::class, 'save']);
    Route::delete('department', [DepartmentController::class, 'delete']);

    Route::get('dict/list', [DictController::class, 'list']);
    Route::put('dict', [DictController::class, 'update']);
    Route::post('dict', [DictController::class, 'save']);
    Route::delete('dict', [DictController::class, 'delete']);
    Route::get('dict', [DictController::class, 'get']);

    Route::get('log/list', [LogController::class, 'list']);
    Route::get('log', [LogController::class, 'get']);
    Route::delete('log', [LogController::class, 'delete']);

    Route::get('login/log/list', [LogController::class, 'listLogin']);
    Route::delete('login/log', [LogController::class, 'deleteLogin']);

    Route::get('menu/list', [MenuController::class, 'list']);
    Route::get('menu/tree', [MenuController::class, 'tree']);
    Route::get('menu/listForRouter', [MenuController::class, 'listForRouter']);
    Route::get('/menu/menuTreeListByRoleId', [MenuController::class, 'menuTreeListByRoleId']);
    Route::post('menu', [MenuController::class, 'save']);
    Route::delete('menu', [MenuController::class, 'delete']);

    Route::get('notice/list', [NoticeController::class, 'list']);

    Route::get('role/list', [RoleController::class, 'list']);
    Route::post('role', [RoleController::class, 'save']);
    Route::delete('role', [RoleController::class, 'delete']);
    Route::get('/role/roleTreeListByUserId', [RoleController::class, 'roleTreeListByUserId']);
    Route::post('role/savePermission', [RoleController::class, 'savePermission']);

    Route::get('task/list', [TaskController::class, 'list']);
    Route::post('task', [TaskController::class, 'save']);
    Route::delete('task', [TaskController::class, 'delete']);
    Route::get('task/logList', [TaskController::class, 'logList']);
    Route::post('task/enable', [TaskController::class, 'enable']);
    Route::post('task/disable', [TaskController::class, 'disable']);

    Route::get('user/list', [UserController::class, 'list']);
    Route::post('user', [UserController::class, 'save']);
    Route::delete('user', [UserController::class, 'delete']);
    Route::post('user/setRole', [UserController::class, 'setRole']);
    Route::post('user/status', [UserController::class, 'status']);
    Route::post('user/resetPassword', [UserController::class, 'resetPassword']);
});
