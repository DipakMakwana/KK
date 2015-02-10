//
//  HandWritingVC.m
//  Alphabets
//
//  Created by I-MAC on 11/27/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "HandWritingVC.h"

@interface HandWritingVC ()

@end

@implementation HandWritingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark
#pragma mark View Life Cycle
#pragma mark

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self animationForCoverImage];
  /*  AppDelegate * appDelegate  = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate setBackgroundColorForViewController:self bColor:WC];*/
    
    alphabetNO = 0;
    noOfAlpha = 1;
    _strTitle = @"A";
    fontSize = 15;
    lineWidth = 2;
    self.color = BC;
    [self checkStringIsInUpperCase];
    [self initializeObject];
    [self setInitialValue];
}
-(void)viewWillAppear:(BOOL)animated
{
   [super viewWillAppear:animated];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(void)initializeObject
{
    _carouselView = [[CustomCarsouselVIew alloc]init];
    _carouselView.delegate = self;
    CGRect carouselFrame;
    CGRect lblFrame ;
    CGRect pageImageFrame ;
    BOOL isLandscape = [[SingletonClass sharedManager] isDeviceLandscape];
    
    if (isLandscape)
    {
        carouselFrame = CGRectMake(0,60, 480 , 260);
        lblFrame = CGRectMake(80, 0, 400, 50);
        pageImageFrame = CGRectMake(0, 0, 50, 260);
    }
    else
    {
        lblFrame = CGRectMake(80, 0, 300, 50);
        pageImageFrame = CGRectMake(0, 0, 50, 260);
    }
    if (isIpad)
    {
        carouselFrame = CGRectMake(0, 80, viewW, 688);
        lblFrame = CGRectMake(150, 10, 700, 60);
        pageImageFrame = CGRectMake(0, 0, 200, 600);
    }
    [_carouselView initlizationObjectAndDegateFromParentView:self.view AndDelegate:self carouselFrame:carouselFrame labelFrame:lblFrame pageImageFrame:pageImageFrame];
}

-(void)setInitialValue
{
    self.lblColor.backgroundColor = self.color;
    self.lblNoOfFont.text  = [NSString stringWithFormat:@"%d",noOfAlpha * noOfAlpha];
    self.lblSize.text = [NSString stringWithFormat:@"%d",lineWidth];
    UIFont *font = [UIFont fontWithName:_fontName size:15];
    self.lblFontName.font =font;
    self.lblFontName.text  = @"ABCD";
    [self DrawMultipleTextOnImage:_alphabet fontName:_fontName noOfAlphabet:noOfAlpha];
}
-(void)animationForCoverImage
{
     self.coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    _coverImage.image = [UIImage imageNamed:COVER_IMAGE2];
    [self.view addSubview:_coverImage];
    [self performSelector:@selector(Animation) withObject:nil afterDelay:1];
}

#pragma  mark
#pragma  mark Remove Custom View From Memory
#pragma  mark
-(void)removeCoverImageFromMemory
{
    if (_coverImage) {
        [_coverImage removeFromSuperview];
        _coverImage = nil;
    }
}
-(void)removeCarsoulView
{
    for (UIView * v  in self.view.subviews){
        if ([v isKindOfClass:[iCarousel class]]) {
            [v removeFromSuperview];
        }
    }
}
#pragma  mark
#pragma  mark Cover Animation Method
#pragma  mark
-(void)Animation{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:_coverImage cache:YES];
    [UIView commitAnimations];
    _coverImage.image = nil;
    [self performSelector:@selector(removeCoverImageFromMemory) withObject:nil afterDelay:4];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag context:(void *)context
{
    [self.view removeFromSuperview];
}
#pragma  mark
#pragma  mark Other Method
#pragma  mark
-(void)DrawMultipleTextOnImage:(NSString*)text fontName:(NSString *)fontName noOfAlphabet:(int)noOfAlphabet
{
    for (UILabel *lbl in self.tempImage.subviews)
    {
        [lbl removeFromSuperview];
    }
    int y = -5;
    fontSize = 200;
    text = @"";
    for (int i = 0 ; i<noOfAlphabet ; i++) {
        text   = [text stringByAppendingString:[NSString stringWithFormat:@"%4s",[_alphabet UTF8String]]];
    }
    for (int i =0 ; i<noOfAlphabet; i++)
    {
        UIFont *font = [UIFont fontWithName:fontName size:fontSize];
        NSLog(@"leading %f",font.leading);
        NSLog(@"xHeight %f",font.xHeight);
        NSLog(@"pointSize %f",font.pointSize);
        NSLog(@"lineHeight %f",font.lineHeight);
        NSLog(@"ascender %f",font.ascender);
        NSLog(@"descender %f",font.descender);
        NSLog(@"capHeight %f",font.capHeight);        
        CGSize size = [text sizeWithFont:font];
        CGRect frame = CGRectMake(-100, y, size.width + 70,size.height);
        CommonFile *obj = [[CommonFile alloc]init];
        obj.parentView = self.view;
        UILabel *lbl = [obj configureLabelFrame:frame title:text tColor:BC fontSize:font.pointSize  fontName:fontName];
        [self.tempImage addSubview:lbl];
        y = y + size.height;
   }
}
/*-(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             frame:(CGRect) frame
            fontName:(NSString *)fontName
{
    UIFont *font = [UIFont fontWithName:fontName size:frame.size.width-10];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(frame.origin.x , frame.origin.y, frame.size.width, frame.size.height);
    [_color set];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys: font, NSFontAttributeName,nil];
    [text drawInRect:CGRectIntegral(rect) withAttributes:dictionary];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}*/

-(void)hideViewWithAnimation{
    [UIView beginAnimations : @"Display notif" context:nil];
    [UIView setAnimationDuration:.5];
    _customView.frame = CGRectMake(_customView.frame.origin.x,-(_customView.frame.origin.y +_customView.frame.size.height),_customView.frame.size.width,0);
    [UIView commitAnimations];
}
-(void)checkStringIsInUpperCase
{
    NSArray *capsAlphabetArray = [[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    NSArray *smallAlphabetArray = [[NSArray alloc]initWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z", nil];
    
    unichar aChar = [_strTitle characterAtIndex: 0]; //get the first character from the string.
    NSCharacterSet *upperCaseSet = [NSCharacterSet uppercaseLetterCharacterSet];
    if ([upperCaseSet characterIsMember: aChar]){
        NSLog(@"The character %C is upper-case.", aChar);
        _alphabetArray = capsAlphabetArray;
        _alphabet = @"A";
    }
    else{
        _alphabetArray = smallAlphabetArray;
        _alphabet = @"a";
        NSLog(@"The character is not  upper-case.");
    }
}

#pragma  mark 
#pragma  mark Custom  Delegate Method
#pragma  mark

-(void)doneButtonClickedAndFont:(NSString *)fontName lineWidth:(int)pWidth PColor:(UIColor *)color1 noOfAlpha:(int)noOfAlpha1 string:(NSString *)string
{
    isEraser = FALSE;
    if (_carouselView)
    {
        [_carouselView removeFromSuperview];
        _carouselView = nil;
    }
    
    noOfAlpha = noOfAlpha1;
    _fontName = fontName;
    lineWidth = pWidth;
    _color  = color1;
    _strTitle = string;
    if (lineWidth == 0)  lineWidth = 5 ;
    _fontName = FONT1;
    if (_color == nil) _color = BLC;
    if (noOfAlpha == 0)  noOfAlpha = 1 ;
    self.tempImage.image = nil;
    self.tempImage.image = [UIImage imageNamed:@"fourLine.png"];
    [self setInitialValue];
}

/*-(void)doneButtonClickedAndFont:(NSString *)fontName lineWidth:(int)pWidth PColor:(UIColor *)color1 noOfAlpha:(int)noOfAlpha1 string:(NSString *)string{
    isEraser = FALSE;
    alphabetNO = 0 ;
    if (noOfAlpha1 > 6) {
        noOfAlpha1 =  (noOfAlpha1 + 6) - 12  ;
    }
    if (_customView) {
        [_customView removeFromSuperview];
        _customView = nil;
    }
    _fontName = fontName;
    lineWidth = pWidth;
    _color  = color1;
    noOfAlpha = noOfAlpha1;
    _strTitle = string;
    if (lineWidth == 0)  lineWidth = 3 ;
    if (noOfAlpha == 0)  noOfAlpha = 1 ;
    if (_fontName == nil) _fontName = FONT_D2;
    if (_color == nil) _color = BLC;
    if (_strTitle == nil) _strTitle = @"A";
    [self checkStringIsInUpperCase];  // Check weather alphabet is caps or small
    [self setInitialValue];
    self.tempImage.image = nil;
    [self DrawMultipleTextOnImage:string fontName:_fontName noOfAlphabet:noOfAlpha];
}*/


#pragma mark
#pragma mark Action  Event
#pragma mark

-(IBAction)backButtonClicked
{
    if ([[SingletonClass sharedManager]getSystemVersion]<7)
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
-(IBAction)numberOfAlphabet
{
    if (!self.carouselView)
    {
        [self initializeObject];
    }
    [self.carouselView carsoulViewForNoOfAlphabet];
   
}
-(IBAction)pencilSizeClicked
{
    if (!self.carouselView)
    {
        [self initializeObject];
    }
    [self.carouselView carsoulViewForPencilSize];
    
}
-(IBAction)pencilColorClicked
{
    if (!self.carouselView) {
        [self initializeObject];
    }
    [self.carouselView carsoulViewForPencilColor];
    
}
-(IBAction)fontClicked:(id)sender
{
    if ([sender tag] == 0)
    {
        self.strTitle = @"A"; //Capital Letter
    }
    else
    {
        self.strTitle = @"a"; // Small Letter
    }
    [self checkStringIsInUpperCase];
    [self DrawMultipleTextOnImage:_alphabet fontName:_fontName noOfAlphabet:noOfAlpha];
}
-(IBAction)resetAllClicked
{
    self.tempImage.image = nil;
    self.tempImage.image = [UIImage imageNamed:@"fourLine.png"];
    _alphabet = [_alphabetArray objectAtIndex:alphabetNO];
}
-(IBAction)eraserClicked
{
    lineWidth = 5;
    isEraser = !isEraser;
    if (isEraser)
    {
        [self.btnEraser setImage:[UIImage imageNamed:WRITTING_IMAGE] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnEraser setImage:[UIImage imageNamed:ERASER_IMAGE] forState:UIControlStateNormal];
    }
}
-(IBAction)prevAlphabetClicked:(id)sender
{
    if (alphabetNO > 0)
    {
         alphabetNO--;
       _alphabet = [_alphabetArray objectAtIndex:alphabetNO];
        [self DrawMultipleTextOnImage:_alphabet fontName:_fontName noOfAlphabet:noOfAlpha];
    }
}
-(IBAction)nextAlphabetClicked:(id)sender
{
    if (alphabetNO < _alphabetArray.count-1)
    {
        alphabetNO++;
        _alphabet = [_alphabetArray objectAtIndex:alphabetNO];
        [self DrawMultipleTextOnImage:_alphabet fontName:_fontName noOfAlphabet:noOfAlpha];
    }
}
-(IBAction)saveButtonPressed
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate saveImage:self.view];
}
#pragma mark
#pragma mark Touch Event
#pragma mark
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.tempImage];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.tempImage];
    
    UIGraphicsBeginImageContext(self.tempImage.frame.size);
    [self.tempImage.image drawInRect:CGRectMake(0, 0, self.tempImage.frame.size.width, self.tempImage.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth );
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), _color.CGColor);

    if (isEraser) {
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeClear);
    }
    else{
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    }
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempImage setAlpha:1];
    UIGraphicsEndImageContext();    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.tempImage.frame.size);
        [self.tempImage.image drawInRect:CGRectMake(0, 0, self.tempImage.frame.size.width, self.tempImage.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);
        
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), _color.CGColor);

        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}
#pragma mark
#pragma mark Memory Managment Method
#pragma mark
-(void)dealloc
{
    [self nilObject:self.originalImage];
    [self nilObject:self.tempImage];
    [self nilObject:self.btnEraser];
    [self nilObject:self.lblNoOfFont];
    [self nilObject:self.lblSize];
    [self nilObject:self.lblColor];
    [self nilObject:self.lblFontName];
    [self nilObject:self.customView];
    [self nilObject:self.color];
    [self nilObject:self.alphabetArray];
    [self nilObject:self.fontName];
    [self nilObject:self.strTitle];
    [self nilObject:self.alphabet];
    
    self.carouselView.delegate = nil;
    
    
}
-(void)nilObject:(id)object
{
    if (object) {
        object = nil ;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
