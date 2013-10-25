//
//  TKCaseLabelTextFieldCell.m
//  Eland
//
//  Created by aJia on 13/10/17.
//  Copyright (c) 2013年 rang. All rights reserved.
//

#import "TKCaseLabelTextFieldCell.h"
#import "UIColor+TPCategory.h"
#import "AlertHelper.h"
@interface TKCaseLabelTextFieldCell ()
-(void)buttonPhotoClick;
-(void)buttonCameraClick;

@end

@implementation TKCaseLabelTextFieldCell
-(void)dealloc{
    [super dealloc];
    [_cameraImage release],_cameraImage=nil;
}
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    UIImage *leftImage=[UIImage imageNamed:@"btn.png"];
    UIEdgeInsets leftInsets = UIEdgeInsetsMake(5,10, 5, 10);
    leftImage=[leftImage resizableImageWithCapInsets:leftInsets resizingMode:UIImageResizingModeStretch];
    
    _buttonPhoto=[[UIButton alloc] initWithFrame:CGRectMake(10, 4.5, 90, 35)];
    [_buttonPhoto setBackgroundImage:leftImage forState:UIControlStateNormal];
    _buttonPhoto.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
    [_buttonPhoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonPhoto setTitle:@"相簿" forState:UIControlStateNormal];
    [_buttonPhoto addTarget:self action:@selector(buttonPhotoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_buttonPhoto];
    
    _buttonCamera=[[UIButton alloc] initWithFrame:CGRectMake(10, 4.5, 90, 35)];
    [_buttonCamera setBackgroundImage:leftImage forState:UIControlStateNormal];
    _buttonCamera.titleLabel.font=[UIFont boldSystemFontOfSize:16.0];
    [_buttonCamera setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonCamera setTitle:@"拍照" forState:UIControlStateNormal];
     [_buttonCamera addTarget:self action:@selector(buttonCameraClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_buttonCamera];
   
    if (!_cameraImage) {
        _cameraImage=[[CaseCameraImage alloc] init];
        _cameraImage.imageSelectDelegate=self;
    }
    
    return self;
}
- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame=[self.label frame];
    frame.origin.y=(self.bounds.size.height-frame.size.height)/2.0;
    self.label.frame=frame;
	
    frame=_buttonCamera.frame;
    frame.origin.x=self.bounds.size.width-10-frame.size.width;
    _buttonCamera.frame=frame;
	
    frame=_buttonPhoto.frame;
	frame.origin.x=_buttonCamera.frame.origin.x-10-frame.size.width;
    _buttonPhoto.frame=frame;
}
-(int)maxImageCount{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(getMaxImageCount)]) {
        _maxImageCount=[self.delegate performSelector:@selector(getMaxImageCount)];
    }
    return _maxImageCount;
}
-(void)buttonPhotoClick{
    if (self.maxImageCount==0) {
        [AlertHelper initWithTitle:@"提示" message:@"不能超過最大圖片上傳數量！"];
        return;
    }
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.limitsMaximumNumberOfSelection=YES;
    imagePickerController.maximumNumberOfSelection=self.maxImageCount;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self.showInController presentViewController:nav animated:YES completion:NULL];
    [imagePickerController release];
    [nav release];
    
}
-(void)buttonCameraClick{
    if (self.maxImageCount==0) {
        [AlertHelper initWithTitle:@"提示" message:@"不能超過最大圖片上傳數量！"];
        return;
    }
    [_cameraImage showCameraInController:self.showInController];
}
-(void)cameraPhoto:(UIImage*)image{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(finishCameraPhoto:)]) {
        [self.delegate finishCameraPhoto:image];
    }
}
#pragma mark - QBImagePickerControllerDelegate
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    if(imagePickerController.allowsMultipleSelection) {
        NSArray *mediaInfoArray = (NSArray *)info;
        NSMutableArray *photos=[NSMutableArray array];
        for (NSDictionary *item in mediaInfoArray) {
            UIImage *image=(UIImage*)[item objectForKey:UIImagePickerControllerOriginalImage];
            [photos addObject:image];
        }
        if (self.delegate&&[self.delegate respondsToSelector:@selector(finishPhotos:)]) {
            [self.delegate finishPhotos:photos];
        }
    } else {
        NSDictionary *mediaInfo = (NSDictionary *)info;
        NSLog(@"Selected: %@", mediaInfo);
    }
    [imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}
- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos
{
    return [NSString stringWithFormat:@"%d張照片,最多選%d張", numberOfPhotos,self.maxImageCount];
}

@end
