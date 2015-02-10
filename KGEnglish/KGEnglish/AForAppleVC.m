
//
//  AForAppleVC.m
//  PEnglish
//
//  Created by I-MAC on 12/5/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "AForAppleVC.h"


@interface AForAppleVC ()

@end

@implementation AForAppleVC

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
   
    [self animationForCoverImage];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.objSTT = [[SpeechToText alloc]init];
    [self.objSTT  initlizeObjectForTextToSpeechfromView:self.view];
    [self getDataFromDatabase];
    alphabetNO = 0 ;
   
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
    if (self.coverImage)
    {
        [self.coverImage removeFromSuperview];
        self.coverImage = nil;
    }
}

-(void)getDataFromDatabase
{
    Database *objDB =[[Database alloc]init];
    self.alphabetArray =  [objDB getImagesforAlphabet];
    if (self.alphabetArray.count > 0 )
    {
        self.alphabetDic = [self.alphabetArray objectAtIndex:alphabetNO];
        [self SetValueInControl];
    }
}
-(void)SetValueInControl
{
    NSString *str = [self.alphabetDic  valueForKey:FLD_ALPHABET_NAME];
    self.lblCapsAlpha.text = str;
    self.lblSmallAlpha.text = [str lowercaseString];
    [self getImageFromDBForKey:FLD_IMAGE_1 button:self.btn1 label:self.lbl1];
    [self getImageFromDBForKey:FLD_IMAGE_2 button:self.btn2 label:self.lbl2];
    
}
-(void)getImageFromDBForKey:(NSString*)forKey button:(UIButton *)button label:(UILabel*)label
{
    NSString * imageName = [self.alphabetDic  valueForKey:forKey];
    button.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    label.text = [[imageName stringByDeletingPathExtension] capitalizedString];
    if ( [label.text length] > 1)
        label.text = [label.text substringToIndex:[label.text length] - 2];
    label.textColor = BC;
    
    NSLog(@"image name = %@ ",imageName);
}
#pragma  mark
#pragma  mark Action Event
#pragma  mark

-(IBAction)backButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)btnImageClicked:(id)sender
{
    NSString *speechText = @"";
    if ([sender tag] == 1)
    {
        speechText= [self.alphabetDic valueForKey:FLD_IMAGE_1];
    }
    else if ([sender tag] == 2)
    {
        speechText = [self.alphabetDic valueForKey:FLD_IMAGE_2];
    }
    speechText = [speechText stringByDeletingPathExtension];
    NSLog(@"Speech = %@ ",speechText);
    if ([speechText length] > 1)
    {
        speechText = [speechText substringToIndex:[speechText length] - 2];
    }
    [self.objSTT   startListening:speechText];
}
-(IBAction)prevAlphabetClicked:(id)sender
{
    if (alphabetNO > 0)
    {
        alphabetNO--;
        self.alphabetDic = [self.alphabetArray objectAtIndex:alphabetNO];
        [self SetValueInControl];
    }
}
-(IBAction)nextAlphabetClicked:(id)sender
{
    if (alphabetNO < _alphabetArray.count-1)
    {
        alphabetNO++;
        self.alphabetDic = [self.alphabetArray objectAtIndex:alphabetNO];
        [self SetValueInControl];
    }
}

#pragma mark
#pragma mark Other Method
#pragma mark

-(void)setBorderForCustomView:(UIView *)view
{
    view.backgroundColor = CC;
    view.layer.borderColor = [BC CGColor];
    view.layer.borderWidth = 1;
    view.layer.cornerRadius = 5;
}
-(NSString *)getImagePathFromImageName:(NSString *)imageName
{
    imageName = [imageName stringByDeletingPathExtension];
    NSString *imagePath = [[NSBundle mainBundle]pathForResource:imageName ofType:@"jpg"];
    return imagePath;
}
/*- (void)viewDidLoad
{
    [super viewDidLoad];
 
        AVSpeechUtterance *utterance = [AVSpeechUtterance                                    speechUtteranceWithString:@"apple"];
        utterance.rate =AVSpeechUtteranceMinimumSpeechRate
        ;
        AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
        [synth speakUtterance:utterance];
        
        NSArray * str = [AVSpeechSynthesisVoice speechVoices];
        
        NSLog(@"str = %@",str);
 
    [self.openEarsEventsObserver setDelegate:self];
    
     [self setBorderForCustomView:self.view1];
     [self setBorderForCustomView:self.view2];
     [self setBorderForCustomView:self.view3];
     [self setBorderForCustomView:self.view4];
//
     NSLog(@"The size of a char is: %lu.", sizeof(char));

    
	// Do any additional setup after loading the view.
}*/
#pragma mark
#pragma mark Memory Managment Method
#pragma mark
-(void)dealloc
{
    [self nilObject:self.alphabetArray];
    [self nilObject:self.lblCapsAlpha];
    [self nilObject:self.lblSmallAlpha];
    [self nilObject:self.view1];
    [self nilObject:self.view2];
    [self nilObject:self.image1];
    [self nilObject:self.image2];
    [self nilObject:self.lbl1];
    [self nilObject:self.lbl2];
    [self nilObject:self.btn1];
    [self nilObject:self.btn2];
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
