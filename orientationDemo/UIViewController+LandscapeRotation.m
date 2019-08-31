//
//  UIViewController+LandscapeRotation.m
//  orientationDemo
//
//  Created by wuwuFQ on 2019/8/31.
//  Copyright © 2019 shankangyun. All rights reserved.
//

#import "UIViewController+LandscapeRotation.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

#define AtAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)


static char *FullScreenAllowRotationKey = "FullScreenAllowRotationKey";

@implementation UIViewController (LandscapeRotation)


void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector){
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


/**
 是否允许横屏
 
 @return bool YES 允许 NO 不允许
 */
- (BOOL)shouldAutorotate1{
    BOOL flag = objc_getAssociatedObject(self, FullScreenAllowRotationKey);
    return flag;
}


/**
 屏幕方向
 
 @return 屏幕方向
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations1{
    //get方法通过key获取对象
    BOOL flag = objc_getAssociatedObject(self, FullScreenAllowRotationKey);
    if (flag) {
        return UIInterfaceOrientationMaskLandscapeLeft;
    }else{
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation1{
    BOOL flag = objc_getAssociatedObject(self, FullScreenAllowRotationKey);
    if (flag) {
        return UIInterfaceOrientationLandscapeLeft;
    }else{
        return UIInterfaceOrientationUnknown;
    }
}

/**
 强制横屏方法
 
 @param fullscreen 屏幕方向
 */
- (void)setLandscapeRotation:(BOOL)fullscreen{
    AtAppDelegate.landscapeRotation = fullscreen;
    objc_setAssociatedObject(self, FullScreenAllowRotationKey,[NSNumber numberWithBool:fullscreen], OBJC_ASSOCIATION_ASSIGN);
    
    swizzleMethod([self class], @selector(shouldAutorotate), @selector(shouldAutorotate1));
    swizzleMethod([self class], @selector(supportedInterfaceOrientations), @selector(supportedInterfaceOrientations1));
    swizzleMethod([self class], @selector(preferredInterfaceOrientationForPresentation), @selector(preferredInterfaceOrientationForPresentation1));
    
    @autoreleasepool {
        if (fullscreen) {
            NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
            [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
            NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
            [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        }else{
            NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
            [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
            NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortraitUpsideDown];
            [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
        }
    }
}

@end
