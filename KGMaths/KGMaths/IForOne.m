//
//  IForOne.m
//  PEnglish
//
//  Created by I-MAC on 12/16/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "IForOne.h"

@interface IForOne ()

@end

@implementation IForOne

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma  mark 
#pragma  mark  View Life Cycle
#pragma  mark
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    startNo = 0 ;
    colCount = 0 ;
    
    
    [self drawNumberInImage];
    //[self drawSingleNumberInImageForNext];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma  mark
#pragma  mark  Other Method
#pragma  mark

/*-(void)drawSingleNumberInImageForPrev
{
    [self commonCode];
    NSArray * oneToTwenty = [self arrayOneToTwenty];
    NSArray * twentyToHundred = [self arrayTwentyToHundred];
    
    for (int i =startNo ; i<startNo + numberGap ; i++)
    {
        NSString * finalString = @"";
        if (startNo < 20)
        {
            finalString = [NSString stringWithFormat:@"%d - %@ ",i + 1 ,[oneToTwenty objectAtIndex:i]];
        }
        else if (startNo >= 20 && startNo <= 100 )
        {
            NSString *str = [twentyToHundred objectAtIndex:colCount];
            NSLog(@"%d ",tenthNo);
              tenthNo -- ;
            if (tenthNo <  0)
            {
                tenthNo = 9 ;
                colCount -- ;
                finalString = [NSString stringWithFormat:@"%d - %@ %@ ",i+1,str,[oneToTwenty objectAtIndex:tenthNo-1]];
            }
            else if (tenthNo > 0)
            {
               str = [twentyToHundred objectAtIndex:colCount];
                finalString = [NSString stringWithFormat:@"%d - %@ %@ ",i+1,str,[oneToTwenty objectAtIndex:tenthNo-1]];
            }
            else
            {
                finalString = [NSString stringWithFormat:@"%d - %@",i+1,str];
            }
        }
        CommonFile *obj = [[CommonFile alloc]init];
        UILabel *lbl = [obj configureLabelFrame:frame title:finalString tColor:BC fontSize:fontSize  fontName:FONT_D2];
        lbl.backgroundColor  = [UIColor redColor];
        [self.touchImage addSubview:lbl];
        finalString = [NSMutableString stringWithFormat:@""];
    }
}*/

/*-(void)drawSingleNumberInImageForNext
{
    [self commonCode];
  
    NSArray * oneToTwenty = [self arrayOneToTwenty];
    NSArray * twentyToHundred = [self arrayTwentyToHundred];
    
    for (int i =startNo ; i<startNo + numberGap ; i++)
    {
            NSString * finalString = @"";
        if (startNo < 20)
        {
            finalString = [NSString stringWithFormat:@"%d - %@ ",i + 1 ,[oneToTwenty objectAtIndex:i]];
        }
        else if (startNo >= 20 && startNo <= 100 )
        {
          
            NSString *str = [twentyToHundred objectAtIndex:colCount];
            if (tenthNo == 9)
            {
                tenthNo = -1 ;
                colCount ++ ;
                str = [twentyToHundred objectAtIndex:colCount];
                finalString = [NSString stringWithFormat:@"%d - %@",i+1,str];
            }
            else
            {
                finalString = [NSString stringWithFormat:@"%d - %@ %@ ",i+1,str,[oneToTwenty objectAtIndex:tenthNo]];
            }
             tenthNo ++ ;
        }
        
        CommonFile *obj = [[CommonFile alloc]init];
        UILabel *lbl = [obj configureLabelFrame:frame title:finalString tColor:BC fontSize:fontSize  fontName:FONT_D2];
         [self.touchImage addSubview:lbl];
        
        finalString = [NSMutableString stringWithFormat:@""];
    }
}*/
-(void)drawNumberInImage
{
    [self commonCode];
    
    NSLog(@"Col Count = %d ",colCount);
    oriX = 10 ;
    oriY = 50 ;
   
    fontSize = 40;
    frame = CGRectMake(oriX,oriY,400,fontSize+5);
    x = oriX;
    y = oriY;
    NSArray * oneToTwenty = [self arrayOneToTwenty];
    NSArray * twentyToHundred = [self arrayTwentyToHundred];
    
    for (int i = startNo; i<startNo + 10; i++)
    {
        NSString * finalString = @"";
        if (startNo < 20)
        {
            finalString = [NSString stringWithFormat:@"%d - %@ ",i + 1 ,[oneToTwenty objectAtIndex:i]];
        }
        else
        {
            if ( i == (startNo + 9))
            {
                finalString = [NSString stringWithFormat:@"%d - %@ ",i + 1 ,[twentyToHundred objectAtIndex:colCount-miniusNumber]];
            }
            else
            {
                finalString = [NSString stringWithFormat:@"%d - %@ %@",i + 1 ,[twentyToHundred objectAtIndex:colCount-(1+miniusNumber)],[oneToTwenty objectAtIndex:i-startNo]];
            }
        }
        CGRect frame1 = CGRectMake(x,y,frame.size.width,fontSize+6);
        CommonFile *obj = [[CommonFile alloc]init];
        UILabel *lbl = [obj configureLabelFrame:frame1 title:finalString tColor:BC fontSize:fontSize  fontName:FONT_D2];
       // lbl.backgroundColor = [UIColor redColor];
        [self.touchImage addSubview:lbl];
        finalString = [NSMutableString stringWithFormat:@""];
        if (isIpad)
        {
            y = y + frame.size.height+0;
        }
        else
        {
            y = y + frame.size.height+ 19;
        }
    }
}

#pragma  mark 
#pragma  mark Common Code Method
#pragma  mark

-(void)commonCode
{
    for (UILabel *lbl in self.touchImage.subviews)
    {
        [lbl removeFromSuperview];
    }
}
-(NSArray *)arrayOneToTwenty
{
    NSArray *oneToTwenty =[[NSArray alloc]initWithObjects:@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eight",@"Nine",@"Ten",@"Eleven",@"Twelve",@"Thirteen",@"Fourteen",@"Fifteen",@"Sixteen",@"Seventeen",@"Eighteen",@"Nineteen",@"Twenty", nil];
     return oneToTwenty;
}

-(NSArray *)arrayTwentyToHundred
{
     NSArray *twentyToHundred = [[NSArray alloc]initWithObjects:@"Twenty",@"Thirty",@"Forty",@"Fifty",@"Sixty",@"Seventy",@"Eighty",@"Ninety",@"Hundred",nil];
    return twentyToHundred;
}
-(UILabel*)configureLabelFrame:(CGRect)frame1 title:(NSString *)title tColor:(UIColor *)tColor fontSize:(int)fontSize1 fontName:(NSString *)fontName
{
    UILabel *lbl = [[UILabel alloc]init];
    lbl.frame =frame1;
    lbl.text = title;
    lbl.textColor =tColor;
    lbl.font = [UIFont fontWithName:fontName size:fontSize1];
    lbl.backgroundColor = CC;
    lbl.textAlignment = NSTextAlignmentCenter;
    return lbl;
}
#pragma  mark
#pragma  mark Action  Method
#pragma  mark
-(IBAction)backButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)eraserClicked
{
    isEraser =!isEraser;
    [self.touchImage eraserButtonClicked:isEraser];
}
-(IBAction)resetAllClicked{
    
    self.touchImage.image = nil;
    self.touchImage.image = [UIImage imageNamed:@"fourLine.jpg"];
    
}

-(IBAction)singleNumberClicked
{
    startNo = 0 ;
    colCount = 0 ;

   /* if (isSingleNumber)
    {
        [self  drawSingleNumberInImageForNext];
    }
    else
    {
        [self drawNumberInImage];
    }*/
}
-(IBAction)prevAlphabetClicked:(id)sender
{
     if (startNo > 0)
     {
        startNo = startNo - 10;
        colCount--;
        miniusNumber = 1 ;
        [self drawNumberInImage];
         
     }
     else if (startNo >= 10)
     {
        startNo = startNo - 10;
        colCount -- ;
        [self drawNumberInImage];
     }
}
-(IBAction)nextAlphabetClicked:(id)sender
{
    if (startNo < 90)
    {
        startNo = startNo + 10;
         miniusNumber = 0 ;
        [self drawNumberInImage];
        colCount ++ ;
    }
}

 -(IBAction)saveButtonPressed
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate saveImage:self.view];
}

#pragma  mark 
#pragma  mark  Memory Management
#pragma  mark

-(void)dealloc
{
    self.touchImage.delegate = nil ; 
    [self nilObjcet:self.coverImage];
    [self nilObjcet:self.touchImage];
}
-(void)nilObjcet:(id)object
{
    if (object)
    {
        object = nil ;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
