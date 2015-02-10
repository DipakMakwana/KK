//
//  VowelsVC.h
//  PEnglish
//
//  Created by I-MAC on 12/11/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VowelsVC : UIViewController
{
    int vowelNumber;
   
}

@property (nonatomic,weak) IBOutlet UIButton *btn1;
@property (nonatomic,weak) IBOutlet UIButton *btn2;
@property (nonatomic,weak) IBOutlet UILabel  *lblHeader;
@property (nonatomic,weak) IBOutlet UILabel  *lbl1;
@property (nonatomic,weak) IBOutlet UILabel  *lbl2;
@property (nonatomic,retain) NSArray         *vowelsArray;
@property (nonatomic,retain) UIImageView     *coverImage;
@property (nonatomic,retain) SpeechToText *objSTT;
@end
