//
//  HorizaontalScrollView.h
//  CollectionViewSearchBarAndRefreshControl
//
//  Created by 佐毅 on 16/2/1.
//  Copyright © 2016年 上海乐住信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizaontalScrollView;

typedef void(^HHScrollingViewItemClickBlock)(HorizaontalScrollView *scrollingView, NSIndexPath *indexPath);

@interface HorizaontalScrollView : UIView

@property (nonatomic, copy) HHScrollingViewItemClickBlock clickBlock;
@property (nonatomic, strong) NSArray *imageArray;
@end
