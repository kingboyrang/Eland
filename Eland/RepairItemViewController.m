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
@interface RepairItemViewController ()
-(void)loadRepairItem;
-(void)updateSourceUI:(NSArray*)arr;
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
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    CGFloat h=204*(DeviceWidth/3.0)/240;
    flowlayout.itemSize=CGSizeMake(DeviceWidth/3.0, h);
    flowlayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowlayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    flowlayout.minimumLineSpacing=0.0;
    flowlayout.minimumInteritemSpacing=0.0;
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    _collectionView.backgroundColor=[UIColor colorFromHexRGB:@"cfd2d9"];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.bounces=NO;
    if (self.isPad) {
        _collectionView.scrollEnabled=NO;
    }
    
    _collectionView.showsVerticalScrollIndicator=NO;
    //_collectionView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView setUserInteractionEnabled:YES];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:_collectionView];
    [flowlayout release];
    //加载项目
    [self loadRepairItem];
  // Do any additional setup after loading the view.
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
    CGFloat surplus=DeviceHeight-total*h-44*3;
    int row=surplus/h>1?(surplus/h+1):surplus/h;
    if (surplus<h) {
        row=1;
    }
    for (int i=1; i<=row*3; i++) {
        CaseSetting *entity=[[CaseSetting alloc] init];
        [_source addObject:entity];
        [entity release];
    }
    self.sourceData=_source;
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
        UIImageView *imageView=[[UIImageView alloc] init];
        [imageView setImageWithURL:[NSURL URLWithString:entity.IconURLString] placeholderImage:[UIImage imageNamed:@"fk_08.jpg"]];
        cell.backgroundView = imageView;
        [imageView release];
    }
    else{
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fk_08.jpg"]];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"row=%d,choose click",indexPath.row);
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
   
    NSLog(@"执行这里〜〜〜");
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
