//
//  asyncHelper.m
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "asyncHelper.h"
#import "ASIHTTPRequest.h"
#import "XmlParseHelper.h"
#import "CacheHelper.h"
#import "ServiceHelper.h"
#import "CaseSetting.h"
#import "AdminURL.h"
#import "AppDelegate.h"
#import "UserSet.h"
@interface asyncHelper ()
+(void)handlerCaseCity:(NSString*)xml;
+(void)handlerCaseCategory:(NSString*)xml;
+(void)handlerCaseSetting:(NSString*)xml;
+(void)handlerAccess:(NSString*)xml;
@end

@implementation asyncHelper
+(void)asyncLoadCity:(void (^)(NSArray *result))completed{
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:CityDownURL]];
    [request setCompletionBlock:^{
        if (request.responseStatusCode==200) {
            NSString *xml=[request.responseString stringByReplacingOccurrencesOfString:@"xmlns=\"CaseCity[]\"" withString:@""];
            XmlParseHelper *parse=[[[XmlParseHelper alloc] initWithData:xml] autorelease];
            NSArray *arr=[parse selectNodes:@"//CaseCity" className:@"CaseCity"];
            if (arr&&[arr count]>0) {
                [CacheHelper cacheCityFromArray:arr];
            }
           if (completed) {
               completed(arr);
           }
        }else{
            if (completed) {
                completed(nil);
            }
        }
     }];
    [request setFailedBlock:^{
        if (completed) {
            completed(nil);
        }
    }];
    [request startAsynchronous];
}
+(void)asyncLoadCaseCategory:(void (^)(NSArray *result))completed{
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:CaseCategoryURL]];
    [request setCompletionBlock:^{
        if (request.responseStatusCode==200) {
            NSString *xml=[request.responseString stringByReplacingOccurrencesOfString:@"xmlns=\"CaseCategory[]\"" withString:@""];
            XmlParseHelper *parse=[[[XmlParseHelper alloc] initWithData:xml] autorelease];
            NSArray *arr=[parse selectNodes:@"//CaseCategory" className:@"CaseCategory"];
            if (arr&&[arr count]>0) {
                [CacheHelper cacheCaseCategoryFromArray:arr];
            }
            if (completed) {
                completed(arr);
            }
        }else{
            if (completed) {
                completed(nil);
            }
        }
    }];
    [request setFailedBlock:^{
        if (completed) {
            completed(nil);
        }
    }];
    [request startAsynchronous];
}
+(void)asyncLoadCaseSettings:(void (^)(NSArray *result))completed{
    NSURL *webURL=[NSURL URLWithString:CaseSettingURL];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:webURL];
    [request setCompletionBlock:^{
        if (request.responseStatusCode==200) {
            NSArray *arr=[CaseSetting xmlStringToCaseSettings:request.responseString];
            if (arr&&[arr count]>0) {
                [CacheHelper cacheCaseSettingsFromArray:arr];
            }
            if (completed) {
                completed(arr);
            }
        }else{
            if (completed) {
                completed(nil);
            }
        }
    }];
    [request setFailedBlock:^{
        if (completed) {
            completed(nil);
        }
    }];
    [request startAsynchronous];
}
+(void)backgroundQueueLoad:(void(^)())completed{
    ServiceHelper *helper=[[ServiceHelper alloc] init];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:CityDownURL]];
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"city",@"name", nil]];
    [helper addQueue:request];
    
    ASIHTTPRequest *request1=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:CaseCategoryURL]];
    [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"CaseCategory",@"name", nil]];
    [helper addQueue:request1];
    
    ASIHTTPRequest *request2=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:CaseSettingURL]];
    [request2 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"CaseSetting",@"name", nil]];
    [helper addQueue:request2];
    
    ASIHTTPRequest *request3=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:DataAccessURL]];
    [request3 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"accessurl",@"name", nil]];
    [helper addQueue:request3];
    
    [helper startQueue:^(ServiceResult *result) {
        NSString *requestName=[result.userInfo objectForKey:@"name"];
        if ([requestName isEqualToString:@"city"]) {
            [self handlerCaseCity:result.xmlString];
        }else if([requestName isEqualToString:@"CaseCategory"]){
            [self handlerCaseCategory:result.xmlString];
        }else if([requestName isEqualToString:@"CaseSetting"]){//项目设定
            [self handlerCaseSetting:result.xmlString];
        }else{//访问接口处理
            [self handlerAccess:result.xmlString];
        }
        
    } failed:^(NSError *error, NSDictionary *userInfo) {
        
    } complete:^{
        if (completed) {
            completed();
        }
    }];
}
+(void)backgroundQueueLoad{
    [self backgroundQueueLoad:nil];
}
#pragma mark private
+(void)handlerCaseCity:(NSString*)xml{
    if ([xml length]==0) {
        return;
    }
    xml=[xml stringByReplacingOccurrencesOfString:@"xmlns=\"CaseCity[]\"" withString:@""];
    XmlParseHelper *parse=[[[XmlParseHelper alloc] initWithData:xml] autorelease];
    NSArray *arr=[parse selectNodes:@"//CaseCity" className:@"CaseCity"];
    if (arr&&[arr count]>0) {
        [CacheHelper cacheCityFromArray:arr];
    }
}
+(void)handlerCaseCategory:(NSString*)xml{
    if ([xml length]==0) {
        return;
    }
    xml=[xml stringByReplacingOccurrencesOfString:@"xmlns=\"CaseCategory[]\"" withString:@""];
    XmlParseHelper *parse=[[[XmlParseHelper alloc] initWithData:xml] autorelease];
    NSArray *arr=[parse selectNodes:@"//CaseCategory" className:@"CaseCategory"];
    if (arr&&[arr count]>0) {
        [CacheHelper cacheCaseCategoryFromArray:arr];
    }
}
+(void)handlerCaseSetting:(NSString*)xml{
    if ([xml length]==0) {
        return;
    }
    NSArray *arr=[CaseSetting xmlStringToCaseSettings:xml];
    if (arr&&[arr count]>0) {
        [CacheHelper cacheCaseSettingsFromArray:arr];
    }
}
+(void)handlerAccess:(NSString*)xml{
    if ([xml length]==0) {
        return;
    }
    xml=[xml stringByReplacingOccurrencesOfString:@"xmlns=\"AdminURL[]\"" withString:@""];
    XmlParseHelper *parse=[[[XmlParseHelper alloc] initWithData:xml] autorelease];
    NSArray *source=[parse selectNodes:@"//AdminURL" className:@"AdminURL"];
    NSMutableArray *arr=[NSMutableArray arrayWithArray:DataServicesSource];
    if (source&&[source count]>0) {
        NSString *pushUrl=@"";
        for (AdminURL *item in source) {
            if ([item.name isEqualToString:@"casesadminurl"]&&[item.url length]>0) {
                arr[0]=item.url;
            }
            if ([item.name isEqualToString:@"pushsadminurl"]&&[item.url length]>0) {
                pushUrl=item.url;
            }
        }
        if ([pushUrl length]>0&&![pushUrl isEqualToString:arr[1]]) {
            arr[1]=pushUrl;
            UserSet *entity=[UserSet sharedInstance];
            entity.isRegisterToken=NO;
            [entity save];
            AppDelegate *app=[[UIApplication sharedApplication] delegate];
            [app registerAPNSToken:[[UserSet sharedInstance] AppToken]];
            //重新注册
        }
        [arr writeToFile:DataWebPath atomically:YES];
    }
}
@end
