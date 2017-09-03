//
//  StyleModel.h
//  StyleTransfer
//
//  Created by 李金 on 2017/9/3.
//  Copyright © 2017年 Kingandyoga. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,StyleModelType) {
    StyleModelTypeWave,
    StyleModelTypeUdniePicabia,
    StyleModelTypeShipWreck,
    StyleModelTypeScream,
    StyleModelTypePrincess,
    StyleModelTypeMuse
};
@interface StyleModel : NSObject
+ (instancetype)createModel:(StyleModelType)type;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) StyleModelType type;
@end
