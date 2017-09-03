//
//  UIImage+ML.h
//  StyleTransfer
//
//  Created by 李金 on 2017/8/31.
//  Copyright © 2017年 Kingandyoga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ML)
- (UIImage *)resizedImage:(CGSize)newSize;
+ (CVPixelBufferRef)CGImageToPixelBufferRGB:(CGImageRef)image
                                      width:(CGFloat)outWidth
                                     height:(CGFloat)outHeight;
+ (UIImage *)pixelBufferBGRToImage:(CVPixelBufferRef)pixelBuffer
                                               width:(CGFloat)outWidth
                                              height:(CGFloat)outHeight
                                         orientation:(UIImageOrientation)orientation;
@end
