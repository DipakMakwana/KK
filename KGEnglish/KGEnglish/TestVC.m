//
//  TestVC.m
//  PEnglish
//
//  Created by I-MAC on 12/11/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // [self animationForCoverImage];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
   /* AppDelegate * appDelegate  = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
   [appDelegate setBackgroundColorForViewController:self bColor:WC];*/
    
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
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
    if (self.coverImage) {
        [self.coverImage removeFromSuperview];
        self.coverImage = nil;
    }
}

#pragma  mark
#pragma  mark Action Method
#pragma  mark
-(IBAction)backButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)missingAlphabetClicked:(id)sender
{
    testIndex = 1 ;
    [self performSegueWithIdentifier:FIND_MISSING_VC sender:self];
}
-(IBAction)missingCharacterClicked:(id)sender
{
     testIndex = 2 ;
    [self performSegueWithIdentifier:FIND_MISSING_VC sender:self];
}
-(IBAction)missingVowelsClicked:(id)sender
{
    testIndex = 3 ;
    [self performSegueWithIdentifier:FIND_MISSING_VC sender:self];
}
-(IBAction)arrangesentenseClicked:(id)sender
{
    [self performSegueWithIdentifier:ARRANGE_VC sender:self];
}
-(IBAction)pictureIdentificationClicked:(id)sender
{
    [self performSegueWithIdentifier:PICTURE_IDEN_VC sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:FIND_MISSING_VC]) {
        FindMissingVC *obj = [segue destinationViewController];
        obj.testIndex =  testIndex ; 
    }
}
-(void)dealloc
{
    [self nilObject:self.coverImage];
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
