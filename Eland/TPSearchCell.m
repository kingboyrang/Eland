//
//  TPSearchCell.m
//  ElandSearch
//
//  Created by rang on 13-9-1.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TPSearchCell.h"
#import "CircularDetail.h"
#import "SearchDetail.h"
#import "UIColor+TPCategory.h"
@implementation TPSearchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /***
        CircularDetail *detail=[[CircularDetail alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 119)];
        detail.autoresizesSubviews=YES;
        detail.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        detail.tag=100;
        [self.contentView addSubview:detail];
        [detail release];
         ***/
        
        SearchDetail *detail=[[SearchDetail alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 62)];
        detail.autoresizesSubviews=YES;
        detail.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        detail.tag=100;
        [self.contentView addSubview:detail];
        [detail release];
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
       
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorFromHexRGB:@"f4f4f4"];
        self.backgroundView = bgView;
        [bgView release];

    }
    return self;
}
-(void)setDataSource:(LevelCase*)entity{
    CircularDetail *view=(CircularDetail*)[self viewWithTag:100];
    [view setDataSource:entity];
}
-(void)selectedCellAnimal:(void (^)(void))completed{
    CircularDetail *detail=(CircularDetail*)[self viewWithTag:100];
    [UIView animateWithDuration:0.5f animations:^{
        [detail selectedBgColorAnimal:YES];
    } completion:^(BOOL finished) {
        if (finished) {
            [detail selectedBgColorAnimal:NO];
            if (completed) {
                completed();
            }
        }
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
