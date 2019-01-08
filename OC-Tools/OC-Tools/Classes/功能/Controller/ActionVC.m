//
//  ActionVC.m
//  OC-Tools
//
//  Created by Ganggang Xie on 2018/12/25.
//  Copyright © 2018年 Ganggang Xie. All rights reserved.
//

#import "ActionVC.h"
#import "ActionVCModel.h"
#import "CTMediator+Actions.h"

@interface ActionVC ()<UITableViewDelegate,UITableViewDataSource>

/** <#aaa#> */
@property(nonatomic,strong)UITableView *tableView;

/** <#aaa#> */
@property(nonatomic,strong)NSArray<ActionVCModel *> *dataArray;

@end

@implementation ActionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"工具";
    
    //
    [self setup];
}

#pragma mark - 初始化
- (void)testAction{
    self.tableView.editing = !self.tableView.editing;
}
- (void)setup{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:self action:@selector(testAction)];
    //
    [self setupData];
    //
    [self setupUI];
}
//MARK: 初始化数据
- (void)setupData{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"ActionVCList" ofType:@"plist"];
//    NSLog(@"%@",marray);
    self.dataArray = [ActionVCModel mj_objectArrayWithFile:filePath];
}
//MARK: 初始化UI
- (void)setupUI{
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ActionVCModel *model = self.dataArray[section];
    return model.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    ActionVCModel *model = self.dataArray[indexPath.section];
    ActionModel *actionM = model.actions[indexPath.row];
    cell.textLabel.text = actionM.title;
    UIButton *btn = [cell viewWithTag:101];
    if (!btn) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor orangeColor];
        [cell addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(cell);
            make.width.equalTo(@100);
        }];
        [btn addTarget:self action:@selector(aaaa) forControlEvents:UIControlEventTouchUpInside];
    }
    
//    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    //cell.editing，使用该属性标示cell 可编辑
//    ActionVCModel *model = self.dataArray[indexPath.section];
//    ActionModel *aModel = model.actions[indexPath.row];
//    cell.textLabel.text = aModel.title;
    return cell;
}
- (void)aaaa{
    NSLog(@"11111");
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"组头视图标题-%zd",section];
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"组头视图标题-%zd",section];
}
//指定位置的 cell 可编辑
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//指定 cell 是否可移动，重新排序。排序方法在 -tableview:moveRowAtIndexPath:toIndexPath 代理方法中实现
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//tableView 右侧索引的提示内容
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.dataArray valueForKeyPath:@"tag"];
}
//索引点击事件的响应
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    //    NSLog(@"%@",[UILocalizedIndexedCollation currentCollation].sectionTitles);
    //[UILocalizedIndexedCollation currentCollation].sectionTitles，A～Z 和 # ，27个字符
    //    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    //    SEL selector = @selector(name);
    //model 模型中的 name 属性在 [UILocalizedIndexedCollation currentCollation].sectionTitles 中的位置。
    //    NSUInteger index = [collation sectionForObject:model collationStringSelector:selector];
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}


//tableView 的 editing 为 YES 时，-tableView:editingStyleForRowAtIndexPath: 代理方法返回值不为 None，cell 的增删触发该代理方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
//tableView 的 editing 为 YES 时，cell 的位置移动结束时触发该方法
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}

#pragma mark - UITableViewDelegate
//cell 开始布局，复制 cell 和 为 cell 加动画等
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    ActionVCModel *model = self.dataArray[indexPath.section];
    ActionModel *aModel = model.actions[indexPath.row];
    cell.textLabel.text = aModel.title;
}
//sessionHeaderView 开始布局
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
//    NSLog(@"sessionHeaderView 开始布局");
}
//sessionFooterView 开始布局
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
//    NSLog(@"sessionFooterView 开始布局");
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
//    NSLog(@"cell 布局结束");
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
//    NSLog(@"sessionHeaderView 布局结束");
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{
//    NSLog(@"sessionFooterView 布局结束");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cell 的高度");
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    NSLog(@"sessionHeaderView 的高度");
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    NSLog(@"sessionFooterView 的高度");
    return UITableViewAutomaticDimension;
}
//
//估算高度，实现了这三个代理方法，上三个代理方法延迟调用
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cell 估算高度");
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
//    NSLog(@"sessionHeaderView 估算高度");
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
//    NSLog(@"sessionFooterView 估算高度");
    return 20;
}

//自定义 sessionHeaderView 和 sessionFooterView
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;   // custom view for footer. will be adjusted to default or specified footer height

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cell.accessoryType = UITableViewCellAccessoryDetailButton; 时，点击 button 时触发");
}

// Selection
//当 cell 选中时，是否显示高亮
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cell 手指按下时触发");
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cell 手指松开时触发");
}
//cell 的选中状态将要改变时触发
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cell 选中状态将要改变时触发");
    return indexPath;//如果返回 nil ，改行不选中。返回 indexPath，选中返回的 indexPath。返回 indexPath 会触发 -tableView:didSelectRowAtIndexPath 方法。
}
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cell 将要取消选中时触发");
    return indexPath;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [[CTMediator sharedInstance] LiveBroadcast:@{@"key" : @"value"}];
    
    ActionVCModel *model = self.dataArray[indexPath.section];
    ActionModel *actionM = model.actions[indexPath.row];
    [[CTMediator sharedInstance] actionUrl:actionM.url];
    
//    [[CTMediator sharedInstance] actionUrl:@"aa://Actions/LiveBroadcast?key=value"];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cell 取消选中时触发");
}

//tableview 的 editing 为 YES 时，cell 右侧可移动标示，UITableViewCellEditingStyleNone(cell左侧空白)、UITableViewCellEditingStyleDelete(cell 左侧减号)、UITableViewCellEditingStyleInsert(cell左侧加号)。
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
//-tableView:canEditRowAtIndexPath: 代理方法返回 YES 时，左滑的提示标题
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"aa";
}
//
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"测试1" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //关闭编辑模式
        [tableView setEditing:NO animated:YES];
    }];
    action1.backgroundColor = [UIColor orangeColor];
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"测试2" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    action2.backgroundColor = [UIColor blueColor];
    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"测试3" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    action3.backgroundColor = [UIColor blackColor];
    action3.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    return @[action1,action2,action3];
}

// Swipe actions
// These methods supersede -editActionsForRowAtIndexPath: if implemented
// return nil to get the default swipe actions
- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)){
    return [UISwipeActionsConfiguration new];
}
//- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);
//
//// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
//
//进入 editing 状态(删除、移动、插入)，左滑时触发
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
//结束编辑状态时触发
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath{
    
}

//// Moving/reordering(移动和重新排序)
// tableView 的 editing 为 YES 时，到达其它 cell 位置时触发。
//sourceIndexPath：起始位置
//proposedDestinationIndexPath：到达 cell 的位置
//返回值 为当前移动cell 的放置位置
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    return proposedDestinationIndexPath;
}

//// Indentation
//
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row;
}
//
//// Copy/Paste.  All three methods must be implemented by the delegate.
//
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0);
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//
//// Focus
//
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0);
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0);
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0);
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0);
//
//// Spring Loading
//
//// Allows opting-out of spring loading for an particular row.
//// If you want the interaction effect on a different subview of the spring loaded cell, modify the context.targetView property. The default is the cell.
//// If this method is not implemented, the default is YES except when the row is part of a drag session.
//- (BOOL)tableView:(UITableView *)tableView shouldSpringLoadRowAtIndexPath:(NSIndexPath *)indexPath withContext:(id<UISpringLoadedInteractionContext>)context API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos, watchos);



#pragma mark - getter 方法
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        _tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
        //设置 tableView 的索引样式
        _tableView.sectionIndexColor = [UIColor orangeColor];//字体颜色
        _tableView.sectionIndexBackgroundColor = [UIColor blueColor];//索引条颜色
        //        _tableView.sectionFooterHeight = 10;
//        [_tableView setEditing:YES animated:YES];//tableView 进入编辑状态。即：可删除行、添加行、移动行
//        _tableView.editing = YES;
    }
    return _tableView;
}


@end
