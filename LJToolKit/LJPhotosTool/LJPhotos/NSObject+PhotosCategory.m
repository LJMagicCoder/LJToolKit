//
//  NSObject+PhotosCategory.m
//  PhotosDemo
//
//  Created by 宋立军 on 2017/6/6.
//  Copyright © 2017年 宋立军. All rights reserved.
//

#import "NSObject+PhotosCategory.h"

@implementation UIImage (PhotosCategory)

//保存图片到相机胶卷
- (PHAsset *)lj_saveImage {
    return [self lj_saveImageForPHAssetCollection:nil];
}

//保存图片到指定相册
- (PHAsset *)lj_saveImageForPHAssetCollection:(PHAssetCollection *)assetCollection {
    return [self lj_saveImageForPHAssetCollection:assetCollection index:defaultIndex];
}

//保存图片到指定相册 与指定位置
- (PHAsset *)lj_saveImageForPHAssetCollection:(PHAssetCollection *)assetCollection index:(NSInteger)index {
    if (index < 0) return nil; //位置需要大于或等于0
    
    //此相册照片数必须大于要存放的位置
    if ([PHAsset fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection options:nil].count < index) return nil;
    
    NSError *error = nil;
    //保存照片到相机胶卷
    __block NSString * localIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        localIdentifier = [PHAssetChangeRequest creationRequestForAssetFromImage:self].placeholderForCreatedAsset.localIdentifier;
        
    } error:&error];
    if (error) return nil;  //保存图片到相机胶卷失败
    
    //获取PHFetchResult
    PHFetchResult<PHAsset *> *createdAsset = [PHAsset fetchAssetsWithLocalIdentifiers:@[localIdentifier] options:nil];
    
    //只保存到相机胶卷
    if (!assetCollection && createdAsset.count) return [createdAsset firstObject];
    
    //将刚才添加到相机胶卷的照片放到指定相册中
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        [request insertAssets:createdAsset atIndexes:[NSIndexSet indexSetWithIndex:index]];
        
    } error:&error];
    if (error)  return nil;  //保存图片失败
    if (createdAsset.count) return [createdAsset firstObject];
    return nil;
}

@end


@implementation NSArray (PhotosCategory)

//保存图片组到相机胶卷
- (PHFetchResult *)lj_saveImageArray {
    return [self lj_saveImageArrayForPHAssetCollection:nil];
}

//保存图片组到指定相册
- (PHFetchResult *)lj_saveImageArrayForPHAssetCollection:(PHAssetCollection *)assetCollection {
    
    NSError *error = nil;
    //保存照片到相机胶卷
    __block NSMutableArray *localIdentifiers = [NSMutableArray array];
    for (UIImage *image in self) {
        [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
            [localIdentifiers addObject:[PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier];
            
        } error:&error];
        if (error) return nil;  //保存图片到相机胶卷失败
    }
    
    //获取PHFetchResult
    PHFetchResult<PHAsset *> *createdAsset = [PHAsset fetchAssetsWithLocalIdentifiers:localIdentifiers options:nil];
    
    //只保存到相机胶卷
    if (!assetCollection && createdAsset.count) return createdAsset;
    
    //将刚才添加到相机胶卷的照片放到指定相册中
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        [request addAssets:createdAsset];
        
    } error:&error];
    if (error)  return nil;  //保存图片失败
    if (createdAsset.count) return createdAsset;
    return nil;
}

@end


@implementation NSObject (PhotosCategory)

//获取所有照片PHFetchResult<PHAsset *>
+ (PHFetchResult *)lj_getAllImages {
    
    //获取相册集合
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    //标识符数组
    NSMutableArray <NSString *> *localIdentifiers = [NSMutableArray array];
    for (PHCollection *collection in smartAlbums) {
        //滤掉视频和最近删除
        if ([collection.localizedTitle isEqualToString:@"Recently Deleted"] || [collection.localizedTitle isEqualToString:@"Videos"])   continue;
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            for (PHAsset *asset in [PHAsset fetchAssetsInAssetCollection:(PHAssetCollection *)collection options:nil]) {
                [localIdentifiers addObject:asset.localIdentifier];
            }
        }
    }
    
    //返回含有所有PHAsset集合的PHFetchResult
    return [PHAsset fetchAssetsWithLocalIdentifiers:localIdentifiers options:nil];
}

@end


@implementation NSString (PhotosCategory)

//获取指定相册（没有该相册则创建一个）
- (PHAssetCollection *)lj_getAssetCollection {
    //self字符串为此相册名
    if (!self.length) return nil;
    
    //抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    //查找self字符串对应的自定义相册
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:self]) return collection;
    }
    //self字符串名对应的相册并不存在 新建一个
    NSError *error = nil;
    __block NSString *localIdentifier;
    //创建一个相册,并且拿到相册的唯一标识符
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        localIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:self].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) return nil;  //新建失败
    
    //根据相册的唯一标识符拿到相册
    if (localIdentifier.length)
        return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[localIdentifier] options:nil].firstObject;
    return nil;
}

@end


@implementation PHAssetCollection (PhotosCategory)

//获取指定相册中PHFetchResult<PHAsset *>
- (PHFetchResult *)lj_getPHFetchResult {
    return [PHAsset fetchAssetsInAssetCollection:(PHAssetCollection *)self options:nil];
}

@end


@implementation PHAsset (PhotosCategory)

//将PHFetchResult<PHAsset *>转成图片(原图)
- (UIImage *)lj_getImage {
    return [self lj_getImageWithTargetSize:PHImageManagerMaximumSize];
}

//将PHFetchResult<PHAsset *>转成指定尺寸图片
- (UIImage *)lj_getImageWithTargetSize:(CGSize)targetSize {
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.synchronous = YES;
    return [self lj_getImageWithTargetSize:targetSize contentMode:PHImageContentModeDefault options:options];
}

//将PHFetchResult<PHAsset *>转成指定格式图片
- (UIImage *)lj_getImageWithTargetSize:(CGSize)targetSize
                           contentMode:(PHImageContentMode)contentMode
                               options:(PHImageRequestOptions *)options {
    __block UIImage *image = nil;
    [[PHImageManager defaultManager] requestImageForAsset:self targetSize:targetSize contentMode:contentMode options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) image = result;
    }];
    return image;
}

@end


@implementation PHFetchResult (PhotosCategory)

//将PHFetchResult<PHAsset *>转成图片(原图)
- (NSArray *)lj_getImages {
    return [self lj_getImagesWithTargetSize:PHImageManagerMaximumSize];
}

//将PHFetchResult<PHAsset *>转成指定尺寸图片
- (NSArray *)lj_getImagesWithTargetSize:(CGSize)targetSize {
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.synchronous = YES;
    return [self lj_getImagesWithTargetSize:targetSize contentMode:PHImageContentModeDefault options:options];
}

//将PHFetchResult<PHAsset *>转成指定格式图片
- (NSArray *)lj_getImagesWithTargetSize:(CGSize)targetSize
                            contentMode:(PHImageContentMode)contentMode
                                options:(PHImageRequestOptions *)options {
    
    __block NSMutableArray *images = [NSMutableArray array];
    if ([self isKindOfClass:[PHAsset class]]) {
        [[PHImageManager defaultManager] requestImageForAsset:(PHAsset *)self targetSize:targetSize contentMode:contentMode options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) [images addObject:result];
        }];
        return images;
    }
    for (PHAsset *asset in self) {
        if (![asset isKindOfClass:[PHAsset class]]) continue;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:contentMode options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) [images addObject:result];
        }];
    }
    return images;
}

@end

