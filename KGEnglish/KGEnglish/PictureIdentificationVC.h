//
//  PictureIdentificationVC.h
//  PEnglish
//
//  Created by I-MAC on 12/30/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "PictureCell.h"
@interface PictureIdentificationVC : UIViewController <UITextFieldDelegate>
{
    int startNumber,reminder;
    int limit;   
    int imageW;
    int imageH;
    CGFloat _initialTVHeight;
}

@property (nonatomic,weak) IBOutlet UIScrollView * scroll;

@property (nonatomic,weak) IBOutlet UITableView *tableView;

@property (nonatomic,retain) NSArray *imageArray;



@end
