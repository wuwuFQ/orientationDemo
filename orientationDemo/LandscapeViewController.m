//
//  LandscapeViewController.m
//  orientationDemo
//
//  Created by wuwuFQ on 2019/8/31.
//  Copyright © 2019 shankangyun. All rights reserved.
//

#import "LandscapeViewController.h"
#import "UIViewController+LandscapeRotation.h"
@interface LandscapeViewController ()

@end

@implementation LandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.cyanColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setLandscapeRotation:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setLandscapeRotation:NO];
}


@end
