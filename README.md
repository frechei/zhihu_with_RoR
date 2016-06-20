###山寨zhihu
部署到heroku的展示：[https://zhihucat.herokuapp.com](https://zhihucat.herokuapp.com)
------

为找工作而做仿写的知乎，大致框架ok。

 - rails4.2.5, ruby2.2.4, Ubuntu14.04
 - Bootstrap, jQuery, CoffeeScript

已完成的功能：

 1. User资源，Admin管理员，注册，登陆，邮箱激活及找回密码（因没credit card不能用heroku的mailgun，此功能暂时注释掉）
 2. Question资源及嵌套的Answer，还有与Quesion多对多关系的Topic。
 3. 关注成员，关注问题，关注话题。
 4. Simditor编辑器。
 5. 对答案的点赞功能。
 6. 问题和答案的评论功能。
 7. 首页feed采用public_activity的Gem，关注的人中提问题，回答问题，点赞答案等都会出现在首页。

待完成功能：

 1. 重构相关答案页面，有不少重复内容。
 2. 点赞功能还没使用ajax。
 3. 没写测试。
 4. 相关微细功能～