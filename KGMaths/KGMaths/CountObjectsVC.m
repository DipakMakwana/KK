//
//  CountObjectsVC.m
//  PEnglish
//
//  Created by I-MAC on 12/26/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "CountObjectsVC.h"

@interface CountObjectsVC ()

@end

@implementation CountObjectsVC

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
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    number = arc4random() % + 100;
    self.lblNo.text = [NSString stringWithFormat:@"%d",number];
    [self addImages:number];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma  mark
#pragma  mark Other Method
#pragma  mark

-(void)addImages:(int)count
{
    self.txtAns.text = @"";
    int x,y,w , h ;
    x =self.lblNo.frame.origin.x + self.lblNo.frame.size.width + 20;
    y = 90;
    w= 75;
    h =65;
    int random = arc4random() % 3 ;
    int limit = 10 ;
    
    for (UIImageView * v in self.view.subviews)
    {
        if (v.tag == 1000) {
            [v removeFromSuperview];
        }
    }
    for (int i = 0 ; i<count; i++)
    {
        NSArray * imageArray = [[NSArray alloc]initWithObjects:@"apple01.jpg",@"ball01.jpg",@"hat02.jpg", nil];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x,y, w, h)];
            imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:random]];
        imageView.tag = 1000;
        imageView.layer.borderColor = BC.CGColor ;
        imageView.layer.borderWidth = 1;        
        x= x + w  + 5;
        
        if (x >= w*limit) {
              x = self.lblNo.frame.origin.x + self.lblNo.frame.size.width + 20 ;
            y = y + h ;
        }
        [self.view addSubview:imageView];
    }
}
#pragma  mark
#pragma  mark  Action Method 
#pragma  mark
-(IBAction)doneButtonClicked
{
    int ans = [self.txtAns.text intValue];
    
    if(number == ans)
    {
        [self.txtAns resignFirstResponder];
        [CustomAlert alertTitle:SUCCESS alertMessage:@"Right Answer" delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitle:nil alertTag:0];

        [self nextAlphabetClicked:nil];
    }
    else
    {
      [CustomAlert alertTitle:SUCCESS alertMessage:@"Wrong Answer" delegate:nil cancelButtonTitle:OK_BUTTON otherButtonTitle:nil alertTag:0];
    }
    
}
-(IBAction)prevAlphabetClicked:(id)sender{
    number = arc4random() % + 100;
    if (number > 1 ) {
        number--;
        [self addImages:number];
        self.lblNo.text = [NSString stringWithFormat:@"%d",number];
    }
}
-(IBAction)nextAlphabetClicked:(id)sender
{
    number = arc4random() % + 100;
    if (number <100) {
        number++ ;
        [self addImages:number];
         self.lblNo.text = [NSString stringWithFormat:@"%d",number];
    }
}
-(IBAction)backButtonClicked{
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
