//
//  CardCollectionController.m
//  CollectionViewSearchBarAndRefreshControl
//
//  Created by 佐毅 on 16/2/1.
//  Copyright © 2016年 上海乐住信息技术有限公司. All rights reserved.
//

#import "CardCollectionController.h"
#import "FXBlurView.h"
#import "CardCollectionViewCell.h"
#import "CardCollectionViewLineLayout.h"

static NSString * const reuseIdentifier = @"Cell";

@interface CardCollectionController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong ) NSMutableArray               *dataSource;
@property (nonatomic, strong) UIImageView                  *imageView;
@property (nonatomic, strong) UICollectionView             *collectionView;
@property (nonatomic, strong) CardCollectionViewLineLayout *lineLayout;

@end

@implementation CardCollectionController

#pragma mark -
#pragma mark lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.collectionView];

    
}

#pragma mark -
#pragma mark init methods
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zi.jpg", 7%3]];
        FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:_imageView.bounds];
        blurView.blurRadius = 10;
        blurView.tintColor = [UIColor clearColor];
        [_imageView addSubview:blurView];
    }
    return _imageView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _lineLayout = [[CardCollectionViewLineLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                             collectionViewLayout:_lineLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundView = self.imageView;
        [_collectionView registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:7 inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];
    }
    return _collectionView;
}

#pragma mark -
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = self.lineLayout.itemSize.width + self.lineLayout.minimumLineSpacing;
    NSInteger item = offsetX/width;
    NSString *imageName1 = [NSString stringWithFormat:@"%zi.jpg", item%3];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.2f animations:^{
        weakSelf.imageView.image = [UIImage imageNamed:imageName1];
    }];
}

#pragma mark -
#pragma mark UICollectionViewDatasoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"%zi.jpg", indexPath.item%3];
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}



@end
