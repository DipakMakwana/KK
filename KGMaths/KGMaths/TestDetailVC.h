//
//  TestDetailVC.h
//  PEnglish
//
//  Created by I-MAC on 1/1/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "Database.h"

@interface TestDetailVC : UIViewController <UITextFieldDelegate>
{
    CGPoint lastPoint;
    
    BOOL mouseSwiped,isEraser,isAscending;
    
    int lineWidth;
    
    UIColor *color;
    
     NSString * sign;
   
}

@property (nonatomic,readwrite)int testNumber;

@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic,weak) IBOutlet UIButton *btnHeader;

@property (nonatomic,weak) IBOutlet UIButton *btnEraser;

@property (nonatomic,retain)IBOutlet TouchView *myImageView;

@property (nonatomic,retain) CustomTextField *myTextField;

@property (nonatomic,retain) NSMutableArray *numberArray;

@property (nonatomic,retain) NSArray * imageArray ;

@property (nonatomic,retain) NSString *buttonTitle;

-(IBAction)refreshButtonClicked;

@end
