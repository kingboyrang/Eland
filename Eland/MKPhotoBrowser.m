//
//  MKPhotoBrowser.m
//  ScrollImageDemo
//
//  Created by rang on 13-8-22.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "MKPhotoBrowser.h"
#import "MKPhotoView.h"

const CGFloat ktkDefaultPortraitToolbarHeight   = 44;
const CGFloat ktkDefaultLandscapeToolbarHeight  = 33;
const CGFloat ktkDefaultToolbarHeight = 44;

@interface MKPhotoBrowser ()
-(void)actionButtonPressed:(id)sender;
-(void)previousPhoto;
-(void)nextPhoto;
-(void)trashPhoto:(id)sender;
-(CGRect)frameForPagingScrollView;
-(CGRect)frameForPageAtIndex:(NSUInteger)index;
-(void)setScrollViewContentSize;
-(void)setCurrentIndex:(NSInteger)newIndex;
-(void)scrollToIndex:(NSInteger)index;
-(void)setPhotoViews;
-(void)loadPhoto:(NSInteger)index;
-(void)unloadPhoto:(NSInteger)index;
-(void)buttonBackClick;
- (void)toggleNavButtons;
-(void)finishTransh;
-(void)toggleChromeDisplay;

-(UIImage*)getCurrentOrignImage;

// Actions
- (void)savePhoto;
- (void)copyPhoto;
- (void)emailPhoto;
@end

@implementation MKPhotoBrowser
@synthesize showShareButton;
@synthesize showTrashButton;
-(void)dealloc{
    [super dealloc];
    [_scrollView release],_scrollView=nil;
    [_toolBar release],_toolBar=nil;
    [_nextButton release],_nextButton=nil;
    [_previousButton release],_previousButton=nil;
    [photoViews_ release],photoViews_=nil;
    [_dataSource release],_dataSource=nil;
    [_trashButton release],_trashButton=nil;
    [_navigationBarBackgroundImageDefault release],_navigationBarBackgroundImageDefault=nil;
    [_navigationBarBackgroundImageLandscapePhone release],_navigationBarBackgroundImageLandscapePhone=nil;
    [_previousNavBarTintColor release],_previousNavBarTintColor=nil;
    //if (_previousViewControllerBackButton) {
     //   [_previousViewControllerBackButton release],_previousViewControllerBackButton=nil;
    //}
    if (_actionsSheet) {
        [_actionsSheet release],_actionsSheet=nil;
    }
    if (_actionsButtonSheet){
        [_actionsButtonSheet release],_actionsButtonSheet=nil;
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
- (id)initWithDataSource:(id <MKPhotoBrowserDataSource>)dataSource andStartWithPhotoAtIndex:(NSUInteger)index{
    if (self=[super init]) {
         _dataSource = [dataSource retain];
         _currentIndex=index;
        
        //[self setWantsFullScreenLayout:YES];
        //BOOL isStatusbarHidden = [[UIApplication sharedApplication] isStatusBarHidden];
        //[self setStatusbarHidden:isStatusbarHidden];
        //self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
-(void)setDataSource:(id <MKPhotoBrowserDataSource>)dataSource{
    _dataSource = [dataSource retain];
    _pagecount=[_dataSource numberOfPhotos];
    [self setPhotoViews];
    [self setScrollViewContentSize];
}
-(void)loadView{
    [super loadView];
    CGRect rect=[self frameForPagingScrollView];
    _scrollView=[[UIScrollView alloc] initWithFrame:rect];
    _scrollView.delegate=self;
    _scrollView.autoresizesSubviews=YES;
    _scrollView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
    //toolbar
    CGRect screenFrame =self.view.bounds;
    //[[UIScreen mainScreen] bounds];
    CGRect toolbarFrame = CGRectMake(0,
                                     screenFrame.size.height - ktkDefaultToolbarHeight,
                                     screenFrame.size.width,
                                     ktkDefaultToolbarHeight);
    
    _toolBar=[[UIToolbar alloc] initWithFrame:toolbarFrame];
    [_toolBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin];
    [_toolBar setBarStyle:UIBarStyleBlackTranslucent];
    _toolBar.alpha=0.8;
    
    _actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonPressed:)];
    UIBarButtonItem *flexSpaceLeft=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    _previousButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"UIBarButtonItemArrowLeft.png"] style:UIBarButtonItemStylePlain target:self action:@selector(previousPhoto)];
    _nextButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"UIBarButtonItemArrowRight.png"] style:UIBarButtonItemStylePlain target:self action:@selector(nextPhoto)];
    UIBarButtonItem *flexSpaceMid=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    _trashButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashPhoto:)];
    
    NSMutableArray *result=[NSMutableArray array];
    if (self.showShareButton) {
        [result addObject:_actionButton];
    }
    [result addObject:flexSpaceLeft];
    [result addObject:_previousButton];
    [result addObject:_nextButton];
    [result addObject:flexSpaceMid];
    if (self.showTrashButton) {
        [result addObject:_trashButton];
    }
    _toolBar.items=result;
    [self.view addSubview:_toolBar];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_viewIsActive) {
        [self storePreviousNavBarAppearance];
    }
    [self setNavBarAppearance:animated];
     //显示
    [self setScrollViewContentSize];
    [self setCurrentIndex:_currentIndex];
    [self scrollToIndex:_currentIndex];
    [self toggleNavButtons];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    // Check that we're being popped for good
    if ([self.navigationController.viewControllers objectAtIndex:0] != self &&
        ![self.navigationController.viewControllers containsObject:self]) {
        
        // State
        _viewIsActive = NO;
        
        // Bar state / appearance
        [self restorePreviousNavBarAppearance:animated];
        
    }
    
    // Controls
    [NSObject cancelPreviousPerformRequestsWithTarget:self]; // Cancel any pending toggles from taps
    //[self setControlsHidden:NO animated:NO permanent:YES];
    
    // Status bar
    //if (self.wantsFullScreenLayout && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    //    [[UIApplication sharedApplication] setStatusBarStyle:_previousStatusBarStyle animated:animated];
    //}
    
	// Super
	[super viewWillDisappear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _viewIsActive = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //buttonBackClick
    
    // Navigation buttons
    if ([self.navigationController.viewControllers objectAtIndex:0] == self) {
        // We're first on stack so show done button
        UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed:)] autorelease];
        // Set appearance
        if ([UIBarButtonItem respondsToSelector:@selector(appearance)]) {
            [doneButton setBackgroundImage:nil forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [doneButton setBackgroundImage:nil forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
            [doneButton setBackgroundImage:nil forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
            [doneButton setBackgroundImage:nil forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
            [doneButton setTitleTextAttributes:[NSDictionary dictionary] forState:UIControlStateNormal];
            [doneButton setTitleTextAttributes:[NSDictionary dictionary] forState:UIControlStateHighlighted];
        }
        self.navigationItem.rightBarButtonItem = doneButton;
    } else {
        // We're not first so show back button
        UIViewController *previousViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
        NSString *backButtonTitle = previousViewController.navigationItem.backBarButtonItem ? previousViewController.navigationItem.backBarButtonItem.title : previousViewController.title;
        UIBarButtonItem *newBackButton = [[[UIBarButtonItem alloc] initWithTitle:backButtonTitle style:UIBarButtonItemStylePlain target:nil action:nil] autorelease];
        // Appearance
        if ([UIBarButtonItem respondsToSelector:@selector(appearance)]) {
            [newBackButton setBackButtonBackgroundImage:nil forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [newBackButton setBackButtonBackgroundImage:nil forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
            [newBackButton setBackButtonBackgroundImage:nil forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
            [newBackButton setBackButtonBackgroundImage:nil forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
            [newBackButton setTitleTextAttributes:[NSDictionary dictionary] forState:UIControlStateNormal];
            [newBackButton setTitleTextAttributes:[NSDictionary dictionary] forState:UIControlStateHighlighted];
        }
        _previousViewControllerBackButton = [previousViewController.navigationItem.backBarButtonItem retain]; // remember previous
        previousViewController.navigationItem.backBarButtonItem = newBackButton;
    }
    
    
    _pagecount=[_dataSource numberOfPhotos];
    [self setScrollViewContentSize];
    [self setPhotoViews];
	// Do any additional setup after loading the view.
}
- (void)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)buttonBackClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)toggleChromeDisplay{
    if (_showStatus) {
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        [_toolBar setHidden:YES];
    }
}
#pragma mark - Nav Bar Appearance

- (void)setNavBarAppearance:(BOOL)animated {
    self.navigationController.navigationBar.tintColor = nil;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    if ([[UINavigationBar class] respondsToSelector:@selector(appearance)]) {
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsLandscapePhone];
    }
}

- (void)storePreviousNavBarAppearance {
    _didSavePreviousStateOfNavBar = YES;
    _previousNavBarTintColor= [self.navigationController.navigationBar.tintColor retain];
    _previousNavBarStyle = self.navigationController.navigationBar.barStyle;
    if ([[UINavigationBar class] respondsToSelector:@selector(appearance)]) {
        _navigationBarBackgroundImageDefault =[[self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault] retain];
        _navigationBarBackgroundImageLandscapePhone = [[self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsLandscapePhone] retain];
    }
}

- (void)restorePreviousNavBarAppearance:(BOOL)animated {
    if (_didSavePreviousStateOfNavBar) {
        self.navigationController.navigationBar.tintColor = _previousNavBarTintColor;
        self.navigationController.navigationBar.barStyle = _previousNavBarStyle;
        if ([[UINavigationBar class] respondsToSelector:@selector(appearance)]) {
            [self.navigationController.navigationBar setBackgroundImage:_navigationBarBackgroundImageDefault forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setBackgroundImage:_navigationBarBackgroundImageLandscapePhone forBarMetrics:UIBarMetricsLandscapePhone];
        }
        // Restore back button if we need to
        if (_previousViewControllerBackButton) {
            UIViewController *previousViewController = [self.navigationController topViewController]; // We've disappeared so previous is now top
            previousViewController.navigationItem.backBarButtonItem = _previousViewControllerBackButton;
            _previousViewControllerBackButton = nil;
        }
    }
}
#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = floor(fractionalPage);
        if (page != _currentIndex) {
            [self setCurrentIndex:page];
        }
    
}

#pragma mark privite Methods
-(void)setPhotoViews{
    if(photoViews_){
        [photoViews_ release],photoViews_=nil;
    }
    photoViews_ = [[NSMutableArray alloc] initWithCapacity:_pagecount];
    for (int i=0; i < _pagecount; i++) {
        [photoViews_ addObject:[NSNull null]];
    }
}
-(void)loadPhoto:(NSInteger)index{
    if (index<0||index>=_pagecount) {
        return;
    }
    id currentPhotoView = [photoViews_ objectAtIndex:index];
    if (NO==[currentPhotoView isKindOfClass:[MKPhotoView class]]) {
        CGRect rect=[self frameForPageAtIndex:index];
        MKPhotoView *photo=[[MKPhotoView alloc] initWithFrame:rect];
        [photo setScroller:self];
        [photo setIndex:index];
        [photo setBackgroundColor:[UIColor clearColor]];
        if (_dataSource) {
            if ([_dataSource respondsToSelector:@selector(imageAtIndex:)]) {
                  [photo setImage:[_dataSource imageAtIndex:index]];
            }
        }
        [_scrollView addSubview:photo];
        [photoViews_ replaceObjectAtIndex:index withObject:photo];
        [photo release];
    }else{
        [currentPhotoView turnOffZoom];
    }
}
- (void)unloadPhoto:(NSInteger)index
{
    if (index < 0 || index >= _pagecount) {
        return;
    }
    id currentPhotoView = [photoViews_ objectAtIndex:index];
    if ([currentPhotoView isKindOfClass:[MKPhotoView class]]) {
        [currentPhotoView removeFromSuperview];
        [photoViews_ replaceObjectAtIndex:index withObject:[NSNull null]];
    }
}
- (void)setCurrentIndex:(NSInteger)newIndex
{
  
    _currentIndex = newIndex;
    [self loadPhoto:_currentIndex];
    [self loadPhoto:_currentIndex+1];
    [self loadPhoto:_currentIndex-1];
    [self unloadPhoto:_currentIndex + 2];
    [self unloadPhoto:_currentIndex - 2];
    [self toggleNavButtons];
}
- (void)scrollToIndex:(NSInteger)index
{
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * index;
    frame.origin.y = 0;
    [_scrollView scrollRectToVisible:frame animated:NO];
    [self toggleNavButtons];
}
- (void)setScrollViewContentSize
{
    NSInteger pageCount = _pagecount;
    if (pageCount == 0) {
        pageCount = 1;
    }
    
    CGSize size = CGSizeMake(_scrollView.frame.size.width * pageCount,
                             _scrollView.frame.size.height / 2);   // Cut in half to prevent horizontal scrolling.
    [_scrollView setContentSize:size];
}
- (void)toggleNavButtons{
    _previousButton.enabled = (_currentIndex > 0);
	_nextButton.enabled = (_currentIndex < _pagecount-1);
    _trashButton.enabled=(_pagecount>0);
    
}
#pragma mark -
#pragma mark Frame calculations
#define browerPADDING  20
- (CGRect)frameForPagingScrollView
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    frame.origin.x -= browerPADDING;
    frame.size.width += (2 * browerPADDING);
    return frame;
}

- (CGRect)frameForPageAtIndex:(NSUInteger)index
{
    // We have to use our paging scroll view's bounds, not frame, to calculate the page placement. When the device is in
    // landscape orientation, the frame will still be in portrait because the pagingScrollView is the root view controller's
    // view, so its frame is in window coordinate space, which is never rotated. Its bounds, however, will be in landscape
    // because it has a rotation transform applied.
    CGRect bounds = [_scrollView bounds];
    CGRect pageFrame = bounds;
    pageFrame.size.width -= (2 * browerPADDING);
    pageFrame.origin.x = (bounds.size.width * index) + browerPADDING;
    return pageFrame;
}

#pragma mark viewer
-(void)previousPhoto{
    [self scrollToIndex:_currentIndex-1];
}
-(void)nextPhoto{
    [self scrollToIndex:_currentIndex+1];
}
-(void)trashPhoto:(id)sender{
        if (!_actionsSheet) {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            _actionsSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                                cancelButtonTitle:nil destructiveButtonTitle:nil
                                                otherButtonTitles:NSLocalizedString(@"删除", nil),NSLocalizedString(@"取消", nil), nil];
            }else{
                _actionsSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:nil
                                                   otherButtonTitles:NSLocalizedString(@"删除", nil), nil];
            }
            _actionsSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [_actionsSheet showFromBarButtonItem:sender animated:YES];
        } else {
            [_actionsSheet showInView:self.view];
        }
}
-(void)actionButtonPressed:(id)sender{
    if (!_actionsButtonSheet) {
    if ([MFMailComposeViewController canSendMail]) {
        _actionsButtonSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                                cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:nil
                                                otherButtonTitles:NSLocalizedString(@"保存到相册", nil), NSLocalizedString(@"复制", nil), NSLocalizedString(@"发送Email", nil), nil];
    } else {
        _actionsButtonSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                                cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:nil
                                                otherButtonTitles:NSLocalizedString(@"存到相册", nil), NSLocalizedString(@"复制", nil), nil];
    }
    _actionsButtonSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [_actionsButtonSheet showFromBarButtonItem:sender animated:YES];
    } else {
        [_actionsButtonSheet showInView:self.view];
    }

}
-(void)finishTransh{
    if (_dataSource) {
        NSInteger photoIndexToDelete = _currentIndex;
        [self unloadPhoto:photoIndexToDelete];
        [_dataSource deleteImageAtIndex:photoIndexToDelete];
        _pagecount -= 1;
        if (_pagecount == 0) {
            //[self showChrome];
            //[[self navigationController] popViewControllerAnimated:YES];
        } else {
            NSInteger nextIndex = photoIndexToDelete;
            if (nextIndex == _pagecount) {
                nextIndex -= 1;
            }
            [self setCurrentIndex:nextIndex];
            [self setScrollViewContentSize];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Rotation Magic

- (void)updateToolbarWithOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    CGRect toolbarFrame = _toolBar.frame;
    if ((interfaceOrientation) == UIInterfaceOrientationPortrait || (interfaceOrientation) == UIInterfaceOrientationPortraitUpsideDown) {
        toolbarFrame.size.height = ktkDefaultPortraitToolbarHeight;
    } else {
        toolbarFrame.size.height = ktkDefaultLandscapeToolbarHeight+1;
    }
    
    toolbarFrame.size.width = self.view.frame.size.width;
    toolbarFrame.origin.y =  self.view.frame.size.height - toolbarFrame.size.height;
    _toolBar.frame = toolbarFrame;
}

- (void)layoutScrollViewSubviews
{
    [self setScrollViewContentSize];
    
    NSArray *subviews = [_scrollView subviews];
    
    for (MKPhotoView *photoView in subviews) {
        CGPoint restorePoint = [photoView pointToCenterAfterRotation];
        CGFloat restoreScale = [photoView scaleToRestoreAfterRotation];
        [photoView setFrame:[self frameForPageAtIndex:[photoView index]]];
        [photoView setMaxMinZoomScalesForCurrentBounds];
        [photoView restoreCenterPoint:restorePoint scale:restoreScale];
    }
    
    // adjust contentOffset to preserve page location based on values collected prior to location
    CGFloat pageWidth = _scrollView.bounds.size.width;
    CGFloat newOffset = (firstVisiblePageIndexBeforeRotation_ * pageWidth) + (percentScrolledIntoFirstVisiblePage_ * pageWidth);
    _scrollView.contentOffset = CGPointMake(newOffset, 0);
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    // here, our pagingScrollView bounds have not yet been updated for the new interface orientation. So this is a good
    // place to calculate the content offset that we will need in the new orientation
    CGFloat offset = _scrollView.contentOffset.x;
    CGFloat pageWidth = _scrollView.bounds.size.width;
    
    if (offset >= 0) {
        firstVisiblePageIndexBeforeRotation_ = floorf(offset / pageWidth);
        percentScrolledIntoFirstVisiblePage_ = (offset - (firstVisiblePageIndexBeforeRotation_ * pageWidth)) / pageWidth;
    } else {
        firstVisiblePageIndexBeforeRotation_ = 0;
        percentScrolledIntoFirstVisiblePage_ = offset / pageWidth;
    }
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [self layoutScrollViewSubviews];
    // Rotate the toolbar.
    [self updateToolbarWithOrientation:toInterfaceOrientation];
    
    // Adjust navigation bar if needed.
    /***
    if (isChromeHidden_ && statusbarHidden_ == NO) {
        UINavigationBar *navbar = [[self navigationController] navigationBar];
        CGRect frame = [navbar frame];
        frame.origin.y = 20;
        [navbar setFrame:frame];
    }
     ***/
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //[self startChromeDisplayTimer];
}

- (UIView *)rotatingFooterView 
{
    return _toolBar;
}
#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (actionSheet == _actionsSheet) {
        // Actions
        if (buttonIndex == 0) {
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
                [self finishTransh];
            }else{
                if (_dataSource) {
                    id currentPhotoView = [photoViews_ objectAtIndex:_currentIndex];
                    if ([currentPhotoView isKindOfClass:[MKPhotoView class]]) {
                        CGRect frame=CGRectMake(self.view.bounds.size.width-22-5, self.view.bounds.size.height-22-5, 22, 22);
                        [currentPhotoView trashPhotoTargetFrame:frame];
                    }
                    // TODO: Animate the deletion of the current photo.
                }
            }
        }
    }
    if (actionSheet==_actionsButtonSheet){
        if (buttonIndex != actionSheet.cancelButtonIndex) {
            if (buttonIndex == actionSheet.firstOtherButtonIndex) {
                [self savePhoto]; return;
            } else if (buttonIndex == actionSheet.firstOtherButtonIndex + 1) {
                [self copyPhoto]; return;
            } else if (buttonIndex == actionSheet.firstOtherButtonIndex + 2) {
                [self emailPhoto]; return;
            }
        }
    }
}
#pragma mark Actions
-(UIImage*)getCurrentOrignImage{
    if (photoViews_&&_currentIndex>=0&&_currentIndex<_pagecount-1) {
        id currentView=[photoViews_ objectAtIndex:_currentIndex];
        if ([currentView isKindOfClass:[MKPhotoView class]]) {
            return [currentView orginImage];
        }
    }
    return nil;
}
- (void)savePhoto{
        UIImage *image=[self getCurrentOrignImage];
        if (image) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"存储照片成功"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
}
- (void)copyPhoto{
    UIImage *image=[self getCurrentOrignImage];
    if (image) {
        [[UIPasteboard generalPasteboard] setData:UIImagePNGRepresentation(image)
                                forPasteboardType:@"public.png"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"图片已copy完成"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}
- (void)emailPhoto{
   
        UIImage *image=[self getCurrentOrignImage];
        if (image) {
            MFMailComposeViewController *emailer = [[MFMailComposeViewController alloc] init];
            emailer.mailComposeDelegate = self;
            [emailer setSubject:NSLocalizedString(@"Photo", nil)];
            [emailer addAttachmentData:UIImagePNGRepresentation(image) mimeType:@"png" fileName:@"Photo.png"];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                emailer.modalPresentationStyle = UIModalPresentationPageSheet;
            }
            [self presentViewController:emailer animated:YES completion:nil];
            [emailer release];
        }
    
}
#pragma mark Mail Compose Delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    if (result == MFMailComposeResultFailed) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Email", nil)
                                                         message:NSLocalizedString(@"Email failed to send. Please try again.", nil)
                                                        delegate:nil cancelButtonTitle:NSLocalizedString(@"Dismiss", nil) otherButtonTitles:nil] autorelease];
		[alert show];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
