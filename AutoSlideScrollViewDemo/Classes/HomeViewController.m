//
//  HomeViewController.m
//  AutoSlideScrollViewDemo
//
//  Created by Mike Chen on 14-1-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "AutoSlideScrollView.h"

static const NSInteger kTotalPageCount = 5;

@interface HomeViewController ()

@property (nonatomic , strong) AutoSlideScrollView *mainScorllView;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *viewsArray = [@[] mutableCopy];
    NSArray *colorArray = @[[UIColor cyanColor],[UIColor blueColor],[UIColor greenColor],[UIColor yellowColor],[UIColor purpleColor]];
    for (int i = 0; i < kTotalPageCount; ++i) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
        tempLabel.backgroundColor = [(UIColor *)[colorArray objectAtIndex:i] colorWithAlphaComponent:0.5];
        [viewsArray addObject:tempLabel];
    }
    
    self.mainScorllView = [[AutoSlideScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 300) animationDuration:3];
    self.mainScorllView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return viewsArray.count;
    };
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%ld个",pageIndex);
    };
    [self.view addSubview:self.mainScorllView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
