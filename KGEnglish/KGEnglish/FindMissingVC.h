//
//  FindMissingVC.h
//  PEnglish
//
//  Created by I-MAC on 12/11/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface FindMissingVC : UIViewController <UITextFieldDelegate>
{
    CGPoint lastPoint;
    BOOL mouseSwiped,isEraser;
    int lastIndex,limit;
    int diffrence;
    int txtPageTag;

}

//@property (weak, nonatomic)  IBOutlet UIImageView *originalImage;
@property (weak, nonatomic)  IBOutlet UIScrollView *scrollView;
@property  (weak,nonatomic)  IBOutlet UILabel  *lblHeader;
@property (weak, nonatomic)  IBOutlet UIButton *btnEraser;
@property (nonatomic,retain) UIImageView * coverImage;
@property (nonatomic,retain) NSMutableArray *testArray;
@property (nonatomic,readwrite) int testIndex;


@end
