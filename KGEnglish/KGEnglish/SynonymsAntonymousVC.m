//
//  SynonymsAntonymousVC.m
//  PEnglish
//
//  Created by I-MAC on 2/8/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import "SynonymsAntonymousVC.h"

@interface SynonymsAntonymousVC ()

@end

@implementation SynonymsAntonymousVC

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
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    index = 0 ;
    [self setValueInLabelAndImage];
}
-(void)setValueInLabelAndImage
{
    Database * objDatabase = [[Database alloc]init];
    self.arrayObjects = [objDatabase  getOppositeObjectImages];
    /*
     id = 13;
     img1Obj1 = "one.jpg";
     img1Obj2 = "many.jpg";
     img2Obj2 = "";
     obj1 = One;
     obj2 = Many;
     */
    NSLog(@"result Array  = %@ ",self.arrayObjects);
     self.lbl1.text = [self checkForNullString:@"obj1"];
     self.lbl2.text = [self checkForNullString:@"obj2"];
     [self setImageInImageView:self.image1 forKey:@"img1Obj1"];
     [self setImageInImageView:self.image2 forKey:@"img1Obj2"];
    
//  self.lbl1.text = [];
}
-(void)setImageInImageView:(UIImageView *)imageView forKey:(NSString *)forKey
{
    NSString * str = [[self.arrayObjects objectAtIndex:index] valueForKey:forKey];
    str = [[SingletonClass sharedManager] checkNullString:str];
    if ([str length] > 0) {
        imageView.image = [UIImage imageNamed:str];
    }
    
}
-(NSString *)checkForNullString:(NSString *)forKey
{
    NSString * str = [[self.arrayObjects objectAtIndex:index] valueForKey:forKey];
    str = [[SingletonClass sharedManager]checkNullString:str];
    return str;
   
}
#pragma  mark
#pragma  mark  Action Method
#pragma  mark

-(IBAction)backButtonClicked
{
    if ([[SingletonClass sharedManager]getSystemVersion]<7) {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }
}
-(IBAction)nextButtonClicked
{
    if (index < self.arrayObjects.count-1) {
        index ++;
        [self setValueInLabelAndImage];
    }
}
-(IBAction)prevButtonClicked
{
    if (index >0) {
        index --;
        [self setValueInLabelAndImage];
    }
}
#pragma mark
#pragma mark Memory Managment Method
#pragma mark

-(void)dealloc
{
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
    // Dispose of any resources that can be recreated.
}

@end
