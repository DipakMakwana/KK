//
//  VowelsVC.m
//  PEnglish
//
//  Created by I-MAC on 12/11/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "VowelsVC.h"

@interface VowelsVC ()

@end

@implementation VowelsVC

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
    /*AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate setBackgroundColorForViewController:self bColor:WC];*/
   
   

     [self animationForCoverImage];
    vowelNumber = 0 ;
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.objSTT = [[SpeechToText alloc]init];

    [self.objSTT initlizeObjectForTextToSpeechfromView:self.view];
    [self getDataFromDatabase];
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
#pragma  mark  Ohter Method 
#pragma  mark
-(void)getDataFromDatabase
{
    Database *objDB =[[Database alloc]init];
    self.vowelsArray =  [objDB getVowelsFromDatabase];
    if (self.vowelsArray.count > 0 ) {
        [self SetValueInControl];
    }
}
-(void)SetValueInControl
{
    NSString *str = [[self.vowelsArray objectAtIndex:vowelNumber] valueForKey:FLD_ALPHABET_NAME];
    self.lblHeader.text = str;
    [self getImageFromDBForKey:FLD_IMAGE_1 button:self.btn1 label:self.lbl1];
    [self getImageFromDBForKey:FLD_IMAGE_2 button:self.btn2 label:self.lbl2];
    
}
-(void)getImageFromDBForKey:(NSString*)forKey button:(UIButton *)button label:(UILabel*)label
{
    NSString * imageName = [[self.vowelsArray  objectAtIndex:vowelNumber]valueForKey:forKey];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    label.text = [[imageName stringByDeletingPathExtension] capitalizedString];
    if ( [label.text length] > 1)
        label.text = [label.text substringToIndex:[label.text length] - 2];
    label.textColor = BC;
}

#pragma  mark
#pragma  mark   Action  Method
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
-(IBAction)imageButtonClicked :(id) sender
{
    NSString *speechText = @"";
    if ([sender tag] == 1 )
    {
        speechText = [[self.vowelsArray objectAtIndex:vowelNumber] valueForKey:FLD_IMAGE_1];
    }
    else if ([sender tag] == 2 )
    {
        speechText = [[self.vowelsArray objectAtIndex:vowelNumber] valueForKey:FLD_IMAGE_2];
    }
    speechText = [speechText stringByDeletingPathExtension];
    if ( [speechText length] > 1)
        speechText = [speechText substringToIndex:[speechText length] - 2];
    [self.objSTT startListening:speechText];
}
-(IBAction)vowelsButtonClicked :(id) sender
{
    vowelNumber = [sender tag];
    [self SetValueInControl];
}
#pragma  mark  
#pragma  mark   Memory Managment Method
#pragma  mark
-(void)dealloc
{
    [self nilObject:self.lbl1];
    [self nilObject:self.lbl2];
    [self nilObject:self.lblHeader];
    [self nilObject:self.btn1];
    [self nilObject:self.btn2];
    [self nilObject:self.coverImage];
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
