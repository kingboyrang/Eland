//
//  CaseCameraImage.h
//  ElandSearch
//
//  Created by rang on 13-8-11.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CaseCameraImage : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,assign) id imageSelectDelegate;
-(void)showCameraInController:(UIViewController*)controller;
@end
