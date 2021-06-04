<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;

class FileController extends Controller
{
    public function list() {
        $res = '{"code":20000,"msg":"成功","data":{"sort":null,"offset":0,"limit":20,"total":25,"size":20,"pages":2,"current":1,"searchCount":true,"records":[{"id":25,"createTime":"2019-05-05 15:36:54","createBy":1,"modifyTime":null,"modifyBy":null,"originalFileName":"timg.jpg","realFileName":"7fe918a2-c59a-4d17-ad77-f65dd4e163bf.jpg","ablatePath":null},{"id":24,"createTime":"2019-04-28 17:39:43","createBy":null,"modifyTime":null,"modifyBy":null,"originalFileName":"timg.jpg","realFileName":"6483eb26-775c-4fe2-81bf-8dd49ac9b6b1.jpg","ablatePath":null},{"id":23,"createTime":"2019-04-28 17:34:31","createBy":null,"modifyTime":null,"modifyBy":null,"originalFileName":"756b9ca8-562f-4bf5-a577-190dcdd25c29.png","realFileName":"7d64ba36-adc4-4982-9ec2-8c68db68861b.png","ablatePath":null},{"id":22,"createTime":"2019-04-28 00:39:47","createBy":1,"modifyTime":null,"modifyBy":null,"originalFileName":"7e07520d-5b73-4712-800b-16f88d133db2.png","realFileName":"8928e5d4-933a-4953-9507-f60b78e3ccee.png","ablatePath":null},{"id":21,"createTime":"2019-04-28 00:39:22","createBy":1,"modifyTime":null,"modifyBy":null,"originalFileName":"67486aa5-500c-4993-87ad-7e1fbc90ac1a.png","realFileName":"ffaf0563-3115-477b-b31d-47a4e80a75eb.png","ablatePath":null},{"id":20,"createTime":"2019-04-28 00:39:09","createBy":1,"modifyTime":null,"modifyBy":null,"originalFileName":"67486aa5-500c-4993-87ad-7e1fbc90ac1a.png","realFileName":"31fdc83e-7688-41f5-b153-b6816d5dfb06.png","ablatePath":null},{"id":19,"createTime":"2019-04-28 00:38:32","createBy":1,"modifyTime":null,"modifyBy":null,"originalFileName":"产品服务.png","realFileName":"99214651-8cb8-4488-b572-12c6aa21f30a.png","ablatePath":null},{"id":18,"createTime":"2019-04-28 00:34:34","createBy":1,"modifyTime":null,"modifyBy":null,"originalFileName":"资讯.png","realFileName":"7e07520d-5b73-4712-800b-16f88d133db2.png","ablatePath":null},{"id":17,"createTime":"2019-04-28 00:34:09","createBy":1,"modifyTime":null,"modifyBy":null,"originalFileName":"首页.png","realFileName":"d5aba978-f8af-45c5-b079-673decfbdf26.png","ablatePath":null},{"id":16,"createTime":"2019-03-21 19:37:50","createBy":1,"modifyTime":null,"modifyBy":null,"originalFileName":"测试文档.doc","realFileName":"d9d77815-496f-475b-a0f8-1d6dcb86e6ab.doc","ablatePath":null},{"id":15,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"originalFileName":"index.png","realFileName":"6a6cb215-d0a7-4574-a45e-5fa04dcfdf90.png","ablatePath":null},{"id":14,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"originalFileName":"login.png","realFileName":"194c8a38-be94-483c-8875-3c62a857ead7.png","ablatePath":null},{"id":13,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"originalFileName":"index.png","realFileName":"cd539518-d15a-4cda-a19f-251169f5d1a4.png","ablatePath":null},{"id":12,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"originalFileName":"login.png","realFileName":"70507c07-e8bc-492f-9f0a-00bf1c23e329.png","ablatePath":null},{"id":11,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"originalFileName":"index.png","realFileName":"55dd582b-033e-440d-8e8d-c8d39d01f1bb.png","ablatePath":null},{"id":10,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"originalFileName":"login.png","realFileName":"357c4aad-19fd-4600-9fb6-e62aafa3df25.png","ablatePath":null},{"id":9,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"originalFileName":"login.png","realFileName":"7ec7553b-7c9e-44d9-b9c2-3d89b11cf842.png","ablatePath":null},{"id":8,"createTime":null,"createBy":null,"modifyTime":null,"modifyBy":null,"originalFileName":"login.png","realFileName":"26835cc4-059e-4900-aff5-a41f2ea6a61d.png","ablatePath":null},{"id":7,"createTime":"2019-03-20 09:05:54","createBy":1,"modifyTime":"2019-03-20 09:05:54","modifyBy":1,"originalFileName":"2303938_1453211.png","realFileName":"87b037da-b517-4007-a66e-ba7cc8cfd6ea.png","ablatePath":null},{"id":6,"createTime":"2019-03-18 20:22:09","createBy":1,"modifyTime":"2019-03-18 20:22:09","modifyBy":1,"originalFileName":"profile.jpg","realFileName":"40ead888-14d1-4e9f-abb3-5bfb056a966a.jpg","ablatePath":null}],"filters":null},"success":true}';
        return $this->success(json_decode($res));
    }
}
