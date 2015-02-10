//
//  TestDetailVC.m
//  PEnglish
//
//  Created by I-MAC on 1/1/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import "TestDetailVC.h"

@interface TestDetailVC ()

@end

@implementation TestDetailVC
//#define ACCEPTABLE_CHARECTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."
#define ACCEPTABLE_CHARECTERS @"0123456789 ,<>=-"
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma  mark
#pragma  mark  View Life Cycle
#pragma  mark
- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate setBackgroundColorForViewController:self bColor:WC];
    
    if(isIpad)
        self.scrollView.contentSize  =  CGSizeMake(self.scrollView.frame.size.width,self.scrollView.frame.size.height + 450);
    else
        self.scrollView.contentSize  =  CGSizeMake(self.scrollView.frame.size.width,self.scrollView.frame.size.height + 200);
    Database * objDB = [[Database alloc]init];
    self.imageArray = [[NSMutableArray alloc]init];
    self.imageArray = [objDB getImagesforAlphabet];
    [self setHeaderButtonTitle];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(void)setHeaderButtonTitle
{
    if (self.testNumber == Count_TT)
        self.buttonTitle = @"Count Object";
    else if (self.testNumber == Match_TT)
        self.buttonTitle = @"Match Pair";
    else if (self.testNumber == Prefix_TT)
        self.buttonTitle = @"Missing Number";
    else if (self.testNumber == Addition_TT)
        self.buttonTitle = @"Additon";
    else if (self.testNumber == Subtraction_TT)
        self.buttonTitle = @"Subtraction";
    else if (self.testNumber == Ascending_TT)
        self.buttonTitle = @"Ascending";
    else if (self.testNumber == Descending_TT)
        self.buttonTitle = @"Descending";
    else if (self.testNumber == Smaller_TT)
        self.buttonTitle = @"Smaller OR Greater";

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"Button  = %@ ",self.buttonTitle);
    
    [self removeSubViewsFromView];
   
    if (self.testNumber == Count_TT ) { // Count Object
        [self setHiddenFlagForControlisScrollHidden:NO isResetHidden:YES isImageHidden:YES];
        [self joinNumbers];
    }
    else if (self.testNumber == Match_TT ){ // Match Pair
        [self setHiddenFlagForControlisScrollHidden:YES isResetHidden:NO isImageHidden:NO];
        self.numberArray = [[NSMutableArray alloc]init];
        [self MatchPair];
    }
    else if (self.testNumber == Prefix_TT ){ // Missing or Prefix Number
        [self setHiddenFlagForControlisScrollHidden:NO isResetHidden:YES isImageHidden:YES];
        [self setRandomLabelForPrefixNumber];
    }
    else if (self.testNumber == Addition_TT ){ // Additiion
         [self setHiddenFlagForControlisScrollHidden:NO isResetHidden:YES isImageHidden:YES];
        sign = @"+";
        [self additionSubtractionNumber];
    }
    else if (self.testNumber == Subtraction_TT ){ // Subtration
        [self setHiddenFlagForControlisScrollHidden:NO isResetHidden:YES isImageHidden:YES];
        sign = @"-";
        [self additionSubtractionNumber];
    }
    else if (self.testNumber == Ascending_TT ){ // Assending
        [self setHiddenFlagForControlisScrollHidden:NO isResetHidden:YES isImageHidden:YES];
        isAscending = YES;
        [self AssendingDesendingOrder:@"Arranged from smallest to largest"];
    }
    else if (self.testNumber == Descending_TT ){ // Assending / Desending
        [self setHiddenFlagForControlisScrollHidden:NO isResetHidden:YES isImageHidden:YES];
        isAscending = NO;
        [self AssendingDesendingOrder:@"Arranged from largest to smallest"];
    }
    else if (self.testNumber == Smaller_TT ){ //smaller or Greater
        [self setHiddenFlagForControlisScrollHidden:NO isResetHidden:YES isImageHidden:YES];
        [self smallerOrGreterNumber];
    }
    self.scrollView.backgroundColor = DGC ;
    [self.btnHeader setTitle:self.buttonTitle forState:UIControlStateNormal];
}
-(void)setHiddenFlagForControlisScrollHidden:(BOOL)scrollInterction isResetHidden:(BOOL)isResetHidden isImageHidden:(BOOL)isImageHidden
{
    self.scrollView.hidden = scrollInterction ;
    self.btnEraser.hidden   = isResetHidden;
    self.myImageView.hidden= isImageHidden;
}
#pragma  mark
#pragma  mark  Other Method
#pragma  mark

-(void)removeSubViewsFromView
{
    
    for (UIView * v  in self.scrollView.subviews) {
        [v removeFromSuperview];
    }
//    for (UIView * v  in self.myImageView.subviews) {
//        [v removeFromSuperview];
//    }
//    if (self.myImageView) {
//        [self.myImageView removeFromSuperview];
//        self.myImageView = nil ;
//    }
}


-(UILabel *)configLabelFrame:(CGRect)frame
{
    int fontSize = 15 ;
    if (isIpad) {
        fontSize = 30 ;
    }
    UILabel *lbl = [[UILabel alloc]initWithFrame:frame];
    lbl.textAlignment   = NSTextAlignmentCenter ;
    lbl.font = [UIFont fontWithName:FONT_GILL_SANS size:fontSize];
    lbl.layer.borderWidth = 1;
    lbl.layer.borderColor = WC.CGColor;
    return lbl;
}

#pragma  mark
#pragma  mark Smaller  / Greater    Number
#pragma  mark

-(void)smallerOrGreterNumber
{
    int oriX = 10 ;
    int lblH = 25 ;
    int lblW = 30 ;
    int limit = 18 ;
    int gap = 10 ;
    int txtTag = 0 ;
    int rowNo = 3 ;
    if (isIpad) {
        lblH = 50 ;
        lblW = 50 ;
        limit  = 36;
        gap = 20 ;
        oriX = 50;
        rowNo = 4 ;
    }
     UILabel *lbl = [self configureLabel:CGRectMake(0, 0, viewW, lblH) view:self.scrollView labelText:@"Use '<','>' and '=' symbol in proper place."];
     lbl.backgroundColor = BC;
     int X= oriX;
     int Y = lbl.frame.origin.y + lbl.frame.size.height + gap ;
    
    for (int i = 0 ; i<limit; i++) {
       
        int n1 = arc4random() % 50;
        int n2 = arc4random() % 50;
        
        UILabel *lbl1 = [self configureLabel:CGRectMake(X, Y , lblW, lblH) view:self.scrollView labelText:[NSString stringWithFormat:@"%d",n1]];
        lbl1.backgroundColor = BC;
    
        CustomTextField * txt = [self configureTextField];
        txt.frame = CGRectMake(X + lblW + gap , lbl1.frame.origin.y, lblW,lblH);
        if (n1 == n2 ) {
            txt.answer = @"=";
        }
        else if (n1  < n2 )
            txt.answer = @"<" ;
        else
            txt.answer =  @">";
        
        if (i%rowNo==0) {
            txtTag ++;
        }
        txt.superViewTag = txtTag ;
        [self.scrollView addSubview:txt];
        
        UILabel *lbl2 = [self configureLabel:CGRectMake(txt.frame.origin.x + txt.frame.size.width + gap,lbl1.frame.origin.y,lbl1.frame.size.width ,lbl1.frame.size.height) view:self.scrollView labelText:[NSString stringWithFormat:@"%d",n2]];
        lbl2.backgroundColor = BC;
        X = lbl2.frame.origin.x + lbl2.frame.size.width + 50 ;
        
        NSLog(@"txtTag %d",txtTag);
       
        if (X >= self.scrollView.frame.size.width - 100) {
            X= oriX ;
            Y = Y + lbl2.frame.size.height + gap  ;
        }
    }
}

#pragma  mark
#pragma  mark Assending / Desending Number
#pragma  mark

/*-(void)changeOrderClicked:(id)sender
{
    self.btnHeader.selected = !self.btnHeader.selected;
    if (isAscending)
    {
        self.buttonTitle = @"Descending";
        [self AssendingDesendingOrder:@"Arrange from largest to smallest"];
    }
    else
    {
         self.buttonTitle = @"Ascending";
        [self AssendingDesendingOrder:@"Arrange from smallest to largest"];
    }
     [self.btnHeader setTitle:self.buttonTitle forState:UIControlStateNormal];
}*/


-(void)AssendingDesendingOrder:(NSString*)labelText
{
    [self removeSubViewsFromView];
   
    int oriX = 150 ;
    int y = 100 ;
    int lblH = 50 ;
    int lblW =300 ;
    int limit = 9 ;
    int gapX = 100 ;
    
    int x  = oriX;
    CGRect frame = CGRectMake(0, 0, viewW, lblH);
    UILabel * lbl = [self configureLabel:frame view:self.scrollView labelText:labelText];
    lbl.backgroundColor = BC ;
    y = lbl.frame.origin.y + lbl.frame.size.height + 10;
    for (int j = 0 ; j < limit; j++) {
          NSMutableArray *numberArray = [NSMutableArray array];
          NSString * finalString = @"";
          NSString * answer = @"";
          for (int i =0 ; i < 5; i++) {
             int number = 0  + arc4random()  % + 20;
             BOOL isAdded =  [self checkNumberIsInArray:numberArray number:number];
            if (isAdded) {
                i--;
            }
            else{
                 finalString = [finalString stringByAppendingString:[NSString stringWithFormat:@"%d,",number]];
                    [numberArray  addObject:[NSString stringWithFormat:@"%d",number]];
                if (numberArray.count >=5) {
                  answer = [self sortNumberAndReturnAnswer:numberArray];
                    NSLog(@"%@",answer);
                    break ;
                }
            }
        }
        finalString = [finalString substringToIndex:[finalString length] - 1];
        UILabel *lbl1 = [self  configureLabel:CGRectMake(x,y,lblW, lblH) view:self.scrollView labelText:finalString];
        
        lbl1.layer.borderColor = WC.CGColor ;
        lbl1.layer.borderWidth = 1 ;
        
        CustomTextField * txt = [self configureTextField];
         txt.frame = CGRectMake(x  + lblW + gapX , y, lbl1.frame.size.width, lbl1.frame.size.height);
            txt.answer = answer ;
            txt.superViewTag = txt.frame.origin.y + txt.frame.size.height;
            [self.scrollView addSubview:txt];
            x = x +  txt.frame.size.width ;
            x = oriX;
        y = y + lbl1.frame.size.height + 20;
    }
}
-(NSString *)sortNumberAndReturnAnswer:(NSMutableArray *)numberArray
{
    NSString * answer = @"";
    NSArray *sortedArray = [numberArray sortedArrayUsingComparator:^(NSString *str1, NSString *str2) {
        return [str1  compare:str2  options:NSNumericSearch];
    }];
    if (isAscending)
    {
        NSLog(@"Ascending");
        for (int i = 0; i<sortedArray.count; i++) {
            answer = [answer stringByAppendingString:[NSString stringWithFormat:@"%@,",[sortedArray objectAtIndex:i]]];
        }
    }
    else
    {
        NSLog(@"Decending");
        for (int i = sortedArray.count-1; i>=0; i--) {
            answer = [answer stringByAppendingString:[NSString stringWithFormat:@"%@,",[sortedArray objectAtIndex:i]]];
        }
    }
    answer =[answer substringToIndex:[answer length]-1];
    return answer;
}

-(int )getRandomNBetween:(int)smallest gap:(int)gap
{
    int largest = smallest + gap ;
    int random = smallest + arc4random() % (largest+1-smallest);
    return random;
}
#pragma  mark
#pragma  mark  Prefix / Postfix Or Missing  Number
#pragma  mark

-(void)setRandomLabelForPrefixNumber
{
    int y = 5;
    int w = 25;
    int h = 20;
    int oriX = 60;
    
    if (isIpad)
    {
        oriX = 60;
        y = 70 ;
        w = 80;
        h = 50 ;
    }
    
    int x = oriX;
    
    for (int  i = 1; i <= 100 ; i++)
    {
        int  gap = 2 ;
        int number1 = [self getRandomNBetween:i gap:gap];
        int number2 = [self getRandomNBetween:number1 gap:gap];
        int number3 = [self getRandomNBetween:number2 gap:gap];
        int number4 = [self getRandomNBetween:number3 gap:gap];
        int number5 = [self getRandomNBetween:number4 gap:gap];
        int number6 = [self getRandomNBetween:number5 gap:gap];
        
        UILabel *lbl = [self configLabelFrame:CGRectMake(x, y, w, h)];
        x = lbl.frame.origin.x + lbl.frame.size.width + 10 ;
        
        if (i %10 ==0)
        {
            x= oriX ;
            y = y + h + 4;
        }
        if (i == number1 || i == number2 || i == number3 || i == number4 || i == number5 || i == number6 )
        {
            CustomTextField *txt = [[CustomTextField alloc]init];
            txt.frame = lbl.frame;
            txt.text = @" ";
            txt.layer.borderWidth = 1 ;
            txt.layer.borderColor = [UIColor whiteColor].CGColor;
            txt.keyboardType = UIKeyboardTypeDecimalPad;
            txt.textColor = [UIColor whiteColor];
            txt.font = [UIFont fontWithName:@"Helvetica" size:25];
            txt.superViewTag = i/10;
            txt.inputAccessoryView = [self addDoneButtonInToolbar];
            txt.delegate = self;
            [self.scrollView addSubview:txt];
        }
        else
        {
            lbl.text = [NSString stringWithFormat:@"%d",i];
            [self.scrollView addSubview:lbl];
        }
        
    }
   // [self.scrollView addSubview:self.myImageView];
}
#pragma  mark
#pragma  mark  Addition / Subtraction Number
#pragma  mark
/*
 -(void)signChanged:(id)sender
{
    if (self.btnHeader.isSelected)
        self.buttonTitle = @"Addition";
    else
         self.buttonTitle = @"Subtraction";
    
    [self.btnHeader setTitle:self.buttonTitle forState:UIControlStateNormal];
    self.btnHeader.selected = !self.btnHeader.selected;
   // NSLog(@"Button  = %@ ",self.buttonTitle);

    [self additionSubtractionNumber];
}
 */
-(void)additionSubtractionNumber
{
    int txtTag  = 1 ;
   // [self.btnHeader addTarget:self action:@selector(signChanged:) forControlEvents:UIControlEventTouchUpInside];

    int mainY = 20 ;
    int mainW = 50 ;
    int mainH = 80 ;
    int limit = 12 ;
    int oriX = 10 ;
    
    if (isIpad)
    {
        mainW = 100 ;
        mainH = 135 ;
        oriX = 30;
        limit = 32 ;
    }
        int mainX = oriX ;
    for (int i = 0 ; i <limit; i++) {
        
       
        int n1 = 0 + arc4random() % + 15 ;
        int n2 = 0 + arc4random() % + 15;
        if ([sign isEqualToString:@"-"])// Subtraction
        {
            n1 = 10 + arc4random() % + 15 ;
            n2 = 0 + arc4random() % + 15;
        }
        CGRect frame ;
        UIView * view = [[UIView alloc]init];
        view.frame = CGRectMake(mainX, mainY, mainW, mainH);
        view.backgroundColor = BC ;
        int X = 10;
        int Y = 5 ;
        int W = 30;
        int H = 17;
        if (isIpad)
        {
            Y = 10 ;
            W = 60 ;
            H = 30 ;
        }
        frame = CGRectMake(X, Y, W, H);
        UILabel * lbl1 = [self configureLabel:frame view:view labelText:[NSString stringWithFormat:@"%d",n1]];
        Y = lbl1.frame.origin.y + lbl1.frame.size.height;
        frame = CGRectMake(X-10, Y, W, H);
        
        UILabel * lblSign = [self configureLabel:frame view:view labelText:sign];
        
        Y = lblSign.frame.origin.y + lblSign.frame.size.height;
         frame = CGRectMake(X, Y, W, H);
            UILabel * lbl3 = [self configureLabel:frame view:view labelText:[NSString stringWithFormat:@"%d",n2]];
        Y = lbl3.frame.origin.y + lbl3.frame.size.height;
            UILabel * lblLine = [[UILabel alloc]init];
            lblLine.frame = CGRectMake(0, Y, view.frame.size.width, 1);
            lblLine.backgroundColor = WC ;
            [view addSubview:lblLine];
        
        Y = lblLine.frame.origin.y + lblLine.frame.size.height + 3  ;
        CustomTextField * txt = [self configureTextField];
        txt.superViewTag = txtTag;
        txt.frame = CGRectMake(0 , Y ,view.frame.size.width,30);
        if ([sign isEqualToString:@"+"])
            txt.answer =[NSString stringWithFormat:@"%d",n1+n2];
        else
             txt.answer =[NSString stringWithFormat:@"%d",n1-n2];
        [view addSubview:txt];
        mainX = mainX + mainW + 20 ;
        
        if (mainX >= self.scrollView.frame.size.width - mainW)
        {
            mainX = oriX;
            mainY = mainY + mainH + 40;
            txtTag ++;
        }
        [self.scrollView addSubview:view];
     }
}

-(UILabel *)configureLabel:(CGRect)frame view:(UIView *)view labelText:(NSString *)labelText
{
    int fontSize = 17 ;
    if (isIpad)
    {
        fontSize = 25 ;
    }
    UILabel * lbl = [[UILabel alloc]init];
    lbl.frame = frame;
    lbl.text = labelText;
    lbl.font = [UIFont fontWithName:FONT_GILL_SANS size:fontSize];
    lbl.textColor = WC ;
    lbl.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lbl];
    
    return  lbl ;
}
#pragma  mark
#pragma  mark  Match Pair
#pragma  mark

-(void)MatchPair
{
    self.buttonTitle = @"Match Pair";
    for (UIView * v  in self.myImageView.subviews)
    {
        [v removeFromSuperview];
    }
    int mainX = 30;
    int mainY = mainX;
    int mainW = 200;
    int mainH = 200;
    int limit = 4 ;
    int gap   = 40 ;
    
    for (int main  = 0; main <limit; main ++)
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(mainX, mainY, mainW, mainH)];
        view.backgroundColor = BC ;
        int y = 2;
        int w=  40;
        int h = 45;
        int oriX = 10;
        int x = oriX;
        int random = 0 ;
        if (self.imageArray.count > 10)
        {
            random  = 1 + arc4random() % 10;
        }
        [self.numberArray addObject:[NSNumber numberWithInteger:random]];
        int randomImage = arc4random() % self.imageArray.count;
        NSString * imagename = [[self.imageArray objectAtIndex:randomImage] valueForKey:FLD_IMAGE_1];
        for (int  i = 0; i < random ; i++)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
            imageView.contentMode = UIViewContentModeScaleAspectFit ;
            imageView.layer.borderColor = WC.CGColor ;
            imageView.layer.borderWidth = .5;
            x = x + w ;
            if (x >view.frame.size.width- w)
            {
                x = oriX;
                y = y + h ;
            }
            imageView.image = [UIImage imageNamed:imagename];
            [view addSubview:imageView];
        }
        mainX = mainX + mainW + gap;
        [self.myImageView addSubview:view];
    }
    [self setRandomLabel];
}
-(void)setRandomLabel
{
    [self exchangeIndexValue];
    int x = 10;
    int h = 70;
    int w = 105;
    int gap = 10 ;
    if (isIpad) {
        w = 200 ;
        h = 150 ;
        gap = 40 ;
        x = 30 ;
    }
     int y = viewH - 2*h;
    for (int  i = 0; i < self.numberArray.count ; i++) {
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
        int randomNumber = [[self.numberArray objectAtIndex:i] integerValue];
        lbl.textAlignment   = NSTextAlignmentCenter ;
        lbl.font = [UIFont fontWithName:FONT_GILL_SANS size:h-20];
        lbl.layer.borderWidth = 1;
        lbl.backgroundColor = WC ;
        lbl.text = [NSString stringWithFormat:@"%d",randomNumber];
        x = lbl.frame.origin.x + lbl.frame.size.width + gap;
        [self.myImageView addSubview:lbl];
    }
}
-(void )exchangeIndexValue
{
    int n1 = 0 + arc4random() % + 1 ;
    int n2 = 1+ arc4random() % + 3 ;
    int n3 = (self.numberArray.count-1) - n1 ;
    int n4 = self.numberArray.count - n2;
    
    int randomExchange = arc4random() + 10 ;
    if (randomExchange %2 == 0)
    {
        [self.numberArray exchangeObjectAtIndex:n1 withObjectAtIndex:n3];
        [self.numberArray exchangeObjectAtIndex:n2 withObjectAtIndex:n4];
    }
    else{
        [self.numberArray exchangeObjectAtIndex:n1 withObjectAtIndex:n4];
        [self.numberArray exchangeObjectAtIndex:n3 withObjectAtIndex:n2];
    }
    
    //[self.numberArray exchangeObjectAtIndex:n1 withObjectAtIndex:n4];
   // [self.numberArray exchangeObjectAtIndex:n2 withObjectAtIndex:n3];
}
-(BOOL)checkNumberIsInArray:(NSMutableArray *)tempArray number:(int)number
{
    BOOL isAdded = FALSE;
    for (int j = 0 ; j < tempArray.count; j++) {
        
        int temp = [[tempArray objectAtIndex:j] integerValue];
        
        if (temp == number) {
            isAdded = YES;
            break ;
        }
        else
        {
            isAdded = NO;
        }
    }
    return  isAdded;
}
#pragma  mark
#pragma  mark  Count the Object
#pragma  mark

-(void)joinNumbers
{
    self.buttonTitle = @"Count Object";
    
    int mainY = 5;
    int mainW = 136;
    int mainH = 77;
    int limit = 9 ;
    int originalX = 5 ;
    if (isIpad)
    {
        originalX  = 55 ;
        mainW = 220;
        mainH = 150 ;
        limit = 16 ;
    }
    int mainX = originalX;
    for (int main = 0; main <limit; main ++ )
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(mainX, mainY, mainW, mainH)];
        view.backgroundColor = BC;
        int imageX = 5;
        int y = 10;
        int w=  40;
        int h = 45;
        
        int x = imageX;
        int random = 1 + arc4random() % 10 ;
        int randomImage = arc4random() % self.imageArray.count;
        NSString * imagename = [[self.imageArray objectAtIndex:randomImage] valueForKey:FLD_IMAGE_1];
        
        for (int  i = 0; i < random ; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
            imageView.contentMode = UIViewContentModeScaleAspectFit ;
            //imageView.layer.borderWidth = .5;
            x = x + w +.5 ;
            if (x >view.frame.size.width- w)
            {
                x = imageX ;
                y = y + h;
            }
            imageView.image = [UIImage imageNamed:imagename];
            [view addSubview:imageView];
        }
        mainX = mainX + mainW + 10  ;
        if (mainX >= self.scrollView.frame.size.width - mainW) {
            mainX = originalX ;
            mainY = mainY + mainH + 10 ;
        }
        CustomTextField * txt = [self configureTextField];
        if (isIpad)
        {
             txt.frame = CGRectMake((view.frame.size.width)/2-30/2 , view.frame.size.height - 30 ,60, 30);
        }
        else
        {
             txt.frame = CGRectMake((view.frame.size.width)/2-30/2 , view.frame.size.height - 20 ,30, 20);
        }
        txt.ansValue = random;
        txt.tag = main;
        [view addSubview:txt];
        [self.scrollView addSubview:view];
    }
}
-(UIToolbar *)addDoneButtonInToolbar
{
    UIToolbar* toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonClicked)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked)];
    toolbar.items = [NSArray arrayWithObjects:cancel,space,done, nil];
    [toolbar sizeToFit];
    return toolbar;
}

#pragma mark
#pragma mark Bar Item Button Method
#pragma mark

-(void)cancelButtonClicked
{
    [self resignTextField];
}
-(void)doneButtonClicked
{
    NSLog(@"answer = %@ ",self.myTextField.answer);
     NSLog(@"%@ ",self.myTextField.text);
    NSString * str = [self.myTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (self.testNumber == Count_TT)
    {
        if (self.myTextField.ansValue == [str integerValue])
            self.myTextField.backgroundColor = GC ;
        else
            self.myTextField.backgroundColor = RC ;
    }
    else if (self.testNumber == Addition_TT)
    {
        if ([self.myTextField.answer isEqualToString:str])
            self.myTextField.backgroundColor = GC ;
        else
             self.myTextField.backgroundColor = RC ;
    }
    else if (self.testNumber == Ascending_TT) {
        if ([self.myTextField.answer isEqualToString:str])
            self.myTextField.backgroundColor = GC ;
        else
            self.myTextField.backgroundColor = RC ;
    }
    else if (self.testNumber == Smaller_TT)
    {
        if ([self.myTextField.answer isEqualToString:str])
            self.myTextField.backgroundColor = GC ;
        else
            self.myTextField.backgroundColor = RC ;
    }
    [self resignTextField];
}
-(void)resignTextField
{
    [self.myTextField resignFirstResponder];
    self.scrollView.contentOffset = CGPointMake(0,0);
}

#pragma  mark
#pragma  mark UITextField Method
#pragma  mark

-(CustomTextField *)configureTextField
{
    CustomTextField * txt = [[CustomTextField alloc]init];
    txt.borderStyle = UITextBorderStyleRoundedRect;
    txt.font = [UIFont fontWithName:FONT_GILL_SANS size:20];
    txt.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    txt.textAlignment = NSTextAlignmentCenter;
    txt.inputAccessoryView = [self addDoneButtonInToolbar];
    txt.delegate = self ;
    return txt;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.scrollView.contentOffset = CGPointMake(0, 0);
    [textField resignFirstResponder];
    [self doneButtonClicked];
    return  YES ;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CustomTextField * txt = (CustomTextField *)textField ;
    if (self.myTextField)
    {
        self.myTextField = nil ;
    }
    self.myTextField = txt;
    NSLog(@"Super tag = %d",[txt superViewTag]);
    
    int txtRow = txt.superViewTag ;
    int contentOffY = 0 ;
    if (self.testNumber == Count_TT){ // Count the Object
        
        if (isIpad) {
            if (txt.tag < 4)        txtRow = 0 ;
            else if (txt.tag < 8)   txtRow = 1 ;
            else if (txt.tag < 12)  txtRow = 2 ;
            else if (txt.tag < 16)  txtRow = 4 ;
        }
        else{
            if (textField.tag < 3) txtRow = 0;      // For 0,1,2
            else  if (txt.tag < 6) txtRow = 1;      // For 3 ,4,5
            else  if (txt.tag < 9) txtRow = 2;      // For 6 ,7,8
        }
         contentOffY = 90 ;
    }
    else if (self.testNumber == Addition_TT) {
        
        if (isIpad) {
            if (txt.superViewTag <= 2) contentOffY = 35 ;
            else   if (txt.superViewTag == 3) contentOffY = 70;
            else   if (txt.superViewTag == 4) contentOffY = 95;
           
        }else
        {
            contentOffY = 35 ;
        }
        
    }
    else if (self.testNumber == Ascending_TT) { // Assending / Desending
            txtRow =  1  ;
            contentOffY = txt.superViewTag - textField.frame.size.height;
    }
    else if (self.testNumber == Smaller_TT ) { // smaller / Greter Number
        
        if (isIpad) {
            contentOffY = txt.frame.size.height;
        }
        else{
            contentOffY = txt.frame.size.height + 7;
        }
    }
    else if (self.testNumber == Prefix_TT ) { // Missing Number
        
        if (txtRow>3)
        {
            contentOffY = txt.frame.size.height;
        }
        
    }
    self.scrollView.contentOffset = CGPointMake(0,txtRow*contentOffY);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}
#pragma  mark
#pragma  mark Action Method
#pragma  mark
-(IBAction)backButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)refreshButtonClicked
{
    self.myImageView.image = nil;
     [self.myImageView eraserButtonClicked:NO];
     NSLog(@"Button  = %@ ",self.buttonTitle);
    [self viewWillAppear:YES];
}

-(IBAction)saveButtonClicked
{
    AppDelegate *appDelegate = (AppDelegate * )[[UIApplication sharedApplication]delegate];
    [appDelegate saveImage:self.view];
}
-(IBAction)eraserClicked
{    
    lineWidth = 5;
    [self.myImageView eraserButtonClicked:YES];
}
#pragma mark
#pragma mark Touch Method 
#pragma mark

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    color = WC ;
    lineWidth = 2 ;
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.myImageView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.myImageView];
    
    UIGraphicsBeginImageContext(self.myImageView.frame.size);
    [self.myImageView.image drawInRect:CGRectMake(0, 0, self.myImageView.frame.size.width, self.myImageView.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor);
    if (isEraser) {
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeClear);
    }
    else{
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    }
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.myImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.myImageView  setAlpha:1];
    UIGraphicsEndImageContext();
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.myImageView.frame.size);
        [self.myImageView.image drawInRect:CGRectMake(0, 0, self.myImageView.frame.size.width, self.myImageView.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);
        
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor);
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.myImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    
}
*/
#pragma mark
#pragma mark Memory Managment Method
#pragma mark

-(void)dealloc
{
    [self nilObject:self.imageArray];
    [self nilObject:self.numberArray];
    [self nilObject:self.btnHeader];
    [self nilObject:self.scrollView];
    [self nilObject:self.myTextField];
    [self nilObject:self.myImageView];
}
-(void)nilObject:(id)object
{
    if (object) {
        object = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
