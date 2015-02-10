//
//  PictureCell.h
//  KGEnglish
//
//  Created by I-MAC on 4/24/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h" 

@interface PictureCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView *imageView1;

@property (nonatomic,weak) IBOutlet UIImageView *imageView2;

@property (nonatomic,weak) IBOutlet UIImageView *imageView3;

@property (nonatomic,weak) IBOutlet UIImageView *imageView4;

@property (nonatomic,weak) IBOutlet CustomTextField *txt1;

@property (nonatomic,weak) IBOutlet CustomTextField *txt2;

@property (nonatomic,weak) IBOutlet CustomTextField *txt3;

@property (nonatomic,weak) IBOutlet CustomTextField *txt4;


@end
