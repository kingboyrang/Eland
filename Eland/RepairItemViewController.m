//
//  RepairItemViewController.m
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "RepairItemViewController.h"
#import "UIColor+TPCategory.h"
#import "CaseSetting.h"
#import "CacheHelper.h"
#import "asyncHelper.h"
#import "UIImageView+WebCache.h"
#import "CaseAddViewController.h"
#import "UserSet.h"
#import "AppDelegate.h"
#import "AlertHelper.h"
#import "MainViewController.h"
#import "NetWorkConnection.h"
#import "ASIHTTPRequest.h"
#import "NSString+TPCategory.h"
#import "MainViewController.h"
@interface RepairItemViewController ()

-(void)updateSourceUI:(NSArray*)arr;
-(void)checAccessWithURL:(NSString*)url complete:(void(^)(BOOL success))completed;
-(UIView*)getHelperView;
@end

@implementation RepairItemViewController
@synthesize sourceData=_sourceData;
-(void)dealloc{
    [super dealloc];
    [_collectionView release],_collectionView=nil;
    [_sourceData release],_sourceData=nil;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect=self.view.bounds;
    rect.size.height-=44*2+(self.isPad?58:40);
    
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    CGFloat h=204*(DeviceWidth/3.0)/240;
    flowlayout.itemSize=CGSizeMake(DeviceWidth/3.0, h);
    flowlayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowlayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    flowlayout.minimumLineSpacing=0.0;
    flowlayout.minimumInteritemSpacing=0.0;
    _collectionView=[[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowlayout];
    _collectionView.backgroundColor=[UIColor colorFromHexRGB:@"cfd2d9"];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.bounces=NO;
    if (self.isPad) {
        //_collectionView.scrollEnabled=NO;
    }
    
    _collectionView.showsVerticalScrollIndicator=NO;
    //_collectionView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView setUserInteractionEnabled:YES];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:_collectionView];
    [flowlayout release];
    
  // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //加载项目
    [self loadRepairItem];
}
-(void)checAccessWithURL:(NSString*)url complete:(void(^)(BOOL success))completed{
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setCompletionBlock:^{
        BOOL boo=NO;
        if (request.responseStatusCode==200) {
            boo=YES;
        }
        if (completed) {
            completed(boo);
        }
    }];
    [request setFailedBlock:^{
        if (completed) {
            completed(NO);
        }
    }];
    [request startAsynchronous];
}
-(void)updateSourceUI:(NSArray*)arr{
    
    NSMutableArray *_source=[NSMutableArray arrayWithArray:arr];
    if (_source.count%3!=0) {
        int len=(_source.count/3+1)*3-_source.count;
        for (int i=1; i<=len; i++) {
            CaseSetting *entity=[[CaseSetting alloc] init];
            [_source addObject:entity];
            [entity release];
        }
    }
    UICollectionViewFlowLayout *flowlayout=(UICollectionViewFlowLayout*)_collectionView.collectionViewLayout;
    CGFloat h=flowlayout.itemSize.height;
    
    int total=_source.count/3;
    CGFloat surplus=_collectionView.frame.size.height-total*h;
    if (surplus>0) {
        int row=surplus/h>1?(surplus/h+1):surplus/h;
        if (surplus<h) {
            row=1;
        }
        for (int i=1; i<=row*3; i++) {
            CaseSetting *entity=[[CaseSetting alloc] init];
            [_source addObject:entity];
            [entity release];
        }
    }
    self.sourceData=_source;
    total=_source.count/3;

    _collectionView.contentSize=CGSizeMake(self.view.bounds.size.width, total*h);
    [_collectionView reloadData];
    
   
}
-(void)loadRepairItem{
    NSArray *arr=[CacheHelper readCacheCaseSettings];
    if (arr&&[arr count]>0) {
        [self performSelectorOnMainThread:@selector(updateSourceUI:) withObject:arr waitUntilDone:NO];
    }else{
        [asyncHelper asyncLoadCaseSettings:^(NSArray *result) {
            if (result&&[result count]>0) {
                [self performSelectorOnMainThread:@selector(updateSourceUI:) withObject:arr waitUntilDone:NO];
            }else{
               
                CaseSetting *entity=[[[CaseSetting alloc] init] autorelease];
                [self performSelectorOnMainThread:@selector(updateSourceUI:) withObject:[NSArray arrayWithObjects:entity, nil] waitUntilDone:NO];
            }
        }];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView*)getHelperView{
        UIView *bgView=[[UIView alloc] initWithFrame:DeviceRect];
        bgView.backgroundColor=[UIColor grayColor];
        bgView.alpha=0.3;
        
        NSString *memo=@"網路檢測中...";
        CGSize size=[memo textSize:[UIFont boldSystemFontOfSize:16] withWidth:bgView.frame.size.width];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake((bgView.frame.size.width-size.width)/2, (bgView.frame.size.height-3*44-size.height)/2, size.width, size.height)];
        label.backgroundColor=[UIColor clearColor];
        label.text=memo;
        label.font=[UIFont boldSystemFontOfSize:16];
        [bgView addSubview:label];
        
        UIActivityIndicatorView  *_activityIndicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.frame=CGRectMake(label.frame.origin.x-2-30,(bgView.frame.size.height-3*44-30)/2, 30, 30);
        [bgView addSubview:_activityIndicatorView];
        [_activityIndicatorView startAnimating];
        [_activityIndicatorView release];
        [label release];
    
    return [bgView autorelease];
}
#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.sourceData count];

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"Cell";
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    CaseSetting *entity=[_sourceData objectAtIndex:indexPath.row];
    if ([[entity IconURLString] length]>0) {
        UIImageView *imageView=[[[UIImageView alloc] init] autorelease];
        [imageView setImageWithURL:[NSURL URLWithString:entity.IconURLString] placeholderImage:[UIImage imageNamed:@"fk_08.jpg"]];
        cell.backgroundView = imageView;
    }
    else{
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fk_08.jpg"]];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CaseSetting *setting=self.sourceData[indexPath.row];
    if (setting.GUID&&[setting.GUID length]>0) {
        if (![UserSet emptyUser]) {
            [AlertHelper initWithTitle:@"提示" message:@"使用者應載明具體事項、真實姓名及聯絡方式(包括電話、住址或電子郵件位址等)，無具體內容、未具「真實姓名」或「聯絡方式」者，受理機關得依分層負責權限規定，得不予處理。" cancelTitle:@"取消" cancelAction:nil confirmTitle:@"確定" confirmAction:^{
                if (self.tabBarController) {
                    MainViewController *main=(MainViewController*)self.tabBarController;
                    [main setSelectedItemIndex:1];
                }else if (self.parentTabBarController){
                    MainViewController *main=(MainViewController*)self.parentTabBarController;
                    [main setSelectedItemIndex:1];
                }
                
            }];
            return;
        }
        NSString *url=[NSString stringWithFormat:SingleCaseSettingURL,setting.GUID];
        __block UIView *bgView=nil;
        if (bgView==nil) {
            bgView=[self getHelperView];
            [self.view addSubview:bgView];
        }
        [self checAccessWithURL:url complete:^(BOOL success) {
            [bgView removeFromSuperview];
            //[bgView release],
            bgView=nil;
             NSLog(@"bgView removeFromSuperview");
            if (!success) {
                [AlertHelper initWithTitle:@"提示" message:@"網路連接發生異常,請檢查網路連接."];
                //[self showNoNetworkNotice:nil];
                return;
            }
            if (self.navigationController) {
                CaseAddViewController *controller=[[CaseAddViewController alloc] init];
                controller.Entity=setting;
                [self.navigationController pushViewController:controller animated:YES];
                [controller release];
            }else{
                if (self.parentNavigation) {
                    CaseAddViewController *controller=[[CaseAddViewController alloc] init];
                    controller.Entity=setting;
                    [self.parentNavigation pushViewController:controller animated:YES];
                    [controller release];
                }
            }
           
        }];
       
    }
}
/***
//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.isLandscape?CGSizeMake(120,102):CGSizeMake(106,90);
}
 ***/
-(void)relayout:(BOOL)isLand{
    if (!self.isPad) {
        UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        flowlayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        flowlayout.minimumLineSpacing=0.0;
        flowlayout.minimumInteritemSpacing=0.0;
        if (isLand) {
            flowlayout.itemSize=CGSizeMake(DeviceHeight/4.0, 204*(DeviceHeight/4.0)/240);
        }else{
            flowlayout.itemSize=CGSizeMake(DeviceWidth/3.0, 204*(DeviceWidth/3.0)/240);
        }
        _collectionView.collectionViewLayout=flowlayout;
    }
    if (isLand) {
        [_sourceData addObject:@"fk_08.jpg"];
        _collectionView.frame=CGRectMake(0, 0, DeviceHeight,DeviceWidth-44-20-32);
    }
    else{
        [_sourceData removeLastObject];
        _collectionView.frame=CGRectMake(0, 0, DeviceWidth,DeviceHeight-44*2-20);
    }
    [_collectionView reloadData];
    [_collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES]; 
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
   

    if (!self.isPad) {
        UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
        flowlayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        flowlayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        flowlayout.minimumLineSpacing=0.0;
        flowlayout.minimumInteritemSpacing=0.0;
        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
            flowlayout.itemSize=CGSizeMake(DeviceHeight/4.0, 204*(DeviceHeight/4.0)/240);
        }else{
            flowlayout.itemSize=CGSizeMake(DeviceWidth/3.0, 204*(DeviceWidth/3.0)/240);
        }
        _collectionView.collectionViewLayout=flowlayout;
    }
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        [_sourceData addObject:@"fk_08.jpg"];
       _collectionView.frame=CGRectMake(0, 0, DeviceHeight,DeviceWidth-44-20-32);
    }
    else{
        [_sourceData removeLastObject];
        _collectionView.frame=CGRectMake(0, 0, DeviceWidth,DeviceHeight-44);
    }
    [_collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES]; 
   
    [_collectionView reloadData];
}
@end
