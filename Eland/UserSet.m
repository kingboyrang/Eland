//
//  appSet.m
//  CaseSearch
//
//  Created by rang on 13-4-22.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "UserSet.h"

@interface UserSet ()
-(void)initloadValue;
@end

@implementation UserSet
@synthesize GUID,Name,Nick,Mobile,Email,AppToken,isSync,isReadPrivacy;
@synthesize isFirstLoad,isSecondLoad;
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.GUID forKey:@"GUID"];
    [encoder encodeObject:self.Name forKey:@"Name"];
    [encoder encodeObject:self.Nick forKey:@"Nick"];
    [encoder encodeObject:self.Mobile forKey:@"Mobile"];
    [encoder encodeObject:self.Email forKey:@"Email"];
    [encoder encodeObject:self.AppToken forKey:@"AppToken"];
    [encoder encodeBool:self.isRegisterToken forKey:@"isRegisterToken"];
    [encoder encodeBool:self.isSync forKey:@"isSync"];
    [encoder encodeBool:self.isFirstLoad forKey:@"isFirstLoad"];
    [encoder encodeBool:self.isSecondLoad forKey:@"isSecondLoad"];
    [encoder encodeBool:self.isReadPrivacy forKey:@"isReadPrivacy"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.GUID=[aDecoder decodeObjectForKey:@"GUID"];
        self.Name=[aDecoder decodeObjectForKey:@"Name"];
        self.Nick=[aDecoder decodeObjectForKey:@"Nick"];
        self.Mobile=[aDecoder decodeObjectForKey:@"Mobile"];
        self.Email=[aDecoder decodeObjectForKey:@"Email"];
        self.AppToken=[aDecoder decodeObjectForKey:@"AppToken"];
        self.isRegisterToken=[aDecoder decodeBoolForKey:@"isRegisterToken"];
        self.isSync=[aDecoder decodeBoolForKey:@"isSync"];
        self.isFirstLoad=[aDecoder decodeBoolForKey:@"isFirstLoad"];
        self.isSecondLoad=[aDecoder decodeBoolForKey:@"isSecondLoad"];
         self.isReadPrivacy=[aDecoder decodeBoolForKey:@"isReadPrivacy"];
    }
    return self;
}
+ (UserSet *)sharedInstance{
    static dispatch_once_t  onceToken;
    static UserSet * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[UserSet alloc] init];
    });
    return sSharedInstance;
}
-(id)init{
    if (self=[super init]) {
        [self initloadValue];
    }
    return self;
}
-(void)save{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"localEncodeSet"];
    [defaults synchronize];
}
- (void) readPrivacy{
    self.isReadPrivacy=YES;
    [self save];
}
- (void) registerAppToken:(NSString*)token status:(BOOL)status{
    self.AppToken=token;
    self.isRegisterToken=status;
    [self save];
}
+ (void) businessSync{
    UserSet *user=[UserSet sharedInstance];
    user.isSync=YES;
    [user save];
}
+(NSString*)ObjectToXml{
    UserSet *app=[UserSet sharedInstance];
    if (app) {
        NSMutableString *body=[NSMutableString stringWithFormat:@""];
        [body appendFormat:@"&lt;Name&gt;%@&lt;/Name&gt;",app.Name];
        [body appendFormat:@"&lt;Nick&gt;%@&lt;/Nick&gt;",app.Nick];
        [body appendFormat:@"&lt;Mobile&gt;%@&lt;/Mobile&gt;",app.Mobile];
        [body appendFormat:@"&lt;Email&gt;%@&lt;/Email&gt;",app.Email];
        [body appendFormat:@"&lt;Flag&gt;%@&lt;/Flag&gt;",app.AppToken];
        return [NSString stringWithFormat:@"%@",body];
    }
    return @"";
}
+ (BOOL)emptyUser{
    UserSet *app=[UserSet sharedInstance];
    if ([app.Name length]==0) {
        return NO;
    }
    if ([app.Mobile length]==0) {
        return NO;
    }
    if ([app.Email length]==0) {
        return NO;
    }
    if ([app.Nick length]==0) {
        return NO;
    }
    return YES;
}


//是否为政府人员
+ (BOOL)isGovEmployee{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"isGovEmployee"]) {
        return [defaults boolForKey:@"isGovEmployee"];
    }
    return YES;
}

//设置人员身份(一般民众或政府人员)
+ (void)enableGovEmployee:(BOOL)enable{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:enable forKey:@"isGovEmployee"];
    [defaults synchronize];
}

#pragma mark -
#pragma mark 私有方法
-(void)initloadValue{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"localEncodeSet"];
    if (data) {
        UserSet *obj = (UserSet*)[NSKeyedUnarchiver unarchiveObjectWithData: data];
        self.GUID=obj.GUID;
        self.Name=obj.Name;
        self.Nick=obj.Nick;
        self.Mobile=obj.Mobile;
        self.Email=obj.Email;
        self.AppToken=obj.AppToken;
        self.isRegisterToken=obj.isRegisterToken;
        self.isSync=obj.isSync;
        self.isFirstLoad=obj.isFirstLoad;
        self.isSecondLoad=obj.isSecondLoad;
        self.isReadPrivacy=obj.isReadPrivacy;
    }else{
        self.GUID=@"";
        self.Name=@"";
        self.Nick=@"";
        self.Mobile=@"";
        self.Email=@"";
        self.AppToken=@"";
        self.isRegisterToken=NO;
        self.isSync=NO;
        self.isFirstLoad=NO;
        self.isSecondLoad=NO;
        self.isReadPrivacy=NO;
    }
}
@end
