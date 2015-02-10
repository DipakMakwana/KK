//
//  CustomTextField.h
//  PEnglish
//
//  Created by I-MAC on 1/7/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField

@property (nonatomic,readwrite)int superViewTag;
@property (nonatomic,readwrite)int ansValue;
@property (nonatomic,retain) NSString *answer;
@end
