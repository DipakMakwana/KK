//
//  CommonFile.m
//  TCP
//
//  Created by I-MAC on 9/20/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "CommonFile.h"

@implementation CommonFile

@synthesize delegate = delegate_;
#define BUTTON_X    10
#define BUTTON_GAP    20
#define BUTTON_WIDTH  150
#define BUTTON_HEIGHT 30

#define PEN1_W   101 // PEN WIDTH SIZE
#define PEN2_W   102
#define PEN3_W   103
#define PEN4_W   104
#define PEN5_W   105

#pragma mark
#pragma mark  ************** Custom View Method   **************
#pragma mark

-(UIView *)insertValueAlertViewFrame:(CGRect)frame lblTitle:(NSString *)lblTitle placeHolderText:(NSString *)placeHolderText addTag:(int)addTag
{
   
    UIView * customView1 = [self ConfigureView:frame backColor:BC cornerRadius:5 maskToBound:YES borderColor:WC borderWidth:2];
    customView1.tag = addTag;
//    if () {
//        <#statements#>
//    }
    frame = CGRectMake(20, 20, customView1.frame.size.width - 20, 25);
    UILabel *lbl = [self configureLabelFrame:frame title:lblTitle tColor:WC fontSize:20 fontName:FONT_GILL_SANS];
    lbl.textAlignment = NSTextAlignmentCenter;
    [customView1 addSubview:lbl];
    
    frame = CGRectMake(10, lbl.frame.origin.y + lbl.frame.size.height + 20 , customView1.frame.size.width - 20 , lbl.frame.size.height);
    
    self.txt = [self configureTextFieldFrame:frame placeholderText:placeHolderText tColor:WC bColor:RC fontSize:20 fontName:FONT_GILL_SANS];
    self.txt.textAlignment = NSTextAlignmentCenter;
    [customView1 addSubview:self.txt];
    
    if (isIpad)
         frame = CGRectMake(40, self.txt.frame.origin.y + self.txt.frame.size.height + 30 , 100, 50);
    else frame = CGRectMake(35, self.txt.frame.origin.y + self.txt.frame.size.height + 20 , 60, 30);
    
    
    UIButton *btnAdd = [self ConfigureButton:frame tag:addTag type:1 title:@"Add" tColor:WC bColor:BC imageName:BTN_IMAGE methodName:@selector(addButtonClicked:)];
        [customView1 addSubview:btnAdd];
    
    frame = CGRectMake(btnAdd.frame.origin.x + btnAdd.frame.size.width + 10 ,btnAdd.frame.origin.y, btnAdd.frame.size.width, btnAdd.frame.size.height);
    UIButton *btnCancel = [self ConfigureButton:frame tag:addTag type:1 title:@"Cancel" tColor:WC bColor:BC imageName:BTN_IMAGE methodName:@selector(cancelButtonClicked:)];
    [customView1 addSubview:btnCancel];
    return customView1;
}

-(void)addButtonClicked:(id)sender
{
    NSString *str = [self.txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([str length] > 0 ) {
        if ([self.delegate respondsToSelector:@selector(addButtonClicked:string:)]) {
            [self.delegate addButtonClicked:sender string:str];
        }
    }
    else
    {
        [CustomAlert alertTitle:FAILURE alertMessage:@"Please insert Category Name" delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitle:nil alertTag:0];
        //NSLog(@"Please insert Category Name ");
    }
    
    
}
-(void)cancelButtonClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:sender];
    }
}

#pragma mark
#pragma mark  ************** Configure  method   **************
#pragma mark

-(UIView *)ConfigureView:(CGRect )frame backColor:(UIColor *)backColor cornerRadius:(int )cornerRadius maskToBound:(BOOL)maskToBound borderColor:(UIColor *)borderColor borderWidth:(int )borderWidth{
    UIView * customView = [[UIView alloc]init];
    customView.frame= frame;
    customView.backgroundColor = backColor;
    customView.layer.cornerRadius = cornerRadius;
    customView.layer.masksToBounds = maskToBound;
    customView.layer.borderColor = [borderColor CGColor];
    customView.layer.borderWidth = borderWidth;
    return customView;
}
-(UIButton *) ConfigureButton:(CGRect)frame tag:(int)tag type :(int)type title:(NSString *)title  tColor:(UIColor *)tColor bColor:(UIColor *)bColor imageName:(NSString *)imageName methodName:(SEL)methodName{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:tColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:FONT_GILL_SANS size:17];
    btn.backgroundColor = bColor;
    btn.layer.cornerRadius = 5;
    if (imageName != nil) {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (methodName) {
        [btn addTarget:self action:methodName forControlEvents:UIControlEventTouchUpInside];
    }
    // NSLog(@"size of Object: %zd", malloc_size(btn));
    return btn;
}


-(UILabel*)configureLabelFrame:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor fontSize:(int)fontSize fontName:(NSString *)fontName{
    UILabel *lbl = [[UILabel alloc]init];
    lbl.frame =frame;
    lbl.text = title;
    lbl.textColor =tColor;
    lbl.font = [UIFont fontWithName:fontName size:fontSize];
    lbl.backgroundColor = [UIColor clearColor];
    return lbl;
}
-(UITextField *)configureTextFieldFrame:(CGRect)frame placeholderText:(NSString *)placeholderText tColor:(UIColor *)textColor  bColor:(UIColor *)backColor fontSize:(int)fontSize fontName:(NSString *)fontName{
    UITextField *txt = [[UITextField alloc]initWithFrame:frame];
    txt.font = [UIFont fontWithName:fontName size:fontSize];
    txt.textColor =[UIColor blackColor];
    txt.backgroundColor = [UIColor whiteColor];
    txt.layer.borderWidth = 1;
    txt.layer.cornerRadius = 5;
    txt.placeholder = placeholderText;
    txt.delegate = self;
    return txt;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}
#pragma mark
#pragma mark  ************** IBAction  method   **************
#pragma mark


-(IBAction)btnOptionClicked:(id)sender
{
    NSLog(@"Tag = %d ",[sender tag]);
}
-(void)dismissAlert:(UIAlertView*)x{
    
    [x dismissWithClickedButtonIndex:-1 animated:YES];
}

#pragma mark
#pragma mark *****************  Loader Method *****************
#pragma mark

-(void)removeViewWithAnimation:(UIView *)view x:(int)x y:(int)y w:(int)w h:(int)h delay:(int)delay
{
    if (view) {
        [UIView beginAnimations : @"Display notif" context:nil];
        [UIView setAnimationDuration:.5];
        
        view.frame = CGRectMake(x, y, w, h);
        [UIView commitAnimations];
        [self performSelector:@selector(removeCustomViewFromMemory:) withObject:view afterDelay:delay];
    }
}

-(void)removeCustomViewFromMemory:(UIView *)view
{
    if (view) {
        [view removeFromSuperview];
        view = nil;
    }
}


-(void)initiateLoaderWithMessage : (NSString *)str inView : (UIView *)view{
    
   // CGFloat screenHeight =  [[UIScreen mainScreen] bounds].size.height;
    
   // CGFloat screenWidth  =  [[UIScreen mainScreen] bounds].size.width;
    
    self.viewLoader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    self.viewLoader.hidden = NO;
	
	//add bg
	UIImageView *imgBg = [[UIImageView alloc] initWithFrame:self.viewLoader.frame];
	imgBg.alpha = 0.5;
	imgBg.backgroundColor = [UIColor blackColor];
	[self.viewLoader addSubview:imgBg];
    
	UIImageView *imgLoadingBG = [[UIImageView alloc] initWithFrame:CGRectMake(140, 70, 200, 180)] ;
    imgLoadingBG.center = self.viewLoader.center;
	imgLoadingBG.alpha = 0.8;
	imgLoadingBG.layer.cornerRadius = 10;
	imgLoadingBG.backgroundColor = [UIColor blackColor];
    
    UILabel *lblMsg = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 40)];
	lblMsg.backgroundColor = [UIColor clearColor];
	lblMsg.textAlignment = NSTextAlignmentCenter;
	lblMsg.textColor = [UIColor whiteColor];
    lblMsg.font = [UIFont fontWithName:FONT_GILL_SANS size:17];
    lblMsg.numberOfLines = 2;
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([str isKindOfClass:[NSNull class]] || [str isEqual:[NSNull null]] || [str isEqualToString:@"<null>"]  || [str isEqualToString:@"(null)"] || [str isEqualToString:@""] || str.length == 0) {
        str = @"Please wait...";
    }
    
    lblMsg.text = str;
   
	UIActivityIndicatorView *activityLoader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityLoader.frame = CGRectMake(70, 75, 50, 50);
	[imgLoadingBG addSubview:activityLoader];
     
	[imgLoadingBG addSubview:lblMsg];
	[activityLoader startAnimating];
     [self.viewLoader addSubview:imgLoadingBG];
    [view addSubview:self.viewLoader];
}

-(void)initiateUploadClipLoader : (NSString *)str inView : (UIView *)view{
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenBound.size.width;
    CGFloat screenHeight = screenBound.size.height;
	self.viewUploadClip = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
	
	//add bg
	UIImageView *imgBg = [[UIImageView alloc] initWithFrame:self.viewUploadClip.frame];
	imgBg.alpha = 0.5;
	imgBg.backgroundColor = [UIColor blackColor];
	[self.viewUploadClip addSubview:imgBg];
    
	UIImageView *imgLoadingBG = [[UIImageView alloc] initWithFrame:CGRectMake(140, 100, 200, 200)];
    imgLoadingBG.center = self.viewUploadClip.center;
	imgLoadingBG.alpha = 0.8;
	imgLoadingBG.layer.cornerRadius = 10;
	imgLoadingBG.backgroundColor = [UIColor blackColor];
	[self.viewUploadClip addSubview:imgLoadingBG];
    
	UILabel *lblProgress = [[UILabel alloc] initWithFrame:CGRectMake(55, 180, 200, 60)];
	lblProgress.backgroundColor = [UIColor clearColor];
	lblProgress.textAlignment = NSTextAlignmentCenter;
	lblProgress.textColor = [UIColor whiteColor];
    lblProgress.numberOfLines = 3;
    lblProgress.text = str;
    lblProgress.font = [UIFont fontWithName:FONT_GILL_SANS size:17];
	[self.viewUploadClip addSubview:lblProgress];
    
	self.progress = [[UIProgressView alloc] initWithFrame:CGRectZero];
	[self.progress setProgressViewStyle: UIProgressViewStyleBar];
    [self.progress setFrame:CGRectMake(160,170,160,10)];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        self.progress.backgroundColor = [UIColor whiteColor];
    }
    
    self.progress.center = imgLoadingBG.center;
	[self.viewUploadClip addSubview:self.progress];
    [view addSubview:self.viewUploadClip];
    
}
-(void)HideLoader
{
    if (self.viewLoader) {
        self.viewLoader.hidden = YES;
        [self.viewLoader removeFromSuperview];
    }
    if (self.viewUploadClip) {
        self.viewUploadClip.hidden = YES;
        [self.viewUploadClip removeFromSuperview];
    }
}

@end
