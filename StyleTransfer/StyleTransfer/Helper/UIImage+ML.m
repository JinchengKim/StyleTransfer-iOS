//
//  UIImage+ML.m
//  StyleTransfer
//
//  Created by 李金 on 2017/8/31.
//  Copyright © 2017年 Kingandyoga. All rights reserved.
//

#import "UIImage+ML.h"
#import <CoreML/CoreML.h>
#import <CoreVideo/CVPixelBuffer.h>

@implementation UIImage (ML)
- (UIImage *)resizedImage:(CGSize)newSize{
    UIImage *resizedImage = self;
    if (newSize.height == self.size.height && newSize.width == self.size.width) {
        
    }else{
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
        [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        if (scaledImage) {
            resizedImage = scaledImage;
        }
    }
    return resizedImage;
}
- (CGImagePropertyOrientation)cgImagePropertyOrientation{
    CGImagePropertyOrientation cgOrientation = kCGImagePropertyOrientationUp;
    switch (cgOrientation) {
        case kCGImagePropertyOrientationUp:
            cgOrientation = kCGImagePropertyOrientationUp;
            break;
        case kCGImagePropertyOrientationDown:
            cgOrientation = kCGImagePropertyOrientationDown;
            break;
        case kCGImagePropertyOrientationLeft:
            cgOrientation = kCGImagePropertyOrientationLeft;
            break;
        case kCGImagePropertyOrientationRight:
            cgOrientation = kCGImagePropertyOrientationRight;
            break;
        case kCGImagePropertyOrientationLeftMirrored:
            cgOrientation = kCGImagePropertyOrientationLeftMirrored;
            break;
        case kCGImagePropertyOrientationRightMirrored:
            cgOrientation = kCGImagePropertyOrientationRightMirrored;
            break;
        case kCGImagePropertyOrientationUpMirrored:
            cgOrientation = kCGImagePropertyOrientationUpMirrored;
            break;
        case kCGImagePropertyOrientationDownMirrored:
            cgOrientation = kCGImagePropertyOrientationDownMirrored;
            break;
            
        default:
            break;
    }
    return cgOrientation;
}

+ (UIImage *)pixelBufferBGRToImage:(CVPixelBufferRef)pixelBuffer
                                               width:(CGFloat)outWidth
                                              height:(CGFloat)outHeight
                                         orientation:(UIImageOrientation)orientation{
    UIImage *image = nil;
    OSType type = CVPixelBufferGetPixelFormatType(pixelBuffer);
//    NSAssert(type != kCVPixelFormatType_32BGRA, @"type is Not kCVPixelFormatType_32BGRA");
    
    size_t width = CVPixelBufferGetWidth(pixelBuffer);
    size_t height = CVPixelBufferGetHeight(pixelBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer);
    CVPixelBufferLockBaseAddress(pixelBuffer, kCVPixelBufferLock_ReadOnly);

    CGContextRef context = CGBitmapContextCreate(CVPixelBufferGetBaseAddress(pixelBuffer), width, height, 8, bytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst);
    if (context != NULL) {
        CGImageRef imgRef = CGBitmapContextCreateImage(context);
        image = [[UIImage imageWithCGImage:imgRef scale:1 orientation:orientation] resizedImage:CGSizeMake(outWidth, outHeight)];
        CGImageRelease(imgRef);
        CGContextRelease(context);
    }
    CVPixelBufferUnlockBaseAddress(pixelBuffer, kCVPixelBufferLock_ReadOnly);
    return image;
}

+ (CVPixelBufferRef)CGImageToPixelBufferRGB:(CGImageRef)image
                                      width:(CGFloat)outWidth
                                     height:(CGFloat)outHeight{
    CVPixelBufferRef pixelBuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault, outWidth, outHeight, kCVPixelFormatType_32ARGB, nil, &pixelBuffer);
    if (status == kCVReturnSuccess){
        size_t bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer);
        CVPixelBufferLockBaseAddress(pixelBuffer, kCVPixelBufferLock_ReadOnly);
        CGContextRef context = CGBitmapContextCreate(CVPixelBufferGetBaseAddress(pixelBuffer), outWidth, outHeight, 8, bytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst);
        CGContextDrawImage(context, CGRectMake(0, 0, outWidth, outHeight), image);
        CGContextRelease(context);
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer, kCVPixelBufferLock_ReadOnly);
    }
    return pixelBuffer;
}


//
//public func CGImageToPixelBufferRGB(_ image: CGImage, width outWidth: Int, height outHeight: Int) -> CVPixelBuffer? {
//    var pixelBuffer: CVPixelBuffer?
//    if kCVReturnSuccess == CVPixelBufferCreate(kCFAllocatorDefault, outWidth, outHeight, kCVPixelFormatType_32ARGB, nil, &pixelBuffer) {
//        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer!)
//
//        CVPixelBufferLockBaseAddress(pixelBuffer!, .readOnly);
//        let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
//
//        if let context = CGContext(data: data, width: outWidth, height: outHeight, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: CGColorSpaceCreateDeviceRGB(),
//                                   bitmapInfo: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.noneSkipFirst.rawValue) { // ARGB
//            context.draw(image, in: CGRect(x:0, y:0, width:outWidth, height:outHeight))
//        }
//
//        CVPixelBufferUnlockBaseAddress(pixelBuffer!, .readOnly);
//    }
//
//    return pixelBuffer
//}
//
//func randomColor(seed: String) -> UIColor {
//    var total: Int = 0
//    for u in seed.unicodeScalars {
//        total += Int(UInt32(u))
//    }
//
//    srand48(total * 200)
//    let r = CGFloat(drand48())
//
//    srand48(total)
//    let g = CGFloat(drand48())
//
//    srand48(total / 200)
//    let b = CGFloat(drand48())
//
//    return UIColor(red: r, green: g, blue: b, alpha: 1)
//}
//
//public func IOU(_ rect1: CGRect, _ rect2: CGRect) -> CGFloat {
//    let intersection = rect1.intersection(rect2)
//    let intersectionArea = intersection.width * intersection.height
//    let unionArea = rect1.width * rect1.height + rect2.width * rect2.height - intersectionArea
//    let iou = intersectionArea / unionArea
//
//    return iou
//}
@end
