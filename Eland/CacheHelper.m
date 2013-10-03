//
//  CacheHelper.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CacheHelper.h"
#import "ASIHTTPRequest.h"
#import "XmlParseHelper.h"
#import "DownloadManager.h"
@implementation CacheHelper
+(void)asyncCacheCity{
    
    DownLoadArgs *args=[[[DownLoadArgs alloc] init] autorelease];
    args.downloadUrl=CityDownURL;
    //args.downloadFileName=@"City";
    args.fileSavePath=[DocumentPath stringByAppendingPathComponent:@"City"];
    args.isFileCache=YES;
    [[DownloadManager sharedInstance] startDownload:args progress:nil finishDownload:^(NSString *filePath, NSDictionary *userInfo) {
         NSLog(@"path=%@\n",filePath);
    } failedDownload:^(NSError *error, NSDictionary *userInfo) {
         NSLog(@"error=%@\n",[error description]);
    }];
    /***
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:CityDownURL]];
    [request setCompletionBlock:^{
        NSLog(@"xml=%@\n",[request responseString]);
        
        if (request.responseStatusCode==200) {
            NSString *xml=[request.responseString stringByReplacingOccurrencesOfString:@"xmlns=\"CaseCity[]\"" withString:@""];
            XmlParseHelper *parse=[[[XmlParseHelper alloc] initWithData:xml] autorelease];
            NSLog(@"%@\n",[parse selectNodes:@"//CaseCity"]);
        }
        
    }];
    [request setFailedBlock:^{
        NSLog(@"error=%@\n",[request.error description]);
    }];
    [request startAsynchronous];
     ***/

}
@end
