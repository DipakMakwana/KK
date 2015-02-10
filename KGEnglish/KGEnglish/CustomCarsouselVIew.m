//
//  CustomCarsouselVIew.m
//  PEnglish
//
//  Created by I-MAC on 12/5/13.
//  Copyright (c) 2013 Indies. All rights reserved.
//

#import "CustomCarsouselVIew.h"

@implementation CustomCarsouselVIew

@synthesize  delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        // Initialization code
    }
    return self;
}
-(void)initlizationObjectAndDegateFromParentView:(UIView *)parentView AndDelegate:(id)delegate1 carouselFrame:(CGRect)cFrame labelFrame:(CGRect)lFrame pageImageFrame:(CGRect)pFrame
{
    _objCommon =[[CommonFile alloc]init];
    _objCommon.delegate = self;
    _objCommon.parentView = parentView;
    _delegate = delegate1;
    _parentView = parentView;
    carouselFrame = cFrame;
    lblFrame = lFrame;
    pageImageFrame = pFrame;
    self.isiPad =  [[SingletonClass sharedManager]isIpad];
}


#pragma  mark
#pragma  mark Custom  Delegate Method
#pragma  mark
-(void)doneButtonClicked
{
    alphabetNO = 0;
    [self removeCarsoulView];
    if ([_delegate respondsToSelector:@selector(doneButtonClickedAndFont:lineWidth:PColor:noOfAlpha:string:)]) {
        [_delegate doneButtonClickedAndFont:_fontName lineWidth:lineWidth PColor:_color noOfAlpha:noOfAlpha string:_strTitle];
    }
}
-(void)pencilSizeButtonClicked:(id)sender
{
    [self carsoulViewForPencilSize];
}
-(void)selectedFont:(id)sender
{
    [self carsoulViewForFont];
}


-(void)pencilColorButtonClicked:(id)sender
{
    [self carsoulViewForPencilColor];
}

-(void)numberOfAlphabet:(id)sender
{
    if ([sender tag] == NO_ALPHA_B_T_0) {
        [self carsoulViewForNoOfAlphabet];
    }
    
}
#pragma mark -
#pragma mark  Other Method
#pragma mark

-(void)removeCarsoulView
{
    for (UIView * v  in _parentView.subviews){
        if ([v isKindOfClass:[iCarousel class]]) {
            [v removeFromSuperview];
        }
    }
}
-(UILabel*)configureLabelFrame:(CGRect)frame title:(NSString *)title tColor:(UIColor *)tColor fontSize:(int)fontSize1 fontName:(NSString *)fontName{
    UILabel *lbl = [[UILabel alloc]init];
    lbl.frame =frame;
    lbl.text = title;
    lbl.textColor =tColor;
    lbl.font = [UIFont fontWithName:fontName size:fontSize1];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    return lbl;
}

#pragma mark -
#pragma mark iCarousel methods For No Of Alphabet
#pragma mark

-(void)carsoulViewForNoOfAlphabet
{
    [self removeCarsoulView];
    _singleAlphaArray = [[NSArray alloc]initWithObjects:@"A",@"AA",@"AAA",@"AAAA",@"a",@"aa",@"aaa",@"aaaa", nil];

     [self commonLayoutInCarouselViewForFrame:carouselFrame viewTag:CARSOUL_V_A_T labelText:@"Select Number of Alphabet" bColor:BC  array:_sizeNumberArray defaultImage:PAGE_IMAGE  contentMode:UIViewContentModeScaleToFill defaultText:@"A" fontName:FONT_D2] ;
}

-(UIView *)carsoulArrangmentForNoOfAlphabetAndIndex:(int)index
{
    
    UIView * view = [[UIImageView  alloc]initWithFrame:pageImageFrame];
    
    UIImage *image = [UIImage imageNamed:PAGE_IMAGE];
    ((UIImageView *)view).image = image;
    view.contentMode = UIViewContentModeScaleToFill;
    
    [self getFrameAndFontFromIndexForAlphabet:index];
    
    UILabel * lbl = [self configureLabelFrame:tempFrame title:[_singleAlphaArray objectAtIndex:index] tColor:BC fontSize:fontSize fontName:FONT_D2];
    lbl.tag = ALPHABET_LBL_TAG;
    lbl.numberOfLines =0;
    //lbl.backgroundColor = RC ;
    lbl.lineBreakMode = NSLineBreakByCharWrapping;
    [view addSubview:lbl];
    
    return view;
}

-(void)getFrameAndFontFromIndexForAlphabet:(int)index
{
    int h = 260;
    if (index == 0 || index == 4 ) {
        
        if (self.isiPad) {
            fontSize  = 150;
            tempFrame =CGRectMake(25, 170, fontSize , h);
        }else{
            fontSize  = 50;
            tempFrame =CGRectMake(0, 0, fontSize , h);
        }
    }
    else if (index == 1 || index == 5) {
        if (self.isiPad) {
            fontSize  = 110;
            tempFrame =CGRectMake(50, 170, fontSize , h);
        }else{
            fontSize = 40;
            tempFrame =CGRectMake(5, 0, fontSize, h);
        }        
    }
    else if (index == 2 || index == 6 ) {
        if (self.isiPad) {
            fontSize  = 80;
            tempFrame =CGRectMake(50, 170, fontSize , h);
        }else{
            fontSize = 30;
            tempFrame =CGRectMake(20, 0, fontSize, h);
        }
        
    }
    else if (index == 3 || index == 7) {
        if (self.isiPad) {
            fontSize  = 60;
            tempFrame =CGRectMake(60, 170, fontSize , h);
        }else{
            fontSize = 20;
            tempFrame =CGRectMake(15, 0, fontSize, h);
        }
        
    }
//    else if (index == 4 ||index == 8 ) {
//        
//        if (self.isiPad) {
//            fontSize  = 60;
//            tempFrame =CGRectMake(60, 170, fontSize , h);
//        }else{
//            fontSize = 18;
//            tempFrame =CGRectMake(15, 0, fontSize, h);
//        }
//       
//    }
//    else if (index == 5 ||index == 11) {
//        fontSize = 15;
//        tempFrame =CGRectMake(15, 0, fontSize, h);
//    }
//    else if (index == 10) {
//        fontSize = 15;
//        tempFrame =CGRectMake(15, 0, fontSize, h);
//    }
    
}

#pragma mark -
#pragma mark iCarousel methods For Pencil Size
#pragma mark

-(void)carsoulViewForPencilSize
{
    [self removeCarsoulView];
    if (self.selectedImage) {
        [self.selectedImage removeFromSuperview];
        self.selectedImage = nil;
    }
    _sizeNumberArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    
     [self commonLayoutInCarouselViewForFrame:carouselFrame viewTag:CARSOUL_V_S_T labelText:@"Select Pencil Size" bColor:BC  array:_sizeNumberArray defaultImage:PAGE_IMAGE  contentMode:UIViewContentModeScaleToFill defaultText:@"1" fontName:FONT_GILL_SANS];   
}

-(UIView *)carsoulArrangmentForSizeAndIndex:(int)index
{
    fontSize = 50 ;
    UIImageView * view = [[UIImageView  alloc]initWithFrame:pageImageFrame];
   
    UIImage *image = [UIImage imageNamed:PAGE_IMAGE];
    ((UIImageView *)view).image = image;
    view.contentMode = UIViewContentModeScaleToFill;
    
    CGRect frame =CGRectMake(-5, 50, 60, 150);
    
    if (self.isiPad) {
        frame = CGRectMake(30, 150, 140, 300);
        fontSize  = 100 ;
    }
    UILabel * lbl = [self configureLabelFrame:frame title:[_sizeNumberArray objectAtIndex:index] tColor:BC fontSize:fontSize fontName:FONT_GILL_SANS];
    
    [view addSubview:lbl];
    
    return view;
}


#pragma mark -
#pragma mark iCarousel methods For Pencil Color
#pragma mark

-(void)carsoulViewForPencilColor
{
    [self removeCarsoulView];
    if (self.lbl)
    {
        [self.lbl removeFromSuperview];
        self.lbl = nil;
    }
    _colorArray  = [[NSArray alloc]initWithObjects:I_BLACK_PEN,I_RED_PEN,I_GREEN_PEN,I_BLUE_PEN,I_GRAY_PEN,I_YELLOW_PEN,I_ORANGE_PEN,nil];
    
     [self commonLayoutInCarouselViewForFrame:carouselFrame viewTag:CARSOUL_V_C_T labelText:@"Select Pencil Color" bColor:BC  array:_colorArray defaultImage:I_BLACK_PEN  contentMode:UIViewContentModeScaleAspectFit defaultText:@"" fontName:@""];
}
-(UIView *)carsoulArrangmentForColorAndIndex:(int)index
{
    CGRect frame ;
    if (self.isiPad)
    {
        frame = CGRectMake(30, 150, 100, 400);
    }
    else
    {
        frame = CGRectMake(0, self.lbl.frame.origin.y + self.lbl.frame.size.height + 20 , 70, 150);
    }
    UIView * view = [[UIImageView alloc] initWithFrame:frame];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[_colorArray objectAtIndex:index]]];
    ((UIImageView *)view).image = image;
    view.contentMode = UIViewContentModeScaleAspectFit;
    return view;
}

#pragma mark -
#pragma mark iCarousel methods For Selected Font
#pragma mark

-(void)carsoulViewForFont
{
//    _fontArray = [[NSArray alloc]initWithObjects:FONT_D1,FONT_D2,FONT2,FONT5,FONT_D1,FONT_D2,FONT2,FONT5, nil];

    _fontArray = [[NSArray alloc]initWithObjects:FONT_D2,FONT2,FONT5,FONT_D2,FONT2,FONT5, nil];
    if (index == 0)
    {
        fontSize = 25 ;
        UIFont *font = [UIFont fontWithName:_fontName size:fontSize];
        CGSize size = [_strTitle sizeWithFont:font];
        fontSize = size.height;
        tempFrame = CGRectMake(5, 0, fontSize, 140);
    }
    [self commonLayoutInCarouselViewForFrame:carouselFrame viewTag:CARSOUL_V_F_T labelText:@"Select Font" bColor:BC  array:_fontArray defaultImage:PAGE_IMAGE contentMode:UIViewContentModeScaleToFill defaultText:@"ABCD" fontName:FONT_D1];
}
-(UIView *)carsoulArrangmentForNoOfFontAndIndex:(int)index
{
    UIView * view = [[UIImageView  alloc]initWithFrame:pageImageFrame];
    
    UIImage *image = [UIImage imageNamed:PAGE_IMAGE];
    ((UIImageView *)view).image = image;
    view.contentMode = UIViewContentModeScaleToFill;
    _fontName = [_fontArray objectAtIndex:index];
    [self getFrameAndFontFromIndexForFont:index];
    
    UILabel * lbl = [self configureLabelFrame:tempFrame title:_strTitle tColor:BC fontSize:fontSize fontName:_fontName];
    lbl.numberOfLines  = 0;
    lbl.tag = FONT_LBL_TAG;
    lbl.lineBreakMode  = NSLineBreakByCharWrapping;
    [view addSubview:lbl];
    return view;
}

-(void)getFrameAndFontFromIndexForFont:(int)index
{
    _strTitle = @"ABCD";
    int x = 0 ; int y = 0 ; int h = 0 ;
    if (self.isiPad)
    {
        x = 70 ;
        y = 150 ;
        h = 300 ;
        fontSize = 55;
    }
    else
    {
        x = 10 ;
        y = 60 ;
        h = 140 ;
        fontSize = 25 ;
    }
    if (index == 0)
    {
        [self getfontSizeFromString];
         tempFrame = CGRectMake(x, y, fontSize, h);
    }
    else if (index == 1) {
        [self getfontSizeFromString];
        tempFrame = CGRectMake(x, y, fontSize, h);
    }
    else if (index == 2) {
        _strTitle = @"A B C D ";
        if (self.isiPad) fontSize = 40 ;
        else             fontSize = 15 ;
        [self getfontSizeFromString];
        
        tempFrame = CGRectMake(x, y, fontSize + 5 , h);
    }
    else if (index == 3) {
        _strTitle = @"A B C D ";
//        if (self.isiPad) fontSize = 55 ;
//        else             fontSize = 20 ;
        [self getfontSizeFromString];
        
        tempFrame = CGRectMake(x, y, fontSize, h);
        
        if (fontSize == 0)         fontSize = 30;
        
    }
    
    else if (index == 4) {
        [self getfontSizeFromString];
        
        tempFrame = CGRectMake(x, y, fontSize, h);
    }
    
    else if (index == 5) {
        _strTitle = @"a b c d";
//        if (self.isiPad) fontSize = 55 ;
//        else             fontSize = 30 ;
        [self getfontSizeFromString];
        
        tempFrame = CGRectMake(x, y, fontSize, h);
    }
    else if (index == 6) {
        _strTitle = @"a b c d";
        if (self.isiPad) fontSize = 40 ;
        else             fontSize = 15 ;
        [self getfontSizeFromString];
        
         tempFrame = CGRectMake(x, y, fontSize, h);
    }
    else if (index == 7) {
        _strTitle = @"a b c d";
//        if (self.isiPad) fontSize = 55 ;
//        else             fontSize = 20 ;
        [self getfontSizeFromString];
        
        tempFrame = CGRectMake(x, y, fontSize, h);
    }
}
-(void)getfontSizeFromString
{
    UIFont *font = [UIFont fontWithName:_fontName size:fontSize]; //
    CGSize size = [_strTitle sizeWithFont:font];
    fontSize = size.height;
/*
 CGSize textSize = [_strTitle sizeWithFont:font
 constrainedToSize:CGSizeMake(40.0, fontSize)
 lineBreakMode:NSLineBreakByCharWrapping];
 fontSize = textSize.width;
 */
}

#pragma mark -
#pragma mark Common layout
#pragma mark
-(void)commonLayoutInCarouselViewForFrame:(CGRect)frame viewTag:(int)viewTag labelText:(NSString *)labelText bColor:(UIColor *)bColor array:(NSArray *)array  defaultImage:(NSString *)imageName contentMode:(UIViewContentMode) contentMode defaultText:(NSString * )title fontName:(NSString *)fontName
{
    [self removeCarsoulView];
    iCarousel *carouselView = [[iCarousel alloc]initWithFrame:frame];
    carouselView.backgroundColor = bColor;
    if (self.isiPad)
    {
        fontSize = 40;
    }
    else
    {
        fontSize = 20;
    }
    if (contentMode == UIViewContentModeScaleAspectFit)  // For Pen Image
    {
        if (self.isiPad)
             frame =  CGRectMake(30 , 100, 150, 500);
        else frame = CGRectMake(40 , 20, 40, 200);
    }
    else
    {
        if (self.isiPad)
        {
            frame =  CGRectMake(30,0,200,700);
        }
        else
        {
            frame = CGRectMake(30 , 0 , pageImageFrame.size.width,pageImageFrame.size.height);
        }
    }
    _selectedImage = [[UIImageView alloc]initWithFrame:frame];
    _selectedImage.image = [UIImage imageNamed:imageName];
    _selectedImage.contentMode = contentMode;
    
    frame = CGRectMake(_selectedImage.frame.origin.x + _selectedImage.frame.size.width + 30 , 0, 1,viewH);
    UILabel *lblLine = [self configureLabelFrame:frame title:@"" tColor:WC fontSize:1 fontName:@""];
    lblLine.backgroundColor = BC;
    [carouselView addSubview:lblLine];
    
     frame = CGRectMake(_selectedImage.frame.origin.x + _selectedImage.frame.size.width + 30 , viewW, 1,1);
    
    UILabel *lblLine2 = [self configureLabelFrame:CGRectMake(0, 0,viewH , 1) title:@"" tColor:WC fontSize:1 fontName:@""];
    lblLine2.backgroundColor = BC;
    [carouselView addSubview:lblLine2];
    
    UILabel *lblTitle = [self configureLabelFrame:CGRectMake(lblLine.frame.origin.x, 0, 600, fontSize + 10) title:labelText tColor:BC fontSize:fontSize fontName:FONT_GILL_SANS];
    lblTitle.backgroundColor = RC;
    [carouselView addSubview:lblTitle];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(lblTitle.frame.origin.x+lblTitle.frame.size.width +50,5,fontSize + 10,lblTitle.frame.size.height);
    btn.backgroundColor = WC;
    [btn setImage:[UIImage imageNamed:DONE_IMAGE] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(doneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [carouselView addSubview:btn];
   
    if (self.isiPad)
    {
        frame = CGRectMake(0, 175, 140, 350);
        fontSize  = 150 ;
    }
    else
    {
         frame = CGRectMake(5, 62, 40,135);
    }
    _lbl = [self configureLabelFrame:frame title:title tColor:BC fontSize:fontSize fontName:fontName];
    _lbl.numberOfLines = 0;
    self.lbl.text = @"";
    _lbl.lineBreakMode = NSLineBreakByCharWrapping;
    [_selectedImage addSubview:_lbl];
    
    [carouselView addSubview:_selectedImage];
    carouselView.tag = viewTag;
    carouselView.backgroundColor = [UIColor  whiteColor];
    carouselView.type = iCarouselTypeRotary;
    carouselView.dataSource = self;
    carouselView.delegate = self;
    [_parentView addSubview:carouselView];
}

#pragma mark
#pragma mark iCarousel Delegate Method
#pragma mark

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    int itemCount = 0;
    if (carousel.tag == CARSOUL_V_C_T) {
        itemCount = _colorArray.count;
    }else if (carousel.tag == CARSOUL_V_S_T) {
        itemCount = _sizeNumberArray.count;
    }else if (carousel.tag == CARSOUL_V_A_T) {
        itemCount = _singleAlphaArray.count;
    }else if (carousel.tag == CARSOUL_V_F_T) {
        itemCount = _fontArray.count;
    }
    return itemCount;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIView *returnView = nil;
    if (carousel.tag == CARSOUL_V_C_T) {
        if (view == nil){
            returnView = [self carsoulArrangmentForColorAndIndex:index]; // For Color
        }
    }else  if (carousel.tag == CARSOUL_V_S_T){
        if (view == nil){
            returnView = [self carsoulArrangmentForSizeAndIndex:index]; // For  Size
        }
    }else  if (carousel.tag == CARSOUL_V_A_T){
        if (view == nil){
            returnView = [self carsoulArrangmentForNoOfAlphabetAndIndex:index]; // For No Of Alphabet
        }
    }else  if (carousel.tag == CARSOUL_V_F_T){
        if (view == nil){
            returnView = [self carsoulArrangmentForNoOfFontAndIndex:index];
        }
    }
    return returnView;
}
- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 0;
}
- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (view == nil) {
        
    }
    return view;
}

#pragma mark -
#pragma mark iCarousel taps
#pragma mark

-(void)setColorAndImageForSelectedColorIndex:(int)index
{
    if (index == 0) {
        
        _selectedImage.image = [UIImage imageNamed:I_BLACK_PEN];
        _color = BC;
    }else if (index == 1) {
        _selectedImage.image = [UIImage imageNamed:I_RED_PEN];
        _color = RC;
    }else if (index == 2) {
        _selectedImage.image = [UIImage imageNamed:I_GRAY_PEN];
        _color = GC;
    }else if (index == 3) {
        _selectedImage.image = [UIImage imageNamed:I_BLUE_PEN];
        _color = BLC;
    }else if (index == 4) {
        _selectedImage.image = [UIImage imageNamed:I_GREEN_PEN];
        _color = GC;
    }else if (index == 5) {
        _selectedImage.image = [UIImage imageNamed:I_YELLOW_PEN];
        _color = YC;
    }else if (index == 6) {
        _selectedImage.image = [UIImage imageNamed:I_ORANGE_PEN];
        _color = OC;
    }
    
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(int)index
{
    
    if (carousel.tag == CARSOUL_V_C_T) {
        [self setColorAndImageForSelectedColorIndex:index];
    }
    else if (carousel.tag == CARSOUL_V_S_T){
        lineWidth = index + 1;
        _lbl.font = [UIFont fontWithName:FONT_GILL_SANS  size:fontSize];
        _lbl.text = [NSString stringWithFormat:@"%d",index+1];
    }
    else if (carousel.tag == CARSOUL_V_A_T){
        for(UILabel *lbl in carousel.subviews){
            if ([lbl viewWithTag:ALPHABET_LBL_TAG]) {
                noOfAlpha = index + 1 ;
                [self getFrameAndFontFromIndexForAlphabet:index];
                if (self.isiPad) {
                    _lbl.frame = CGRectMake(tempFrame.origin.x, 200, tempFrame.size.width,tempFrame.size.height);
                }else{
                    _lbl.frame = tempFrame;
                }
                _lbl.font = [UIFont fontWithName:FONT_D2 size:fontSize];
                 _lbl.text = [_singleAlphaArray objectAtIndex:index];
                _strTitle = _lbl.text;
            }
        }
    }else if (carousel.tag == CARSOUL_V_F_T){
        for(UILabel *lbl in carousel.subviews){
            if ([lbl viewWithTag:FONT_LBL_TAG]) {
                _fontName = [_fontArray objectAtIndex:index];
                [self getFrameAndFontFromIndexForFont:index];
                if (self.isiPad) {
                    _lbl.frame = CGRectMake(tempFrame.origin.x, 200, tempFrame.size.width,tempFrame.size.height);
                }else{
                    _lbl.frame = CGRectMake(tempFrame.origin.x, 60, tempFrame.size.width,tempFrame.size.height);
                }
                _lbl.font = [UIFont fontWithName:_fontName size:fontSize];
                _lbl.text =_strTitle;
            }
        }
    }
}
 - (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * _carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (_carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
