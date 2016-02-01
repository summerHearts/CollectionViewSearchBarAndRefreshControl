//
//  HorizaontalScrollView.m
//  CollectionViewSearchBarAndRefreshControl
//
//  Created by 佐毅 on 16/2/1.
//  Copyright © 2016年 上海乐住信息技术有限公司. All rights reserved.
//

#import "HorizaontalScrollView.h"
#import "HorizaontalViewCell.h"

static NSString *reuseIdentifier = @"HorizaontalViewCellIdentifier";

@interface HorizaontalScrollView () <UICollectionViewDataSource, UICollectionViewDelegate> {
    UICollectionView *_collectionView;
}

@end

@implementation HorizaontalScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = (CGSize){120.f, 120.f};
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = \
    [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140.f) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"HorizaontalViewCell" bundle:nil]
        forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HorizaontalViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.horizaontalImageView.image = [UIImage imageNamed:@"cellImage"];
    return cell;
}

#pragma mark - UICollectionViewDelegate Methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    if (self.clickBlock) {
        self.clickBlock(weakSelf, indexPath);
    }
}


@end
