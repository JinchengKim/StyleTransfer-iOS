//
//  StyleTransferManager.m
//  StyleTransfer
//
//  Created by 李金 on 2017/8/31.
//  Copyright © 2017年 Kingandyoga. All rights reserved.
//

#import "StyleTransferManager.h"
#import <CoreML/CoreML.h>
#import "UIImage+ML.h"

#import "STMuseMLModel.h"
#import "STPrincessMLModel.h"
#import "STScreamMLModel.h"
#import "STShipwreckMLModel.h"
#import "STUdnieMLModel.h"
#import "STWaveMLModel.h"

@interface StyleTransferManager()
@property (nonatomic, strong) STMuseMLModel *museModel;
@property (nonatomic, strong) STPrincessMLModel *princessModel;
@property (nonatomic, strong) STScreamMLModel *screamModel;
@property (nonatomic, strong) STShipwreckMLModel *shipwreckModel;
@property (nonatomic, strong) STUdnieMLModel *udnieModel;
@property (nonatomic, strong) STWaveMLModel *waveModel;
@property (nonatomic, strong) NSMutableArray *modelDatas;
@end

@implementation StyleTransferManager
+ (instancetype)getSharedStyleTransferManager{
    static dispatch_once_t onceToken;
    static StyleTransferManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[StyleTransferManager alloc] init];
    });
    return manager;
}

- (UIImage *)transferImage2Type:(StyleModelType)type image:(UIImage *)image{
    CGFloat inputWidth = 480;
    CGFloat inputHeight = 640;
    UIImage *resizedImage = [image resizedImage:CGSizeMake(inputWidth, inputHeight)];
    CGImageRef imageInputRef = image.CGImage;
    CVPixelBufferRef imageInputBufferRef = [UIImage CGImageToPixelBufferRGB:imageInputRef width:inputWidth height:inputHeight];
    CVPixelBufferRef imageOutputBufferRef = NULL;
    NSError *error;
    switch (type) {
        case StyleModelTypeMuse:
        {
            
            STMuseMLModelOutput *outPut = [self.museModel predictionFromInput1:imageInputBufferRef error:&error];
            imageOutputBufferRef = outPut.output1;
        }
            break;
        case StyleModelTypeWave:
        {
            STWaveMLModelOutput *outPut = [self.waveModel predictionFromInput1:imageInputBufferRef error:&error];
            imageOutputBufferRef = outPut.output1;
        }
            break;
        case StyleModelTypeScream:
        {
            STScreamMLModelOutput *outPut = [self.screamModel predictionFromInput1:imageInputBufferRef error:&error];
            imageOutputBufferRef = outPut.output1;
        }
            break;
        case StyleModelTypePrincess:
        {
            STPrincessMLModelOutput *outPut = [self.princessModel predictionFromInput1:imageInputBufferRef error:&error];
            imageOutputBufferRef = outPut.output1;
        }
            break;
        case StyleModelTypeShipWreck:
        {
            STShipwreckMLModelOutput *outPut = [self.shipwreckModel predictionFromInput1:imageInputBufferRef error:&error];
            imageOutputBufferRef = outPut.output1;
        }
            break;
        case StyleModelTypeUdniePicabia:
        {
            STUdnieMLModelOutput *outPut = [self.udnieModel predictionFromInput1:imageInputBufferRef error:&error];
            imageOutputBufferRef = outPut.output1;
        }
            break;
        default:
            break;
    }
    
    if (error) {
        NSLog(@"error code:%ld",(long)error.code);
    }
    if (imageOutputBufferRef == NULL) {
        return nil;
    }
    resizedImage = [UIImage  pixelBufferBGRToImage:imageOutputBufferRef width:inputWidth height:inputHeight orientation:image.imageOrientation];
    return resizedImage;
}

+ (NSArray *)modelDate{
    return [StyleTransferManager getSharedStyleTransferManager].modelDatas;
}
#pragma mark - @property
- (STMuseMLModel *)museModel{
    if (!_museModel) {
        _museModel = [STMuseMLModel new];
    }
    return _museModel;
}


- (STPrincessMLModel *)princessModel{
    if (!_princessModel) {
        _princessModel = [STPrincessMLModel new];
    }
    return _princessModel;
}

- (STScreamMLModel *)screamModel{
    if (!_screamModel) {
        _screamModel = [STScreamMLModel new];
    }
    return _screamModel;
}

- (STShipwreckMLModel *)shipwreckModel{
    if (!_shipwreckModel) {
        _shipwreckModel = [STShipwreckMLModel new];
    }
    return _shipwreckModel;
}

- (STUdnieMLModel *)udnieModel{
    if (!_udnieModel) {
        _udnieModel = [STUdnieMLModel new];
    }
    return _udnieModel;
}

- (STWaveMLModel *)waveModel{
    if (!_waveModel) {
        _waveModel = [STWaveMLModel new];
    }
    return _waveModel;
}

- (NSMutableArray *)modelDatas{
    if (!_modelDatas) {
        _modelDatas = [NSMutableArray array];
        [_modelDatas addObject:[StyleModel createModel:StyleModelTypeMuse]];
        [_modelDatas addObject:[StyleModel createModel:StyleModelTypeWave]];
        [_modelDatas addObject:[StyleModel createModel:StyleModelTypeScream]];
        [_modelDatas addObject:[StyleModel createModel:StyleModelTypePrincess]];
        [_modelDatas addObject:[StyleModel createModel:StyleModelTypeShipWreck]];
        [_modelDatas addObject:[StyleModel createModel:StyleModelTypeUdniePicabia]];
    }
    return _modelDatas;
}
@end
