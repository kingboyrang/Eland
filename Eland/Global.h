//
//  Global.h
//  Eland
//
//  Created by aJia on 13/9/27.
//  Copyright (c) 2013年 rang. All rights reserved.
//

//http://60.251.51.217/Pushs.Admin/
//http://60.251.51.217/Cases.Admin/

//获取设备的物理大小
#define DeviceRect [UIScreen mainScreen].bounds
#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height

//路径设置
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define TempPath NSTemporaryDirectory()

//设备
#define DeviceIsPad UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad

//通知post name
#define kPushNotificeName @"kPushNotificeNameInfo"


//推播中心WebService的URL地址
#define PushWebserviceURL @"http://60.251.51.217/Pushs.Admin/WebServices/Push.asmx"
#define PushNameSpace @"http://tempuri.org/"

//数据请求地址
// 取得項目鄉鎮市 - GET
#define CityDownURL @"http://60.251.51.217/Cases.Admin/WebServices/CaseCity.aspx"
// 取得所有项目设定 - GET
#define CaseSettingURL @"http://60.251.51.217/Cases.Admin/WebServices/CaseSetting.aspx?action=1"
// 取得指定的項目設定 - GET
#define SingleCaseSettingURL @"http://60.251.51.217/Cases.Admin/WebServices/CaseSetting.aspx?action=2&guid=%@"
// 取得设定的所有類別 - GET
#define CaseCategoryURL @"http://60.251.51.217/Cases.Admin/WebServices/CaseCategory.aspx"
// 查询项目 - POST
#define CaseSearchURL @"http://60.251.51.217/Cases.Admin/WebServices/CaseSearch.aspx"
// 取得项目 - GET
#define SingleCaseURL @"http://60.251.51.217/Cases.Admin/WebServices/CaseFind.aspx?guid=%@&pwd=%@"
// 新增项目 - POST
#define AddCaseURL @"http://60.251.51.217/Cases.Admin/WebServices/CaseAdd.aspx"

//图片浏览地址
#define CaseImageViewURL @"http://60.251.51.217/Cases.Admin/%@"



