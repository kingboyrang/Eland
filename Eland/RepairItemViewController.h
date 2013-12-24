//
//  RepairItemViewController.h
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepairItemViewController : BasicViewController<UICollectionViewDataSource,UICollectionViewDelegate>{
@private
    UICollectionView *_collectionView;
}
-(void)relayout:(BOOL)isLand;
@property(nonatomic,strong) NSMutableArray *sourceData;
-(void)loadRepairItem;
@end
