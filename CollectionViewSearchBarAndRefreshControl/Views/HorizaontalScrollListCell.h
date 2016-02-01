//
//  HorizaontalScrollListCell.h
//  CollectionViewSearchBarAndRefreshControl
//
//  Created by 佐毅 on 16/2/1.
//  Copyright © 2016年 上海乐住信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HorizaontalScrollListCellClickBlock)(NSIndexPath *indexPath);

@interface HorizaontalScrollListCell : UICollectionViewCell


@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, copy) HorizaontalScrollListCellClickBlock clickBlock;

@end
