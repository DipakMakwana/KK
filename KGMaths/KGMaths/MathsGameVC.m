//
//  MathsGameVC.m
//  PEnglish
//
//  Created by I-MAC on 1/31/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import "MathsGameVC.h"

@interface MathsGameVC ()

@end

@implementation MathsGameVC

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

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
     score = 0 ;
    ballonCount = 50;
    
    self.timeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateScore:) userInfo:Nil repeats:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (ballonCount > 0)
    {
        [self initlizeVariableWithDefaultValue];
        [self setGameObjects];
        [self setButtonInBothSide];
        limitY  = -(self.ballonImage.frame.size.height+150);
        [self ballonAnimation];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self timerInvalidate:self.ballonTimer];
}
-(void)initlizeVariableWithDefaultValue
{
    result = NO;
    attempCount = 0;
    ballonGap = 10;
    self.lblRemain.text = @"Remaining : " ;
}
-(void)updateScore:(NSTimer*)timer
{
    time++;
    self.lblTime.text = [NSString stringWithFormat:@"Time: %d ",time];
}
-(void)removeSubviewFromView:(UIView *)view
{
    for (UIView *v in view.subviews)
    {
        [v removeFromSuperview];
    }
}
-(void)setGameObjects
{
    int x ,y,fontSize,w ,h;
    [self removeSubviewFromView:self.ballonImage];
    x = 0 ; y = 100 ;fontSize = 20 ; w = 100 ; h = 100 ;
    if (isIpad)
    {
        y = 250 ;
        fontSize = 40 ;
        w = 200 ; h = 200 ;
    }
    x = viewW / 2 - w/2 ;
    int randomNumer1 = arc4random() % 10 ;
    int randomNumer2 = arc4random() % 10 ;
    ranAnsInBtn =  arc4random()%10;

    NSString *sign = @"+";
    if (ballonCount%2 == 0)
    {
        sign = @"-";
        ansValue = randomNumer1 - randomNumer2 ;
    }
    else
    {
         ansValue = randomNumer1 + randomNumer2 ;
    }
    NSString *finalString = [NSString stringWithFormat:@"%d%4s%4d",randomNumer1,[sign UTF8String],randomNumer2];
   
    UILabel * lbl = [self configureLabelFrame:CGRectMake(30,100,self.ballonImage.frame.size.width -10,fontSize+10) title:finalString tColor:BC fontSize:fontSize  fontName:FONT_GILL_SANS];
    [self.ballonImage addSubview:lbl];
}
-(void)setButtonInBothSide
{
    self.lblRemain.text = [NSString stringWithFormat:@"Remaining: %d",ballonCount];
    ballonCount--;
    [self removeSubviewFromView:self.mainImage];
    
    int x = 10;
    int oriY=100;
    int y = oriY;
    int w = 100;
    int h = 40;
   
    NSString  *imageName = @"arrow.png";
    
  /* [self setRandomValueInButton:self.btn1];
    [self setRandomValueInButton:self.btn2];
    [self setRandomValueInButton:self.btn3];
    [self setRandomValueInButton:self.btn4];
    [self setRandomValueInButton:self.btn5];
    [self setRandomValueInButton:self.btn6];
    [self setRandomValueInButton:self.btn7];
    [self setRandomValueInButton:self.btn8];
    [self setRandomValueInButton:self.btn9];
    [self setRandomValueInButton:self.btn10];*/
    NSString *str = @"";
    
    for (int i = 0 ; i<10; i++)
    {
        if (i == ranAnsInBtn)
        {
            str = [NSString stringWithFormat:@"%d",ansValue];
        }
        else
        {
            str = [NSString stringWithFormat:@"%d",arc4random() % 20];
        }
    
        CustomButton *btn = [self ConfigureButton:CGRectMake(x, y, w, h) tag:i type:0 title:str tColor:RC bColor:CC imageName:imageName  methodName:@selector(arrawButtonClicked:)];
        [self.mainImage addSubview:btn];
    
        if (i==4)
        {
            imageName = @"arrow_Right.png";
            y = oriY;
            x = viewW - (btn.frame.size.width+10);
        }
        else
        {
            y = y + h + 80;
        }
    }
}
-(void)setRandomValueInButton:(CustomButton *)btn
{
    NSString *str = @"";

    if ([btn tag] == ranAnsInBtn)
    {
      str = [NSString stringWithFormat:@"%d",ansValue];
    }
    else
    {
        str = [NSString stringWithFormat:@"%d",arc4random() % 20];
    }
    [btn setTitle:str forState:UIControlStateNormal];
}
-(IBAction)arrawButtonClicked:(id)sender
{
     attempCount ++;
      CustomButton * btn = (CustomButton *)sender;
    if (ansValue == [[btn currentTitle] integerValue])
    {
        result = YES ;
        score ++;
        self.lblScore.text = [NSString stringWithFormat:@"Score: %d/50",score];
        limitY = - self.ballonImage.frame.size.height;
    }
    if ([sender tag] >= 5) fromRight = TRUE ;
    else fromRight = FALSE;
    NSMutableDictionary * userInfo = [[NSMutableDictionary alloc]init];
    [userInfo setObject:btn forKey:@"view"];
    NSTimer *timer =  [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(arrowAnimation:) userInfo:userInfo repeats:YES];
    NSLog(@"%@",[timer class]);
}

#pragma mark
#pragma mark Animation Method
#pragma mark
-(void)ballonAnimation
{
    self.ballonImage.frame = CGRectMake(self.ballonImage.frame.origin.x,900, self.ballonImage.frame.size.width,self.ballonImage.frame.size.height);
    self.ballonTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(ballonFyingAnimation:) userInfo:nil repeats:YES];
    
}
-(void)arrowAnimation:(NSTimer *)timer
{
    int  arrowGap = 50;
    CustomButton * btn = [[timer userInfo] valueForKey:@"view"];
    BOOL arrowTrash = FALSE;
    [UIView beginAnimations : @"Display notif" context:nil];
    [UIView setAnimationDuration:.5];
    if (fromRight)
    {
        btn.frame = CGRectMake(btn.frame.origin.x - arrowGap,btn.frame.origin.y,btn.frame.size.width,btn.frame.size.height);
        if (btn.frame.origin.x <= viewW/2)
        {
            arrowTrash = TRUE;
        }
    }
    else
    {
        btn.frame = CGRectMake(btn.frame.origin.x + arrowGap,btn.frame.origin.y,btn.frame.size.width,btn.frame.size.height);
        if (btn.frame.origin.x >= viewW/2-btn.frame.size.width)
        {
            arrowTrash = TRUE;
        }
    }
    if (arrowTrash)
    {
       [self arrowTrashAnimation:btn];
       [self timerInvalidate:timer];
        if (result) {
            self.ballonImage.frame = CGRectMake(self.ballonImage.frame.origin.x  ,-(self.ballonImage.frame.size.height+500), self.ballonImage.frame.size.width,self.ballonImage.frame.size.height);
        }
      
    }
    [UIView commitAnimations];
}

-(void)arrowTrashAnimation:(UIButton *)view
{
     [UIView beginAnimations:@"suck" context:NULL];
     [UIView setAnimationTransition:103 forView:view cache:NO];
     [UIView setAnimationDuration:.5];
     NSLog(@"%d",view.tag);
     if (view.tag >=4) {
       // [view.layer setPosition:CGPointMake(0,-300)];
     }
     else{
        [view.layer setPosition:CGPointMake(viewW,-view.frame.size.height)];
    }
    [UIView commitAnimations];

/*
    CATransition *animation = [CATransition animation];
    animation.type = @"suckEffect";
    animation.duration = 2.0f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    view.alpha = 1.0f;
    [view.layer addAnimation:animation forKey:@"transitionViewAnimation"];
*/
    
    [self performSelector:@selector(removeViewFromMemory:) withObject:view afterDelay:1];
}
-(void)ballonFyingAnimation:(NSTimer *)timer
{
    [UIView beginAnimations : @"Display notif" context:nil];
    [UIView setAnimationDuration:.1];
    self.ballonImage.frame = CGRectMake(self.ballonImage.frame.origin.x  ,self.ballonImage.frame.origin.y-ballonGap, self.ballonImage.frame.size.width,self.ballonImage.frame.size.height);
        if (self.ballonImage.frame.origin.y <=limitY)
        {
            [self timerInvalidate:timer];
            [self viewWillAppear:YES]; // new ballon comes
        }
   [UIView commitAnimations];
}
-(void)removeViewFromMemory:(UIView*)view
{
    if (view)
    {
        [view removeFromSuperview];
         view = nil;
    }
}
-(void)timerInvalidate:(NSTimer *)timer
{
    if (timer)
    {
        [timer invalidate];
        timer = nil ;
    }
}
#pragma mark
#pragma mark Configuration Method
#pragma mark

-(UILabel*)configureLabelFrame:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor fontSize:(int)fontSize fontName:(NSString *)fontName{
    UILabel *lbl = [[UILabel alloc]init];
    lbl.frame =frame;
    lbl.text = title;
    lbl.textColor =tColor;
    lbl.font = [UIFont fontWithName:fontName size:fontSize];
    lbl.backgroundColor = [UIColor clearColor];
    return lbl;
}
-(CustomButton *) ConfigureButton:(CGRect)frame tag:(int)tag type:(int)type title:(NSString *)title  tColor:(UIColor *)tColor bColor:(UIColor *)bColor imageName:(NSString *)imageName methodName:(SEL)methodName{
    int fontSize = 17 ;
    if (isIpad)
    {
        fontSize = 40 ;
    }
    CustomButton * btn = [CustomButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:tColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:FONT_GILL_SANS size:fontSize];
    btn.backgroundColor = bColor;
    if (imageName != nil)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (methodName)
    {
        [btn addTarget:self action:methodName forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

#pragma  mark
#pragma  mark  Action Method
#pragma  mark

-(IBAction)backButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma  mark
#pragma  mark  Memory Managment
#pragma  mark

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
