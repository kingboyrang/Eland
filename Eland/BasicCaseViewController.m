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
#import "AlertHelper.h"
#import "TkCaseImageCell.h"
#import "TkCaseLocationCell.h"
#import "TKCaseLightNumberCell.h"
#import "TKCaseCalendarCell.h"
#import "TKCaseRadioCell.h"
#import "TKCaseDropListCell.h"
@interface BasicCaseViewController ()
-(void)buttonOpenURL:(id)sender;
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
    [cell1 setLabelName:@"案件分類:" required:NO];
    TKCaseTextFieldCell *cell2=[[[TKCaseTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    UIImage *img=[UIImage imageNamed:@"Open.png"];
    UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
    cell2.required=NO;
    cell2.field.enabled=NO;
    cell2.field.rightView=imageView;
    cell2.field.rightViewMode=UITextFieldViewModeAlways;
    cell2.field.placeholder=@"請選擇案件分類";
    cell2.LabelName=@"CaseSettingGuid";
    
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
        cell4.field.placeholder=@"請選擇鄉鎮市別";
        cell4.LabelName=@"CityGuid";
        cell4.required=boo;
        
        [result addObject:cell3];
        [result addObject:cell4];
    }
    return result;
}
-(NSMutableArray*)CaseCategoryImagesCells:(CaseSetting*)entity{
    NSMutableArray *result=[NSMutableArray array];
    
    TkCaseImageCell *cell2=[[[TkCaseImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.UpImgNum=entity.UpImgNum;
    cell2.showInController=self;
    
    TKCaseLabelTextFieldCell *cell1=[[[TKCaseLabelTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:@"案件圖片:" required:NO];
    cell1.showInController=self;
    cell1.delegate=cell2;
   
    [result addObject:cell1];
    [result addObject:cell2];
    
    return result;
}
-(NSMutableArray*)CaseCategoryNoteCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:[NSString stringWithFormat:@"%@:",entity.Label] required:NO];
    
    TKCaseTextCell *cell2=[[[TKCaseTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.label.text=entity.Text;
    cell2.label.textColor=[entity NoteColor];
    
    [result addObject:cell1];
    [result addObject:cell2];
    return result;
}
-(NSMutableArray*)CaseCategoryTextCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:[NSString stringWithFormat:@"%@:",entity.Label] required:entity.isRequired];
    
    TKCaseTextFieldCell *cell2=[[[TKCaseTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.required=entity.isRequired;
    cell2.field.placeholder=[NSString stringWithFormat:@"請輸入%@",entity.Label];
    cell2.LabelName=entity.Name;
    if (entity.Text&&[entity.Text length]>0) {
        cell2.field.text=entity.Text;
    }
    if ([entity.Name isEqualToString:@"Link"]) {
        UIImage *img=[UIImage imageNamed:@"arrow_right.png"];
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, img.size.width, img.size.height);
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonOpenURL:) forControlEvents:UIControlEventTouchUpInside];
        //UIImage *img=[UIImage imageNamed:@"arrow_right.png"];
        //UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
        cell2.field.rightView=btn;
        cell2.field.rightViewMode=UITextFieldViewModeAlways;
    }
    
    [result addObject:cell1];
    [result addObject:cell2];
    return result;
}
-(NSMutableArray*)CaseCategoryTextAreaCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:[NSString stringWithFormat:@"%@:",entity.Label] required:entity.isRequired];
    
    TKCaseTextViewCell *cell2=[[[TKCaseTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.required=entity.isRequired;
    cell2.textView.placeholder=[NSString stringWithFormat:@"請輸入%@",entity.Label];
    cell2.LabelName=entity.Name;
    if (entity.Text&&[entity.Text length]>0) {
        cell2.textView.text=entity.Text;
    }
    
    [result addObject:cell1];
    [result addObject:cell2];
    return result;
}
-(NSMutableArray*)CaseCategoryPWDCells{
    NSMutableArray *result=[NSMutableArray array];
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:@"案件瀏覽密碼:" required:YES];
    
    TKCaseTextFieldCell *cell2=[[[TKCaseTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.required=YES;
    cell2.field.placeholder=@"請輸入案件瀏覽密碼";
    cell2.LabelName=@"PWD";
    cell2.field.secureTextEntry=YES;
    [result addObject:cell1];
    [result addObject:cell2];
    return result;

}
-(NSMutableArray*)CaseCategoryLocationCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    
    TKCaseTextViewCell *cell2=[[[TKCaseTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.required=entity.isRequired;
    cell2.textView.placeholder=[NSString stringWithFormat:@"請輸入%@",entity.Label];
    cell2.LabelName=entity.Name;
    if (entity.Text&&[entity.Text length]>0) {
        cell2.textView.text=entity.Text;
    }
    cell2.delegate=self;
    
    TkCaseLocationCell *cell1=[[[TkCaseLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:[NSString stringWithFormat:@"%@:",entity.Label] required:entity.isRequired];
    cell1.controller=cell2;
    
    [result addObject:cell1];
    [result addObject:cell2];
    return result;
}
-(NSMutableArray*)CaseCategoryNumberCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1.label setText:@"<font size=16 color='#dd1100'>路燈編號和地址請擇一填寫:</font>"];
    
    TKCaseLightNumberCell *cell2=[[[TKCaseLightNumberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.lightNumber.controller=self;
    
    TKCaseLabelCell *cell3=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell3 setLabelName:[NSString stringWithFormat:@"%@:",entity.Label] required:YES];
    
    TKCaseTextFieldCell *cell4=[[[TKCaseTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.required=YES;
    cell4.field.placeholder=[NSString stringWithFormat:@"請輸入%@",entity.Label];
    cell4.LabelName=entity.Name;
    if (entity.Text&&[entity.Text length]>0) {
        cell4.field.text=entity.Text;
    }
    
    

    [result addObject:cell1];
    [result addObject:cell2];
    [result addObject:cell3];
    [result addObject:cell4];
    
    
    return result;
    
}
-(NSMutableArray*)CaseCategoryLightNumberCells:(CaseSettingField*)entity{
     NSMutableArray *result=[NSMutableArray array];
    TKCaseLabelCell *cell3=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell3 setLabelName:[NSString stringWithFormat:@"%@:",entity.Label] required:YES];
    
    TKCaseTextFieldCell *cell4=[[[TKCaseTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell4.required=YES;
    cell4.field.placeholder=[NSString stringWithFormat:@"請輸入%@",entity.Label];
    cell4.LabelName=entity.Name;
    if (entity.Text&&[entity.Text length]>0) {
        cell4.field.text=entity.Text;
    }
    [result addObject:cell3];
    [result addObject:cell4];
    return result;
}
-(NSMutableArray*)CaseCategoryLostDateCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:[NSString stringWithFormat:@"%@:",entity.Label] required:entity.isRequired];
    
    TKCaseCalendarCell *cell2=[[[TKCaseCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.LabelText=entity.Label;
    cell2.required=entity.isRequired;
    cell2.lostCalendar.popoverText.popoverTextField.placeholder=[NSString stringWithFormat:@"請選擇%@",entity.Label];
    cell2.LabelName=entity.Name;
    if (entity.Text&&[entity.Text length]>0) {
        cell2.lostCalendar.popoverText.popoverTextField.text=entity.Text;
    }
    
    UIImage *img=[UIImage imageNamed:@"Open.png"];
    UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
    cell2.lostCalendar.popoverText.popoverTextField.enabled=NO;
    cell2.lostCalendar.popoverText.popoverTextField.rightView=imageView;
    cell2.lostCalendar.popoverText.popoverTextField.rightViewMode=UITextFieldViewModeAlways;
    
    
    [result addObject:cell1];
    [result addObject:cell2];
    return result;

}
-(NSMutableArray*)CaseCategoryRadioCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:[NSString stringWithFormat:@"%@:",entity.Label] required:entity.isRequired];
    
    TKCaseRadioCell *cell2=[[[TKCaseRadioCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.required=entity.isRequired;
    cell2.LabelName=entity.Name;
    if (entity.Text&&[entity.Text length]>0) {
        [cell2 setSelectedItemText:entity.Text];
    }
    if([entity.Name isEqualToString:@"PetSterilization"])
    {
        [cell2.radioView setIndexWithTitle:@"有" withIndex:0];
        [cell2.radioView setIndexWithTitle:@"無" withIndex:1];
    }
    if([entity.Name isEqualToString:@"PetGender"])
    {
        [cell2.radioView setIndexWithTitle:@"公" withIndex:0];
        [cell2.radioView setIndexWithTitle:@"母" withIndex:1];
    }
    if([entity.Name isEqualToString:@"PetChip"])
    {
        [cell2.radioView setIndexWithTitle:@"無" withIndex:0];
        [cell2.radioView setIndexWithTitle:@"有" withIndex:1];
    }
    
    
    [result addObject:cell1];
    [result addObject:cell2];
    return result;

}
-(NSMutableArray*)CaseCategoryHRCells:(CaseSetting*)entity hrType:(int)type{
    NSMutableArray *result=[NSMutableArray array];
    if (type==1) {
        CaseSettingField *field=[entity getEntityFieldWithName:@"Note1"];
        if(field!=nil){
           [result addObjectsFromArray:[self CaseCategoryNoteCells:field]];
        }
        field=[entity getEntityFieldWithName:@"NewbornRelation"];
        if (field!=nil) {
            [result addObjectsFromArray:[self CaseCategoryBornRelationCells:field]];
        }
    }else if (type==2)
    {
        CaseSettingField *field=[entity getEntityFieldWithName:@"Note2"];
        if(field!=nil){
            [result addObjectsFromArray:[self CaseCategoryNoteCells:field]];
        }
        field=[entity getEntityFieldWithName:@"ManName"];
        if(field!=nil){
            [result addObjectsFromArray:[self CaseCategoryTextCells:field]];
        }
        field=[entity getEntityFieldWithName:@"WoManName"];
        if(field!=nil){
            [result addObjectsFromArray:[self CaseCategoryTextCells:field]];
        }
        field=[entity getEntityFieldWithName:@"ManAddress"];
        if(field!=nil){
            [result addObjectsFromArray:[self CaseCategoryTextAreaCells:field]];
        }
        field=[entity getEntityFieldWithName:@"WoManAddress"];
        if(field!=nil){
            [result addObjectsFromArray:[self CaseCategoryTextAreaCells:field]];
        }
    }else{
        CaseSettingField *field=[entity getEntityFieldWithName:@"Note3"];
        if(field!=nil){
            [result addObjectsFromArray:[self CaseCategoryNoteCells:field]];
        }
        field=[entity getEntityFieldWithName:@"DeadRelation"];
        if(field!=nil){
            [result addObjectsFromArray:[self CaseCategoryDeadRelationCells:field]];
        }
        field=[entity getEntityFieldWithName:@"DeadName"];
        if(field!=nil){
            [result addObjectsFromArray:[self CaseCategoryTextCells:field]];
        }
         field=[entity getEntityFieldWithName:@"DeadAddress"];
        if(field!=nil){
            [result addObjectsFromArray:[self CaseCategoryTextAreaCells:field]];
        }
        
    }
    return result;
}
-(NSMutableArray*)CaseCategoryDropCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:[NSString stringWithFormat:@"%@:",entity.Label] required:entity.isRequired];
    
    TKCaseDropListCell *cell2=[[[TKCaseDropListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.required=entity.isRequired;
    cell2.select.popoverText.popoverTextField.placeholder=[NSString stringWithFormat:@"請選擇%@",entity.Label];
    cell2.LabelName=entity.Name;
    if (entity.Text&&[entity.Text length]>0) {
        cell2.select.popoverText.popoverTextField.text=entity.Text;
    }
    cell2.LabelText=entity.Label;
    
    UIImage *img=[UIImage imageNamed:@"Open.png"];
    UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
    cell2.select.popoverText.popoverTextField.enabled=NO;
    cell2.select.popoverText.popoverTextField.rightView=imageView;
    cell2.select.popoverText.popoverTextField.rightViewMode=UITextFieldViewModeAlways;
    
    cell2.select.popoverView.popoverTitle=entity.Label;
    
    NSMutableArray *saveArr=[NSMutableArray array];
    for (int i=1; i<12; i++) {
        [saveArr addObject:[NSString stringWithFormat:@"%d 個月",i]];
    }
    for (int i=1; i<=20; i++) {
        [saveArr addObject:[NSString stringWithFormat:@"%d 年",i]];
    }
    [cell2.select setDataSourceForArray:saveArr];
       
    [result addObject:cell1];
    [result addObject:cell2];
    return result;
}
-(NSMutableArray*)CaseCategoryBornRelationCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:[NSString stringWithFormat:@"%@:",entity.Label] required:entity.isRequired];
    
    TKCaseDropListCell *cell2=[[[TKCaseDropListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.required=entity.isRequired;
    cell2.select.popoverText.popoverTextField.placeholder=[NSString stringWithFormat:@"請選擇%@",entity.Label];
    cell2.LabelName=entity.Name;
    if (entity.Text&&[entity.Text length]>0) {
        cell2.select.popoverText.popoverTextField.text=entity.Text;
    }
    cell2.LabelText=entity.Label;
    
    UIImage *img=[UIImage imageNamed:@"Open.png"];
    UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
    cell2.select.popoverText.popoverTextField.enabled=NO;
    cell2.select.popoverText.popoverTextField.rightView=imageView;
    cell2.select.popoverText.popoverTextField.rightViewMode=UITextFieldViewModeAlways;
    
    cell2.select.popoverView.popoverTitle=entity.Label;
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"父母",@"key", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"祖父母",@"key", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"戶長", @"key",nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"同居人",@"key", nil]];
    [cell2.select setDataSourceForArray:arr dataTextName:@"key" dataValueName:@"key"];
    //[cell2.select setDataSourceForArray:saveArr];
    
    [result addObject:cell1];
    [result addObject:cell2];
    return result;
}
-(NSMutableArray*)CaseCategoryDeadRelationCells:(CaseSettingField*)entity{
    NSMutableArray *result=[NSMutableArray array];
    TKCaseLabelCell *cell1=[[[TKCaseLabelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell1 setLabelName:[NSString stringWithFormat:@"%@:",entity.Label] required:entity.isRequired];
    
    TKCaseDropListCell *cell2=[[[TKCaseDropListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    cell2.required=entity.isRequired;
    cell2.select.popoverText.popoverTextField.placeholder=[NSString stringWithFormat:@"請選擇%@",entity.Label];
    cell2.LabelName=entity.Name;
    if (entity.Text&&[entity.Text length]>0) {
        cell2.select.popoverText.popoverTextField.text=entity.Text;
    }
    cell2.LabelText=entity.Label;
    
    UIImage *img=[UIImage imageNamed:@"Open.png"];
    UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
    cell2.select.popoverText.popoverTextField.enabled=NO;
    cell2.select.popoverText.popoverTextField.rightView=imageView;
    cell2.select.popoverText.popoverTextField.rightViewMode=UITextFieldViewModeAlways;
    
    cell2.select.popoverView.popoverTitle=entity.Label;
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"配偶",@"key", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"親屬",@"key", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"戶長", @"key",nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"同居人",@"key", nil]];
    [cell2.select setDataSourceForArray:arr dataTextName:@"key" dataValueName:@"key"];
    //[cell2.select setDataSourceForArray:saveArr];
    
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
        if ([guid isEqualToString:@"HR"]) {
            [controller setSelectedCategoryIndex:0];
        }
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
-(void)buttonOpenURL:(id)sender{
    UIButton *btn=(UIButton*)sender;
    UITextField *field=(UITextField*)[btn superview];
    if ([field.text length]>0) {
        [AlertHelper initWithTitle:@"提示" message:@"是否瀏覽網頁?" cancelTitle:@"取消" cancelAction:nil confirmTitle:@"確認" confirmAction:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:field.text]];//使用浏览器打开
        }];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
