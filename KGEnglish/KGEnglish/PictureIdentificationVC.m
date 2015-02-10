
//
//  PictureIdentificationVC.m
//  PEnglish
//
//  Created by I-MAC on 12/30/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "PictureIdentificationVC.h"
//#define WIDTH  80
//#define HEIGHT 75

@interface PictureIdentificationVC ()

@end

@implementation PictureIdentificationVC



-(id) initWithNibName:(NSString*)nibNameOrNil bundle:nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[SingletonClass sharedManager]addKeyboardNotificationInVC:self];
    Database * objDB = [[Database alloc]init];
    self.imageArray =[objDB getImagesforAlphabet];
    imageW = imageH = 75;
    limit = self.imageArray.count;
    
    if ([[SingletonClass sharedManager]isIpad])
    {
        imageW =  imageH = 150;
        if (limit >= 18)
        {
            limit = 18;
        }
    }
    else
    {
        if (limit >= 8)
        {
            limit = 8;
        }
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark
#pragma mark Keyboard Method
#pragma mark

-(void) keyboardShown:(NSNotification*) notification
{
    _initialTVHeight = _tableView.frame.size.height;
    
    CGRect initialFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect convertedFrame = [self.view convertRect:initialFrame fromView:nil];
    CGRect tvFrame = _tableView.frame;
    tvFrame.size.height = convertedFrame.origin.y;
    _tableView.frame = tvFrame;
}

-(void) keyboardHidden:(NSNotification*) notification
{
    CGRect tvFrame = _tableView.frame;
    tvFrame.size.height = _initialTVHeight;
    [UIView beginAnimations:@"TableViewDown" context:NULL];
    [UIView setAnimationDuration:0.3f];
    _tableView.frame = tvFrame;
    [UIView commitAnimations];
}

#pragma mark
#pragma mark Configuration Method
#pragma mark

 -(void)configureTextField:(CustomTextField*)txt rowIndex:(NSInteger)rowIndex arrayIndex:(NSInteger)arrayIndex
{
    txt.borderStyle = UITextBorderStyleRoundedRect;
    txt.hidden =  FALSE ;
    txt.textAlignment = NSTextAlignmentCenter;
    txt.font = [UIFont fontWithName:FONT_GILL_SANS size:17];
    txt.superViewTag = rowIndex;
    txt.answer =[[[self.imageArray objectAtIndex:arrayIndex] valueForKey:FLD_IMAGE_1] stringByDeletingPathExtension];
    txt.answer = [txt.answer substringToIndex:[txt.answer length]-2];
    NSLog(@"answer - %@ ",txt.answer);
    
}

 -(void )configureImageView:(UIImageView *)imageView cell:(UITableViewCell*)cell arrayIndex:(NSInteger)arrayIndex
{
    imageView.image = [UIImage imageNamed:[[self.imageArray objectAtIndex:arrayIndex] valueForKey:FLD_IMAGE_1]];
    imageView.layer.borderColor = RC.CGColor;
    imageView.layer.borderWidth = 1 ;
    imageView.layer.cornerRadius = 2 ;
    imageView.layer.masksToBounds = YES;
    
}
#pragma mark
#pragma mark CustomTextField Delegate Method
#pragma mark

- (BOOL)textFieldShouldReturn:(CustomTextField *)textField
{
     self.scroll.contentOffset = CGPointMake(0, 0);
    CustomTextField * txt = (CustomTextField*)textField;
     [txt resignFirstResponder];
    if( [txt.text caseInsensitiveCompare:txt.answer] == NSOrderedSame)
           txt.backgroundColor = GC;
    else   txt.backgroundColor = RC;
    return  YES ;
}
-(void) textFieldDidBeginEditing:(CustomTextField *)textField
{
    CustomTextField *txt = (CustomTextField *)textField;
    int row  = txt.superViewTag;
    
    if (row>=1)
    {
        self.tableView.contentOffset = CGPointMake(0, row*self.tableView.rowHeight);
    }
}
    
    
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

#pragma  mark
#pragma  mark Action Method
#pragma  mark
-(IBAction)saveImageButtonClicked
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate saveImage:self.view];
}

-(IBAction)backButtonClicked
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma  mark
#pragma  mark  UITable View  Method
#pragma  mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ceilf([self.imageArray count] / 4.0) + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseIdentifier = PICTURE_CELL;
    PictureCell *cell;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:reuseIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSInteger arrayIndex = indexPath.row * 4;
    if (arrayIndex < [self.imageArray count])
    {
        if (arrayIndex < self.imageArray.count)  // IMAGE 1
        {
            [self configureImageView:cell.imageView1  cell:cell arrayIndex:arrayIndex];
            [self configureTextField:cell.txt1 rowIndex:indexPath.row arrayIndex:arrayIndex];
            arrayIndex++;
        }
        if (arrayIndex < self.imageArray.count)  // IMAGE 2
        {
            [self configureImageView:cell.imageView2  cell:cell arrayIndex:arrayIndex];
            [self configureTextField:cell.txt2 rowIndex:indexPath.row arrayIndex:arrayIndex];
            arrayIndex++;
        }
        if (arrayIndex < self.imageArray.count)  // IMAGE 3
        {
            [self configureImageView:cell.imageView3 cell:cell arrayIndex:arrayIndex];
            [self configureTextField:cell.txt3 rowIndex:indexPath.row arrayIndex:arrayIndex];
            arrayIndex++;
        }
        if (arrayIndex < self.imageArray.count)  // IMAGE 4
        {
            [self configureImageView:cell.imageView4 cell:cell arrayIndex:arrayIndex];
            [self configureTextField:cell.txt4 rowIndex:indexPath.row arrayIndex:arrayIndex];
            arrayIndex++;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark
#pragma mark Memory Managment Method
#pragma mark

-(void)dealloc
{
    [self nilObject:self.scroll];
    [self nilObject:self.imageArray];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}
-(void)nilObject:(id)object
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
