//
//  BasicCaseViewController.m
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "BasicCaseViewController.h"
#import "CaseCategoryViewController.h"
#import "TKCaseLabelCell.h"
#import "TKCaseTextFieldCell.h"
#import "VillageTownViewController.h"
#import "TKCaseTextCell.h"
#import "TKCaseTextViewCell.h"
#import "TKCaseLabelTextFieldCell.h"
#import "TKEmptyCell.h"
@interface BasicCaseViewController ()

@end

@implementation BasicCaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem titleViewBackground];
	
}
-(NSMutableArray*)CaseCategoryAndCityCells:(CaseSetting*)entity{
    NSMutableArray *result=[NSMutableArray array];
    
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:@"案件分類:" required:YES];
    TKCaseTextFieldCell *cell2=[[[TKCaseTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    UIImage *img=[UIImage imageNamed:@"Open.png"];
    UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
    cell2.field.enabled=NO;
    cell2.field.rightView=imageView;
    cell2.field.rightViewMode=UITextFieldViewModeAlways;
    cell2.field.placeholder=@"choose category";
    
    [result addObject:cell1];
    [result addObject:cell2];
    
    if (entity.showCityDown) {
        BOOL boo=[entity isRequiredShowCity];
        TKCaseLabelCell *cell3=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        [cell3 setLabelName:@"鄉鎮市別:" required:boo];
        
        TKCaseTextFieldCell *cell4=[[[TKCaseTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
        UIImage *img=[UIImage imageNamed:@"Open.png"];
        UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
        cell4.field.enabled=NO;
        cell4.field.rightView=imageView;
        cell4.field.rightViewMode=UITextFieldViewModeAlways;
        cell4.field.placeholder=@"choose city";
        cell4.LabelName=@"CityGuid";
        cell4.required=boo;
        
        [result addObject:cell3];
        [result addObject:cell4];
    }
    return result;
}
-(NSMutableArray*)CaseCategoryImagesCells:(CaseSetting*)entity{
    NSMutableArray *result=[NSMutableArray array];
    
    TKCaseLabelTextFieldCell *cell1=[[[TKCaseLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:@"案件圖片:" required:NO];
    UIImage *img=[UIImage imageNamed:@"Open.png"];
    UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
    cell1.field.enabled=NO;
    cell1.field.rightView=imageView;
    cell1.field.rightViewMode=UITextFieldViewModeAlways;
    cell1.field.placeholder=[NSString stringWithFormat:@"最多上傳%@張圖片",entity.UpImgNum];
    
    
    TKEmptyCell *cell2=[[[TKEmptyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    
    [result addObject:cell1];
    [result addObject:cell2];
    return result;
}
-(NSMutableArray*)CaseCategoryNoteCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:entity.Label required:NO];
    
    TKCaseTextCell *cell2=[[[TKCaseTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.label.text=entity.Text;
    
    [result addObject:cell1];
    [result addObject:cell2];
    return result;
}
-(NSMutableArray*)CaseCategoryTextCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:entity.Label required:entity.isRequired];
    
    TKCaseTextFieldCell *cell2=[[[TKCaseTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.required=entity.isRequired;
    cell2.field.placeholder=[NSString stringWithFormat:@"請輸入%@",entity.Label];
    cell2.LabelName=entity.Name;
    cell2.required=entity.isRequired;
    
    [result addObject:cell1];
    [result addObject:cell2];
    return result;
}
-(NSMutableArray*)CaseCategoryTextAreaCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:entity.Label required:entity.isRequired];
    
    TKCaseTextViewCell *cell2=[[[TKCaseTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.required=entity.isRequired;
    cell2.textView.placeholder=[NSString stringWithFormat:@"請輸入%@",entity.Label];
    cell2.LabelName=entity.Name;
    
    [result addObject:cell1];
    [result addObject:cell2];
    return result;
}
-(void)buttonCaseCityClick:(id)sender{
    if (!popoverCaseCity) {
        VillageTownViewController *controller=[[[VillageTownViewController alloc] init] autorelease];
        controller.title=@"鄉鎮市別";
        controller.delegate=self;
        popoverCaseCity = [[FPPopoverController alloc] initWithViewController:controller];
        popoverCaseCity.tint=FPPopoverLightGrayTint;
        popoverCaseCity.contentSize = CGSizeMake(300, 300);
        popoverCaseCity.arrowDirection = FPPopoverArrowDirectionAny;
    }
    [popoverCaseCity presentPopoverFromView:sender];
}
-(void)hidePopoverCaseCity{
    if (popoverCaseCity) {
        [popoverCaseCity dismissPopoverAnimated:YES];
    }
}
-(void)buttonCaseCategoryClick:(id)sender CaseCategoryGUID:(NSString*)guid{
    if (!popoverCaseCategory) {
        CaseCategoryViewController *controller=[[[CaseCategoryViewController alloc] init] autorelease];
        controller.title=@"案件分類";
        controller.delegate=self;
        controller.ParentGUID=guid;
        popoverCaseCategory = [[FPPopoverController alloc] initWithViewController:controller];
        popoverCaseCategory.tint=FPPopoverLightGrayTint;
        popoverCaseCategory.contentSize = CGSizeMake(300, 300);
        popoverCaseCategory.arrowDirection = FPPopoverArrowDirectionAny;
    }
    [popoverCaseCategory presentPopoverFromView:sender];
}
-(void)hidePopoverCaseCategory{
    if (popoverCaseCategory) {
        [popoverCaseCategory dismissPopoverAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
