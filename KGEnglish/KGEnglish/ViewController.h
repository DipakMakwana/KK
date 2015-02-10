//
//  ViewController.h
//  KGEnglish
//
//  Created by I-MAC on 4/9/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    BOOL wrap;
    int w ;
    int h ;
}
@property (weak,nonatomic) IBOutlet iCarousel *carouselView;
@property (nonatomic,retain)  UIImageView * schoolBag;
@property (nonatomic,retain)  UIButton *btnBag;

@property (nonatomic,retain) NSArray *subjectArray;
@property (nonatomic,retain) NSArray *coverImageArray;
@end