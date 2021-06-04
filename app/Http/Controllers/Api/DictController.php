<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class DictController extends Controller
{
    public function list() {
        $res = '[{"id":"system","label":"系统管理","children":[{"id":"mgr","label":"用户管理","children":[{"id":"mgrAdd","label":"添加用户"},{"id":"mgrEdit","label":"修改用户"},{"id":"mgrDelete","label":"删除用户"},{"id":"mgrReset","label":"重置密码"},{"id":"setRole","label":"分配角色"},{"id":"mgrUnfreeze","label":"解除冻结用户"},{"id":"mgrSetRole","label":"分配角色"}]},{"id":"role","label":"角色管理","children":[{"id":"roleAdd","label":"添加角色"},{"id":"roleEdit","label":"修改角色"},{"id":"roleDelete","label":"删除角色"},{"id":"roleSetAuthority","label":"配置权限"}]},{"id":"dept","label":"部门管理","children":[{"id":"deptEdit","label":"修改部门"},{"id":"deptDelete","label":"删除部门"},{"id":"deptAdd","label":"添加部门"},{"id":"deptList","label":"部门列表"},{"id":"deptDetail","label":"部门详情"}]},{"id":"menu","label":"菜单管理","children":[{"id":"menuAdd","label":"添加菜单"},{"id":"menuEdit","label":"修改菜单"},{"id":"menuDelete","label":"删除菜单"}]},{"id":"dict","label":"字典管理","children":[{"id":"dictAdd","label":"添加字典"},{"id":"dictEdit","label":"修改字典"},{"id":"dictDelete","label":"删除字典"},{"id":"dictList","label":"字典列表"},{"id":"dictDetail","label":"字典详情"}]},{"id":"taskLog","label":"任务日志"},{"id":"cfg","label":"参数管理","children":[{"id":"cfgAdd","label":"添加参数"},{"id":"cfgEdit","label":"修改参数"},{"id":"cfgDelete","label":"删除参数"}]},{"id":"task","label":"任务管理","children":[{"id":"taskAdd","label":"添加任务"},{"id":"taskEdit","label":"修改任务"},{"id":"taskDelete","label":"删除任务"}]}]},{"id":"operationMgr","label":"运维管理","children":[{"id":"druid","label":"数据库管理"},{"id":"swagger","label":"接口文档"},{"id":"log","label":"业务日志","children":[{"id":"logClear","label":"清空日志"},{"id":"logDetail","label":"日志详情"}]},{"id":"loginLog","label":"登录日志","children":[{"id":"loginLogClear","label":"清空登录日志"},{"id":"loginLogList","label":"登录日志列表"}]}]},{"id":"cms","label":"CMS管理","children":[{"id":"channel","label":"栏目管理","children":[{"id":"channelEdit","label":"编辑栏目"},{"id":"channelDelete","label":"删除栏目"}]},{"id":"editArticle","label":"新建文章"},{"id":"article","label":"文章管理","children":[{"id":"deleteArticle","label":"删除文章"}]},{"id":"banner","label":"banner管理","children":[{"id":"bannerEdit","label":"编辑banner"},{"id":"bannerDelete","label":"删除banner"}]},{"id":"contacts","label":"邀约管理"},{"id":"file","label":"文件管理","children":[{"id":"fileUpload","label":"上传文件"}]}]},{"id":"messageMgr","label":"消息管理","children":[{"id":"msg","label":"历史消息"},{"id":"msgTpl","label":"消息模板","children":[{"id":"msgTplEdit","label":"编辑模板"},{"id":"msgTplDelete","label":"删除模板"}]},{"id":"msgSender","label":"消息发送者","children":[{"id":"msgSenderEdit","label":"编辑发送器"},{"id":"msgSenderDelete","label":"删除发送器"}]},{"id":"msgClear","label":"清空历史消息"}]},{"id":"documentp","label":"在线文档","children":[{"id":"document","label":"在线文档"}]}]';
        return $this->success(json_decode($res));
    }

    public function get() {
        $res = '[{"id":72,"createTime":"2020-07-18 21:43:41","createBy":1,"modifyTime":"2020-07-18 21:43:41","modifyBy":1,"num":"1","pid":71,"name":"业务日志","tips":null},{"id":73,"createTime":"2019-01-13 14:18:21","createBy":1,"modifyTime":"2020-07-18 21:43:41","modifyBy":1,"num":"2","pid":71,"name":"异常日志","tips":null}]';
        return $this->success(json_decode($res));
    }
}
