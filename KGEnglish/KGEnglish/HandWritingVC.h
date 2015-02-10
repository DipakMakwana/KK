//
//  HandWritingVC.h
//  Alphabets
//
//  Created by I-MAC on 11/27/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> 

@interface HandWritingVC : UIViewController <CustomCarouselDelegate>
{
    CGPoint lastPoint;
    BOOL mouseSwiped,isEraser;
    int alphabetNO;
    int  lineWidth;
    int noOfAlpha;
    int fontSize;
   


}
@property (weak, nonatomic)  IBOutlet UIImageView *originalImage;
@property (weak, nonatomic)  IBOutlet UIImageView *tempImage;
@property (weak, nonatomic)  IBOutlet UIButton *btnEraser;
@property (weak, nonatomic)  IBOutlet UILabel *lblNoOfFont;
@property (weak, nonatomic)  IBOutlet UILabel *lblSize;
@property (weak, nonatomic)  IBOutlet UILabel *lblColor;
@property (weak, nonatomic)  IBOutlet UILabel *lblFontName;


@property (nonatomic,retain) UIView  *customView;

@property (nonatomic,retain) UIImageView * coverImage;
@property (nonatomic,retain) UIColor *color;
@property (nonatomic,retain) NSArray *alphabetArray;
@property (nonatomic,retain) NSString *fontName;
@property (nonatomic,retain) NSString *alphabet;
@property (nonatomic,retain) NSString *strTitle;

@property (nonatomic,retain) CustomCarsouselVIew *carouselView;





@end
