//
//  CustomCarsouselVIew.h
//  PEnglish
//
//  Created by I-MAC on 12/5/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  CustomCarouselDelegate <NSObject>

@optional

-(void)doneButtonClickedAndFont:(NSString *)fontName lineWidth:(int)pWidth PColor:(UIColor *)color1 noOfAlpha:(int)noOfAlpha1 string:(NSString *)string;

@end

@interface CustomCarsouselVIew : UIView <iCarouselDataSource,iCarouselDelegate>
{
    BOOL mouseSwiped;
    int alphabetNO;
    int lineWidth;
    int noOfAlpha;
    int fontSize;
    CGRect tempFrame;
    CGRect carouselFrame;
    CGRect lblFrame;
    CGRect pageImageFrame;
    BOOL wrap;
    id<CustomCarouselDelegate> delegate;
}

@property (nonatomic,retain) id delegate;
@property (nonatomic,assign) BOOL isiPad;
@property (nonatomic,retain) UIView  *parentView;
@property (nonatomic,retain) UIImageView *selectedImage;
@property (nonatomic,retain) UILabel *lbl;
@property (nonatomic,retain) UIColor *color;
@property (nonatomic,retain) CommonFile *objCommon;
@property (nonatomic,retain) NSArray *singleAlphaArray;
@property (nonatomic,retain) NSArray *alphabetArray;


@property (nonatomic,retain) NSArray  *colorArray;
@property (nonatomic,retain) NSArray  *sizeNumberArray;
@property (nonatomic,retain) NSArray  *fontArray;
@property (nonatomic,retain) NSString *fontName;
@property (nonatomic,retain) NSString *alphabet;
@property (nonatomic,retain) NSString *strTitle;



-(void)initlizationObjectAndDegateFromParentView:(UIView *)parentView AndDelegate:(id)delegate1 carouselFrame:(CGRect)cFrame labelFrame:(CGRect)lFrame pageImageFrame:(CGRect)pFrame ;

-(void)carsoulViewForNoOfAlphabet;

-(void)carsoulViewForPencilSize;

-(void)carsoulViewForPencilColor;

-(void)carsoulViewForFont;

@end
