//
//  FindMissingVC.m
//  PEnglish
//
//  Created by I-MAC on 12/11/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "FindMissingVC.h"

@interface FindMissingVC ()

@end

@implementation FindMissingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma  mark
#pragma  mark View Life Cycle
#pragma  mark

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    if ([[SingletonClass sharedManager]isIpad ])
    {
        limit = 10;
    }
     [[SingletonClass sharedManager]addKeyboardNotificationInVC:self];
     diffrence = limit ;
     //[self animationForCoverImage];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    Database * objDB = [[Database alloc]init];
    self.testArray = [[NSMutableArray alloc]init];
    
    if (self.testIndex == 1)
    {
        self.lblHeader.text = @"Find Missing Alphabet";
        self.testArray = [[NSMutableArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
        [self testForMissingAlphabet];
    }
    else if (self.testIndex == 2)
    {
        self.lblHeader.text = @"Find Missing Character";
        self.testArray =  [objDB  getWordsFromDatabase];
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,self.scrollView.frame.size.height+400);
        [self testForMissingCharacter];
    }
    else if (self.testIndex == 3 )
    {
        self.lblHeader.text = @"Find Vowels";
        NSArray * tempArray =  [objDB  getVowelsFromDatabase];
        for (int i =0 ; i < tempArray.count; i++)
        {
            NSString *str1 = [[tempArray objectAtIndex:i]valueForKey:FLD_IMAGE_1];
            NSString *str2 = [[tempArray objectAtIndex:i]valueForKey:FLD_IMAGE_2];
            [self makeProperString:str1 str2:str2];
        }
        [self testForMissingVowels];
    }
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(void )makeProperString:(NSString *)str1 str2:(NSString *)str2
{
    str1 = [[str1 stringByDeletingPathExtension] capitalizedString];
    str2 = [[str2 stringByDeletingPathExtension] capitalizedString];

    str1 = [str1 substringToIndex:[str1 length] - 2];
    str2 = [str2 substringToIndex:[str2 length] - 2];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic  setValue:str1 forKey:FLD_WORD_NAME];
    [self.testArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc]init];
    [dic  setValue:str2 forKey:FLD_WORD_NAME];
    [self.testArray addObject:dic];
}
#pragma mark
#pragma mark Keyboard Method
#pragma mark

-(void) keyboardShown:(NSNotification*) notification
{
}

-(void) keyboardHidden:(NSNotification*) notification
{
    self.scrollView.contentOffset = CGPointMake(0, 0);
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
-(void)Animation{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.coverImage cache:YES];
    [UIView commitAnimations];
    self.coverImage.image = nil;
    [self performSelector:@selector(removeCoverImageFromMemory) withObject:nil afterDelay:4];
}
-(void)removeCoverImageFromMemory
{
    if (self.coverImage)
    {
        [self.coverImage removeFromSuperview];
        self.coverImage = nil;
    }
}

#pragma  mark
#pragma  mark Other Method
#pragma  mark

-(CustomTextField *)configureTextField
{
    CustomTextField * txt = [[CustomTextField alloc]init];
    txt.delegate = self;
    txt.placeholder = @"__";
    txt.textColor = WC;
//    txt.textAlignment = NSTextAlignmentRight;
    txt.font = [UIFont fontWithName:FONT_GILL_SANS size:50];
    return txt;
}

-(void)setLabelInImage:(CGRect)frame labelTitle:(NSString *)labelTitle
{
    CommonFile *obj = [[CommonFile alloc]init];
    UILabel *lbl = [obj configureLabelFrame:CGRectMake(frame.origin.x, frame.origin.y,frame.size.width,frame.size.height) title:labelTitle tColor:BC fontSize:50  fontName:FONT_GILL_SANS];
    //lbl.backgroundColor = RC;
    lbl.textAlignment = NSTextAlignmentCenter;

    [self.scrollView addSubview:lbl];
}

-(int)setLabelInImage:(int )i labelTitle:(NSString *)labelTitle lastY:(int)y
{
    CGRect  frame = CGRectMake(40,y, viewW - 20,80);
    CommonFile *obj = [[CommonFile alloc]init];
    UILabel *lbl = [obj configureLabelFrame:CGRectMake(frame.origin.x, frame.origin.y,frame.size.width,54) title:labelTitle tColor:BC fontSize:50  fontName:FONT_GILL_SANS];
    y = lbl.frame.origin.y + lbl.frame.size.height + 30 ;
    [self.scrollView addSubview:lbl];
    return  y;
}
-(void)setTextFieldInImage:(CGRect)frame txtTag:(int)txtTag
{
    CustomTextField *txt = [self configureTextField];
    txt.superViewTag = txtTag;
    txt.textAlignment = NSTextAlignmentRight;
    txt.borderStyle = UITextBorderStyleNone;
    txt.frame = frame;
    [self.scrollView addSubview:txt];
}

-(void)removeLabelFromImage
{
    for (UILabel *lbl in self.scrollView.subviews)
    {
        [lbl removeFromSuperview];
    }
}

-(void)testForMissingCharacter
{
    [self removeLabelFromImage];
    int y = 20;
    if ([[SingletonClass sharedManager]isIpad])
    {
        y =  50 ;
    }
        for (int i = lastIndex; i<limit; i++)
        {
            if (i < self.testArray.count)
            {
                CommonFile *obj = [[CommonFile alloc]init];
                UILabel *lbl = [obj configureLabelFrame:CGRectMake(10,y,60,60) title:[NSString stringWithFormat:@"%d)",i+1] tColor:BC fontSize:40  fontName:FONT_GILL_SANS];
                [self.scrollView addSubview:lbl];
                [self seprateString:[[self.testArray objectAtIndex:i] valueForKey:FLD_WORD_NAME] x:lbl.frame.origin.x+lbl.frame.size.width y:y txtTag:i];
            }
             y = y + 60 ;
    }
}
-(void)testForMissingVowels
{
    [self removeLabelFromImage];
    
    int y = 20;
    if ([[SingletonClass sharedManager]isIpad ]) {
        y =  30 ;
    }
    
    for (int i = lastIndex; i<limit; i++)
    {
        if (i < self.testArray.count)
        {
            NSString *str = [[self.testArray objectAtIndex:i] valueForKey:FLD_WORD_NAME];
            //CGRect frame = CGRectMake(5,y, 470, 30);
            //int strLength = [str length];
            NSString * finalStr = [NSString stringWithFormat:@"%d)%@ ------",i+1,str];
           y =  [self setLabelInImage:i labelTitle:finalStr lastY:y];
        }
    }
}
-(void)testForMissingAlphabet
{
    for (UILabel * lbl  in self.scrollView.subviews)
    {
        [lbl removeFromSuperview];
    }
    NSMutableString *finalString =  [[NSMutableString alloc]init];
   
    int y = 0;
    int gap =5;
    int x = 10;
    int w = 130;
    int h = 90 ;
    
    int smallest = arc4random() % 5 ;
    CGRect  frame = CGRectMake(x,y, w, h);
    int r1 =  [self getRandomNBetween:smallest gap:gap];
    int r2 =  [self getRandomNBetween:r1  gap: gap];
    int r3 =  [self getRandomNBetween:r2  gap: gap];
    int r4 =  [self getRandomNBetween:r3  gap:gap];
    int r5 =  [self getRandomNBetween:r4  gap:gap];
    int r6 =  [self getRandomNBetween:r5  gap:gap];
    int r7 =  [self getRandomNBetween:r6  gap:gap];
    int r8 =  [self getRandomNBetween:r7  gap:gap];
    int r9 =  [self getRandomNBetween:r8  gap:gap];
    int r10 = [self getRandomNBetween:r9  gap:gap];
    
    NSString *str1;
    for (int i = 0; i<4; i++)//row
    {
        for (int j =i*7 ; j<7*(i+1); j++) // column
        {
            if (j <self.testArray.count)
            {
                if (j ==  r1  ||  j ==  r2 ||  j ==  r3 ||  j ==  r4 ||  j ==  r5 ||  j ==  r6 ||  j ==  r7 ||  j ==  r8 ||  j ==  r9 ||  j ==  r10)
                {
                    [self setTextFieldInImage:CGRectMake(x,y,w,h)txtTag:1];
                }
                else
                {
                    str1= [self.testArray objectAtIndex:j];
                    finalString = [NSMutableString stringWithFormat:@"%@%7s",finalString,[str1 UTF8String]];
                    [self setLabelInImage:CGRectMake(x,y,w,h) labelTitle:finalString];
                    finalString = [NSMutableString stringWithFormat:@""];
                }
            }
            x = x + frame.size.width+ 10;
        }
        x = 10;
        y = (i+1)*h;
    }
}

-(void)seprateString:(NSString *)string  x:(int)x y:(int)y txtTag:(int)txtTag
 {
    int gap = 2 ;
   
    int w = 60 ;
    int h = 60 ;
    int number1 = [self getRandomNBetween:0 gap:gap];
    int number2 = [self getRandomNBetween:number1 gap:gap];
    int number3 = [self getRandomNBetween:number2 gap:gap];
    int number4 = [self getRandomNBetween:number3 gap:gap];
    int number5 = [self getRandomNBetween:number4 gap:gap];
    int number6 = [self getRandomNBetween:number5 gap:gap];

    for (int i=0; i < [string length]; i++)
    {
        NSString *iChar  = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        if (i == number1 || i == number2 || i == number3 || i == number4 || i == number5 || i == number6 )
        {
            [self setTextFieldInImage:CGRectMake(x, y, w, h) txtTag:txtTag];
        }
        else
        {
            [self setLabelInImage:CGRectMake(x, y, w, h) labelTitle:iChar];
        }
        x = x + w  + 30;
    }


}

#pragma  mark
#pragma  mark Random Number Method
#pragma  mark
-(int )getRandomNBetween:(int)smallest gap:(int)gap
{
    int largest = smallest + gap ;
    int random = smallest + arc4random() % (largest+1-smallest);
    return random;
}
-(int)getReminderNumber
{
    NSDecimalNumber *dividend = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInteger:self.testArray.count] decimalValue]];
    
    NSDecimalNumber *divisor = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInteger:diffrence] decimalValue]];
    
    NSDecimalNumber *quotient = [dividend decimalNumberByDividingBy:divisor withBehavior:[NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO]];
    
    NSDecimalNumber *subtractAmount = [quotient decimalNumberByMultiplyingBy:divisor];
    
    NSDecimalNumber *remainder = [dividend decimalNumberBySubtracting:subtractAmount];
    
    int myInt = [remainder integerValue];
    
    return  myInt ;
    
}

#pragma  mark
#pragma  mark Action Method 
#pragma  mark
-(IBAction)backButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)eraserClicked
{
    /*
    
     if (isEraser) {
     [self.btnEraser setImage:[UIImage imageNamed:WRITTING_IMAGE] forState:UIControlStateNormal];
     }
     else {
     [self.btnEraser setImage:[UIImage imageNamed:ERASER_IMAGE] forState:UIControlStateNormal];
     }
     */
    
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
-(IBAction)nextButtonClicked
{
    if (self.testIndex == 1 ) {
        [self testForMissingAlphabet];
    }
    else  if (self.testIndex == 2)
    {
        if (lastIndex < self.testArray.count)
        {
            lastIndex = lastIndex + diffrence ;
            limit = lastIndex + diffrence ;
            if (limit <= self.testArray.count)
            {
                [self testForMissingCharacter];
            }
            else
            {
                limit = lastIndex + [self getReminderNumber];
                if (limit < self.testArray.count)
                {
                    [self testForMissingCharacter];
                }
            }
        }
    }
    else  if (self.testIndex == 3 ){
        
        if (lastIndex < self.testArray.count) {
            lastIndex = lastIndex + diffrence ;
            limit = lastIndex + diffrence ;
            if (limit <= self.testArray.count) {
                [self testForMissingVowels];
            }
            else
            {
                limit = lastIndex + [self getReminderNumber];
                if (limit <= self.testArray.count) {
                    [self testForMissingVowels];
                }
            }
        }
    }
    
}

-(IBAction)saveButtonPressed
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate saveImage:self.view];
}

#pragma mark
#pragma mark CustomTextField Delegate Method
#pragma mark
-(int)getReminderFromNumber:(int)dividendNO divisorBy:(int)divisorBy
{
    NSDecimalNumber *dividend = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:dividendNO] decimalValue]];
    
    NSDecimalNumber *divisor = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:divisorBy] decimalValue]];
    
    NSDecimalNumber *quotient = [dividend decimalNumberByDividingBy:divisor withBehavior:[NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO]];
    
    NSDecimalNumber *subtractAmount = [quotient decimalNumberByMultiplyingBy:divisor];
    
    NSDecimalNumber *remainder = [dividend decimalNumberBySubtracting:subtractAmount];
    
    int myInt = [remainder integerValue];
    
    return  myInt ;
    
}


- (BOOL)textFieldShouldReturn:(CustomTextField *)textField
{
    self.scrollView.contentOffset = CGPointMake(0, 0);
    CustomTextField * txt = (CustomTextField*)textField;
    [txt resignFirstResponder];
    /*if( [txt.text caseInsensitiveCompare:txt.answer] == NSOrderedSame)
        txt.backgroundColor = GC;
    else   txt.backgroundColor = RC;*/
    return  YES ;
}
-(void) textFieldDidBeginEditing:(CustomTextField *)textField
{
    CustomTextField *txt = (CustomTextField *)textField;
    if (txt.superViewTag >=5)
    {
        int diff = [ self getReminderFromNumber:txt.superViewTag divisorBy:5];
        self.scrollView.contentOffset = CGPointMake(0, 65*(diff+1));
    }
}

#pragma mark
#pragma mark Touch Event
#pragma mark

/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
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
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor blackColor].CGColor);
    
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
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor blackColor].CGColor);
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}
*/
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}


#pragma  mark
#pragma  mark Memory Managment   Method
#pragma  mark
-(void)dealloc
{
    [self nilObject:self.scrollView];
    [self nilObject:self.coverImage];
    [self nilObject:self.btnEraser];
    [self nilObject:self.lblHeader];
    [self nilObject:self.testArray];
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
