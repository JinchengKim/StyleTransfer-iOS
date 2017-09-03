//
//  CollectionViewCell.m
//  StyleTransfer
//
//  Created by 李金 on 2017/8/31.
//  Copyright © 2017年 Kingandyoga. All rights reserved.
//

#import "CollectionViewCell.h"
#import "StyleModel.h"
@interface CollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *bgButton;
@property (weak, nonatomic) IBOutlet UIView *labelBgView;

@end
@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.labelBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"CollectionViewCell"     owner:self options:nil].lastObject;
        self.labelBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
    }
    return self;
}

- (void)setModel:(StyleModel *)model{
    _model = model;
    self.nameLabel.text = model.name;
    [self.bgButton setImage:[UIImage imageNamed:model.imageName] forState:UIControlStateNormal];
}
- (IBAction)clilck:(id)sender {
    if (_clickBlock) {
        _clickBlock(self.model.type);
    }
}

@end
