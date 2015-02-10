
//
//  MathsTestVC.m
//  PEnglish
//
//  Created by I-MAC on 1/1/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import "MathsTestVC.h"

@interface MathsTestVC ()

@end

@implementation MathsTestVC

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
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate setBackgroundColorForViewController:self bColor:WC];    
    }
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma  mark
#pragma  mark Action Method
#pragma  mark

-(IBAction)backButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)joinNumberButtonClicked
{
    testNumber = Count_TT ;
    [self performSegueWithIdentifier:TEST_DETAIL_VC sender:self];
}
-(IBAction)matchPairButtonClicked
{
    testNumber = Match_TT ;
    [self performSegueWithIdentifier:TEST_DETAIL_VC sender:self];
}
-(IBAction)prefixPostfixButtonClicked
{
    testNumber = Prefix_TT ;
    [self performSegueWithIdentifier:TEST_DETAIL_VC sender:self];
}
-(IBAction)additionSubtractionButtonClicked
{
    testNumber = Addition_TT ;
    [self performSegueWithIdentifier:TEST_DETAIL_VC sender:self];
}
-(IBAction)assendingDesendingButtonClicked
{
    testNumber = Ascending_TT ;
    [self performSegueWithIdentifier:TEST_DETAIL_VC sender:self];
}
-(IBAction)smallerGreterButtonClicked
{
    testNumber = Smaller_TT;
    [self performSegueWithIdentifier:TEST_DETAIL_VC sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:TEST_DETAIL_VC])
    {
        TestDetailVC *obj = [segue destinationViewController];
        obj.testNumber = testNumber;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
