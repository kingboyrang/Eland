//
//  RepairItemViewController.h
//  Eland
//
//  Created by rang on 13-9-29.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepairItemViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>{
@private
    UICollectionView *_collectionView;
    NSMutableArray *_sourceData;
}

@end
