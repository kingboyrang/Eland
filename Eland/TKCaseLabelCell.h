//
//  TKCaseLabelCell.h
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@interface TKCaseLabelCell : UITableViewCell
@property (nonatomic,strong) RTLabel *label;
@property (nonatomic,copy) NSString *labelText;
- (void)setLabelName:(NSString*)title required:(BOOL)required;
-(void)setShowName:(NSString*)title required:(BOOL)required;
@end
