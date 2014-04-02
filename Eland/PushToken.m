//
//  PushToken.m
//  Eland
//
//  Created by aJia on 13/10/3.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "PushToken.h"
#import "UIDevice+TPCategory.h"
@implementation PushToken
-(NSString*)XmlSerialize{
    NSMutableString *xml=[NSMutableString stringWithFormat:@"<?xml version=\"1.0\"?>"];
    [xml appendString:@"<PushToken xmlns=\"PushToken\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">"];
    
    [xml appendFormat:@"<GUID>%@</GUID>",[self getPropertyValue:_GUID]];
    [xml appendFormat:@"<UniqueCode>%@</UniqueCode>",[self getPropertyValue:_UniqueCode]];
    [xml appendFormat:@"<AppCode>%@</AppCode>",[self getPropertyValue:_AppCode]];
    [xml appendFormat:@"<AppName>%@</AppName>",[self getPropertyValue:_AppName]];
    [xml appendFormat:@"<AppType>%@</AppType>",[self getPropertyValue:_AppType]];
    [xml appendFormat:@"<Flatbed>%@</Flatbed>",[self getPropertyValue:_Flatbed]];
    [xml appendString:@"</PushToken>"];
     NSString  *result=[xml stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    result=[result stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    return result;
}
+(ServiceArgs*)registerTokenWithDeivceId:(NSString*)deviceId{
    PushToken *push=[[[PushToken alloc] init] autorelease];
    push.GUID=deviceId;
    push.UniqueCode=[[UIDevice currentDevice] uniqueDeviceIdentifier];
    push.AppCode=@"ios.app.com.eland2.cases";
    push.AppName=@"IOS施政互動";
    push.AppType=@"ios";
    push.Flatbed=DeviceIsPad?@"1":@"2";
    
    ServiceArgs *args=[[[ServiceArgs alloc] init] autorelease];
    args.methodName=@"Register";
    args.soapParams=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:[push XmlSerialize],@"xml", nil], nil];
    return args;
}
@end
