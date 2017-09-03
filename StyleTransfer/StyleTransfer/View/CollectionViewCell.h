//
//  CollectionViewCell.h
//  StyleTransfer
//
//  Created by 李金 on 2017/8/31.
//  Copyright © 2017年 Kingandyoga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyleModel.h"

typedef void(^ClickStyleBlock) (StyleModelType type);
@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) StyleModel *model;
@property (nonatomic, copy) ClickStyleBlock clickBlock;
@end
