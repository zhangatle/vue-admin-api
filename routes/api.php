<?php

use App\Http\Controllers\Api\ArticleController;
use App\Http\Controllers\Api\BannerController;
use App\Http\Controllers\Api\ChannelController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ConfigController;
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

Route::middleware(['cors'])->group(function (){
    // authenticate
    Route::post('login', [AuthController::class, 'login']);
    Route::post('register', [AuthController::class, 'register']);
    Route::get('info', [AuthController::class, 'info']);
    Route::get('logout', [AuthController::class, 'logout']);
    Route::post('changePassword', [AuthController::class, 'changePassword']);
    /** cms */
    // article
    Route::get('article/list', [ArticleController::class, 'list']);
    Route::post('article', [ArticleController::class, 'save']);
    Route::delete('article', [ArticleController::class, 'delete']);
    Route::get('article', [ArticleController::class, 'get']);
    // banner
    Route::get('banner/list', [BannerController::class, 'list']);
    Route::post('banner', [BannerController::class, 'save']);
    Route::delete('banner', [BannerController::class, 'delete']);
    // channel
    Route::get('channel/list', [ChannelController::class, 'list']);
    Route::post('channel', [ChannelController::class, 'save']);
    Route::delete('channel', [ChannelController::class, 'delete']);
    //contact-file
    Route::get('contact/list', [ContactController::class, 'list']);
    Route::get('file/list', [FileController::class, 'list']);
    /** message */
    Route::get('message/list', [MessageController::class, 'list']);
    Route::post('message', [MessageController::class, 'save']);
    Route::delete('message', [MessageController::class, 'delete']);
    Route::get('message/sender/list', [MessageSenderController::class, 'list']);
    Route::post('message/sender', [MessageSenderController::class, 'save']);
    Route::delete('message/sender', [MessageSenderController::class, 'delete']);
    Route::get('message/template/list', [MessageTemplateController::class, 'list']);
    Route::post('message/template', [MessageTemplateController::class, 'save']);
    Route::delete('message/template', [MessageTemplateController::class, 'delete']);
    /** system */
    Route::get('config/list', [ConfigController::class, 'list']);
    // department
    Route::get('department/list', [DepartmentController::class, 'list']);
    Route::get('department/tree', [DepartmentController::class, 'tree']);
    Route::post('department', [DepartmentController::class, 'save']);
    Route::delete('department', [DepartmentController::class, 'delete']);
    //dict
    Route::get('dict/list', [DictController::class, 'list']);
    Route::put('dict', [DictController::class, 'update']);
    Route::post('dict', [DictController::class, 'save']);
    Route::delete('dict', [DictController::class, 'delete']);
    Route::get('dict', [DictController::class, 'get']);
    //log
    Route::get('log/list', [LogController::class, 'list']);
    Route::get('log', [LogController::class, 'get']);
    Route::delete('log', [LogController::class, 'delete']);
    //loginLog
    Route::get('/log/login/list', [LogController::class, 'listLogin']);
    Route::delete('log/login', [LogController::class, 'deleteLogin']);
    // menu
    Route::get('menu/list', [MenuController::class, 'list']);
    Route::get('menu/tree', [MenuController::class, 'tree']);
    Route::get('menu/listForRouter', [MenuController::class, 'listForRouter']);
    Route::get('/menu/menuTreeListByRoleId', [MenuController::class, 'menuTreeListByRoleId']);
    Route::post('menu', [MenuController::class, 'save']);
    Route::delete('menu', [MenuController::class, 'delete']);
    // notice
    Route::get('notice/list', [NoticeController::class, 'list']);
    // role
    Route::get('role/list', [RoleController::class, 'list']);
    Route::post('role', [RoleController::class, 'save']);
    Route::delete('role', [RoleController::class, 'delete']);
    Route::get('/role/roleTreeListByUserId', [RoleController::class, 'roleTreeListByUserId']);
    Route::post('role/savePermission', [RoleController::class, 'savePermission']);
    // task
    Route::get('task/list', [TaskController::class, 'list']);
    Route::post('task', [TaskController::class, 'save']);
    Route::delete('task', [TaskController::class, 'delete']);
    Route::get('task/logList', [TaskController::class, 'logList']);
    Route::post('task/enable', [TaskController::class, 'enable']);
    Route::post('task/disable', [TaskController::class, 'disable']);
    // user
    Route::get('user/list', [UserController::class, 'list']);
    Route::post('user', [UserController::class, 'save']);
    Route::delete('user', [UserController::class, 'delete']);
    Route::post('user/setRole', [UserController::class, 'setRole']);
    Route::post('user/status', [UserController::class, 'status']);
    Route::post('user/resetPassword', [UserController::class, 'resetPassword']);
});
