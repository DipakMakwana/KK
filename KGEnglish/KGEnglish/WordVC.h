//
//  WordVC.h
//  PEnglish
//
//  Created by I-MAC on 12/9/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordVC : UIViewController
{
    CGPoint lastPoint;
    BOOL mouseSwiped;
    int lineWidth;
    int lastIndex;
    BOOL isEraser;
    int gap;
    int fontSize;
    int index ; 
}
@property (weak, nonatomic)  IBOutlet UIImageView *originalImage;
@property (weak, nonatomic)  IBOutlet UIImageView *tempImage;
@property (weak, nonatomic)  IBOutlet UIButton *btnEraser;
@property (weak, nonatomic)  IBOutlet UILabel *lblSize;
@property (weak, nonatomic)  IBOutlet UILabel *lblColor;

@property (nonatomic,retain) CustomCarsouselVIew *carouselView;
@property (nonatomic,retain) UIColor *color;
@property (nonatomic,retain) UIImageView * coverImage;
@property (nonatomic,retain) NSMutableArray *wordArray;
@property (nonatomic,retain) NSMutableArray *savedImageArray;
@property (nonatomic,retain) NSString *fontName;
//@property (nonatomic,retain) NSArray *wordDic;
@property (nonatomic,readwrite) int selectedIndex;
@end
