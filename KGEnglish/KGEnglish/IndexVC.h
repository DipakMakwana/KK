//
//  IndexVC.h
//  PEnglish
//
//  Created by I-MAC on 11/29/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexVC : UIViewController <iCarouselDataSource,iCarouselDelegate>
{
    int w ;
    int h ;
    
    int fontSize;
}

@property (weak,nonatomic) IBOutlet iCarousel *carouselView;
@property (nonatomic,retain) UIImageView *coverImage;
@property (retain,nonatomic) NSArray *indexArray;
@property (nonatomic,assign) BOOL wrap;
@end
