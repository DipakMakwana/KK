//
//  MathsVC.h
//  PEnglish
//
//  Created by I-MAC on 12/14/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestDetailVC.h"
@interface MathsVC : UIViewController
{
    BOOL wrap;
    int w ;
    int h ;
    int fontSize;
}
@property (weak,nonatomic) IBOutlet iCarousel *carouselView;

@property (nonatomic,readwrite)int testNumber;

@property (nonatomic,retain) UIImageView *coverImage;

@property (nonatomic,retain) NSArray *indexArray;
@end
