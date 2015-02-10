//
//  ABCDVC.h
//  PEnglish
//
//  Created by I-MAC on 12/4/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCarsouselVIew.h"

@interface ABCDVC : UIViewController <CustomCarouselDelegate>
{
    CGPoint lastPoint;
    BOOL mouseSwiped,isEraser;
    int lineWidth;
    int w ;
    int h ;
    
}

@property (weak, nonatomic)  IBOutlet UIImageView *originalImage;
@property (weak, nonatomic)  IBOutlet UIImageView *tempImage;
@property (weak, nonatomic)  IBOutlet UIButton *btnEraser;
@property (weak, nonatomic)  IBOutlet UILabel *lblSize;
@property (weak, nonatomic)  IBOutlet UILabel *lblColor;
@property (weak, nonatomic)  IBOutlet UILabel *lblFontName;

@property (nonatomic,retain) UIImageView * coverImage;
@property (nonatomic,retain) NSArray *abcdArray;
@property (nonatomic,retain) UIView *customView;
@property (nonatomic,retain) UIColor *color;
@property (nonatomic,retain) NSArray *alphabetArray;
@property (nonatomic,retain) NSString *fontName;
@property (nonatomic,retain) CustomCarsouselVIew *carouselView;
@property (nonatomic,retain) NSString *strTitle;

@end
