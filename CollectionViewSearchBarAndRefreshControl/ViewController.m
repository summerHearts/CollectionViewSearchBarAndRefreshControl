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
#import "codeObfuscation.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Entity.h"
#import "GCD.h"
#import "HorizaontalScrollView.h"
#import "CardCollectionController.h"
static NSString * const CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";

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
    [self.view setBackgroundColor:[UIColor whiteColor]];

    //初始化searchBar
    [self initSearchBar];
    self.dataSource =@[@"1",@"2"];
    
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"HorizaontalScrollListCell" bundle:nil] forCellWithReuseIdentifier:@"HorizaontalScrollListCellIdentifier"];
    [self.collectionView setBackgroundColor: [UIColor whiteColor]];

    
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:[NSString stringWithFormat:@"%@.sqlite", @"Entery"]];

    //查找并按name升序排序
    NSArray *ary2 = [Entity MR_findAllSortedBy:@"name" ascending:YES]; //查找type为2的数据
    NSArray *ary3 = [Entity MR_findByAttribute:@"type" withValue:@"2"];
    //查找第一条数据
    Entity *entyty = [Entity MR_findFirst];
    
    for (Entity *enty in ary2) {
        NSLog(@"%@ ,%@ ,%@",enty.name,enty.type,enty.tag);
    }
    NSLog(@"---------------------------------------------------------------------");

    for (Entity *enty in ary3) {
        NSLog(@"%@ ,%@ ,%@",enty.name,enty.type,enty.tag);
    }
   

    NSLog(@"---------------------------------------------------------------------");
    NSArray *ary = [Entity MR_findAll];
    
    //修改
    Entity *entity = [ary lastObject];
    entity.name = @"mike";
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    NSLog(@"%@ ,%@ ,%@",entity.name,entyty.type,entyty.tag);
    
    //删除
    NSArray *arry = [Entity MR_findAll];
    
    Entity *ensy = [arry lastObject];
    [ensy MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];

    //上拉刷新和下拉刷新
    [self refreshAction];
    
    [self nameAction];
}

- (void)nameAction{
    NSLog(@"asfgagdfjklgl");
}

- (void)initSearchBar{
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
    
        [self.view addSubview:self.searchBar];
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)refreshAction{
    // 下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //添加
        
        [GCDQueue executeInGlobalQueue:^{
            
            // 子线程执行下载操作
            Entity *enty = [Entity MR_createEntity];
            enty.name = @"Blank_佐毅";
            enty.type = @"2";
            enty.tag  = @"22";
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
            [GCDQueue executeInMainQueue:^{
                [self.collectionView.mj_header endRefreshing];
            }];
            
            
        }];
    }];
}

- (void)loadMoreRefreshAction{
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self.collectionView.mj_footer endRefreshing];
    }];
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
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        collectionCell =  cell;
    }else{
        HorizaontalScrollListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HorizaontalScrollListCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [cell setImageArray:@[@"1"]];
        cell.clickBlock = ^(NSIndexPath *indexPath){
            CardCollectionController *cardController = [[CardCollectionController alloc]init];
            [self.navigationController pushViewController:cardController animated:YES];
        };
        collectionCell =  cell;
    }
    return collectionCell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CardCollectionController *cardController = [[CardCollectionController alloc]init];
    [self.navigationController pushViewController:cardController animated:YES];
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

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x,
                                      self.searchBarBoundsY + ((-1* offset)-self.searchBarBoundsY),
                                      self.searchBar.frame.size.width,
                                      self.searchBar.frame.size.height);
}



@end
