//
//  ViewController.m
//  CollectionViewSearchBarAndRefreshControl
//
//  Created by 佐毅 on 16/2/1.
//  Copyright © 2016年 上海乐住信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "HorizaontalScrollListCell.h"
#import "MJRefresh.h"
static NSString * const reuseIdentifier = @"CollectionViewCellIdentifier";

static NSString *const HorizaontalScrollListCellIdentifier = @"HorizaontalScrollListCellIdentifier";
@interface ViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) NSArray        *dataSource;

@property (nonatomic,strong) UISearchBar        *searchBar;

@property (nonatomic)        float          searchBarBoundsY;

@end

@implementation ViewController


-(void)dealloc{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self.collectionView setBackgroundColor: [UIColor whiteColor]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.dataSource =@[@"1",@"2"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HorizaontalScrollListCell" bundle:nil] forCellWithReuseIdentifier:@"HorizaontalScrollListCellIdentifier"];
    [self refreshAction];
}


- (void)refreshAction{
    // 下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.collectionView.mj_header endRefreshing];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prepareUI];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  self.dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *collectionCell = nil;
    if (indexPath.section == 0) {
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        collectionCell =  cell;
    }else{
        HorizaontalScrollListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HorizaontalScrollListCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [cell setImageArray:@[@"1"]];
        collectionCell =  cell;
    }
    return collectionCell;
}


#pragma mark -  <UICollectrionViewDelegateFlowLayout>
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(self.searchBar.frame.size.height, 0, 0, 0);
    }else{
        return UIEdgeInsetsZero;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(161,111);
    }else{
        return CGSizeMake([UIScreen mainScreen].bounds.size.width,120);
    }
    
}


#pragma mark - search

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
   //
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self cancelSearching];
    [self.collectionView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.view endEditing:YES];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    [self.searchBar setShowsCancelButton:YES animated:YES];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    [self.searchBar setShowsCancelButton:NO animated:YES];
}
-(void)cancelSearching{
    
    [self.searchBar resignFirstResponder];
    self.searchBar.text  = @"";
}
#pragma mark - prepareVC
-(void)prepareUI{
    [self addSearchBar];
}
-(void)addSearchBar{
    if (!self.searchBar) {
        self.searchBarBoundsY = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,self.searchBarBoundsY, [UIScreen mainScreen].bounds.size.width, 44)];
        self.searchBar.searchBarStyle       = UISearchBarStyleMinimal;
        self.searchBar.tintColor            = [UIColor orangeColor];
        self.searchBar.barTintColor         = [UIColor orangeColor];
        self.searchBar.delegate             = self;
        self.searchBar.placeholder          = @"search bar filter";
        [self.searchBar setBackgroundColor:[UIColor whiteColor]];
        UITextField *textField =  [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]];
        [textField setTextColor:[UIColor orangeColor]];
    }
    if (![self.searchBar isDescendantOfView:self.view]) {
        [self.view addSubview:self.searchBar];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x,
                                      self.searchBarBoundsY + ((-1* offset)-self.searchBarBoundsY),
                                      self.searchBar.frame.size.width,
                                      self.searchBar.frame.size.height);
}



@end
