//
//  TKCaseDownListCell.m
//  Eland
//
//  Created by aJia on 2014/1/21.
//  Copyright (c) 2014年 rang. All rights reserved.
//

#import "TKCaseDownListCell.h"
#import "CacheHelper.h"
#import "CaseCategoryHelper.h"
#import "asyncHelper.h"
#import "CaseCategory.h"

@interface TKCaseDownListCell (){
    BOOL isLoad;
}
- (NSArray*)objectsToDictionarys:(NSArray*)source;
- (CaseCategory*)dictionaryToCaseCategory:(NSDictionary*)dic;
- (void)showSelect:(BOOL)show;
- (void)bindSecondDataSource;
@end

@implementation TKCaseDownListCell
- (void)dealloc{
    [super dealloc];
    [_field1.popoverText.popoverTextField removeObserver:self forKeyPath:@"text"];
}
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    
    _field1 = [[CVUISelect alloc] initWithFrame:CGRectZero];
	_field1.popoverText.popoverTextField.borderStyle=UITextBorderStyleRoundedRect;
    _field1.popoverText.popoverTextField.font = [UIFont boldSystemFontOfSize:16.0];
    UIImage *img=[UIImage imageNamed:@"Open.png"];
    UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
    _field1.popoverText.popoverTextField.rightView=imageView;
    _field1.popoverText.popoverTextField.rightViewMode=UITextFieldViewModeAlways;
    _field1.popoverText.popoverTextField.placeholder=@"請選擇案件分類1";
    _field1.delegate=self;
	[self.contentView addSubview:_field1];
    [_field1.popoverText.popoverTextField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    _field2 = [[CVUISelect alloc] initWithFrame:CGRectZero];
	_field2.popoverText.popoverTextField.borderStyle=UITextBorderStyleRoundedRect;
    _field2.popoverText.popoverTextField.font = [UIFont boldSystemFontOfSize:16.0];
    UIImage *img1=[UIImage imageNamed:@"Open.png"];
    UIImageView *imageView1=[[[UIImageView alloc] initWithImage:img1] autorelease];
    _field2.popoverText.popoverTextField.rightView=imageView1;
    _field2.popoverText.popoverTextField.rightViewMode=UITextFieldViewModeAlways;
    _field2.popoverText.popoverTextField.placeholder=@"請選擇案件分類2";
	[self.contentView addSubview:_field2];
    _field2.hidden=YES;
    _hasClilds=YES;
    isLoad=NO;
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}
- (BOOL)hasValue{
    if ([_field1.value length]==0&&[_field2.value length]==0) {
        return NO;
    }
    return YES;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        if (![[change objectForKey:@"new"] isEqualToString:[change objectForKey:@"old"]]) {
            if (isLoad) {//户政预约
                if (self.delegate&&[self.delegate respondsToSelector:@selector(selectedCaseCategory:)]) {
                    [self.delegate performSelector:@selector(selectedCaseCategory:) withObject:[self dictionaryToCaseCategory:_field1.itemData]];
                }
            }
            [self bindSecondDataSource];//绑定第二层级数据源
        }
    }
}
//显示或隐藏层级
- (void)showSelect:(BOOL)show{
    _field2.hidden=show;
    _hasClilds=show;
    id v=[self superview];
    while (![v isKindOfClass:[UITableView class]]) {
        v=[v superview];
    }
    UITableView *tableView=(UITableView*)v;
    NSIndexPath *indexPath=[tableView indexPathForCell:self];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}
//绑定第二层级数据源
- (void)bindSecondDataSource{
    BOOL boo=YES;
    if ([_field1.value length]>0) {
        NSArray *source=[CaseCategoryHelper findByChilds:_field1.value];
        NSArray *results=[self objectsToDictionarys:source];
        boo=results.count>0?NO:YES;
        
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        [dic setValue:@"請選擇" forKey:@"Name"];
        [dic setValue:@"" forKey:@"GUID"];
        [dic setValue:@"" forKey:@"Parent"];
        
        NSMutableArray *source1=[NSMutableArray array];
        [source1 addObject:dic];
        if (results.count>0) {
            [source1 addObjectsFromArray:results];
        }
        [_field2 setDataSourceForArray:source1 dataTextName:@"Name" dataValueName:@"GUID"];
    }else{
        NSMutableDictionary *dic=[NSMutableDictionary dictionary];
        [dic setValue:@"請選擇" forKey:@"Name"];
        [dic setValue:@"" forKey:@"GUID"];
        [dic setValue:@"" forKey:@"Parent"];
        NSMutableArray *results=[NSMutableArray array];
        [results addObject:dic];
        [_field2 setDataSourceForArray:results dataTextName:@"Name" dataValueName:@"GUID"];
    }
    [_field2 unBindSource];
    [self showSelect:boo];//显示或隐藏
}
#pragma mark CVUISelectDelegate Methods
-(void)closeSelect:(id)sender{
   if (![self.ParentGUID isEqualToString:@"HR"]){
       _field1.itemData=nil;
       _field1.popoverText.popoverTextField.text=@"";
   }else{
       
   }
}
- (void)fillNodesArray{
    if ([self.ParentGUID isEqualToString:@"HR"]){
        _field1.popoverView.clearButtonTitle=@"關閉";
    }
    CaseCategoryHelper *_helper=[[[CaseCategoryHelper alloc] init] autorelease];
    NSArray *arr=[CacheHelper readCacheCaseCategorys];
    if (arr&&[arr count]>0) {
         
        _helper.categorys=[NSMutableArray arrayWithArray:arr];
        if (self.ParentGUID&&[self.ParentGUID length]>0) {
            NSArray *source;
            if ([self.ParentGUID isEqualToString:@"HR"]){
               source=[_helper childsTreeNodes:self.ParentGUID];//取得子项
            }else{
               source=[_helper childsTreeNodesWithEmpty:self.ParentGUID];//取得子项
            }
            NSArray *results=[self objectsToDictionarys:source];
            //如果有子项，则必填
            if ([results count]>0) {
                self.required=YES;
            }
            //绑定数据源
            [_field1 setDataSourceForArray:results dataTextName:@"Name" dataValueName:@"GUID"];
            [_field1 unBindSource];
            
            if ([self.ParentGUID isEqualToString:@"HR"]){//设置选中项
                isLoad=YES;
                [_field1 setIndex:0];
            }
        }
        //判断第一层案件分类是否加载完成
        if (self.delegate&&[self.delegate respondsToSelector:@selector(finishLoadCategory)]) {
            [self.delegate performSelector:@selector(finishLoadCategory)];
        }
    }else{
        [asyncHelper asyncLoadCaseCategory:^(NSArray *result) {
            [self performSelectorOnMainThread:@selector(updateSourceData:) withObject:result waitUntilDone:NO];
        }];
    }
}
-(void)updateSourceData:(NSArray*)source{
    CaseCategoryHelper *_helper=[[[CaseCategoryHelper alloc] init] autorelease];
    _helper.categorys=[NSMutableArray arrayWithArray:source];
    if (self.ParentGUID&&[self.ParentGUID length]>0) {
        NSArray *source=[_helper childsTreeNodesWithEmpty:self.ParentGUID];//取得子项
        NSArray *results=[self objectsToDictionarys:source];
        //绑定数据源
        [_field1 setDataSourceForArray:results dataTextName:@"Name" dataValueName:@"GUID"];
        [_field1 unBindSource];
    }
    //判断第一层案件分类是否加载完成
    if (self.delegate&&[self.delegate respondsToSelector:@selector(finishLoadCategory)]) {
        [self.delegate performSelector:@selector(finishLoadCategory)];
    }
}
- (NSArray*)objectsToDictionarys:(NSArray*)source{
    NSMutableArray *results=[NSMutableArray array];
    if (source&&[source count]>0) {
        for (CaseCategory *item in source) {
            NSMutableDictionary *dic=[NSMutableDictionary dictionary];
            [dic setValue:item.Name forKey:@"Name"];
            [dic setValue:item.GUID forKey:@"GUID"];
            [dic setValue:item.Parent forKey:@"Parent"];
            [results addObject:dic];
        }
    }
    return results;
}
- (CaseCategory*)dictionaryToCaseCategory:(NSDictionary*)dic{
    CaseCategory *entity=[[CaseCategory alloc] init];
    if (dic&&[dic count]>0) {
        entity.Name=[dic objectForKey:@"Name"];
        entity.GUID=[dic objectForKey:@"GUID"];
        entity.Parent=[dic objectForKey:@"Parent"];
    }else{
        entity.Name=@"";
        entity.GUID=@"";
        entity.Parent=@"";
    }
    return [entity autorelease];
}
- (void) layoutSubviews {
    [super layoutSubviews];
    CGRect r=CGRectInset(self.bounds, 10, 4);
    r.size.height=36;
	_field1.frame=r;
    if (!_field2.hidden) {
        CGRect r1=self.frame;
        r1.size.height=90;
        self.frame=r1;
    }else{
        CGRect r1=self.frame;
        r1.size.height=44;
        self.frame=r1;
    }
    r.origin.y=_field1.frame.origin.y+_field1.frame.size.height+10;
    _field2.frame=r;
}
@end
