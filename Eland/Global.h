//
//  Global.h
//  Eland
//
//  Created by aJia on 13/9/27.
//  Copyright (c) 2013年 rang. All rights reserved.
//


//获取设备的物理大小
#define DeviceRect [UIScreen mainScreen].bounds
#define DeviceWidth [UIScreen mainScreen].bounds.size.width
#define DeviceHeight [UIScreen mainScreen].bounds.size.height

//路径设置
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define TempPath NSTemporaryDirectory()

#define DataAccessURL @"http://60.251.51.217/Pushs.Admin/WebServices/CasesAdminURL.aspx?get=cases"

//数据源
#define DataWebPath [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"]
#define DataServicesSource [NSArray arrayWithContentsOfFile:DataWebPath]
#define DataCaseUrlPre @"http://cir.e-land.gov.tw:8080/admin2/" 
#define DataPushUrlPre @"http://cir.e-land.gov.tw:8080/pushs/"

//#define DataCaseUrlPre [DataServicesSource objectAtIndex:0]
//#define DataPushUrlPre [DataServicesSource objectAtIndex:1]

//

//设备
#define DeviceIsPad UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad

//通知post name
#define kPushNotificeName @"kPushNotificeNameInfo"


//推播中心WebService的URL地址
#define PushWebserviceURL [NSString stringWithFormat:@"%@WebServices/Push.asmx",DataPushUrlPre]
#define PushNameSpace @"http://tempuri.org/"

//数据请求地址
// 取得項目鄉鎮市 - GET
#define CityDownURL [NSString stringWithFormat:@"%@WebServices/CaseCity.aspx",DataCaseUrlPre]
// 取得所有项目设定 - GET
#define CaseSettingURL [NSString stringWithFormat:@"%@WebServices/CaseSetting.aspx?action=1",DataCaseUrlPre]
// 取得指定的項目設定 - GET
#define SingleCaseSettingURL [NSString stringWithFormat:@"%@%@",DataCaseUrlPre,@"WebServices/CaseSetting.aspx?action=2&guid=%@"]
// 取得设定的所有類別 - GET
#define CaseCategoryURL [NSString stringWithFormat:@"%@WebServices/CaseCategory.aspx",DataCaseUrlPre]
// 查询项目 - POST
#define CaseSearchURL [NSString stringWithFormat:@"%@WebServices/CaseSearch.aspx",DataCaseUrlPre]
// 取得项目 - GET
#define SingleCaseURL [NSString stringWithFormat:@"%@%@",DataCaseUrlPre,@"WebServices/CaseFind.aspx?guid=%@&pwd=%@"]
// 新增项目 - POST
#define AddCaseURL [NSString stringWithFormat:@"%@WebServices/CaseAdd.aspx",DataCaseUrlPre]

//图片浏览地址
#define CaseImageViewURL [NSString stringWithFormat:@"%@%@",DataCaseUrlPre,@"%@"]



