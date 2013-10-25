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
    [cell1 setLabelName:@"案件分類:" required:YES];
    TKCaseTextFieldCell *cell2=[[[TKCaseTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    UIImage *img=[UIImage imageNamed:@"Open.png"];
    UIImageView *imageView=[[[UIImageView alloc] initWithImage:img] autorelease];
    cell2.required=YES;
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
