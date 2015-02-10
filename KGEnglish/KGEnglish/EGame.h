//
//  EGame.h
//  PEnglish
//
//  Created by I-MAC on 12/16/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGame : UIViewController <UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    CGRect previousframe;
    BOOL blinkStatus;
    int firstTruckCount,secondTruckCount,thirdTruckCount,forthTruckCount,totalTruckCount,score;
    CGRect frameLimit;
    //int viewW ;
   // int viewH ;
    int limitY;
    int W;
    int H;
}

//@property (nonatomic,weak) IBOutlet UIView *scoreView;
@property (nonatomic,weak) IBOutlet UIImageView *roadImage;
//@property (nonatomic,weak) IBOutlet UIImageView *imageView1;
@property (nonatomic,weak) IBOutlet UIView      *view1;
@property (nonatomic,weak) IBOutlet UIView      *view2;
@property (nonatomic,weak) IBOutlet UIView      *view3;
@property (nonatomic,weak) IBOutlet UIView      *view4;
@property (nonatomic,weak) IBOutlet UIView      *viewWin;
@property (nonatomic,weak) IBOutlet UILabel     *lbl1;
@property (nonatomic,weak) IBOutlet UILabel     *lbl2;
@property (nonatomic,weak) IBOutlet UILabel     *lbl3;
@property (nonatomic,weak) IBOutlet UILabel     *lbl4;
@property (nonatomic,weak) IBOutlet UILabel     *lblTime;
@property (nonatomic,weak) IBOutlet UILabel     *lblCongrates;
@property (nonatomic,weak) IBOutlet UIButton    *btnPlayAgain;
@property (nonatomic,retain) NSTimer *timer1 ;
@property (nonatomic,retain) NSTimer *timer2 ;
@property (nonatomic,retain) NSMutableArray *objectArray;

@end
