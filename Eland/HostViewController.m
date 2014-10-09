//
//  HostViewController.m
//  ICViewPager
//
//  Created by Ilter Cengiz on 28/08/2013.
//  Copyright (c) 2013 Ilter Cengiz. All rights reserved.
//

#import "HostViewController.h"
#import "RepairItemViewController.h"
#import "CaseSearchViewController.h"
#import "PushViewController.h"
#import "BusinessAreaViewController.h"
#import "UIColor+TPCategory.h"
#define MenuItem @""

@interface HostViewController () <ViewPagerDataSource, ViewPagerDelegate>

@end

@implementation HostViewController

- (void)viewDidLoad {
    
    self.dataSource = self;
    self.delegate = self;
   
    // Keeps tab bar below navigation bar on iOS 7.0+
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [super viewDidLoad];
     self.menuBar.controlers=self;
    
    [self.navigationItem titleViewBackground];
    
    NSLog(@"nav=%@",self.navigationController);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectedMenuItemIndex:(int)index{
    [self selectedViewcontrollerIndex:index];
    if (index==1) {
        UIViewController *controller=[self viewControllerAtIndex:index];
        if (controller&&[controller isKindOfClass:[CaseSearchViewController class]]) {
            CaseSearchViewController *search=(CaseSearchViewController*)controller;
            [search loadingSource];
        }
    }
}
#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 4;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.text = [NSString stringWithFormat:@"Content View #%u",index];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
    //return [self menuItemWithIndex:index];
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    if (index==0) {
        RepairItemViewController *item=[[RepairItemViewController alloc] init];
        item.parentNavigation=self.navigationController;
        return item;
    }else if(index==1){
        CaseSearchViewController *search=[[CaseSearchViewController alloc] init];
        search.parentNavigation=self.navigationController;
        return search;
    }else if(index==2){
        PushViewController *push=[[PushViewController alloc] init];
        push.parentNavigation=self.navigationController;
        return push;
    }else{
        BusinessAreaViewController *business=[[BusinessAreaViewController alloc] init];
        
        return business;
    }
}
#pragma mark - ViewPagerDelegate
- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index{
    
    
    [self.menuBar setSelectedButtonWithIndex:index];
    if (index==1) {
        UIViewController *controller=[self viewControllerAtIndex:index];
        if (controller&&[controller isKindOfClass:[CaseSearchViewController class]]) {
            CaseSearchViewController *search=(CaseSearchViewController*)controller;
            [search loadingSource];
        }
    }
    
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}

@end
