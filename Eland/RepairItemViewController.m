//
//  RepairItemViewController.m
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "RepairItemViewController.h"
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
    if (DeviceIsPad) {
        flowlayout.itemSize=CGSizeMake(256, 217.6);
    }else{
       flowlayout.itemSize=CGSizeMake(106, 90);
    }
    flowlayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowlayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    flowlayout.minimumLineSpacing=0.0;
    flowlayout.minimumInteritemSpacing=0.0;
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.bounces=NO;
    _collectionView.showsVerticalScrollIndicator=NO;
    _collectionView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView setUserInteractionEnabled:YES];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:_collectionView];
    [flowlayout release];
    
    _sourceData=[[NSMutableArray alloc] init];
    for (int i=1; i<9; i++) {
        [_sourceData addObject:[NSString stringWithFormat:@"fk_0%d.jpg",i]];
        
    }
    int len=DeviceIsPad?8:5;
    for (int i=1; i<len; i++) {
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
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    if (self.isPad) {
        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
          [_sourceData addObject:@"fk_08.jpg"];
        }
        else{
            [_sourceData removeLastObject];
        }
        [_collectionView reloadData];
    }else{
    UICollectionViewFlowLayout *flowlayout=[[UICollectionViewFlowLayout alloc] init];
    flowlayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    flowlayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    flowlayout.minimumLineSpacing=0.0;
    flowlayout.minimumInteritemSpacing=0.0;
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
       flowlayout.itemSize=CGSizeMake(120, 102);
    }else{
       flowlayout.itemSize=CGSizeMake(106, 90);
    }
    _collectionView.collectionViewLayout=flowlayout;
    [_collectionView reloadData];
    }
}
@end
