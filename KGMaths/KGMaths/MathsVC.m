//
//  MathsVC.m
//  PEnglish
//
//  Created by I-MAC on 12/14/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "MathsVC.h"

@interface MathsVC ()

@end

@implementation MathsVC

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
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate setBackgroundColorForViewController:self bColor:WC];
    _indexArray = [[NSArray alloc]initWithObjects:For_one,Count_Objects,Match_Pair,Prefix_Postfix,Addition,Subtraction,Ascending,Descending,Greater_Smaller,Game,nil];
        
    if (isIpad)
    {
        w = 250;
        h = 400;
        fontSize = 50 ;
    }else{
        w = 100 ;
        h = 130 ;
        fontSize = 15 ;
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.carouselView.type = iCarouselTypeCoverFlow;
     [_carouselView reloadData];
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
-(void)Animation
{    
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

#pragma  mark
#pragma  mark Action Method
#pragma  mark
-(IBAction)backButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma  mark
#pragma  mark Carousel Delegate  Method
#pragma  mark

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _indexArray.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIView *returnView = nil;
    
    if (view == nil){
        
        UIView * view = [[UIImageView  alloc]initWithFrame:CGRectMake(5, 5, w, h)];
        
        UIImage *image = [UIImage imageNamed:COVER_IMAGE2];
        ((UIImageView *)view).image = image;
        view.contentMode = UIViewContentModeScaleToFill;
        CGRect frame =CGRectMake(10, 20, w-20, h-40);

        UILabel * lbl = [self configureLabelFrame:frame title:[NSString stringWithFormat:@"%d. %@",index + 1 ,[_indexArray objectAtIndex:index]] tColor:WC fontSize:fontSize fontName:FONT_GILL_SANS];
        lbl.numberOfLines = 0;
        lbl.lineBreakMode = NSLineBreakByWordWrapping;
               [view addSubview:lbl];
        
        returnView = view;
    }
    return returnView;
}

-(UILabel*)configureLabelFrame:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor fontSize:(int)fontSize1 fontName:(NSString *)fontName{
    UILabel *lbl = [[UILabel alloc]init];
    lbl.frame =frame;
    lbl.text = title;
    lbl.textColor =tColor;
    lbl.font = [UIFont fontWithName:fontName size:fontSize1];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    return lbl;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}
- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (view == nil) {
        
    }
    return view;
}

#pragma mark -
#pragma mark iCarousel taps
#pragma mark

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(int)index
{
    if (index == 0)
        [self performSegueWithIdentifier:I_FOR_ONE sender:self];
    
    else if (index == 1 || index == 2|| index == 3 ||index == 4 || index == 5||index == 6||index == 7 || index == 8)
    {
        if (index == 1) self.testNumber = Count_TT;
        else if (index == 2) self.testNumber = Match_TT;
        else if (index == 3) self.testNumber = Prefix_TT;
        else if (index == 4) self.testNumber = Addition_TT;
        else if (index == 5) self.testNumber = Subtraction_TT;
        else if (index == 6) self.testNumber = Ascending_TT;
        else if (index == 7) self.testNumber = Descending_TT;
        else if (index == 8) self.testNumber = Smaller_TT;
       [self performSegueWithIdentifier:TEST_DETAIL_VC sender:self];
    }
    else if (index == 9)
        [self performSegueWithIdentifier:MATHS_GAME sender:self];
  
 }
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:TEST_DETAIL_VC])
    {
        TestDetailVC *obj = [segue destinationViewController];
        obj.testNumber = self.testNumber;
    }
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * _carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (_carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}

-(void)dealloc
{
    [self nilObject:self.carouselView];
    [self nilObject:self.coverImage];
    [self nilObject:self.indexArray];
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
