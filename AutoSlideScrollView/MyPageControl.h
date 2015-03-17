//
//  MyPageControl.h
//  
//
//  Created by Mike Chen on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
/*
 *自定义PageContrl控件，实现了setCurrentPage事件和touch事件这两个最基本的功能
 *如果要使用touch事件，请使用MyPageControlDelegate代理
 */
#import <UIKit/UIKit.h>

@protocol MyPageControlDelegate <NSObject>

@optional

- (void)pageControlDidStopAtIndex:(NSInteger)index;

@end

@interface MyPageControl : UIView 

@property (nonatomic , assign)NSInteger pageNumbers;
@property (nonatomic , weak)id<MyPageControlDelegate> delegate;
- (id)initWithFrame:(CGRect)frame
        normalImage:(UIImage *)nImage
   highlightedImage:(UIImage *)hImage
         dotsNumber:(NSInteger)pageNum
         sideLength:(NSInteger)size
            dotsGap:(NSInteger)gap;

- (void)setCurrentPage:(NSInteger)pages;

@end
