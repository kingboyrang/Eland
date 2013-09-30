//
//  RepairItemViewController.m
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "RepairItemViewController.h"
#import "UIColor+TPCategory.h"
@interface RepairItemViewController ()

@end

@implementation RepairItemViewController
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
    _collectionView.scrollEnabled=NO;
    _collectionView.showsVerticalScrollIndicator=NO;
    //_collectionView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView setUserInteractionEnabled:YES];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:_collectionView];
    [flowlayout release];
    
    _sourceData=[[NSMutableArray alloc] init];
    for (int i=1; i<8; i++) {
        [_sourceData addObject:[NSString stringWithFormat:@"fk_0%d.jpg",i]];
    }
    [_sourceData addObject:@"fk_08.jpg"];
    [_sourceData addObject:@"fk_08.jpg"];
    
    CGFloat surplus=self.view.bounds.size.height-3*h-44*2;
    int row=surplus/h>1?(surplus/h+1):surplus/h;
    for (int i=1; i<=row*3; i++) {
        [_sourceData addObject:@"fk_08.jpg"];
    }
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_sourceData count];

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"Cell";
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_sourceData objectAtIndex:indexPath.row]]];
    return cell;
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
        _collectionView.frame=CGRectMake(0, 0, DeviceHeight,self.view.bounds.size.width-44-20-32);
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
       _collectionView.frame=CGRectMake(0, 0, DeviceHeight,self.view.bounds.size.width-44-20-32);
    }
    else{
        [_sourceData removeLastObject];
        _collectionView.frame=CGRectMake(0, 0, DeviceWidth,self.view.bounds.size.height);
    }
    [_collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES]; 
   
    [_collectionView reloadData];
}
@end
