//
//  TouchView.h
//  PEnglish
//
//  Created by I-MAC on 12/16/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TouchDelegate
@optional
    -(void)touchEnded:(UIImageView *)imageView;
@end

@interface TouchView :  UIImageView
{
    CGPoint lastPoint;
    BOOL mouseSwiped,isEraser;
    int lineWidth;
    id<TouchDelegate> delegate;
}
@property (nonatomic,retain) id delegate;

@property (nonatomic,retain) UIColor *color;

-(void)initImage:(UIImageView *)imageView color:(UIColor *)color;

-(void)eraserButtonClicked:(BOOL)eraser;

@end
