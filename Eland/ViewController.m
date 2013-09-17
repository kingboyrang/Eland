//
//  ViewController.m
//  Eland
//
//  Created by aJia on 13/9/10.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+TPCategory.h"
@interface ViewController ()
-(void)saveImage:(UIImage*)image withName:(NSString*)name;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image=[[UIImage imageNamed:@"system_normal.png"] imageByScalingProportionallyToSize:CGSizeMake(30, 30)];
    [self saveImage:image withName:@"system_normal.png"];
    
    UIImage *image1=[[UIImage imageNamed:@"system_select.png"] imageByScalingProportionallyToSize:CGSizeMake(30, 30)];
    [self saveImage:image1 withName:@"system_select.png"];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)saveImage:(UIImage*)image withName:(NSString*)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:name];   // 保存文件的名称
    BOOL result = [UIImagePNGRepresentation(image) writeToFile: filePath    atomically:YES]; // 保存成功会返回YES
    NSLog(@"result=%c\n",result);
    NSLog(@"path=%@\n",filePath);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
