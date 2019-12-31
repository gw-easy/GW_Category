//
//  UIImage+GWImage.m
//  Zhuntiku（准题库）
//
//  Created by zdwx on 2019/11/26.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "UIImage+GWImage.h"

@implementation UIImage (GWImage)

#pragma mark - 截屏
+ (UIImage *)gw_createScreenshotsViewImage:(UIView *)shareView{
    return [self gw_createScreenshotsViewImage:shareView cornerRadius:0];
}

+ (UIImage *)gw_createScreenshotsViewImage:(UIView *)shareView cornerRadius:(CGFloat)cornerRadius{
    if (!shareView) {
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(shareView.frame.size, NO, [[UIScreen mainScreen] scale]);
    if (cornerRadius>0) {
        [[UIBezierPath bezierPathWithRoundedRect:shareView.bounds cornerRadius:cornerRadius] addClip];
    }
    [shareView drawViewHierarchyInRect:shareView.bounds afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

#pragma mark - 压缩图片
- (UIImage *)gw_changeImageSizeToByte:(NSUInteger)maxLength{
    UIImage *resultImage = self;
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return resultImage;
}

- (UIImage *)gw_changeImageQualityToByte:(NSInteger)maxLength{
    UIImage *resultImage = [UIImage imageWithData:[self gw_dataChangeImageQualityToByte:maxLength]];
    return resultImage;
}

- (NSData *)gw_dataChangeImageQualityToByte:(NSInteger)maxLength{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}


- (UIImage *)gw_changeImageToAppointByte:(NSUInteger)maxLength{
    return [UIImage imageWithData:[self gw_dataChangeImageToAppointByte:maxLength]];
}

- (NSData *)gw_dataChangeImageToAppointByte:(NSUInteger)maxLength{
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return data;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return data;
}

#pragma mark - 缩放图片 - 适配宽或高

//指定宽度按比例缩放
-(UIImage *)gw_imageCompressForWidth:(CGFloat)defineWidth{
    
    return [self gw_imageCompressForSize:CGSizeMake(defineWidth, self.size.height / (self.size.width / defineWidth))];
}

//指定高度按比例缩放
-(UIImage *)gw_imageCompressForHeight:(CGFloat)defineHeight{
    return [self gw_imageCompressForSize:CGSizeMake(self.size.width/(self.size.height/defineHeight), defineHeight)];
}

//按比例缩放,size是你要把图显示到 多大区域 ,例如:CGSizeMake(300, 400)
-(UIImage *)gw_imageCompressForSize:(CGSize)size{
   UIImage *newImage = nil;
   CGSize imageSize = self.size;
   CGFloat width = imageSize.width;
   CGFloat height = imageSize.height;
   CGFloat targetWidth = size.width;
   CGFloat targetHeight = size.height;
   CGFloat scaleFactor = 0.0;
   CGFloat scaledWidth = targetWidth;
   CGFloat scaledHeight = targetHeight;
   CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
   if(CGSizeEqualToSize(imageSize, size) == NO){
       CGFloat widthFactor = targetWidth / width;
       CGFloat heightFactor = targetHeight / height;

       if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
       if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) *0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) *0.5;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO,[UIScreen mainScreen].scale);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();

    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 绘制图片圆角
-(UIImage *)gw_imageForCornerRadius:(CGFloat)radius{
    CGSize itemSize = CGSizeMake(self.size.width, self.size.height);
    //开启图片的上下文
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, [UIScreen mainScreen].scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    //绘制圆角矩形
    [[UIBezierPath bezierPathWithRoundedRect:imageRect cornerRadius:radius] addClip];
    //绘制图片
    [self drawInRect:imageRect];
    //从上下文中获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片的上下文
    UIGraphicsEndImageContext();
    return newImage;
}





@end
