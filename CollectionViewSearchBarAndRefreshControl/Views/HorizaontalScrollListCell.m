//
//  HorizaontalScrollListCell.m
//  CollectionViewSearchBarAndRefreshControl
//
//  Created by 佐毅 on 16/2/1.
//  Copyright © 2016年 上海乐住信息技术有限公司. All rights reserved.
//

#import "HorizaontalScrollListCell.h"
#import "HorizaontalScrollView.h"

@interface HorizaontalScrollListCell ()

@property (nonatomic, strong) HorizaontalScrollView *scrollingView;

@end

@implementation HorizaontalScrollListCell

- (HorizaontalScrollView *)scrollingView {
    if (!_scrollingView) {
        _scrollingView = [[HorizaontalScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140.f)];
        __weak typeof(self) weakSelf = self;
        _scrollingView.clickBlock = ^(HorizaontalScrollView *scrollingView, NSIndexPath *indexPath){
            if (weakSelf.clickBlock) {
                weakSelf.clickBlock(indexPath);
            }
        };
        [self.contentView addSubview:_scrollingView];
    }
    return _scrollingView;
}
- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];

}

- (void)setImageArray:(NSArray *)imageArray{
    self.scrollingView.imageArray = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
}

@end
