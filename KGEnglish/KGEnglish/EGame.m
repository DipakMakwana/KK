//
//  EGame.m
//  PEnglish
//
//  Created by I-MAC on 12/16/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "EGame.h"

@interface EGame ()

@end

@implementation EGame
//static float deltaAngle;

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
    /* AppDelegate * appDelegate  = (AppDelegate *)[[UIApplication sharedApplication]delegate];
     [appDelegate setBackgroundColorForViewController:self bColor:WC];
   */
    if (isIpad)
    {
        W = 70 ;
        H = 70 ;
        frameLimit = CGRectMake(0, 80, viewW, self.roadImage.frame.origin.y);
    }
    else
    {
        W = 25 ;
        H = 25 ;
        frameLimit = CGRectMake(0, 44, viewW, self.roadImage.frame.origin.y-H);
    }
}
-(void)setViewBorder:(UIView *)view
{
    view.layer.borderColor = RC.CGColor ;
    view.layer.borderWidth = 1 ;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    firstTruckCount = 0 ;
    secondTruckCount = 0 ;
    thirdTruckCount = 0 ;
    forthTruckCount = 0 ;
    totalTruckCount = 0 ;
    self.lblCongrates.hidden = YES;
    self.viewWin.hidden = YES;
    self.btnPlayAgain.hidden = YES ;
    self.timer2 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateScore) userInfo:nil repeats:YES];
    [self removeSubviewOfView:self.view1];
    [self removeSubviewOfView:self.view2];
    [self removeSubviewOfView:self.view3];
    [self removeSubviewOfView:self.view4];
    [self setRandomGame];
    [self addObjectInGround];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self timerInvalidate:self.timer1];
    [super viewDidDisappear:animated];
}
#pragma mark
#pragma mark Other Method
#pragma mark

/* Hide Status bar */
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(void)allocateCustomView
{
     NSArray *capsAlphabetArray = [[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    int x = 10 ;
    int w = 100 ;
    int h = 100 ;
    int y = 250 ;
    int gap = 20 ;
    int fontSize = 20 ;
    if ([[SingletonClass  sharedManager] isIpad])
    {
         x = 20 ;
         w = 200 ;
         h = 200 ;
         y = 610 ;
        gap = 50 ;
        fontSize = 45;
        
    }
    for (int i = 0 ; i < 4; i++)
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x,y, w, h)];
        UIImageView *truckImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
        view.tag =  i + 1;
        truckImage.contentMode = UIViewContentModeScaleAspectFit;
        truckImage.image = [UIImage imageNamed:TRUCK_I];
        [view addSubview:truckImage];
        
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(fontSize + 10, fontSize + 15,fontSize + 10, fontSize + 10 )];
        lbl.font = [UIFont fontWithName:FONT_GILL_SANS size:fontSize];
        lbl.textColor = WC ;
        lbl.textAlignment = NSTextAlignmentCenter ;
        lbl.text = [capsAlphabetArray objectAtIndex:i];
        [view addSubview:lbl];
        x = x + w + gap;
        [self.view addSubview:view];
    }
   
}
-(void)updateScore
{
    score ++ ;
    self.lblTime.text = [NSString stringWithFormat:@"Time: %d",score];
}
-(void)setPropertyInView:(UIView *)view
{
    view.layer.borderColor = BC.CGColor;
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 2;
    view.layer.masksToBounds = YES ;
}
#pragma mark
#pragma mark Game Initlization Method
#pragma mark

-(void)setRandomAlphabetwithStartNo:(int)startNO gap:(int)gap  label:(UILabel *)label view:(UIView *)view
{
    NSArray *capsAlphabetArray = [[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    int n1 = startNO + arc4random() % gap;
    view.tag = n1+1;
    NSString *str = [capsAlphabetArray objectAtIndex:n1];
    label.text = str;
}

-(void)setRandomGame
{
    
/*For Random Game ,it will played after all images of alphabet is insertrein Database */
    
    
//    [self setRandomAlphabetwithStartNo:0  gap:6 label:self.lbl1 view:self.view1];
//    [self setRandomAlphabetwithStartNo:6  gap:6 label:self.lbl2 view:self.view2];
//    [self setRandomAlphabetwithStartNo:13 gap:6 label:self.lbl3 view:self.view3];
//    [self setRandomAlphabetwithStartNo:20 gap:6 label:self.lbl4 view:self.view4];
    
    int x = 10 ;
    int y = 50 ;
    int gap = 20 ;
    int w = self.view1.frame.size.width ;
    int h = self.view1.frame.size.height ;
    if (isIpad)
    {
        y = 635;
        gap = 50;
        x = 50;
    }
    else
    {
        y = viewH - h + 7;
    }
    self.view1.frame = CGRectMake(x,y,w,h);    x = x + w + gap ;
    self.view2.frame = CGRectMake(x,y,w,h);    x = x + w + gap ;
    self.view3.frame = CGRectMake(x,y,w,h);    x = x + w + gap ;
    self.view4.frame = CGRectMake(x,y,w,h);

    /*For Default Game Play*/
    [self setTagInLableAndImage:self.lbl1 view:self.view1 tag:0];
    [self setTagInLableAndImage:self.lbl2 view:self.view2 tag:1];
    [self setTagInLableAndImage:self.lbl3 view:self.view3 tag:2];
    [self setTagInLableAndImage:self.lbl4 view:self.view4 tag:3];
}
-(int )getRandomNBetween:(int)smallest gap:(int)gap
{
    int largest = smallest + gap ;
    int random = smallest + arc4random() % (largest+1-smallest);
    return random;
}

-(void)setTagInLableAndImage:(UILabel*)label view:(UIView *)view tag:(int)tag
{
     NSArray *capsAlphabetArray = [[NSArray alloc]initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    label.text = [capsAlphabetArray objectAtIndex:tag];
    view.tag = tag + 1 ;
    [view addSubview:label];
}
-(void)removeSubviewOfView:(UIView *)view
{
    for (UIImageView *v in view.subviews)
    {
        if (v.tag == 999)
        {
            
        }
        else
        {
            [v removeFromSuperview];
        }
        
    }
}
-(void)addObjectInGround
{
    Database *objDB = [[Database alloc]init];
    self.objectArray = [objDB getImagesforAlphabet];
    for (int i = 0 ; i<  self.objectArray.count; i++)
    {
        [self addImages:FLD_IMAGE_1 arrayIndex:i];
        [self addImages:FLD_IMAGE_2 arrayIndex:i];
    }
}
-(void)addImages :(NSString *)forKey  arrayIndex:(int)i
{
    int limitonX  =  viewW - W;
    if ([[SingletonClass sharedManager]isIpad])
    {
        limitY = self.roadImage.frame.origin.y - 2*H;
    }
    else
    {
        limitY = self.roadImage.frame.origin.y - 4*H;
    }
    int x = 5 + arc4random() % limitonX ;
    int y = 70 + arc4random() %  limitY ;
    CGRect frame = CGRectMake(x, y, W, H);
    
    NSString *imageName = [[self.objectArray objectAtIndex:i] valueForKey:forKey];
    int alphaTag = [[[self.objectArray  objectAtIndex:i]valueForKey:FLD_ALPHABET_TAG]integerValue];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    [self setPropertyInImageView:imageView]; // Set Property
    imageView.image = [UIImage imageNamed:imageName];
    imageView.userInteractionEnabled  = YES ;
    imageView.tag = alphaTag + 1000 ;
    
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [imageView addGestureRecognizer:panGesture];
    [self.view addSubview:imageView];
}
-(void)setPropertyInImageView:(UIImageView *)imageView
{
   // imageView.layer.borderColor = BC.CGColor;
    //imageView.layer.borderWidth = 1 ;
   // imageView.layer.cornerRadius = 2;
   // imageView.layer.masksToBounds = YES ;
    imageView.contentMode = UIViewContentModeScaleAspectFit ;
}

#pragma mark
#pragma mark Touch Event
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

-(IBAction)playAgainClicked
{
    score = 0 ; 
    [self timerInvalidate:self.timer1];
    [self timerInvalidate:self.timer2];
    [self viewWillAppear:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    UIView * v = [touch view];
    previousframe   = v.frame ;
}
#pragma mark
#pragma mark Gesture Method
#pragma mark

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

    if (recognizer.state == UIGestureRecognizerStateEnded) {
        UIView * v = recognizer.view;
        CGPoint  point = CGPointMake(v.frame.origin.x, v.frame.origin.y);
        if (CGRectContainsPoint(frameLimit, point)){
            NSLog(@"In Same View");
        }
        else
        {
            if ([v isKindOfClass:[UIImageView class ]])
            {
                BOOL added = [self checkObjectInImageViewForPoint:point movedView:v];
                if (!added)
                {
                    v.frame = previousframe;
                    NSLog(@"Not Added");
                }
            }
        }
    }
}
/* Check that object  is match with touched view */

-(BOOL)checkObjectInImageViewForPoint:(CGPoint)point movedView:(UIView *)view
{
    int imageTag = view.tag - 1000 ;
    BOOL added = FALSE;
    NSLog(@"%d",self.view1.tag);
    if(CGRectContainsPoint(self.view1.frame, point)) // FOR A
    {
         if (self.view1.tag == imageTag)
         {
             added  = TRUE;
             firstTruckCount =   [self removeViewIncreaseCountSetFlag:view incCount:firstTruckCount currentView:self.view1 lable:self.lbl1];
         }
         else
         {
                added  = FALSE ;
         }
    }
    else  if(CGRectContainsPoint(self.view2.frame, point))
    {
          if (self.view2.tag == imageTag) // FOR B
          {
              added  = TRUE ;
              secondTruckCount =  [self removeViewIncreaseCountSetFlag:view incCount:secondTruckCount currentView:self.view2 lable:self.lbl2];
          }
          else
          {
              added  = FALSE ;
          }
    }
    else  if(CGRectContainsPoint(self.view3.frame, point)) { // FOR C
        if (self.view3.tag == imageTag)
        {
            added  = TRUE ;
             thirdTruckCount =  [self removeViewIncreaseCountSetFlag:view incCount:thirdTruckCount currentView:self.view3 lable:self.lbl3];
        }
        else
        {
            added  = FALSE ;
        }
    }
    else  if(CGRectContainsPoint(self.view4.frame, point)) // FOR D
    {
        if (self.view4.tag == imageTag)
        {
             added  = TRUE ;
             forthTruckCount =  [self removeViewIncreaseCountSetFlag:view incCount:forthTruckCount currentView:self.view4 lable:self.lbl4];
        }
        else
        {
            added  = FALSE ;
        }
    }
    else
    {
        added = FALSE ;
    }
    return added;
}
-(int)removeViewIncreaseCountSetFlag:(UIView *)view incCount:(int)count currentView:(UIView *)currentView lable:(UILabel *)label
{
    count ++;
    int x = 7;
    if (count == 1)
    {
        view.frame = CGRectMake(x, 32, view.frame.size.width,view.frame.size.height);
        [currentView addSubview:view];
    }
    if (count == 2)
    {
        view.frame = CGRectMake(x+view.frame.size.width + 5 , 32, view.frame.size.width,view.frame.size.height);
        [currentView addSubview:view];
        [currentView bringSubviewToFront:label];
        [self addScrollViewAndAnimationForImageView:currentView];
    }
    [view  removeFromSuperview];
    return count ;
}
#pragma mark
#pragma mark Animation Method
#pragma mark

-(void)addScrollViewAndAnimationForImageView:(UIView *)view{
    
    if (isIpad)
    {
        view.frame = CGRectMake(10, viewH - (4*H), view.frame.size.width,view.frame.size.height);
    }
    else
    {
        view.frame = CGRectMake(10, viewH - (5*H), view.frame.size.width,view.frame.size.height);
    }
    NSMutableDictionary * userInfo = [[NSMutableDictionary alloc]init];
    [userInfo setObject:view forKey:@"view"];
    NSTimer *timer   =  [NSTimer scheduledTimerWithTimeInterval:.1                                      target:self selector:@selector(makeAnimationForImageView:)                                    userInfo:userInfo repeats:YES];
    NSLog(@"Timer %@",timer);

}
-(void)makeAnimationForImageView:(NSTimer *)timer
{
    UIView *customView = [[timer userInfo] valueForKey:@"view"];
    [UIView beginAnimations : @"Display notif" context:nil];
    [UIView setAnimationDuration:.5];
    customView.frame = CGRectMake( customView.frame.origin.x + 5 , customView.frame.origin.y,  customView.frame.size.width,  customView.frame.size.height);
    [UIView commitAnimations];
   
    if ( customView.frame.origin.x >=  viewW + customView.frame.size.width)
    {
        totalTruckCount ++;
        [self timerInvalidate:timer]; // stop truck movement for particular truck
       // [self removeViewsFromMemory:customView];
        if (totalTruckCount == 4) {
            self.lblCongrates.hidden = NO; // show congralulation
            self.btnPlayAgain.hidden = NO ;//and play again button
            
            [self timerInvalidate:self.timer2]; // Stop time
            
            for(UIImageView *v in self.view.subviews) // Remove all Images from
            {                                         // ground
                if (v.tag >= 1000) {
                    [v removeFromSuperview];
                }
            }
            self.viewWin.hidden = FALSE ;
            self.timer1 = [NSTimer
                           scheduledTimerWithTimeInterval:.5
                           target:self
                           selector:@selector(labelAnimation)
                           userInfo:nil
                           repeats:YES];
        }
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

-(void)labelAnimation
{
    if(blinkStatus == NO)
    {
        self.lblCongrates.textColor = [UIColor greenColor];
    }
    else
    {
        self.lblCongrates.textColor = [UIColor yellowColor];
    }
    blinkStatus = !blinkStatus ;
}

-(void)removeViewsFromMemory:(UIView *)view
{
    if (view)
    {
       [view removeFromSuperview];
       view = nil ;
    }
}
#pragma mark
#pragma mark Memory Managment Method
#pragma mark

-(void)dealloc
{
    [self nilObject:self.objectArray];
    [self nilObject:self.view1];
    [self nilObject:self.view2];
    [self nilObject:self.view3];
    [self nilObject:self.view4];
    [self nilObject:self.lbl1];
    [self nilObject:self.lbl2];
    [self nilObject:self.lbl3];
    [self nilObject:self.lbl4];
    [self nilObject:self.lblTime];
    [self nilObject:self.lblCongrates];
    [self nilObject:self.timer1];
    [self nilObject:self.timer2];
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
