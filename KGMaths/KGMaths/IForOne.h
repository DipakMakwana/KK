//
//  IForOne.h
//  PEnglish
//
//  Created by I-MAC on 12/16/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchView.h"

@interface IForOne : UIViewController <TouchDelegate>
{
    int startNo; // endNo
    int colCount;
    BOOL isEraser; //isSingleNumber
    CGRect frame ;
    int fontSize;
    int oriX;
    int oriY;
    int x;
    int y;
    int miniusNumber;
}
@property (nonatomic,weak) IBOutlet TouchView *touchImage;

@property (nonatomic,weak) IBOutlet TouchView *originalImage;

@property (nonatomic,weak) IBOutlet UIButton *btnEraser;

@property (nonatomic,retain) UIImageView *coverImage;

@property (nonatomic,retain) NSMutableArray *savedImageArray;


@end
