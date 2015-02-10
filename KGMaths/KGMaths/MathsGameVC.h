//
//  MathsGameVC.h
//  PEnglish
//
//  Created by I-MAC on 1/31/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
@interface MathsGameVC : UIViewController
{
    
    int ansValue;
    int attempCount;
    int time;
    int score;
    int limitY;
    int ballonGap;
    int ballonCount;
    BOOL result;
    BOOL fromRight;
    int  ranAnsInBtn;

    
}
@property (nonatomic,weak) IBOutlet UIImageView *ballonImage;
@property (nonatomic,weak) IBOutlet UIImageView *mainImage;
@property (nonatomic,weak) IBOutlet UILabel *lblScore;
@property (nonatomic,weak) IBOutlet UILabel *lblRemain;
@property (nonatomic,weak) IBOutlet UILabel *lblTime;

@property (nonatomic,retain) NSTimer *timeTimer;

@property (nonatomic,retain) NSTimer *ballonTimer;

@property (nonatomic,weak) IBOutlet CustomButton *btn1;
@property (nonatomic,weak) IBOutlet CustomButton *btn2;
@property (nonatomic,weak) IBOutlet CustomButton *btn3;
@property (nonatomic,weak) IBOutlet CustomButton *btn4;
@property (nonatomic,weak) IBOutlet CustomButton *btn5;
@property (nonatomic,weak) IBOutlet CustomButton *btn6;
@property (nonatomic,weak) IBOutlet CustomButton *btn7;
@property (nonatomic,weak) IBOutlet CustomButton *btn8;
@property (nonatomic,weak) IBOutlet CustomButton *btn9;
@property (nonatomic,weak) IBOutlet CustomButton *btn10;


@end
