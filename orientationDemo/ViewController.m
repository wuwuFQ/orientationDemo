//
//  ViewController.m
//  orientationDemo
//
//  Created by wuwuFQ on 2019/8/31.
//  Copyright © 2019 shankangyun. All rights reserved.
//

#import "ViewController.h"
#import "LandscapeViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)jumpPage:(id)sender {
    LandscapeViewController *vc = [LandscapeViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
