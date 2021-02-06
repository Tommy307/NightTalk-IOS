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

// TableName ...
func (User) TableName() string {
	return "user"
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

// TableName 指定Audio对应的数据表的名字
func (Audio) TableName() string {
	return "audio"
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

// TableName 指定Room对应的数据表的名字
func (Room) TableName() string {
	return "room"
}
```

- `Topic`
``` go
// Topic 话题
type Topic struct {
	ID          uint
	Content     string
  Score       uint      // 对话题进行评分，分数低的进行剔除
}

// TableName 指定Topic对应的数据表的名字
func (Topic) TableName() string {
	return "topic"
}
```

# API设计

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
|topics | array|                // 话题库中的所有话题

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
|topics | array|                // 用户选择的话题
|custom-topic | array|         // 用户自定义的话题

- 删除房间中的某个用户，如果房间中用户数为0，删除该房间

`localhost:8000/room/cancel POST`
|参数| 类型 |
|---|---|
|username | string|
|roomid | uint|

- 获取某个房间的所有音频信息

`localhost:8000/room/audios/:roomid GET`

- 举报某个用户

`localhost:8000/score/:username PATCH`

- 获取某个用户在某个房间发送的新音频

`localhost:8000/room/audios POST`
|参数| 类型 |
|---|---|
|username | string|
|roomid | uint|

# 特殊功能
将用户自定义话题存储起来，对话题库中评分低的（用户每次选择就给话题加1分）予以替换。
