//
//  MyPageControl.m
//  
//
//  Created by Mike Chen on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyPageControl.h"

@interface MyPageControl ()

@property (nonatomic , strong)UIImage *normalDotImage;
@property (nonatomic , strong)UIImage *highlightedDotImage;
@property (nonatomic , strong)NSMutableArray *dotsArray;
@property (nonatomic , assign)float dotsSize;
@property (nonatomic , assign)NSInteger dotsGap;
@property (nonatomic , retain) UIImageView *highlightedDotImageView;

- (void)dotsDidTouched:(UIView *)sender;

@end

@implementation MyPageControl

@synthesize normalDotImage = _normalDotImage;
@synthesize highlightedDotImage = _highlightedDotImage;
@synthesize dotsArray = __dotsArray;
@synthesize pageNumbers = __pageNumbers;
@synthesize dotsSize = __dotsSize;
@synthesize dotsGap = __dotsGap;
@synthesize highlightedDotImageView = _highlightedDotImageView;
@synthesize delegate;

- (void)dealloc
{
    [_normalDotImage release];
    [_highlightedDotImage release];
    [__dotsArray release];
    [_highlightedDotImageView release];
    [super dealloc];
}

/* 
 *pageNum是pageControl的页面总个数
 *size是单个dot的边长
 */
- (id)initWithFrame:(CGRect)frame
        normalImage:(UIImage *)nImage
   highlightedImage:(UIImage *)hImage
         dotsNumber:(NSInteger)pageNum
         sideLength:(NSInteger)size
            dotsGap:(NSInteger)gap
{
    if ((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = YES;
        self.dotsGap = gap;
        self.dotsSize = size;
        self.dotsArray = [NSMutableArray array];
        self.normalDotImage = [nImage retain];
        self.highlightedDotImage = [hImage retain];
        self.pageNumbers = pageNum;
        
        UIImageView *dotImageView_h = [[UIImageView alloc] initWithImage:_highlightedDotImage];
        [dotImageView_h.layer setMasksToBounds:NO];
        dotImageView_h.frame = CGRectMake(0, 0, self.dotsSize, self.dotsSize);
        self.highlightedDotImageView = dotImageView_h;
        [dotImageView_h release];
        
        for (int i = 0; i != __pageNumbers; ++ i) {
            UIImageView *dotsImageView = [[UIImageView alloc] init];
            dotsImageView.userInteractionEnabled = YES;
            dotsImageView.frame = CGRectMake((size + gap) * i, 0, size, size);
            dotsImageView.tag = 100 + i;
            if (i == 0) {
                self.highlightedDotImageView.frame = CGRectMake((size + gap) * i, 0, size, size);
            }
//            NSLog(@"self.highlightedDotImageView = %@",self.highlightedDotImageView);
//            dotsImageView.backgroundColor = [UIColor colorWithPatternImage:_normalDotImage];
//            [[YHGlobalDataManager shared] drawView:dotsImageView BorderColor:[UIColor redColor]];
            dotsImageView.image = _normalDotImage;
            [dotsImageView.layer setMasksToBounds:NO];
            
            UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dotsDidTouched:)];
            [dotsImageView addGestureRecognizer:gestureRecognizer];
            [gestureRecognizer release];
            [self addSubview:dotsImageView];
            [dotsImageView release];
        }
        [self addSubview:_highlightedDotImageView];
    }
    return self;
}

- (void)dotsDidTouched:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(pageControlDidStopAtIndex:)]) {
        [delegate pageControlDidStopAtIndex:[[sender view] tag] - 100];
    }
}

- (void)setCurrentPage:(NSInteger)pages
{
    //pages从0开始的
//    NSLog(@"pages = %d",pages);
    if (_normalDotImage || _highlightedDotImage) {
        //将_highlightedDotImageView往pages方向移动
        CGRect newRect = CGRectMake((self.dotsSize + self.dotsGap) * pages, 0, self.dotsSize, self.dotsSize);
//        CGPoint newOrignal = CGPointMake((self.dotsSize + self.dotsGap) * pages, 0);
        [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^(void){
            self.highlightedDotImageView.frame = newRect;
        } completion:^(BOOL finished){}];
        /*
        for (int i = 0 ; i != __pageNumbers; ++ i) {
            if (i == pages) {
                [((UIView *)[self viewWithTag:100 + i]) setCenter:CGPointMake((0.5 + i) * __dotsSize + __dotsGap * i, 0.5 * __dotsSize)];
                [((UIView *)[self viewWithTag:100 + i]) setBackgroundColor:[UIColor colorWithPatternImage:_highlightedDotImage]];
            } else {
                [((UIView *)[self viewWithTag:100 + i]) setBackgroundColor:[UIColor colorWithPatternImage:_normalDotImage]];
            }
        }*/
    }
}

@end
