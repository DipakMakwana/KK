//
//  SynonymsAntonymousVC.h
//  PEnglish
//
//  Created by I-MAC on 2/8/14.
//  Copyright (c) 2014 Indies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SynonymsAntonymousVC : UIViewController
{
    int index;
}
@property (nonatomic,retain) NSArray *arrayObjects;
@property (nonatomic,weak) IBOutlet UILabel *lbl1;
@property (nonatomic,weak) IBOutlet UILabel *lbl2;
@property (nonatomic,weak) IBOutlet UIImageView *image1;
@property (nonatomic,weak) IBOutlet UIImageView *image2;
@end
