# 数据库设计

- `User`

``` go
// User 用户信息
type User struct {
	ID       uint
	Name     string
	Password string
	Avatar   string
	Scores   uint `gorm:"default:100"`
}
```

- `Audio`
``` go
// Audio 录音信息
type Audio struct {
	gorm.Model
	Data   string
	Poster string
	RoomID uint
}
```

- `Room`
``` go
// Room 房间信息
type Room struct {
	ID          uint
	Audios      string
	Users       string
	Num         uint
	Recordtimes string
}
```

- `Topic`
``` go
// Topic 话题
type Topic struct {
	ID          uint
	Content     string
  	Score       uint      // 对话题进行评分，分数低的进行剔除
	Activate    bool      // 是否激活（== 1 表示激活），用户自定义话题进入话题库，处于未激活状态，仅用于当次的聊天
}
```

- `Message`
``` go
// Message 消息
// 目前只有举报消息
type Message struct {
	ID          		uint
	Sender	    		string
	Content     		string
	Time	    		time
	Dirty	    		bool		// 是否处理，为 0 表示未处理（认同举报或拒绝举报）
	Reported_User_ID	uint		// 被举报用户的 ID
	Audios      		array		// 被举报用户的音频信息（至多20条音频）
}
```

# API设计

## IOS 端使用 API   

- 用户注册

`localhost:8000/user/register POST`

|参数| 类型 |
|---|---|
|username | string|
|password | string| 

- 用户登录

`localhost:8000/user/login POST`

|参数| 类型 |
|---|---|
|username | string|
|password | string| 

- 获取所有用户信息

`localhost:8000/user  GET`

- 获取某个用户信息

`localhost:8000/user/:username  GET`

- 修改某个用户信息

`localhost:8000/user/:username PATCH`
|参数| 类型 |
|---|---|
|username | string|
|password | string| 
|avatar | string|

- 获取头像

`localhost:8000/picture/:picname GET`

- 发送一段录音

`localhost:8000/audio POST`
|参数| 类型 |
|---|---|
|data | file|
|poster | string| 
|roomid | uint|

- 获取音频文件

`localhost:8000/wav/:audioname GET`

- 获取话题			

`localhost:8000/topic GET`

返回：
|参数| 类型 |
|---|---|
|topics | array|		// 仅返回常驻话题 ！！！（暂定常驻10条）

- 用户加入一个未满的房间

`localhost:8000/room/join POST`
|参数| 类型 |
|---|---|
|username | string|
|topics | array|                // 用户选择的话题
|custom-topic | string|         // 用户自定义的话题

- 确定一个房间人数是否满员

`localhost:8000/room/check/:roomid GET`

返回需要添加：
|topics | array|                // 用户选择的话题中重合度较高的前 5 条话题（无重合或重合不足 5 条则随机返回有用户选择的话题）
|custom-topic | array|          // 用户自定义的话题

- 删除房间中的某个用户，如果房间中用户数为0，删除该房间以及房间有关的音频文件

`localhost:8000/room/cancel POST`
|参数| 类型 |
|---|---|
|username | string|
|roomid | uint|

- 获取某个房间的所有音频信息

`localhost:8000/room/audios/:roomid GET`

- 获取某个用户在某个房间发送的新音频

`localhost:8000/room/audios POST`
|参数| 类型 |
|---|---|
|username | string|
|roomid | uint|

- 举报某个用户

`localhost:8000/report POST`
|参数| 类型 |
|---|---|
|username | string|			 // 举报的用户账户名
|reason | string|		 	 // 举报原因，供举报系统使用
|time | time|
|audios | array|			 // 举报时间线之前，回溯被举报用户至多 20 条音频

- 扣除用户信用分

`localhost:8000/score/:username PATCH`		 // 一次扣10分

## 后台管理使用 API

- 获取举报消息

`localhost:8000/messages_client GET`

返回 Message 库中所有 dirty == 0（未处理） 的消息  

- 获取常驻话题

`localhost:8000/topics_client GET`

返回 Topic 库中所有常驻话题

- 添加常驻话题

`localhost:8000/topic_client POST`
|参数| 类型 |
|---|---|
|topic | string|

将创建的话题，直接作为常驻话题（Activate = 1）添加到 Topic 库中

- 删除常驻话题

`localhost:8000/topic_client PATCH`
|参数| 类型 |
|---|---|
|topic | string|

删除常驻话题

# 特色功能
将用户自定义话题存储起来，对话题库中评分低的（用户每次选择就给话题加1分）予以替换。
!(学习功能实现流程图)[]
