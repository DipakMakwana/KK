//
//  ArrangeSentenceVC.m
//  PEnglish
//
//  Created by I-MAC on 12/28/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "ArrangeSentenceVC.h"

@interface ArrangeSentenceVC ()

@end

@implementation ArrangeSentenceVC
static float deltaAngle;

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
   
       
    if ([[SingletonClass sharedManager]isIpad]) w = h = 50 ;
    else                                        w = h = 25 ;

    self.carView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, viewW,viewH-80)];
    self.carView.backgroundColor =CC;
    [self.view addSubview:self.carView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for(UIImageView *v in self.carView.subviews)
    {
        [self removeViewsFromMemory:v];
    }
    self.finalStr= @"";
    charCount = 0 ;
    [self setRandomCharacter];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma  mark 
#pragma  mark  Other Method 
#pragma  mark
-(void)setRandomCharacter
{
    NSArray *spellArray = [[NSArray alloc]initWithObjects:@"MANGO",@"WHITE",@"BLACK",@"CAMEL",@"Yellow",@"ORANGE",@"TIGER",@"LION",@"Mango",@"White",@"Black",@"Camel",@"Yellow",@"Orange",@"Kite",@"Tiger",@"Lion",nil];
    
    int number = arc4random() % spellArray.count ;
   self.strWord = [spellArray objectAtIndex:number];
    strLength = [self.strWord length];
    
    for (int i = 0 ;  i < strLength; i++) {
      
        int x = w + arc4random() % viewW -w;
        int y = 80 + arc4random() % 100 ;
        UIImageView  * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        imageView.backgroundColor = RC;
        imageView.layer.cornerRadius = 2 ;
        imageView.layer.masksToBounds = YES ;
        imageView.userInteractionEnabled = YES ;
        imageView.tag = i + 1001 ;
        
        CommonFile *obj = [[CommonFile alloc]init];
        NSString *charOfStr = [NSString stringWithFormat:@"%c",[self.strWord characterAtIndex:i]];
        UILabel *lbl = [obj configureLabelFrame:CGRectMake(0, 0, w, h) title:charOfStr tColor:WC fontSize:25  fontName:FONT_GILL_SANS];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.userInteractionEnabled = FALSE ;
        [imageView addSubview:lbl];
        
        UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        panGesture.delegate = self;
        [imageView addGestureRecognizer:panGesture];
        [self.carView addSubview:imageView];
    }
    [self setNumberOfCar:strLength];
}

-(void)setNumberOfCar:(int)number
{
    int carW =(viewW/number) - 10;
    int x = 10;
    int y = 195;
    int carH = 60;
    int gap = 5 ;
    if ([[SingletonClass sharedManager]isIpad])
    {
        carH = 100;
        gap = 10 ;
        y = viewH - 2*carH;
    }
    for (int  i = 0; i< number; i++)
    {
        UIImageView * carImage = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, carW,carH)];
        carImage.contentMode = UIViewContentModeScaleAspectFit;
        carImage.image  = [UIImage imageNamed:@"car.png"];
        x= x + carW + gap;
        carImage.tag = i + 2001;
        [self.carView addSubview:carImage];
    }
}
- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        UIView * v = recognizer.view;
        CGPoint  point = CGPointMake(v.frame.origin.x, v.frame.origin.y);
         BOOL added =  [self checkObjectInImageViewForPoint:point movedView:v];
        if (added) {
            v.frame = previousframe ;
        }
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    UIView * v = [touch view];
    previousframe   = v.frame ;
}
-(BOOL)checkObjectInImageViewForPoint:(CGPoint)point movedView:(UIView *)view {
    
    int imageTag = view.tag - 1000 ;
    BOOL added = FALSE;
    NSLog(@"Count %d ",[self.carView.subviews count]);
    
    for (UIImageView * carView in self.carView.subviews){
        if (CGRectContainsPoint(carView.frame, point)) {
            if ((carView.tag-2000) == imageTag) {
                view.frame = CGRectMake(carView.frame.size.width/ 2.5,  carView.frame.size.height/ 2.5, w, h);
                NSString *str = [NSString stringWithFormat:@"%c",[self.strWord characterAtIndex:imageTag-1]];
                self.finalStr = [self.finalStr stringByAppendingString:str];
                [carView addSubview:view];
                charCount ++ ;
            }
        }
    }
   
    if (charCount == strLength) {
        [self addScrollViewAndAnimationForImageView
         :view];
    }
    return added;
}
-(void)addScrollViewAndAnimationForImageView:(UIView *)view{
    
     charCount = 0 ;
    for (UIImageView * car in self.carView.subviews) {
        
        NSMutableDictionary * userInfo = [[NSMutableDictionary alloc]init];
        [userInfo setObject: car forKey:@"view"];
        [NSTimer scheduledTimerWithTimeInterval:.1                                      target:self selector:@selector(makeAnimationForImageView:)                                    userInfo:userInfo repeats:YES];
    }
}
-(void)makeAnimationForImageView:(NSTimer *)timer
{
    UIView *customView = [[timer userInfo] valueForKey:@"view"];
    UIImageView *imgWheel1 = [[timer userInfo] valueForKey:@"wheel1"];
    UIImageView *imgWheel2 = [[timer userInfo] valueForKey:@"wheel2"];
    
    [UIView beginAnimations : @"Display notif" context:nil];
    [UIView setAnimationDuration:.5];
    customView.frame = CGRectMake(customView.frame.origin.x - 50, customView.frame.origin.y,  customView.frame.size.width,  customView.frame.size.height);
    deltaAngle = deltaAngle - 180;
    imgWheel1.transform = CGAffineTransformMakeRotation(deltaAngle);
    imgWheel2.transform = CGAffineTransformMakeRotation(deltaAngle);
    [UIView commitAnimations];
    
    if ((customView.tag-2000) == strLength) {
          NSLog(@"x = %f ",customView.frame.origin.x);
          if (customView.frame.origin.x <= - (customView.frame.origin.x +customView.frame.size.width + 200)) {
              if (timer) {
                for(UIImageView *v in self.carView.subviews){
                    [self removeViewsFromMemory:v];
                }
                [self removeViewsFromMemory:customView];
                [self removeViewsFromMemory:imgWheel1];
                [self removeViewsFromMemory:imgWheel2];
                [timer invalidate];
                timer = nil ;
                [self viewWillAppear:YES];
              }
         }
    }
}
-(void)removeViewsFromMemory:(UIView *)view
{
    if (view) {
        [view removeFromSuperview];
        view = nil ;
    }
}
#pragma  mark
#pragma  mark Action Method
#pragma  mark
-(IBAction)nextButtonClicked:(id)sender
{
    [self viewWillAppear:YES];
}
-(IBAction)backButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma  mark
#pragma  mark Memory Managment 
#pragma  mark

-(void)dealloc
{
    [self nilObject:self.carView];
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
