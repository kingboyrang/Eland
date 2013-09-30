//
//  IndexViewController.m
//  CaseSearch
//
//  Created by rang on 13-7-23.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "IndexViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "RepairItemViewController.h"
#import "CaseSearchViewController.h"
#import "PushViewController.h"
#import "BusinessAreaViewController.h"
#import "AppDelegate.h"
@interface IndexViewController ()
- (void)setupLeftMenuButton;
- (void)switchViewControllers:(int)tag;
- (void)addSearch:(int)tag;
@end

@implementation IndexViewController
@synthesize menu=_menu;
-(void)dealloc{
    [super dealloc];
    [_menu release],_menu=nil;
    if (_repairItem) {
        [_repairItem release],_repairItem=nil;
    }
    if (_casesearch) {
        [_casesearch release],_casesearch=nil;
    }
    if (_push) {
        [_push release],_push=nil;
    }
    if (_businessarea) {
        [_businessarea release],_businessarea=nil;
    }
    if (_currentViewController) {
        [_currentViewController release],_currentViewController=nil;
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLeftMenuButton];
    [self.navigationItem titleViewBackground];
    
    CGRect rect=self.view.bounds;
    //rect.size.height-=44;
    
    _casesearch=[[CaseSearchViewController alloc] init];
     _casesearch.view.frame=rect;
    [self addChildViewController:_casesearch];
    
    _push=[[PushViewController alloc] init];
     _push.view.frame=rect;
    [self addChildViewController:_push];
    
    _businessarea=[[BusinessAreaViewController alloc] init];
    _businessarea.view.frame=rect;
    _businessarea.view.autoresizesSubviews=YES;
    _businessarea.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addChildViewController:_businessarea];
    
    _repairItem=[[RepairItemViewController alloc] init];
    _repairItem.view.frame=rect;
    _repairItem.view.autoresizesSubviews=YES;
    _repairItem.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addChildViewController:_repairItem];
    [self.view addSubview:_repairItem.view];
    
    _currentViewController=_repairItem;
    
}
-(void)reSubViewLayout{
    AppDelegate *app=[[UIApplication sharedApplication] delegate];
    if (app.isLandscape) {
        if ([_currentViewController isKindOfClass:[RepairItemViewController class]]) {
            [_repairItem relayout:app.isLandscape];
        }
        if ([_currentViewController isKindOfClass:[CaseSearchViewController class]]) {
            [_casesearch relayout:app.isLandscape];
        }
        if ([_currentViewController isKindOfClass:[PushViewController class]]) {
            [_push relayout:app.isLandscape];
        }
        if ([_currentViewController isKindOfClass:[BusinessAreaViewController class]]) {
            [_businessarea relayout:app.isLandscape];
        }
    }
}
- (void)addSearch:(int)tag{
    if (tag==1) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, 30, 30);
        [btn setBackgroundImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
        UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.rightBarButtonItem=rightBtn;
        [rightBtn release];
    }else{
        self.navigationItem.rightBarButtonItem=nil;
    }
}
- (void)switchViewControllers:(int)tag{
    AppDelegate *app=[[UIApplication sharedApplication] delegate];
    UIViewController *oldViewController=_currentViewController;
    switch (tag) {
        case 0:
        {
            //UIApplication *app=[UIApplication sharedApplication];
            
            [_repairItem relayout:app.isLandscape];
            [self transitionFromViewController:_currentViewController toViewController:_repairItem duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            }  completion:^(BOOL finished) {
                if (finished) {
                    _currentViewController=_repairItem;
                    
                }else{
                    _currentViewController=oldViewController;
                }
            }];
        }
            break;
        case 1:
        {
            [self transitionFromViewController:_currentViewController toViewController:_casesearch duration:1 options:UIViewAnimationOptionTransitionCurlDown animations:^{
                
            }  completion:^(BOOL finished) {
                if (finished) {
                    _currentViewController=_casesearch;
                }else{
                    _currentViewController=oldViewController;
                }
            }];
        }
            break;
        case 2:
        {
            [self transitionFromViewController:_currentViewController toViewController:_push duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                
            }  completion:^(BOOL finished) {
                if (finished) {
                    _currentViewController=_push;
                }else{
                    _currentViewController=oldViewController;
                }
            }];
        }
            break;
        case 3:
        {
            [_businessarea relayout:app.isLandscape];
            [self transitionFromViewController:_currentViewController toViewController:_businessarea duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                
            }  completion:^(BOOL finished) {
                if (finished) {
                    _currentViewController=_businessarea;
                }else{
                    _currentViewController=oldViewController;
                }
            }];
        }
            break;

        default:
            break;
    }
}
-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}
#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    if (_menu.isOpen)
        return [_menu close];
   
    
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"報修顯目"
                                                       image:[UIImage imageNamed:@"Icon_Home"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          if(![_currentViewController isKindOfClass:[RepairItemViewController class]])
                                                          {
                                                             [self switchViewControllers:0];
                                                              [self addSearch:0];
                                                          }
                                                      }];
    
    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"案件查詢"
                                                          image:[UIImage imageNamed:@"Icon_Explore"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             if(![_currentViewController isKindOfClass:[CaseSearchViewController class]])
                                                             {
                                                                 [self switchViewControllers:1];
                                                                 [self addSearch:1];
                                                             }
                                                         }];
    
    REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:@"訊息推播"
                                                           image:[UIImage imageNamed:@"Icon_Activity"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              if(![_currentViewController isKindOfClass:[PushViewController class]])
                                                              {
                                                                  [self switchViewControllers:2];
                                                                  [self addSearch:2];
                                                              }
                                                          }];
    
    REMenuItem *profileItem = [[REMenuItem alloc] initWithTitle:@"業務專區"
                                                          image:[UIImage imageNamed:@"Icon_Profile"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             if(![_currentViewController isKindOfClass:[BusinessAreaViewController class]])
                                                             {
                                                                 [self switchViewControllers:3];
                                                                 [self addSearch:3];
                                                             }
                                                         }];
    
    
    homeItem.tag = 0;
    exploreItem.tag = 1;
    activityItem.tag = 2;
    profileItem.tag = 3;
    
    _menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem]];
    _menu.cornerRadius = 4;
    _menu.shadowColor = [UIColor blackColor];
    _menu.shadowOffset = CGSizeMake(0, 1);
    _menu.shadowOpacity = 1;
    _menu.imageOffset = CGSizeMake(5, -1);
    
    [_menu showFromNavigationController:self.navigationController];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Rotation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
