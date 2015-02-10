//
//  ABCDVC.m
//  PEnglish
//
//  Created by I-MAC on 12/4/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "ABCDVC.h"

@interface ABCDVC ()

@end

@implementation ABCDVC

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
    
   /* AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate setBackgroundColorForViewController:self bColor:BC];*/

    _fontName = FONT1;
     _color =BC;
    lineWidth = 2;
    _strTitle = @"ABCD";
    if (isIpad)
    {
        w = 250;
        h = 400;
    }
    
	 //[self animationForCoverImage];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self checkStringIsInUpperCase];
    [self initializeObject];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma  mark 
#pragma  mark  Other Method
#pragma  mark
-(void)initializeObject
{
    _carouselView = [[CustomCarsouselVIew   alloc]init];
    _carouselView.delegate = self;
    CGRect carouselFrame = [[SingletonClass sharedManager] carsoulFrame];
    CGRect lblFrame = [[SingletonClass sharedManager] labelFrame];
    CGRect pageImageFrame = [[SingletonClass sharedManager] pageImageFrame];
    [_carouselView initlizationObjectAndDegateFromParentView:self.view AndDelegate:self carouselFrame:carouselFrame labelFrame:lblFrame pageImageFrame:pageImageFrame];
    [self setInitialValue];
    
}
-(void)setInitialValue
{
    self.lblColor.backgroundColor = self.color;
    self.lblSize.text = [NSString stringWithFormat:@"%d",lineWidth];
    UIFont *font = [UIFont fontWithName:_fontName size:15];
    self.lblFontName.font =font;
    self.lblFontName.text  = _strTitle;
    [self drawABCDInImage];
}
-(void)drawABCDInImage
{
    
    for (UILabel *v in self.tempImage.subviews)
    {
        [v removeFromSuperview];
    }
    
    NSMutableString *finalString =  [[NSMutableString alloc]init];
    int  y = 6;
    int  fontSize = 30 ;
    CGRect frame = CGRectMake(5 , y, 470  , 40 );
    if ([[SingletonClass sharedManager]isIpad])
    {
        fontSize =80 ;
    }
    for (int i =0 ; i<7; i++)
    {
        for (int j =i*4 ; j<4*(i+1); j++)
        {
            if (j < _alphabetArray.count)
            {
                NSString *str1 = [_alphabetArray objectAtIndex:j];
                if (isIpad)
                {
                     finalString = [NSMutableString stringWithFormat:@"%@%8s",finalString,[str1 UTF8String]];
                }
                else
                {
                    finalString = [NSMutableString stringWithFormat:@"%@%6s",finalString,[str1 UTF8String]];
                }
            }
        }
        if ([[SingletonClass sharedManager]isIpad])
        {
            frame = CGRectMake(10, y, 1004,120);
        }
        CommonFile *obj = [[CommonFile alloc]init];
        UILabel *lbl = [obj configureLabelFrame:frame title:finalString tColor:BC fontSize:fontSize  fontName:_fontName];
        [self.tempImage addSubview:lbl];
        finalString = [NSMutableString stringWithFormat:@""];
        y = lbl.frame.origin.y + lbl.frame.size.height-33;
    }
}
-(UILabel*)configureLabelFrame:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor fontSize:(int)fontSize1 fontName:(NSString *)fontName
{
    UILabel *lbl = [[UILabel alloc]init];
    lbl.frame =frame;
    lbl.text = title;
    lbl.textColor =tColor;
    lbl.font = [UIFont fontWithName:fontName size:fontSize1];
    lbl.backgroundColor = CC;
    lbl.textAlignment = NSTextAlignmentCenter;
    return lbl;
}

#pragma  mark
#pragma  mark Cover Animation  Method
#pragma  mark

-(void)animationForCoverImage
{
    self.coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    self.coverImage.image = [UIImage imageNamed:COVER_IMAGE2];
    [self.view addSubview:self.coverImage];
    [self performSelector:@selector(Animation) withObject:nil afterDelay:1];
}
-(void)Animation
{
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
#pragma  mark Remove View From Memory
#pragma  mark
-(void)removeCoverImageFromMemory
{
    if (_coverImage)
    {
        [_coverImage removeFromSuperview];
        _coverImage = nil;
    }
}
-(void)removeCarsoulView
{
    for (UIView * v  in self.view.subviews)
    {
        if ([v isKindOfClass:[iCarousel class]])
        {
            [v removeFromSuperview];
        }
    }
}
#pragma  mark
#pragma  mark Custom Delegate  Method
#pragma  mark

-(void)doneButtonClickedAndFont:(NSString *)fontName lineWidth:(int)pWidth PColor:(UIColor *)color1 noOfAlpha:(int)noOfAlpha1 string:(NSString *)string
{
    isEraser = FALSE;
    if (_customView)
    {
        [_customView removeFromSuperview];
        _customView = nil;
    }
    _fontName = fontName;
    lineWidth = pWidth;
     _color  = color1;
    _strTitle = string;
    if (lineWidth == 0)  lineWidth = 2 ;
    if (_fontName == nil) _fontName = FONT1;
    if (_color == nil) _color = BLC;
    self.tempImage.image = nil;
    [self checkStringIsInUpperCase];
    [self setInitialValue];
}

#pragma  mark
#pragma  mark Other  Method
#pragma  mark
-(void)checkStringIsInUpperCase
{
    NSArray *capsAlphabetArray = [[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    NSArray *smallAlphabetArray = [[NSArray alloc]initWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z", nil];

    unichar aChar = [_strTitle characterAtIndex: 0]; //get the first character from the string.
    NSCharacterSet *upperCaseSet = [NSCharacterSet uppercaseLetterCharacterSet];
    
    if ([upperCaseSet characterIsMember: aChar]){
        NSLog(@"The character %C is upper-case.", aChar);
        _alphabetArray = capsAlphabetArray;
    }
    else
    {
        _alphabetArray = smallAlphabetArray;
        NSLog(@"The character is not  upper-case.");
    }
}


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
    if (!self.carouselView)
    {
        [self initializeObject];
    }
    [self.carouselView carsoulViewForPencilColor];
}
-(IBAction)fontClicked
{
    if (!self.carouselView)
    {
        [self initializeObject];
    }
    [self.carouselView carsoulViewForFont];
}

-(IBAction)eraserClicked
{
    lineWidth = 5;
    if (isEraser)
    {
        [self.btnEraser setImage:[UIImage imageNamed:ERASER_IMAGE] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnEraser setImage:[UIImage imageNamed:WRITTING_IMAGE] forState:UIControlStateNormal];
    }
    isEraser = !isEraser;
}

-(IBAction)resetAllClicked
{
    self.tempImage.image = nil;
    [self drawABCDInImage];
}

-(IBAction)saveButtonPressed
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate saveImage:self.view];
}
#pragma mark
#pragma mark Touch Event
#pragma mark


/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.tempImage];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
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
    if (isEraser)
    {
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
}**/

#pragma mark
#pragma mark Memory Managment Method
#pragma mark

-(void)dealloc
{
    [self nilObject:self.originalImage];
    [self nilObject:self.tempImage];
    [self nilObject:self.btnEraser];
    [self nilObject:self.lblSize];
    [self nilObject:self.lblColor];
    [self nilObject:self.lblFontName];
    [self nilObject:self.customView];
    [self nilObject:self.coverImage];
    [self nilObject:self.alphabetArray];
    [self nilObject:self.fontName];
    [self nilObject:self.strTitle];
    [self nilObject:self.fontName];    
    self.carouselView.delegate = nil;
}

-(void)nilObject:(id)object
{
    if (object)
    {
        object = nil ;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
