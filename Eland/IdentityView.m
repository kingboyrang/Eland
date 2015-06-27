//
//  IdentityView.m
//  Eland
//
//  Created by rang on 15/6/27.
//  Copyright (c) 2015年 rang. All rights reserved.
//

#import "IdentityView.h"
#import "NSString+TPCategory.h"
#import "UserSet.h"

@interface IdentityView ()
@property (nonatomic,strong) UIButton *generalBtn;//一般民众
@property (nonatomic,strong) UIButton *govBtn;//政府
@end

@implementation IdentityView

- (id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        
        
        self.backgroundColor=[UIColor clearColor];
        
        UIImage *chk=[UIImage imageNamed:@"checkbox.png"];
        _generalBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _generalBtn.frame=CGRectMake(0, (self.bounds.size.height-chk.size.height)/2, chk.size.width, chk.size.height);
        [_generalBtn setImage:chk forState:UIControlStateNormal];
        [_generalBtn setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateSelected];
        [_generalBtn addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_generalBtn];
        
        //一般民众
        NSString *str=@"一般民眾";
        CGSize size=[str textSize:[UIFont boldSystemFontOfSize:16.0] withWidth:self.bounds.size.width];
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(chk.size.width+2, (self.bounds.size.height-size.height)/2,size.width,size.height)];
        lab.font=[UIFont boldSystemFontOfSize:16.0];
        lab.backgroundColor=[UIColor clearColor];
        lab.text=str;
        [self addSubview:lab];
        [lab release];
        
        
        _govBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _govBtn.frame=CGRectMake(lab.frame.size.width+lab.frame.origin.x+10, (self.bounds.size.height-chk.size.height)/2, chk.size.width, chk.size.height);
        [_govBtn setImage:chk forState:UIControlStateNormal];
        [_govBtn setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateSelected];
        [_govBtn addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_govBtn];
        
        
        str=@"宜蘭縣府員工";
        size=[str textSize:[UIFont boldSystemFontOfSize:16.0] withWidth:self.bounds.size.width];
        UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(_govBtn.frame.size.width+_govBtn.frame.origin.x+2, (self.bounds.size.height-size.height)/2,size.width,size.height)];
        lab1.font=[UIFont boldSystemFontOfSize:16.0];
        lab1.backgroundColor=[UIColor clearColor];
        lab1.text=str;
        [self addSubview:lab1];
        [lab1 release];
        
    }
    return self;
}
- (void)setIdentityValue{
    BOOL boo=[UserSet isGovEmployee];
    if (boo) {
        _govBtn.selected=YES;
        _generalBtn.selected=NO;
        return;
    }
    _generalBtn.selected=YES;
    _govBtn.selected=NO;
   
    
}
- (void)checkClick:(UIButton*)sender{
    if (self.generalBtn==sender) {
        if (self.generalBtn.selected) {
            self.govBtn.selected=YES;
            self.generalBtn.selected=NO;
        }else{
            self.govBtn.selected=NO;
            self.generalBtn.selected=YES;
        }
    }
    
    if (self.govBtn==sender) {
        if (self.govBtn.selected) {
            self.govBtn.selected=NO;
            self.generalBtn.selected=YES;
        }else{
            self.govBtn.selected=YES;
            self.generalBtn.selected=NO;
        }
    }
    
    [UserSet enableGovEmployee:self.govBtn.selected];
}

@end
