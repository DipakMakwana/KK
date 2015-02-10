//
//  ViewController.h
//  PEnglish
//
//  Created by I-MAC on 11/29/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    BOOL  wrap;
    int w;
    int h;
    ////
    NSInteger currentPage;
    NSInteger numberOfPages;
    
    NSInteger pageDifference;
    
    UIView *currentView;
    UIView *newView;
    
    // shadows
    CALayer *frontLayerShadow;
    CALayer *backLayerShadow;
    CALayer *leftLayerShadow;
    CALayer *rightLayerShadow;
    // shadows
    
    CALayer *backgroundAnimationLayer;
    CALayer *flipAnimationLayer;
    CALayer *blankFlipAnimationLayerOnLeft1;
    CALayer *blankFlipAnimationLayerOnRight1;
    
    CALayer *blankFlipAnimationLayerOnLeft2;
    CALayer *blankFlipAnimationLayerOnRight2;
    
  //  AFKPageFlipperDirection flipDirection;
    float startFlipAngle;
    float endFlipAngle;
    float currentAngle;
    
    BOOL setNewViewOnCompletion;
    BOOL animating;
    
    BOOL disabled;
    
    UIImage *flipIllusionPortrait;
    UIImage *flipIllusionLandscape;
}

@property (nonatomic,weak) IBOutlet iCarousel *carouselView;
@property (nonatomic,weak) IBOutlet UIImageView * schoolBagCover;
@property (nonatomic,weak) IBOutlet UIImageView * schoolBag;
@property (nonatomic,retain) UIButton *btnBag;
@property (nonatomic,retain) NSArray *subjectArray;
@property (nonatomic,retain) NSArray *coverImageArray;

@end
