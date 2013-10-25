//
//  MKPhotoBrowser.h
//  ScrollImageDemo
//
//  Created by rang on 13-8-22.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MKPhotoBrowserDataSource.h"


@interface MKPhotoBrowser : UIViewController<UIScrollViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate>{
@private
    UIScrollView *_scrollView;
    UIToolbar *_toolBar;
    UIBarButtonItem *_actionButton;
    UIBarButtonItem *_nextButton;
    UIBarButtonItem *_previousButton;
    UIBarButtonItem *_trashButton;
     UIActionSheet *_actionsSheet;
    UIActionSheet *_actionsButtonSheet;
    
    NSMutableArray *photoViews_;
    
    id <MKPhotoBrowserDataSource> _dataSource;
    NSInteger _currentIndex;
    NSInteger _pagecount;
    
    int firstVisiblePageIndexBeforeRotation_;
    CGFloat percentScrolledIntoFirstVisiblePage_;
    
    BOOL _showStatus;
    // Appearance
    BOOL _viewIsActive;
    BOOL _didSavePreviousStateOfNavBar;
    UIImage *_navigationBarBackgroundImageDefault,
    *_navigationBarBackgroundImageLandscapePhone;
    UIColor *_previousNavBarTintColor;
    UIBarStyle _previousNavBarStyle;
    UIBarButtonItem *_previousViewControllerBackButton;
}
- (id)initWithDataSource:(id <MKPhotoBrowserDataSource>)dataSource andStartWithPhotoAtIndex:(NSUInteger)index;
-(void)setDataSource:(id <MKPhotoBrowserDataSource>)dataSource;
@property(nonatomic,assign) BOOL showTrashButton;
@property(nonatomic,assign) BOOL showShareButton;
@end
