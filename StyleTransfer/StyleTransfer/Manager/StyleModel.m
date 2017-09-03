//
//  StyleModel.m
//  StyleTransfer
//
//  Created by 李金 on 2017/9/3.
//  Copyright © 2017年 Kingandyoga. All rights reserved.
//

#import "StyleModel.h"
@interface StyleModel()

@end

@implementation StyleModel
+ (instancetype)createModel:(StyleModelType)type{
    StyleModel *model = [[StyleModel alloc] init];
    if (model) {
        model.type = type;
    }
    return model;
}

- (void)setType:(StyleModelType)type{
    _type = type;
    switch (_type) {
        case StyleModelTypeMuse:
        {
            self.name = @"Muse";
            self.imageName = @"la_muse";
        }
            
            break;
       case StyleModelTypeUdniePicabia:
        {
            self.name = @"Udnie";
            self.imageName = @"udnie";
        }
            break;
        case StyleModelTypeWave:
        {
            self.name = @"Wave";
            self.imageName = @"wave";
        }
            break;
            
        case StyleModelTypeShipWreck:
        {
            self.name = @"Wreck";
            self.imageName = @"the_shipwreck_of_the_minotaur";
        }
            break;
            
        case StyleModelTypeScream:
        {
            self.name = @"Scream";
            self.imageName = @"the_scream";
        }
            break;
            
        case StyleModelTypePrincess:
        {
            self.name = @"Princess";
            self.imageName = @"rain_princess";
        }
            break;
        default:
            break;
    }
}
@end
