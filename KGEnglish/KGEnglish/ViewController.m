//
//  ViewController.m
//  KGEnglish
//
//  Created by I-MAC on 4/9/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark
#pragma mark View Life Cycle
#pragma mark
- (void)viewDidLoad
{
    NSLog(@"OS Version = %f",[[SingletonClass sharedManager]getSystemVersion]);
  
    self.subjectArray = [[NSArray alloc]initWithObjects:E_C_I, nil];
    if ([[SingletonClass sharedManager]isIpad])
    {
        w = 250 ;
        h = 400 ;
    }
    else
    {
        w = 100 ;
        h = 150 ;
    }
    [self animationForCoverImage];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _carouselView.type = iCarouselTypeCoverFlow;
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
    self.schoolBag = [[UIImageView alloc]init];
    self.schoolBag.backgroundColor = WC ;
    self.schoolBag.frame = self.carouselView.frame ;
    self.schoolBag.contentMode = UIViewContentModeScaleAspectFit;
    self.schoolBag.image = [UIImage imageNamed:@"SchoolBag.png"];
    [self.view addSubview:self.schoolBag];
    
    self.btnBag = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnBag .frame = self.schoolBag.frame ;
    [self.btnBag  addTarget:self  action:@selector(Animation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnBag];
    
    //[self performSelector:@selector(Animation) withObject:nil afterDelay:1];
    
}
-(void)Animation{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.schoolBag cache:YES];
    [UIView commitAnimations];
    self.schoolBag.image = nil;
    [self performSelector:@selector(removeCoverImageFromMemory) withObject:nil afterDelay:4];
    
    
}
-(void)removeCoverImageFromMemory
{
    if (self.schoolBag) {
        [self.schoolBag removeFromSuperview];
        self.schoolBag = nil;
    }
    if (self.btnBag) {
        [self.btnBag removeFromSuperview];
        self.btnBag = nil ;
        
    }
}

#pragma  mark
#pragma  mark Carousel Delegate  Method
#pragma  mark

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.subjectArray.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIView *returnView = nil;
    if (view == nil){
        
        UIView * view = [[UIImageView  alloc]initWithFrame:CGRectMake(5, 5, w, h)];
        UIImage *image = [UIImage imageNamed:[self.subjectArray  objectAtIndex:index]];
        ((UIImageView *)view).image = image;
        view.contentMode = UIViewContentModeScaleToFill;
        
        
        returnView = view;
    }
    return returnView;
}

/*-(UILabel*)configureLabelFrame:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor fontSize:(int)fontSize1 fontName:(NSString *)fontName{
 UILabel *lbl = [[UILabel alloc]init];
 lbl.frame =frame;
 lbl.text = title;
 lbl.textColor =tColor;
 lbl.font = [UIFont fontWithName:fontName size:fontSize1];
 lbl.backgroundColor = [UIColor clearColor];
 lbl.textAlignment = NSTextAlignmentCenter;
 return lbl;
 }*/

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
    if (index == 0) { // English
        [self performSegueWithIdentifier:INDEX_VC sender:self];
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
    [self nilObject:self.subjectArray];
    [self nilObject:self.schoolBag];
    [self nilObject:self.carouselView];
    [self nilObject:self.coverImageArray];
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
