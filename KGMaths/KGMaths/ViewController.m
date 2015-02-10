//
//  ViewController.m
//  PEnglish
//
//  Created by I-MAC on 11/29/13.
//  Copyright (c) 2013 Indies. All rights reserved.
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
    [super viewDidLoad];

    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate setBackgroundColorForViewController:self bColor:WC];
    self.subjectArray = [[NSArray alloc]initWithObjects:M_C_I, nil];
    if (isIpad)
    {
        w = 250 ;
        h = 400 ;
    }
    else{
        w = 100 ;
        h = 150 ;
    }
    [self animationForCoverImage];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // [self flipImage];
  }
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(UIImage *)imageByRenderingView:(UIImageView *)imageView
{
    CGFloat oldAlpha = self.schoolBagCover.alpha;
    imageView.alpha = 1 ;
    UIGraphicsBeginImageContext(self.schoolBagCover.bounds.size);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageView.alpha = oldAlpha;
    return  image;
}
-(void)flipImage
{
    UIImage *currentImage = [self imageByRenderingView:self.schoolBag];
    UIImage *newImage = [self imageByRenderingView:self.schoolBagCover];
    self.schoolBag.hidden = YES;
    self.schoolBagCover.hidden = YES;
    self.schoolBag.alpha = 0;
    self.schoolBagCover.alpha = 0;

    CGRect rect = self.schoolBagCover.bounds;
    rect.size.width /= 2;
    CALayer *backgroundLayer = [CALayer layer];
    backgroundLayer.frame = self.schoolBag.bounds;
    backgroundLayer.zPosition = -3000000;
    
    CALayer *leftLayer = [CALayer layer];
    leftLayer.frame = rect ;
    leftLayer.masksToBounds = YES;
    leftLayer.contentsGravity = kCAGravityLeft;
    [backgroundLayer addSublayer:leftLayer];
    
    rect.origin.x = rect.size.width;
    CALayer *rightLayer = [CALayer layer];
    rightLayer.frame = rect;
    rightLayer.masksToBounds = YES;
    rightLayer.contentsGravity = kCAGravityRight;
    [backgroundLayer addSublayer:rightLayer];
    
    leftLayer.contents = (id) [currentImage CGImage];
    rightLayer.contents =(id) [newImage CGImage];
    rect.origin.x =  0 ;
    
    CATransformLayer *flipAnimation = [CATransformLayer layer];
    flipAnimation.anchorPoint = CGPointMake(1.0, 0.5);
    flipAnimation.frame = rect;
}

#pragma  mark
#pragma  mark Cover Animation  Method
#pragma  mark

-(UIImageView *)allocImageView:(UIImageView *)imageView
{
    imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = WC ;
    imageView.frame = self.carouselView.frame ;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}
-(void)animationForCoverImage
{
   self.btnBag = [UIButton buttonWithType:UIButtonTypeCustom];
   self.btnBag.frame = self.schoolBagCover.frame ;
  [self.btnBag  addTarget:self  action:@selector(Animation) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:self.btnBag];
}
-(void)Animation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.schoolBagCover cache:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView commitAnimations];
    self.schoolBagCover.image = nil;
    [self performSelector:@selector(removeCoverImageFromMemory) withObject:nil afterDelay:3];
}

-(void)removeCoverImageFromMemory
{
    if (self.schoolBag)
    {
        [self.schoolBag removeFromSuperview];
        self.schoolBag = nil;
    }
    if (self.schoolBagCover)
    {
        [self.schoolBagCover removeFromSuperview];
        self.schoolBagCover = nil;
    }
    if (self.btnBag)
    {
        [self.btnBag removeFromSuperview];
        self.btnBag = nil;
    }
    self.carouselView.type = iCarouselTypeCoverFlow;
    [_carouselView reloadData];
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
    if (view == nil)
    {
       UIView * view = [[UIImageView  alloc]initWithFrame:CGRectMake(5,5,w,h)];
        UIImage *image = [UIImage imageNamed:[self.subjectArray  objectAtIndex:index]];
        ((UIImageView *)view).image = image;
        view.contentMode = UIViewContentModeScaleToFill;
        returnView = view;
    }
    return returnView;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}
- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (view == nil)
    {
        
    }
    return view;
}

#pragma mark -
#pragma mark iCarousel taps
#pragma mark

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(int)index
{
    [self performSegueWithIdentifier:MATHS_VC sender:self];    
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
