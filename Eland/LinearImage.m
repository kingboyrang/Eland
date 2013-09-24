//
//  LinearImage.m
//  Eland
//
//  Created by aJia on 13/9/24.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "LinearImage.h"
#import "UIColor+TPCategory.h"
@interface LinearImage ()
+(CGContextRef)createBitmapContextWith:(int)pixelsWide height:(int)pixelsHigh;
+(void)addRoundedRectToPathContext:(CGContextRef)context frame:(CGRect)rect cornerWith:(float)ovalWidth cornerHeight:(float)ovalHeight;
@end


@implementation LinearImage
#pragma mark private Methods
+(CGContextRef)createBitmapContextWith:(int)pixelsWide height:(int)pixelsHigh
{
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedLast);
    if (context== NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
        return NULL;
    }
    CGColorSpaceRelease( colorSpace );
    
    return context;
}
+(void)addRoundedRectToPathContext:(CGContextRef)context frame:(CGRect)rect cornerWith:(float)ovalWidth cornerHeight:(float)ovalHeight
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}
+(UIImage*)createCornerImageSize:(CGSize)imageSize cornerRadius:(float)radius  imageColor:(UIColor*)imagecolor{
    CGContextRef context  = [self createBitmapContextWith:imageSize.width height:imageSize.height];
    [self addRoundedRectToPathContext:context frame:CGRectMake(0, 0, imageSize.width, imageSize.height) cornerWith:radius cornerHeight:radius];
    CGContextSetRGBFillColor(context, imagecolor.red, imagecolor.green, imagecolor.blue, imagecolor.alpha);
    CGContextFillPath(context);
    CGImageRef myRef = CGBitmapContextCreateImage (context);
    free(CGBitmapContextGetData(context));
    CGContextRelease(context);
    return [UIImage imageWithCGImage:myRef];
}
@end
