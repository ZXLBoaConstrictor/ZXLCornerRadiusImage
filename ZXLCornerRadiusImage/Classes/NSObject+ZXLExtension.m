//
//  NSObject+ZXLExtension.m
//  ZXLUtils
//
//  Created by 张小龙 on 2018/5/28.
//  Copyright © 2018年 张小龙. All rights reserved.
//

#import "NSObject+ZXLExtension.h"
@implementation NSObject (ZXLExtension)
//IMP 交换
+ (void)zxlSwizzleMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    if (!originalSelector || !swizzledSelector) return;
    
    Class class = [self class];
    //原有方法
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    //替换原有方法的新方法
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {//添加成功：如果源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class,swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {//添加失败：如果源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)zxlSwizzleClassMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    if (!originalSelector || !swizzledSelector) return;
    
    Class class = [self class];
    //原有方法
    Method originalMethod = class_getClassMethod(class, originalSelector);
    //替换原有方法的新方法
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class,originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {//添加成功：如果源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        method_exchangeImplementations(originalMethod, swizzledMethod);
    } else {//添加失败：如果源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
