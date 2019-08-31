//
//  UIViewController+LandscapeRotation.h
//  orientationDemo
//
//  Created by wuwuFQ on 2019/8/31.
//  Copyright © 2019 shankangyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LandscapeRotation)
/**
 强制横屏方法
 
 @param fullscreen 横屏(如果属性值为YES,仅允许屏幕横向)
 */
- (void)setLandscapeRotation:(BOOL)fullscreen;
@end

NS_ASSUME_NONNULL_END
