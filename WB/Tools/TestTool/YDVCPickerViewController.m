//
//  YDTestControllerPickerViewController.m
//  YunDiTrip
//
//  Created by 席萍萍 on 16/3/24.
//  Copyright © 2016年 shenzhen yundi technology co.,Ltd. All rights reserved.
//

#import "YDVCPickerViewController.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define UserDefaults [NSUserDefaults standardUserDefaults]
#define searchHistoryKey @"searchHistoryKey"
#define testKey @"testKey"
#define kDownLoadWidth 60
#define kOffSet kDownLoadWidth / 2

#pragma mark - FloatingView

typedef void (^FloatingBlock) ();

@interface FloatingView : UIView <UIDynamicAnimatorDelegate>

@property (nonatomic, assign) CGPoint startPoint;//触摸起始点
@property (nonatomic, assign) CGPoint endPoint;//触摸结束点
@property (nonatomic, strong) UIView *backgroundView;//背景视图
@property (nonatomic, strong) UIImageView *imageView;//图片视图
@property (nonatomic, strong) UIDynamicAnimator *animator;//物理仿真动画
@property (nonatomic,   copy) FloatingBlock floatingBlock;

@end

@implementation FloatingView
//初始化
-(instancetype)initWithFrame:(CGRect)frame{
    
    frame.size.width = kDownLoadWidth;
    
    frame.size.height = kDownLoadWidth;
    
    if (self = [super initWithFrame:frame]) {
        //初始化背景视图
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _backgroundView.layer.cornerRadius = _backgroundView.frame.size.width / 2;
        _backgroundView.clipsToBounds = YES;
        _backgroundView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.7];
        _backgroundView.userInteractionEnabled = NO;
        [self addSubview:_backgroundView];
        
        //初始化图片背景视图
        UIView * imageBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame) - 10, CGRectGetHeight(self.frame) - 10)];
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.size.width / 2;
        imageBackgroundView.clipsToBounds = YES;
        imageBackgroundView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.8f];
        imageBackgroundView.userInteractionEnabled = NO;
        [self addSubview:imageBackgroundView];
        //初始化图片
        
        _imageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"icon_tempMarkup"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        _imageView.tintColor = [UIColor whiteColor];
        _imageView.frame = CGRectMake(0, 0, 30, 30);
        _imageView.center = CGPointMake(kDownLoadWidth / 2 , kDownLoadWidth / 2);
        [self addSubview:_imageView];
        //将正方形的view变成圆形
        self.layer.cornerRadius = kDownLoadWidth / 2;
        //开启呼吸动画
        [self HighlightAnimation];
    }
    
    return self;
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //得到触摸点
    
    UITouch *startTouch = [touches anyObject];
    //返回触摸点坐标
    self.startPoint = [startTouch locationInView:self.superview];
    // 移除之前的所有行为
    [self.animator removeAllBehaviors];
}

//触摸移动

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //得到触摸点
    UITouch *startTouch = [touches anyObject];
    //将触摸点赋值给touchView的中心点 也就是根据触摸的位置实时修改view的位置
    self.center = [startTouch locationInView:self.superview];
}

//结束触摸

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //得到触摸结束点
    UITouch *endTouch = [touches anyObject];
    //返回触摸结束点
    self.endPoint = [endTouch locationInView:self.superview];
    //判断是否移动了视图 (误差范围5)
    CGFloat errorRange = 5;
    if (( self.endPoint.x - self.startPoint.x >= -errorRange && self.endPoint.x - self.startPoint.x <= errorRange ) && ( self.endPoint.y - self.startPoint.y >= -errorRange && self.endPoint.y - self.startPoint.y <= errorRange )) {
        //未移动
        //调用打开下载视图控制器方法
        //Bob-> 打开控制器
        if (self.floatingBlock) {
            self.floatingBlock();
        }
        
    } else {
        //移动
        self.center = self.endPoint;
        //计算距离最近的边缘 吸附到边缘停靠
        CGFloat superwidth = self.superview.bounds.size.width;
        CGFloat superheight = self.superview.bounds.size.height;
        CGFloat endX = self.endPoint.x;
        CGFloat endY = self.endPoint.y;
        CGFloat topRange = endY;//上距离
        CGFloat bottomRange = superheight - endY;//下距离
        CGFloat leftRange = endX;//左距离
        CGFloat rightRange = superwidth - endX;//右距离
        //比较上下左右距离 取出最小值
        CGFloat minRangeTB = topRange > bottomRange ? bottomRange : topRange;//获取上下最小距离
        CGFloat minRangeLR = leftRange > rightRange ? rightRange : leftRange;//获取左右最小距离
        CGFloat minRange = minRangeTB > minRangeLR ? minRangeLR : minRangeTB;//获取最小距离
        //判断最小距离属于上下左右哪个方向 并设置该方向边缘的point属性
        CGPoint minPoint = CGPointZero;
        if (minRange == topRange) {
            //上
            endX = endX - kOffSet < 0 ? kOffSet : endX;
            endX = endX + kOffSet > superwidth ? superwidth - kOffSet : endX;
            minPoint = CGPointMake(endX , 0 + kOffSet);
        } else if(minRange == bottomRange){
            //下
            endX = endX - kOffSet < 0 ? kOffSet : endX;
            endX = endX + kOffSet > superwidth ? superwidth - kOffSet : endX;
            minPoint = CGPointMake(endX , superheight - kOffSet);
            
        } else if(minRange == leftRange){
            //左
            endY = endY - kOffSet < 0 ? kOffSet : endY;
            endY = endY + kOffSet > superheight ? superheight - kOffSet : endY;
            minPoint = CGPointMake(0 + kOffSet , endY);
            
        } else if(minRange == rightRange){
            //右
            endY = endY - kOffSet < 0 ? kOffSet : endY;
            endY = endY + kOffSet > superheight ? superheight - kOffSet : endY;
            minPoint = CGPointMake(superwidth - kOffSet , endY);
        }
        
        
        //添加吸附物理行为
        UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:minPoint];
        [attachmentBehavior setLength:0];
        [attachmentBehavior setDamping:0.1];
        [attachmentBehavior setFrequency:5];
        [self.animator addBehavior:attachmentBehavior];
    }
}

#pragma mark ---UIDynamicAnimatorDelegate

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    
}

#pragma mark ---LazyLoading
- (UIDynamicAnimator *)animator {
    if (!_animator) {
        // 创建物理仿真器(ReferenceView : 仿真范围)
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
        //设置代理
        _animator.delegate = self;
    }
    
    return _animator;
}

#pragma mark ---BreathingAnimation 呼吸动画
- (void)HighlightAnimation {
    __block typeof(self) Self = self;
    [UIView animateWithDuration:1.5f animations:^{
        Self.backgroundView.backgroundColor = [Self.backgroundView.backgroundColor colorWithAlphaComponent:0.1f];
        
    } completion:^(BOOL finished) {
        [Self DarkAnimation];
    }];
}

- (void)DarkAnimation{
    __block typeof(self) Self = self;
    [UIView animateWithDuration:1.5f animations:^{
        Self.backgroundView.backgroundColor = [Self.backgroundView.backgroundColor colorWithAlphaComponent:0.6f];
    } completion:^(BOOL finished) {
        [Self HighlightAnimation];
    }];
}

@end

#pragma mark - YDVCPickerViewController

static FloatingView *_floatingView = nil;
static NSArray *_prefixArray = nil;
static BOOL _hasShown = NO;

@interface YDVCPickerViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_finalArray; // all possible classes
    NSArray *_tempArray; // search results classes
    NSMutableArray *_historyArray; // history classes
}

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation YDVCPickerViewController
#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pickCancel)];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"Search";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    [self loadHistoryData];
    
    [self.view addSubview:self.tableView];
}

// view appear to find all controllers and show search keyboard
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self findControllers];
    
    // UISearchBar *searchBar = (UISearchBar *)self.navigationItem.titleView;
    // [searchBar becomeFirstResponder];
    
    [[self class] setCircleHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    UISearchBar *searchBar = (UISearchBar *)self.navigationItem.titleView;
    [searchBar resignFirstResponder];
    
    [[self class] setCircleHidden:NO];
}

//layout tableview
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

//load history data
- (void)loadHistoryData {
    _historyArray = [UserDefaults objectForKey:searchHistoryKey];
    if (_historyArray) {
        _historyArray = [_historyArray mutableCopy];
        
    }else {
        _historyArray = [NSMutableArray array];
    }
}

// cancel pick
- (void)pickCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// lazy initializing tableview
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}

// try gcddddddd
- (void)findControllers {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _finalArray = [self findViewControllers];
        _tempArray = _finalArray;
        
        [self handleMissedHistory];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

//if some classes has gone remove it from history records
- (void)handleMissedHistory {
    NSMutableArray *newHistoryArray = [_historyArray mutableCopy];
    for (NSString *className in newHistoryArray) {
        NSInteger index = [_finalArray indexOfObject:className];
        if (index == NSNotFound) {
            [_historyArray removeObject:className];
        }
    }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
//history or search
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? _tempArray.count : _historyArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section ? @"Search ↓" : @"History ↓";
}

// return cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"TestPickerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSArray *dataArray = indexPath.section ? _tempArray : _historyArray;
    NSString *className = dataArray[indexPath.row];
    
    cell.textLabel.text = className;
    
    return cell;
}

//edit history
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [_historyArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    [UserDefaults setObject:_historyArray forKey:searchHistoryKey];
    [UserDefaults synchronize];
}

//can only edit history
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return !indexPath.section;
}

// did selector one ViewController and show it
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *dataArray = nil;
    dataArray = indexPath.section ? _tempArray : _historyArray;
    NSString *className = dataArray[indexPath.row];
    
    [self addHistoryRecord:className];
    
    [self dismissViewControllerAnimated:YES completion:^{
        UIViewController *targetVC = [[NSClassFromString(className) alloc] init];
        
        [[self class] showViewController:targetVC];
    }];
}

// hide the keyboard while scrolling
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UISearchBar *searchBar = (UISearchBar *)self.navigationItem.titleView;
    [searchBar resignFirstResponder];
}

// add one history record, the same one will be avoied
- (void)addHistoryRecord:(NSString *)history {
    if ([_historyArray indexOfObject:history] == NSNotFound) {
        [_historyArray addObject:history];
        
        [UserDefaults setObject:_historyArray forKey:searchHistoryKey];
        [UserDefaults synchronize];
    }
}

#pragma mark - UISearchBarDelegate
//find proper result while editing, ignore the upperCase of character
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSString *className in _finalArray) {
        NSString *upperClassName = [className uppercaseString];
        NSString *upperSearchText = [searchText uppercaseString];
        
        NSRange range = [upperClassName rangeOfString:upperSearchText];
        
        if (range.location != NSNotFound) {
            [resultArray addObject:className];
        }
    }
    
    _tempArray = searchText.length ? resultArray : _finalArray;
    
    [self.tableView reloadData];
}

//click search just to hide the keyboard
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - finder
+ (void)showFinderWithClassPrefix:(NSArray<NSString *> *)prefixArray {
#ifdef DEBUG
    UIWindow *keyWindow = [self getKeyWindow];
    if(!_hasShown) {
        _hasShown = YES;
        _prefixArray = prefixArray;
        
        _floatingView = [[FloatingView alloc] initWithFrame:CGRectMake(CGRectGetWidth(keyWindow.frame) - 80 , keyWindow.frame.size.height - 190, 60, 60)];
        _floatingView.backgroundColor = [UIColor clearColor];
        _floatingView.floatingBlock = ^{
            [self setCircleHidden:YES];
            [self showPickerController];
        };
    }
    
    [keyWindow addSubview:_floatingView];
    [keyWindow bringSubviewToFront:_floatingView];
#endif
}

+ (void)showPickerController {
    UIViewController *rootVC = [self getKeyWindow].rootViewController;
    UINavigationController *naviedPickerVC = [[UINavigationController alloc] initWithRootViewController:[self new]];
    
    [rootVC presentViewController:naviedPickerVC animated:YES completion:nil];
}

+ (UIWindow *)getKeyWindow {
    id appDelegate = [UIApplication sharedApplication].delegate;
    UIWindow *keyWindow = [appDelegate valueForKey:@"window"];
    
    return keyWindow;
}

+ (void)setCircleHidden:(BOOL)hidden {
    _floatingView.hidden = hidden;
}


+ (void)showViewController:(UIViewController *)controller {
    UIViewController *rootVC = [self getKeyWindow].rootViewController;
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        for (UINavigationController *naviVC in ((UITabBarController *)rootVC).viewControllers) {
            if ([naviVC isKindOfClass:[UINavigationController class]]) {
                [naviVC pushViewController:controller animated:YES];
                return;
            }
        }
        
    }else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        [((UINavigationController *)rootVC) pushViewController:controller animated:YES];
        
    }else {
        UINavigationController *reulstNavi = [[UINavigationController alloc] initWithRootViewController:controller];
        [rootVC presentViewController:reulstNavi animated:YES completion:^{
            controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissPresentedViewController)];
        }];
    }
}

// 关闭弹出的控制器
+ (void)dismissPresentedViewController {
    UIViewController *rootVC = [self getKeyWindow].rootViewController;
    
    [rootVC dismissViewControllerAnimated:YES completion:nil];
}

//也许可以递归查找
- (NSArray *)findViewControllers {
    Class *classes = NULL;
    int numClasses = objc_getClassList(NULL, 0);
    
    NSMutableArray *unSortedArray = [NSMutableArray array];
    if (numClasses > 0) {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            Class theClass = classes[i];
            NSString *className = [NSString stringWithUTF8String:class_getName(theClass)];
            for (NSString *classPrefix in _prefixArray) {
                if ([className hasPrefix:classPrefix]) {
                    BOOL isSelfClass = [className isEqualToString:NSStringFromClass([self class])];
                    if ([theClass isSubclassOfClass:[UIViewController class]] && !isSelfClass) {
                        [unSortedArray addObject:className];
                    }
                }
            }
        }
        free(classes);
    }
    
    NSArray *finalArray = [unSortedArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSForcedOrderingSearch];
    }];
    
    return finalArray;
}

@end