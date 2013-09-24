//
//  LinearImage.h
//  Eland
//
//  Created by aJia on 13/9/24.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinearImage : NSObject
+(UIImage*)createCornerImageSize:(CGSize)imageSize cornerRadius:(float)radius  imageColor:(UIColor*)imagecolor;
@end
