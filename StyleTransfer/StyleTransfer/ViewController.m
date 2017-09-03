//
//  ViewController.m
//  StyleTransfer
//
//  Created by 李金 on 2017/8/31.
//  Copyright © 2017年 Kingandyoga. All rights reserved.
//

#import "ViewController.h"
#import "StyleTransferManager.h"
#import "CollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpViews];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)transferImage2Type:(StyleModelType)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hintLabel.alpha = 1;
    });
    
    [self.view setUserInteractionEnabled:NO];
    self.imageView.image = [[StyleTransferManager getSharedStyleTransferManager] transferImage2Type:type image:self.imageView.image];
    [self.view setUserInteractionEnabled:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hintLabel.alpha = 0.01;
    });
}

#pragma mark - setUpViews
- (void)setUpViews{
    self.hintLabel.alpha = 0.01;
    self.collectionView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(70, 70);
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 15;
    
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"kCollectionViewCell"];
}

#pragma mark - CollectionView delegate datesource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [StyleTransferManager modelDate].count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kCollectionViewCell" forIndexPath:indexPath];

    StyleModel *model = [[StyleTransferManager modelDate] objectAtIndex:indexPath.row];
    cell.model = model;
    __weak __typeof(self) weakSelf = self;
    cell.clickBlock = ^(StyleModelType type) {
        [weakSelf transferImage2Type:type];
    };
    return cell;
}
@end
