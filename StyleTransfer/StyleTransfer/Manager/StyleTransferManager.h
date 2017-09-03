//
//  StyleTransferManager.h
//  StyleTransfer
//
//  Created by 李金 on 2017/8/31.
//  Copyright © 2017年 Kingandyoga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StyleModel.h"
@interface StyleTransferManager : NSObject
+ (instancetype)getSharedStyleTransferManager;
+ (NSArray *)modelDate;
- (UIImage *)transferImage2Type:(StyleModelType)type image:(UIImage *)image;
@end
