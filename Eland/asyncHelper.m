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
@interface asyncHelper ()
+(void)handlerCaseCity:(NSString*)xml;
+(void)handlerCaseCategory:(NSString*)xml;
+(void)handlerCaseSetting:(NSString*)xml;
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
+(void)backgroundQueueLoad{
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
    
    [helper startQueue:^(ServiceResult *result) {
        NSString *requestName=[result.userInfo objectForKey:@"name"];
        if ([requestName isEqualToString:@"city"]) {
            [self handlerCaseCity:result.xmlString];
        }else if([requestName isEqualToString:@"CaseCategory"]){
            [self handlerCaseCategory:result.xmlString];
        }else{//项目设定
            [self handlerCaseSetting:result.xmlString];
        }
        
    } failed:^(NSError *error, NSDictionary *userInfo) {
        
    } complete:^{
        
    }];
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
@end
