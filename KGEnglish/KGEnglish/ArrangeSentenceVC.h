//
//  ArrangeSentenceVC.h
//  PEnglish
//
//  Created by I-MAC on 12/28/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArrangeSentenceVC : UIViewController <UIGestureRecognizerDelegate>

{
   CGRect previousframe;
   int strLength;
   int charCount;
   int w;
   int h;
    
}
@property (nonatomic,retain) NSString *finalStr;
@property (nonatomic,retain) NSString *strWord;
@property (nonatomic,retain) NSTimer *timer; 
@property (nonatomic,retain) UIView *carView;
@end
