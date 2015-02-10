//
//  WordVC.m
//  PEnglish
//
//  Created by I-MAC on 12/9/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "WordVC.h"

@interface WordVC ()

@end

@implementation WordVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark 
#pragma mark  View Life Cycle
#pragma mark


- (void)viewDidLoad
{
    [super viewDidLoad];
   /* AppDelegate * appDelegate  = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate setBackgroundColorForViewController:self bColor:WC];*/
        //[self animationForCoverImage];
  
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];   
    
    _carouselView = [[CustomCarsouselVIew   alloc]init];
    _carouselView.delegate = self;
    CGRect carouselFrame = CGRectMake(0,80, 480 , 240);
    CGRect   lblFrame = CGRectMake(80, 0, 300, 50);
    CGRect   pageImageFrame = CGRectMake(0, 0, 50, 260);
    
    [_carouselView initlizationObjectAndDegateFromParentView:self.view AndDelegate:self carouselFrame:carouselFrame labelFrame:lblFrame pageImageFrame:pageImageFrame];
    
     //[self getDataFromDatabase];
    
    [self setInitialValue];
    [self drawSingleWordOnImage];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark
#pragma mark  Other Method
#pragma mark

-(void)setInitialValue
{
    lineWidth = 2 ;
    lastIndex = 0 ;
    fontSize  = 17 ;
    index     = 0 ;
    self.color = BC;
    self.lblColor.backgroundColor = self.color;
    self.lblSize.text = [NSString stringWithFormat:@"%d",lineWidth];
    self.savedImageArray = [[NSMutableArray alloc]init];
    [self addImageView];
}

-(void)addImageView
{
    for(int i = 0 ; i < self.wordArray.count; i++)
    {
        [self configureImageView];
   
    }
}
-(void)configureImageView
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.originalImage.frame];
    imageView.image  = [UIImage imageNamed:BACK_IMAGE1];
     imageView.contentMode = UIViewContentModeScaleToFill;
    [self.savedImageArray addObject:imageView];
}
-(void)drawSingleWordOnImage
{
    [self removeLabel];
    UIImageView *imageView = [self.savedImageArray objectAtIndex:self.selectedIndex];
    [imageView sendSubviewToBack:self.originalImage];
    int y = 20 ;
    NSString *str  = [[self.wordArray objectAtIndex:self.selectedIndex] valueForKey:FLD_WORD_NAME];
    CGRect frame = CGRectMake(5,y,200, fontSize + 10 );
    CommonFile *objCommon = [[CommonFile alloc]init];
    UILabel *lbl = [objCommon configureLabelFrame:frame title:str tColor:BC fontSize:fontSize fontName:FONT2];
    [imageView addSubview:lbl];
    [self.view addSubview:imageView];
    self.tempImage = imageView ;
    y = lbl.frame.origin.y + lbl.frame.size.height + 15 ;
}
-(void)removeLabel
{
    for (UILabel *lbl in self.tempImage.subviews)
    {
        [lbl removeFromSuperview];
    }
}
-(void)drawWordOnImage
{
    self.tempImage.image = nil;
    [self removeLabel];
    int y = 20;
    int limit = lastIndex + gap ;
    for (int i = lastIndex; i<limit; i++)
    {
        if (i < self.wordArray.count)
        {
            NSString *str = [[self.wordArray objectAtIndex:i] valueForKey:FLD_WORD_NAME];
            CGRect frame = CGRectMake(5,y, 200, fontSize + 10);
            CommonFile *objCommon = [[CommonFile alloc]init];
            UILabel *lbl = [objCommon configureLabelFrame:frame title:str tColor:BC fontSize:fontSize fontName:FONT2];
            [self.tempImage addSubview:lbl];
            y =  lbl.frame.origin.y + lbl.frame.size.height +10 ;
        }
    }
}

#pragma  mark
#pragma  mark Animation For Cover Image
#pragma  mark
-(void)animationForCoverImage
{
    self.coverImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    self.coverImage.image = [UIImage imageNamed:COVER_IMAGE2];
    [self.view addSubview: self.coverImage];
    [self performSelector:@selector(Animation) withObject:nil afterDelay:1];
}

-(void)Animation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:_coverImage cache:YES];
    [UIView commitAnimations];
    _coverImage.image = nil;
    [self performSelector:@selector(removeCoverImageFromMemory) withObject:nil afterDelay:5];
}
-(void)removeCoverImageFromMemory
{
    if (self.coverImage)
    {
        [self.coverImage removeFromSuperview];
        self.coverImage = nil;
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag context:(void *)context
{
    [self.view removeFromSuperview];
}
#pragma  mark
#pragma  mark Touch Method 
#pragma  mark

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.tempImage];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.tempImage];
    
    UIGraphicsBeginImageContext(self.tempImage.frame.size);
    [self.tempImage.image drawInRect:CGRectMake(0, 0, self.tempImage.frame.size.width, self.tempImage.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth );
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), _color.CGColor);
    
    if (isEraser)
    {
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeClear);
    }
    else
    {
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    }
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempImage setAlpha:1];
    UIGraphicsEndImageContext();
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!mouseSwiped)
    {
        UIGraphicsBeginImageContext(self.tempImage.frame.size);
        [self.tempImage.image drawInRect:CGRectMake(0, 0, self.tempImage.frame.size.width, self.tempImage.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), _color.CGColor);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

#pragma  mark
#pragma  mark Action Event
#pragma  mark

-(IBAction)saveButtonPressed
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate saveImage:self.view];
    
}
-(IBAction)allButtonClicked;
{
    //[self getDataFromDatabase];
    gap = 5;
    [self drawWordOnImage];
}
-(IBAction)backButtonClicked
{
    if ([[SingletonClass sharedManager]getSystemVersion]<7)
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

-(IBAction)pencilSizeClicked
{
    [self.carouselView carsoulViewForPencilSize];
}
-(IBAction)pencilColorClicked
{
    [self.carouselView carsoulViewForPencilColor];
}
-(IBAction)prevAlphabetClicked:(id)sender
{
    if (self.selectedIndex > 0)
    {
        self.selectedIndex  -- ;
        [self drawSingleWordOnImage];        
    }
}
-(IBAction)nextAlphabetClicked:(id)sender
{
    if (self.selectedIndex< self.wordArray.count-1)
    {
        self.selectedIndex  ++ ;
        //lastIndex = lastIndex + gap;
        [self drawSingleWordOnImage];
    }
}

-(IBAction)eraserClicked
{
    
    if (isEraser)
    {
        lineWidth = 2 ;
        [self.btnEraser setImage:[UIImage imageNamed:ERASER_IMAGE] forState:UIControlStateNormal];
    }
    else
    {
        lineWidth = 5;
        [self.btnEraser setImage:[UIImage imageNamed:WRITTING_IMAGE] forState:UIControlStateNormal];
    }
    isEraser = !isEraser;
    
}
-(IBAction)resetAllClicked{
    
    self.tempImage.image     = [UIImage imageNamed:BACK_IMAGE1];
    self.originalImage.image = [UIImage imageNamed:BACK_IMAGE1];
}
#pragma  mark
#pragma  mark Custom  Delegate Method
#pragma  mark
-(void)doneButtonClickedAndFont:(NSString *)fontName lineWidth:(int)pWidth PColor:(UIColor *)color1 noOfAlpha:(int)noOfAlpha1 string:(NSString *)string
{
    
    isEraser = FALSE;
    lineWidth = pWidth;
    _color  = color1;
    self.fontName = fontName;
    if (lineWidth == 0)  lineWidth = 2 ;
    if (_color == nil) _color = BLC;
    if ( self.fontName == nil)  self.fontName = FONT1;
    [self setInitialValue];
    [self drawWordOnImage];
}


#pragma mark
#pragma mark Memory Managment Method
#pragma mark
-(void)dealloc
{
    [self nilObject:self.color];
    [self nilObject:self.originalImage];
    [self nilObject:self.tempImage];
    [self nilObject:self.coverImage];
    [self nilObject:self.wordArray];
    [self nilObject:self.btnEraser];
    [self nilObject:self.lblColor];
    [self nilObject:self.lblSize];
    [self nilObject:self.carouselView];
    
}
-(void)nilObject:(id)object
{
    if (object) {
        object = nil ;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
