//
//  NSObject+PhotosCategory.h
//  PhotosDemo
//
//  Created by 宋立军 on 2017/6/6.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

static NSInteger defaultIndex = 0;  //默认保存位置在第几个

@interface UIImage (PhotosCategory)

/*!
 @brief         保存图片到相机胶卷
 @result        照片在相册中的PHAsset  返回nil保存失败
 @discussion    self 为照片(UIImage *)
 */
- (PHAsset *)lj_saveImage;

/*!
 @brief         保存图片到指定相册
 @result        照片在相册中的PHAsset  返回nil保存失败
 @discussion    self 为照片(UIImage *)
 @param         assetCollection 相册
 */
- (PHAsset *)lj_saveImageForPHAssetCollection:(PHAssetCollection *)assetCollection;

/*!
 @brief         保存图片到指定相册 与指定位置
 @result        照片在相册中的PHAsset  返回nil保存失败
 @discussion    self 为照片(UIImage *)
 @param         assetCollection 相册  index 保存在第几个(要求大于等于0&小于总个数)
 */
- (PHAsset *)lj_saveImageForPHAssetCollection:(PHAssetCollection *)assetCollection index:(NSInteger)index;

@end


@interface NSArray (PhotosCategory)

/*!
 @brief         保存图片组到相机胶卷
 @result        照片组在相册中的PHFetchResult  返回nil保存失败
 @discussion    self 为照片组(NSArray<UIImage *>)
 */
- (PHFetchResult *)lj_saveImageArray;

/*!
 @brief         保存图片组到指定相册
 @result        照片组在相册中的PHFetchResult  返回nil保存失败
 @discussion    self 为照片组(NSArray<UIImage *>)
 @param         assetCollection 相册
 */
- (PHFetchResult *)lj_saveImageArrayForPHAssetCollection:(PHAssetCollection *)assetCollection;

@end


@interface NSObject (PhotosCategory)

/*!
 @brief         获取所有照片PHFetchResult<PHAsset *>(不包含最近删除)
 @result        所有照片的PHFetchResult
 */
+ (PHFetchResult *)lj_getAllImages;

@end


@interface NSString (PhotosCategory)

/*!
 @brief         获取指定相册（没有该相册则创建一个）
 @result        相册 (PHAssetCollection *)
 @discussion    self 为相册名(NSString *)
 */
- (PHAssetCollection *)lj_getAssetCollection;

@end


@interface PHAssetCollection (PhotosCategory)

/*!
 @brief         获取指定相册中PHFetchResult<PHAsset *>
 @result        PHFetchResult<PHAsset *>
 @discussion    self 为相册(PHAssetCollection *)
 */
- (PHFetchResult *)lj_getPHFetchResult;

@end


@interface PHAsset (PhotosCategory)

/*!
 @brief         将PHFetchResult<PHAsset *>转成图片(原图)(慎重使用容易干爆内存)
 @result        图片(UIImage *)
 @discussion    self 为PHAsset
 */
- (UIImage *)lj_getImage;

/*!
 @brief         将PHFetchResult<PHAsset *>转成指定尺寸图片
 @result        图片(UIImage *)
 @discussion    self 为PHAsset
 @param         targetSize 图片尺寸
 */
- (UIImage *)lj_getImageWithTargetSize:(CGSize)targetSize;

//
/*!
 @brief         将PHFetchResult<PHAsset *>转成指定格式图片
 @result        图片(UIImage *)
 @discussion    self 为PHAsset
 @param         targetSize 图片尺寸    contentMode 图片模式    options 加载方式
 */

- (UIImage *)lj_getImageWithTargetSize:(CGSize)targetSize
                           contentMode:(PHImageContentMode)contentMode
                               options:(PHImageRequestOptions *)options;

@end


@interface PHFetchResult (PhotosCategory)

/*!
 @brief         将PHFetchResult<PHAsset *>转成图片(原图)(慎重使用容易干爆内存)
 @result        图片数组(NSArray <UIImage *>)
 @discussion    self 为PHFetchResult
 */
- (NSArray *)lj_getImages;

/*!
 @brief         将PHFetchResult<PHAsset *>转成指定尺寸图片
 @result        图片数组(NSArray <UIImage *>)
 @discussion    self 为PHFetchResult
 @param         targetSize 图片尺寸
 */
- (NSArray *)lj_getImagesWithTargetSize:(CGSize)targetSize;

/*!
 @brief         将PHFetchResult<PHAsset *>转成指定格式图片
 @result        图片数组(NSArray <UIImage *>)
 @discussion    self 为PHFetchResult
 @param         targetSize 图片尺寸    contentMode 图片模式    options 加载方式
 */
- (NSArray *)lj_getImagesWithTargetSize:(CGSize)targetSize
                            contentMode:(PHImageContentMode)contentMode
                                options:(PHImageRequestOptions *)options;

@end

