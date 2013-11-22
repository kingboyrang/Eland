 //
//  SwitchLightNumber.h
//  ElandSearch
//
//  Created by rang on 13-8-26.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchLightNumber : UIView{
@private
    
    UILabel *_lightLabel;
    UILabel *_addressLabel;
    
}
@property(nonatomic,assign) NSInteger currentIndex;
@end
