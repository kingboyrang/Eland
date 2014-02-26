//
//  CaseAddViewController.m
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "CaseAddViewController.h"
#import "ASIHTTPRequest.h"
#import "TKCaseLabelCell.h"
#import "TKCaseTextFieldCell.h"
#import "TKCaseTextViewCell.h"
#import "TKCaseTextCell.h"
#import "NSString+TPCategory.h"
#import "TKEmptyCell.h"
#import "TKCaseLabelTextFieldCell.h"
#import "TKCaseButtonCell.h"
#import "CaseSettingField.h"
#import "UIColor+TPCategory.h"
#import "TkCaseImageCell.h"
#import "CaseCategoryHelper.h"
#import "UserSet.h"
#import "NSString+TPCategory.h"
#import "CaseImage.h"
#import "UIImage+TPCategory.h"
#import "ASIFormDataRequest.h"
#import "NSDate+TPCategory.h"
#import "XmlParseHelper.h"
#import "TKCaseLightNumberCell.h"
#import "TkCaseLocationCell.h"
#import "TKCaseCalendarCell.h"
#import "AlertHelper.h"
#import "TKCaseLightNumberCell.h"
#import "TKCaseRadioCell.h"
#import "TKCaseDropListCell.h"
#import "AlertHelper.h"
#import "TKCaseDownListCell.h"
#import "UITextField+TPCategory.h"
@interface CaseAddViewController ()
@property (nonatomic,assign) CGRect orginFrame;
@property (nonatomic,assign) CGRect tableFrame;
-(void)loadingFormFields;
-(void)updateFormUI;
-(BOOL)formValidate;
-(CGFloat)scrollerToRowTotal:(int)index;
-(void)buttonSubmit;
-(void)insertAndRemoveRows;
-(void)updateCaseCityShowWithType:(int)type;
-(CGRect)fieldToRect:(UITextField*)field;
@end

@implementation CaseAddViewController
-(void)dealloc{
    [super dealloc];
    [_tableView release],_tableView=nil;
    [_caseArgs release],_caseArgs=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
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
    self.orginFrame=self.view.frame;

    
    _hrType=-1;
    _prvHrTypeCount=0;
    
    _caseArgs=[[Case alloc] init];
    _caseArgs.Extend=[[CaseExtend alloc] init];
    _caseArgs.Applicant=[[CaseApplicant alloc] init];
    _caseArgs.CaseSettingGuid=self.Entity.GUID;
    _caseArgs.CaseCagegory1=@"";
    _caseArgs.CaseCagegory2=@"";
    _caseArgs.CityGuid=@"宜蘭縣";
   
    
    //NSLog(@"GUID=%@",self.Entity.GUID);
    CGRect r=self.view.bounds;
    _tableView=[[UITableView alloc] initWithFrame:r style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.bounces=NO;
    _tableView.backgroundColor=[UIColor clearColor];
    self.tableFrame=_tableView.frame;
    [self.view addSubview:_tableView];
    //self.cells=[self CaseCategoryAndCityCells:self.Entity];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(done:)];
    tapGestureRecognizer.numberOfTapsRequired =1;
    tapGestureRecognizer.cancelsTouchesInView =NO;
    [_tableView addGestureRecognizer:tapGestureRecognizer];  //只需要点击非文字输入区域就会响应hideKeyBoard
    [tapGestureRecognizer release];
    
	[self loadingFormFields];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardWillShowHideNotification:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardWillShowHideNotification:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    
}
#pragma mark - Notifications
- (void)handleKeyboardWillShowHideNotification:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    //取得键盘的大小
    //CGRect kbFrame = [[info valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if ([notification.name isEqualToString:UIKeyboardDidShowNotification]) {//显示键盘
               
    }
    else if ([notification.name isEqualToString:UIKeyboardDidHideNotification]) {//隐藏键盘

        NSTimeInterval animationDuration = [[info valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        _tableView.contentInset=UIEdgeInsetsZero;
        [UIView commitAnimations];
    }
}

-(void)done:(id)sender
{
   
    for (id v in self.cells) {
        if ([v isKindOfClass:[TKCaseTextFieldCell class]]) {
            TKCaseTextFieldCell *cell=(TKCaseTextFieldCell*)v;
            if (cell.field.isFirstResponder) {
                [cell.field resignFirstResponder];
                break;
            }
        }
        if ([v isKindOfClass:[TKCaseTextViewCell class]]) {
            TKCaseTextViewCell *cell=(TKCaseTextViewCell*)v;
            if (cell.textView.isFirstResponder) {
                [cell.textView resignFirstResponder];
                break;
            }
        }
    }
}
-(void)updateFormUI{
    
    [ZAActivityBar dismissForAction:@"loadFields"];
    NSMutableArray *source=[NSMutableArray array];
    [source addObjectsFromArray:[self CaseCategoryAndCityCells:self.Entity]];
    NSArray *sortfields=[self.Entity sortFields];
    if ([sortfields count]>0) {
        for (CaseSettingField *item in sortfields) {
            //NSLog(@"name=%@,label=%@,sort=%@\n",item.Name,item.Label,item.Sort);
            if ([item.Name isEqualToString:@"LngLat"]) {
                continue;
            }
            
            if ([item.Name isEqualToString:@"PetAge"]) {
                [source addObjectsFromArray:[self CaseCategoryDropCells:item]];
                continue;
            }
            if ([item.Name isEqualToString:@"PetDate"]) {//走失时间
                [source addObjectsFromArray:[self CaseCategoryLostDateCells:item]];
                continue;
            }
            if ([item.Name isEqualToString:@"IsAgree"]||[item.Name isEqualToString:@"IsPublic"]||[item.Name isEqualToString:@"IsHistory"]||[item.Name isEqualToString:@"PetSterilization"]||[item.Name isEqualToString:@"PetGender"]||[item.Name isEqualToString:@"PetChip"]) {//单选
                [source addObjectsFromArray:[self CaseCategoryRadioCells:item]];
                continue;
            }
            if ([self.Entity.GUID isEqualToString:@"HR"]) {//戶政預約处理
                if ([self.Entity hrExistFieldName:item.Name]) {
                    continue;
                }
            }
            if ([item.Name startWithString:@"Note"]) {
                [source addObjectsFromArray:[self CaseCategoryNoteCells:item]];
                continue;
            }
                       if ([self.Entity.GUID isEqualToString:@"Light"]) {//路灯报修处理
                if ([item.Name isEqualToString:@"LightNumber"]) {
                    [source addObjectsFromArray:[self CaseCategoryNumberCells:[self.Entity getEntityFieldWithName:@"LightNumber"]]];
                    continue;
                }
                if ([item isTextArea]) {
                    if ([item.Name isEqualToString:@"Location"]) {//定位
                        
                    }else{
                        [source addObjectsFromArray:[self CaseCategoryTextAreaCells:item]];
                    }
                    continue;
                }
                [source addObjectsFromArray:[self CaseCategoryTextCells:item]];
                
            }else{
                if ([item isTextArea]) {
                    if ([item.Name isEqualToString:@"Location"]) {//定位
                        [source addObjectsFromArray:[self CaseCategoryLocationCells:item]];
                    }else{
                        [source addObjectsFromArray:[self CaseCategoryTextAreaCells:item]];
                    }
                    continue;
                }
                [source addObjectsFromArray:[self CaseCategoryTextCells:item]];
            }
            
        }
    }
    [source addObjectsFromArray:[self CaseCategoryPWDCells]];
    if (self.Entity.showImage) {//是否显示上传图片
        [source addObjectsFromArray:[self CaseCategoryImagesCells:self.Entity]];
    }
    TKCaseButtonCell *cell=[[[TKCaseButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
    [cell.button addTarget:self action:@selector(buttonSubmit) forControlEvents:UIControlEventTouchUpInside];
    [source addObject:cell];
    self.cells=source;
    [_tableView reloadData];
    
    //CaseSettingGuid
    //加载第一层分类 
    if([self.cells[1] isKindOfClass:[TKCaseDownListCell class]])
    {
        TKCaseDownListCell *select=(TKCaseDownListCell*)self.cells[1];
        [select fillNodesArray];
    }
    
   
}
-(void)finishLoadCategory{
    if (self.Entity&&[self.Entity.GUID isEqualToString:@"HR"]) {
        CaseCategory *entity=[CaseCategoryHelper getHRFirstChildWithGuid:self.Entity.GUID];
        if (entity!=nil) {
            [self selectedCaseCategory:entity];
        }
    }
}
-(void)loadingFormFields{
    [ZAActivityBar showWithStatus:@"正在加載..." forAction:@"loadFields"];
    NSString *url=[NSString stringWithFormat:SingleCaseSettingURL,self.Entity.GUID];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setCompletionBlock:^{
       
        if (request.responseStatusCode==200) {
            self.Entity=[CaseSetting xmlStringToCaseSetting:request.responseString];
        }
        [self performSelectorOnMainThread:@selector(updateFormUI) withObject:nil waitUntilDone:NO];
       
    }];
    [request setFailedBlock:^{
        [self performSelectorOnMainThread:@selector(updateFormUI) withObject:nil waitUntilDone:NO];
    }];
    [request startAsynchronous];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)scrollerToRowTotal:(int)index{
    CGFloat total=0;
    for (int i=0; i<index; i++) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        total+=[_tableView.delegate tableView:_tableView heightForRowAtIndexPath:indexPath];
    }
    return total;
}
-(void)switchControlSelectedIndex:(NSInteger)index withObject:(id)sender{
    id v=[sender superview];
    while (![v isKindOfClass:[UITableViewCell class]]) {
        v=[v superview];
    }
    TKCaseLightNumberCell *cell=(TKCaseLightNumberCell*)v;
     NSIndexPath *indexPath=[_tableView indexPathForCell:cell];
    id  cell1=[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0]];
    
    if ([cell1 isKindOfClass:[TKCaseTextFieldCell class]]&&index!=1) {
        [self.cells removeObjectAtIndex:indexPath.row+1];
        [self.cells removeObjectAtIndex:indexPath.row+1];
        
        NSIndexPath *indexPath1=[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
        NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0];
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,indexPath2, nil] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
       
        
        
        CaseSettingField *entity=[self.Entity getEntityFieldWithName:@"Location"];
        if (entity!=nil) {
            NSMutableArray *arr=[self CaseCategoryLocationCells:entity];
            NSMutableArray *indexPaths=[NSMutableArray arrayWithCapacity:arr.count];
            for (int i=0; i<arr.count; i++) {
                [self.cells insertObject:[arr objectAtIndex:i] atIndex:indexPath.row+i+1];
                NSIndexPath *cellIndexPath=[NSIndexPath indexPathForRow:indexPath.row+i+1 inSection:0];
                [indexPaths addObject:cellIndexPath];
            }
            [_tableView beginUpdates];
            [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [_tableView endUpdates];
            
        }
        
    }
    //LightNumber
    if ([cell1 isKindOfClass:[TKCaseTextViewCell class]]&&index!=2) {
        [self.cells removeObjectAtIndex:indexPath.row+1];
        [self.cells removeObjectAtIndex:indexPath.row+1];
        
        NSIndexPath *indexPath1=[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
        NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0];
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,indexPath2, nil] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
        
        
        
        CaseSettingField *entity=[self.Entity getEntityFieldWithName:@"LightNumber"];
        if (entity!=nil) {
            NSMutableArray *arr=[self CaseCategoryLightNumberCells:entity];
            NSMutableArray *indexPaths=[NSMutableArray arrayWithCapacity:arr.count];
            for (int i=0; i<arr.count; i++) {
                [self.cells insertObject:[arr objectAtIndex:i] atIndex:indexPath.row+i+1];
                NSIndexPath *cellIndexPath=[NSIndexPath indexPathForRow:indexPath.row+i+1 inSection:0];
                [indexPaths addObject:cellIndexPath];
            }
            [_tableView beginUpdates];
            [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [_tableView endUpdates];
            
        }

    }
}
#pragma mark UITextViewDelegate Methods
- (void)textViewDidBeginEditing:(UITextView *)textView{
   
    id v=[textView superview];
    while (![v isKindOfClass:[UITableViewCell class]]) {
        v=[v superview];
    }
    UITableViewCell *cell=(UITableViewCell*)v;
    NSIndexPath *indexPath=[_tableView indexPathForCell:cell];
    CGRect r=[_tableView rectForRowAtIndexPath:indexPath];
    r.origin.y+=textView.frame.origin.y*2+textView.frame.size.height;
    
    
    
    CGFloat h=r.origin.y+216+10;
    if (h>_tableView.frame.size.height&&h<_tableView.contentSize.height) {
        [_tableView setContentOffset:CGPointMake(0,h-_tableView.frame.size.height) animated:YES];
    }
    if (h>_tableView.contentSize.height) {
        int offset=r.origin.y-(_tableView.frame.size.height-216);
        if (offset>0) {
            [UIView animateWithDuration:0.3f animations:^{
                _tableView.contentInset=UIEdgeInsetsMake(-offset, 0, 0, 0);
            }];
            
        }
    }
    /***
    if (_tableView.frame.size.height-216-10>r.origin.y) {
        [_tableView setContentOffset:CGPointMake(0, r.origin.y) animated:YES];
    }else{
        int offset=r.origin.y-(_tableView.frame.size.height-216);
        if (offset>0) {
            _tableView.contentInset=UIEdgeInsetsMake(-offset, 0, 0, 0);
        }
    }
     ***/
}
#pragma mark UITextFieldDelegate Methods
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    id v=[textField superview];
    while (![v isKindOfClass:[UITableViewCell class]]) {
        v=[v superview];
    }
    UITableViewCell *cell=(UITableViewCell*)v;
    NSIndexPath *indexPath=[_tableView indexPathForCell:cell];
    CGRect r=[_tableView rectForRowAtIndexPath:indexPath];
    r.origin.y+=textField.frame.origin.y*2+textField.frame.size.height;
    
    
    CGFloat h=r.origin.y+216+10;
    if (h>_tableView.frame.size.height&&h<_tableView.contentSize.height) {
        [_tableView setContentOffset:CGPointMake(0,h-_tableView.frame.size.height) animated:YES];
    }
    if (h>_tableView.contentSize.height) {
        int offset=r.origin.y-(_tableView.frame.size.height-216);
        if (offset>0) {
            [UIView animateWithDuration:0.3f animations:^{
                _tableView.contentInset=UIEdgeInsetsMake(-offset, 0, 0, 0);
            }];
            
        }
    }

    /***
    if (r.origin.y+216+10>_tableView.frame.size.height) {
        if (_tableView.frame.size.height-216-10>r.origin.y) {
            [_tableView setContentOffset:CGPointMake(0, r.origin.y) animated:YES];
        }else{
            int offset=r.origin.y-(_tableView.frame.size.height-216);
            if (offset>0) {
                _tableView.contentInset=UIEdgeInsetsMake(-offset, 0, 0, 0);
            }
        }
    }
    ***/
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//计算输入框与顶部的高度
- (CGRect)fieldToRect:(UITextField*)field{
    id v=[field superview];
    while (![v isKindOfClass:[UITableViewCell class]]) {
        v=[v superview];
    }
    UITableViewCell *cell=(UITableViewCell*)v;
    CGRect r=[self.view convertRect:cell.frame fromView:_tableView];//计算当前cell距离顶部的高度
    //CGRect r1=[cell convertRect:field.frame fromView:cell];
    r.origin.y+=field.frame.origin.y;
    //[self tableView:_tableView heightForRowAtIndexPath:[_tableView indexPathForCell:cell]];
    r.origin.x=field.frame.origin.x;
    
    return r;
}
//验证
-(BOOL)formValidate{
    for (id  item in self.cells) {
        if ([item isKindOfClass:[TKCaseDownListCell class]]) {//案件分类
            TKCaseDownListCell *cell=(TKCaseDownListCell*)item;
            if (cell.required&&!cell.hasValue) {
                [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.cells indexOfObject:item] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                [AlertHelper initWithTitle:@"提示" message:@"請選擇案件分類!"];
                 return NO;
            }
        }
        
        if ([item isKindOfClass:[TKCaseTextFieldCell class]]) {
            TKCaseTextFieldCell *cell=(TKCaseTextFieldCell*)item;
            if (cell.required&&!cell.hasValue) {
                //[_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.cells indexOfObject:item] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                //滚动到指定位置
                [cell.field becomeFirstResponder];
                [cell errorVerify];
                [cell.field shake];
                return NO;
            }
        }
        if ([item isKindOfClass:[TKCaseTextViewCell class]]) {
            TKCaseTextViewCell *cell=(TKCaseTextViewCell*)item;
            if (cell.required&&!cell.hasValue) {
                [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.cells indexOfObject:item] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                //滚动到指定位置
                [cell errorVerify];
                [cell.textView shake];
                return NO;
            }
        }
        if ([item isKindOfClass:[TKCaseCalendarCell class]]) {
            TKCaseCalendarCell *cell=(TKCaseCalendarCell*)item;
            if (cell.required&&!cell.hasValue) {
                [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.cells indexOfObject:item] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                //滚动到指定位置
                [AlertHelper initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@不為空!",cell.LabelText]];
                return NO;
            }
        }
        if ([item isKindOfClass:[TKCaseDropListCell class]]) {
            TKCaseDropListCell *cell=(TKCaseDropListCell*)item;
            if (cell.required&&!cell.hasValue) {
                [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.cells indexOfObject:item] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                //滚动到指定位置
                [AlertHelper initWithTitle:@"提示" message:[NSString stringWithFormat:@"請選擇%@!",cell.LabelText]];
                return NO;
            }
        }
        

        
    }
    return YES;
}
//提交
-(void)buttonSubmit{
    if (![self formValidate]) {
        return;
    }
    for (id item in self.cells) {
        if ([item isKindOfClass:[TKCaseDownListCell class]]) {//案件分类
             TKCaseDownListCell *cell=(TKCaseDownListCell*)item;
            _caseArgs.CaseCagegory1=[cell.field1 value];
            _caseArgs.CaseCagegory2=[cell.field2 value];
        }
        if ([item isKindOfClass:[TKCaseTextFieldCell class]]) {//单行文本
            TKCaseTextFieldCell *cell=(TKCaseTextFieldCell*)item;
            if ([cell.LabelName isEqualToString:@"CaseSettingGuid"]||[cell.LabelName isEqualToString:@"CityGuid"]||[cell.LabelName isEqualToString:@"LngLat"]) {
                continue;
            }
            [_caseArgs objectValue:cell.field.text objectKey:cell.LabelName];
        }
        if ([item isKindOfClass:[TKCaseCalendarCell class]]) {//日期
            TKCaseCalendarCell *cell=(TKCaseCalendarCell*)item;
            [_caseArgs objectValue:cell.lostCalendar.popoverText.popoverTextField.text objectKey:cell.LabelName];
        }
        if ([item isKindOfClass:[TKCaseRadioCell class]]) {//单选
            TKCaseRadioCell *cell=(TKCaseRadioCell*)item;
            [_caseArgs objectValue:[NSString stringWithFormat:@"%d",cell.radioView.currentIndex] objectKey:cell.LabelName];
        }
        if ([item isKindOfClass:[TKCaseDropListCell class]]) {//下拉选单
            TKCaseDropListCell *cell=(TKCaseDropListCell*)item;
            [_caseArgs objectValue:cell.select.popoverText.popoverTextField.text objectKey:cell.LabelName];
        }
        if ([item isKindOfClass:[TKCaseTextViewCell class]]) {//多行文本
            TKCaseTextViewCell *cell=(TKCaseTextViewCell*)item;
            [_caseArgs objectValue:cell.textView.text objectKey:cell.LabelName];
        }
        if ([item isKindOfClass:[TkCaseImageCell class]]) {//案件图片
            TkCaseImageCell *cell=(TkCaseImageCell*)item;
            NSArray *arr=[cell.PhotoScroll sourceImages];
            if (arr&&[arr count]>0) {
                NSMutableArray *source=[NSMutableArray array];
                for (UIImage *image in arr) {
                    CaseImage *entity=[[[CaseImage alloc] init] autorelease];
                    entity.Name=[NSString stringWithFormat:@"%@.jpg",[NSString createGUID]];
                    entity.Content=[image imageBase64String];
                    [source addObject:entity];
                }
                _caseArgs.Images=source;
            }else{
                _caseArgs.Images=[NSArray array];
            }
        }
        
    }
    
    UserSet *user=[UserSet sharedInstance];
    if ([_caseArgs.Applicant.Name isEqual:[NSNull null]]||[_caseArgs.Applicant.Name length]==0) {
        _caseArgs.Applicant.Name=user.Name;
    }
    if ([_caseArgs.Applicant.Phone isEqual:[NSNull null]]||[_caseArgs.Applicant.Phone length]==0) {
        _caseArgs.Applicant.Phone=user.Mobile;
    }
    if ([_caseArgs.Applicant.Email isEqual:[NSNull null]]||[_caseArgs.Applicant.Email length]==0) {
        _caseArgs.Applicant.Email=user.Email;
    }
    if ([_caseArgs.Applicant.Nick isEqual:[NSNull null]]||[_caseArgs.Applicant.Nick length]==0) {
        _caseArgs.Applicant.Nick=user.Nick;
    }
    _caseArgs.Source=@"ios";
    NSString *time=[NSDate stringFromDate:[NSDate date] withFormat:@"yyyy-MM-dd HH:mm:ss"];
    time=[time stringByReplacingOccurrencesOfString:@" " withString:@"T"];
    _caseArgs.ApplyDate=time;
    _caseArgs.AppCode=user.AppToken;
   
    if (!self.hasNetwork) {
        [self showNoNetworkNotice:nil];
        return;
    }
    [ZAActivityBar showWithStatus:@"正在送出..." forAction:@"caseAdd"];
    //提交
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:AddCaseURL]];
    [request setPostValue:[_caseArgs XmlSerialize] forKey:@"xml"];
    [request setRequestMethod:@"POST"];
    [request setTimeOutSeconds:60.0];//表示30秒请求超时
    [request setCompletionBlock:^{
        if (request.responseStatusCode==200) {
            NSString *xml=[request.responseString stringByReplacingOccurrencesOfString:@"xmlns=\"CaseAddResult\"" withString:@""];
            XmlParseHelper *parse=[[[XmlParseHelper alloc] initWithData:xml] autorelease];
            XmlNode *node=[parse selectSingleNode:@"//Success"];
            if ([node.Value isEqualToString:@"true"]) {
                [ZAActivityBar showSuccessWithStatus:@"送出成功!" forAction:@"caseAdd"];
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
        }
        [ZAActivityBar showErrorWithStatus:@"送出失敗!" forAction:@"caseAdd"];
    }];
    [request setFailedBlock:^{
        [ZAActivityBar showErrorWithStatus:@"送出失敗!" forAction:@"caseAdd"];
    }];
    [request startAsynchronous];
}
-(void)selectedCaseCategory:(CaseCategory*)category{
    
    //户政预约
    if ([self.Entity.GUID isEqualToString:@"HR"]) {
        if ([category.Name isEqualToString:@"出生登記"]&&_hrType!=1) {
            _hrType=1;
            [self updateCaseCityShowWithType:1];
            [self insertAndRemoveRows];
        }
        if ([category.Name isEqualToString:@"結婚登記"]&&_hrType!=2) {
            _hrType=2;
            [self updateCaseCityShowWithType:2];
            [self insertAndRemoveRows];
        }
        if ([category.Name isEqualToString:@"死亡登記"]&&_hrType!=3) {
            _hrType=3;
            [self updateCaseCityShowWithType:3];
            [self insertAndRemoveRows];
        }
    }
}
  /***
-(void)selectedCaseCategory:(CaseCategory*)category{
    [self hidePopoverCaseCategory];
  
    if ([category.Parent length]==0) {
        _caseArgs.CaseSettingGuid=category.GUID;
        _caseArgs.CaseCagegory1=@"";
        _caseArgs.CaseCagegory2=@"";
    }else{
        CaseCategory *item=[CaseCategoryHelper getCaseCategoryEntity:category.Parent];
        if ([item.Parent length]==0) {
            _caseArgs.CaseSettingGuid=category.Parent;
            _caseArgs.CaseCagegory1=category.GUID;
            _caseArgs.CaseCagegory2=@"";
        }else{
            _caseArgs.CaseSettingGuid=item.GUID;
            _caseArgs.CaseCagegory1=category.Parent;
            _caseArgs.CaseCagegory2=category.GUID;
        }
    }
    
    TKCaseDownListCell *cell=self.cells[1];
    if (cell.required) {
       // [cell removeVerify];
    }
    //户政预约
    if ([self.Entity.GUID isEqualToString:@"HR"]) {
        if ([category.Name isEqualToString:@"出生登記"]&&_hrType!=1) {
            _hrType=1;
            [self updateCaseCityShowWithType:1];
            [self insertAndRemoveRows];
        }
        if ([category.Name isEqualToString:@"結婚登記"]&&_hrType!=2) {
            _hrType=2;
            [self updateCaseCityShowWithType:2];
            [self insertAndRemoveRows];
        }
        if ([category.Name isEqualToString:@"死亡登記"]&&_hrType!=3) {
            _hrType=3;
            [self updateCaseCityShowWithType:3];
            [self insertAndRemoveRows];
        }
    }
    
}
    ***/
-(void)updateCaseCityShowWithType:(int)type{
    TKCaseLabelCell *cell=self.cells[2];
    if (type==1) {
        [cell setShowName:@"新生兒預約設籍之戶政事務所:" required:[self.Entity isRequiredShowCity]];
    }else{
        [cell setShowName:@"預約戶籍地之戶政事務所:" required:[self.Entity isRequiredShowCity]];
    }
}
-(void)insertAndRemoveRows{
    NSMutableArray *insertRows=[self CaseCategoryHRCells:self.Entity hrType:_hrType];
    if (insertRows.count==0) {
        _prvHrTypeCount=0;
        return;
    }
    int startIndex=2;
    if (self.Entity.showCityDown) {
        startIndex=4;
    }
    if (_prvHrTypeCount!=0) {
        [self.cells removeObjectsInRange:NSMakeRange(startIndex, _prvHrTypeCount)];
        NSMutableArray *indexPaths=[NSMutableArray arrayWithCapacity:_prvHrTypeCount];
        for (int i=0; i<_prvHrTypeCount; i++) {
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:startIndex+i inSection:0];
            [indexPaths addObject:indexPath];
        }
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
    }
    NSMutableArray *insertIndexPaths=[NSMutableArray arrayWithCapacity:insertRows.count];
    for (int i=0; i<insertRows.count; i++) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:startIndex+i inSection:0];
        [insertIndexPaths addObject:indexPath];
        [self.cells insertObject:[insertRows objectAtIndex:i] atIndex:startIndex+i];
    }
    [_tableView beginUpdates];
    [_tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [_tableView endUpdates];
    
    _prvHrTypeCount=insertRows.count;
    
}
-(void)selectedVillageTown:(CaseCity*)city{
    [self hidePopoverCaseCity];
    TKCaseTextFieldCell *cell=self.cells[3];
    cell.field.text=city.Name;
    _caseArgs.CityGuid=city.GUID;
    if (cell.required) {
        [cell removeVerify];
    }
}
-(void)geographyLocation:(SVPlacemark*)place{
    _caseArgs.Extend.Lat=[NSString stringWithFormat:@"%f",place.location.coordinate.latitude];
    _caseArgs.Extend.Lng=[NSString stringWithFormat:@"%f",place.location.coordinate.longitude];
}
#pragma mark -
#pragma mark UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.cells.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *tableCell=self.cells[indexPath.row];
    tableCell.selectionStyle=UITableViewCellSelectionStyleNone;
    return tableCell;
}
#pragma mark -
#pragma mark UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        if ([self.cells[indexPath.row] isKindOfClass:[TKCaseTextCell class]]) {
            TKCaseTextCell *cell=self.cells[indexPath.row];
            CGSize size=[cell.label.text textSize:[UIFont boldSystemFontOfSize:16.0] withWidth:self.view.bounds.size.width-2*10];
            return size.height+8;
        }
        if ([self.cells[indexPath.row] isKindOfClass:[TKCaseTextViewCell class]]) {
            return 120;
        }
        if ([self.cells[indexPath.row] isKindOfClass:[TkCaseImageCell class]]) {
            return 300;
        }
       if ([self.cells[indexPath.row] isKindOfClass:[TkCaseLocationCell class]]) {
           TkCaseLocationCell *cell=self.cells[indexPath.row];
           CGRect r=cell.label.frame;
           r.size.width=self.view.bounds.size.width-112;
           cell.label.frame=r;
           return [cell.label optimumSize].height+5+9;
       }
    if ([self.cells[indexPath.row] isKindOfClass:[TKCaseDownListCell class]]) {
        TKCaseDownListCell *cell=(TKCaseDownListCell*)self.cells[indexPath.row];
        if (cell.field2.hidden) {
            return 44;
        }
        /***
        if (cell.hasClilds) {
            return 44.0;
        }
          ***/
        return 90.0;
    }
    if ([self.cells[indexPath.row] isKindOfClass:[TKCaseLightNumberCell class]]) {
        return 40.0;
    }
    if ([self.cells[indexPath.row] isKindOfClass:[TKCaseRadioCell class]]) {
        return 30.0;
    }
       if ([self.cells[indexPath.row] isKindOfClass:[TKCaseButtonCell class]]) {
          return 64.0;
       }
    /***
      if ([self.cells[indexPath.row] isKindOfClass:[TKCaseLabelCell class]]) {
          TKCaseLabelCell *cell=self.cells[indexPath.row];
          CGRect r=cell.label.frame;
          r.size.width=self.view.bounds.size.width-20;
          cell.label.frame=r;
          return [cell.label optimumSize].height+5+6;
      }
     ***/
    
       if (indexPath.row%2==0) {
            if (![self.cells[indexPath.row] isKindOfClass:[TKCaseLabelTextFieldCell class]]) {
                return 30;
            }
        }
        return 44.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row==1) {
            //TKCaseDownListCell *cell=self.cells[1];
            //[self buttonCaseCategoryClick:cell.field1 CaseCategoryGUID:self.Entity.GUID];
        }
        if (indexPath.row==3) {
            if (self.Entity.showCityDown) {
                //隐藏键盘
                for (id v in self.cells) {
                    if ([v isKindOfClass:[TKCaseTextFieldCell class]]) {
                        TKCaseTextFieldCell *cell=(TKCaseTextFieldCell*)v;
                        //[cell.field resignFirstResponder];
                        [self textFieldShouldReturn:cell.field];
                    }
                    if ([v isKindOfClass:[TKCaseTextViewCell class]]) {
                        TKCaseTextViewCell *cell=(TKCaseTextViewCell*)v;
                        [cell.textView resignFirstResponder];
                    }
                }
                
                TKCaseTextFieldCell *cell=self.cells[3];
                [self buttonCaseCityClick:cell];
            }
        }
    
}
@end
