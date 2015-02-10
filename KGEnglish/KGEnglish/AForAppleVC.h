//
//  AForAppleVC.h
//  PEnglish
//
//  Created by I-MAC on 12/5/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <AVFoundation/AVFoundation.h>
@interface AForAppleVC : UIViewController
{
    AVAudioPlayer *_googlePlayer;
    int alphabetNO;
   
}

//@property (nonatomic,retain) NSString * speechText;
//////////////////////////////////////////////////////////////////////

@property (weak, nonatomic) IBOutlet UILabel     *lblCapsAlpha;
@property (weak, nonatomic) IBOutlet UILabel     *lblSmallAlpha;
@property (weak, nonatomic) IBOutlet UIView      *view1;
@property (weak, nonatomic) IBOutlet UIView      *view2;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UILabel     *lbl1;
@property (weak, nonatomic) IBOutlet UILabel     *lbl2;
@property (weak, nonatomic) IBOutlet UIButton    *btn1;
@property (weak, nonatomic) IBOutlet UIButton    *btn2;
@property (nonatomic,retain) SpeechToText        *objSTT;
@property (nonatomic,retain) UIImageView    *coverImage;
@property (nonatomic,retain) NSMutableArray *alphabetArray;
@property (nonatomic,retain) NSDictionary   *alphabetDic;
- (IBAction)btnImageClicked:(id)sender;

@end
