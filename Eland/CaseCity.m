//
//  CaseCity.m
//  Eland
//
//  Created by aJia on 13/10/4.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseCity.h"

@implementation CaseCity
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.GUID forKey:@"GUID"];
    [encoder encodeObject:self.Name forKey:@"Name"];
    [encoder encodeObject:self.ParentGuid forKey:@"ParentGuid"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.GUID=[aDecoder decodeObjectForKey:@"GUID"];
        self.Name=[aDecoder decodeObjectForKey:@"Name"];
        self.ParentGuid=[aDecoder decodeObjectForKey:@"ParentGuid"];
    }
    return self;
}
@end
