import { LoadMoreState, PullRefreshLoadConstant as Const, RefreshState } from './PullRefreshLoadConstant';

@Observed
export class PullRefreshLoadModel {
  /******** [公共]上拉下拉 ********/
  /**
   * 当前偏移量(上拉偏移量或下拉偏移量)
   */
  offsetY: number = 0;
  /**
   * 首个触摸点的纵坐标
   * (TouchType.Down 事件)赋值
   */
  downY: number = 0;
  /**
   * 最新的触摸点纵坐标
   * (TouchType.Down 事件)首次点击屏幕时修改、
   * (TouchType.Move 事件)移动手指时修改
   */
  lastMoveY: number = 0;


  /*********** 下拉 **************/
  /**
   * [下拉] 禁用下拉刷新
   */
  banRefresh: boolean = false
  /**
   * [下拉] 是否到达顶部
   */
  isReachStart: boolean = false
  /**
   * [下拉刷新阈值] 触发刷新钩子的下拉偏移量
   */
  pullDownRefreshHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
  /**
   * [下拉] 下拉过程状态的数字枚举
   */
  refreshStateNum: RefreshState = RefreshState.default;
  /**
   * [下拉-动画时间] 延迟多少秒后，再执行「加载ing动画」的结束逻辑
   */
  pullDownRefreshingDelay: number = Const.Enter_Refreshing_Delay
  /**
   * [下拉-动画时间] 刷新完成后提示持续时间
   */
  pullDownAnimationOverDelay: number = Const.RefreshOver_Duration
  /**
   * [下拉-提示文案] 未达到刷新阈值偏移量
   */
  pullDownRefreshText: string = Const.PullDown_Refresh_Text
  /**
   * [下拉-提示文案] 达到刷新阈值偏移量
   */
  releaseRefreshText: string = Const.Release_Refresh_Text
  /**
   * [下拉-提示文案] 正在刷新
   */
  refreshingText: string = Const.Refreshing_Text
  /**
   * [下拉-提示文案] 刷新成功
   */
  refreshSuccessText: string = Const.Refresh_Success_Text
  /**
   * [下拉-提示文案] 刷新失败
   */
  refreshFailText: string = Const.Refresh_Fail_Text


  /*********** 上拉 **************/
  /**
   * [上拉] 禁用上拉加载
   */
  banLoadMore: boolean = false
  /**
   * [上拉] 是否到达底部
   */
  isReachEnd: boolean = false
  /**
   * [上拉加载更多阈值] 触发加载钩子的上拉偏移量
   */
  pullUpLoadHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
  /**
   * [上拉] 上拉过程状态的数字枚举
   */
  loadMoreStateNum: LoadMoreState = LoadMoreState.default;
  /**
   * [下拉-动画时间] 延迟多少秒后，再执行「加载ing动画」的结束逻辑
   */
  pullUpLoadingDelay: number = Const.Enter_loadingMore_Delay
  /**
   * [下拉-动画时间] 刷新完成后提示持续时间
   */
  pullUpAnimationOverDelay: number = Const.LoadOver_Duration
  /**
   * [上拉-提示文案] 未达到加载更多阈值偏移量
   */
  pullUpLoadMoreText: string = Const.PullUp_LoadMore_Text
  /**
   * [上拉-提示文案] 达到加载更多阈值偏移量
   */
  releaseLoadMoreText: string = Const.Release_LoadMore_Text
  /**
   * [上拉-提示文案] 正在加载中
   */
  LoadingMoreText: string = Const.LoadingMore_Text
  /**
   * [上拉-提示文案] 加载成功
   */
  loadMoreSuccessText: string = Const.LoadMore_Success_Text
  /**
   * [上拉-提示文案] 加载失败
   */
  loadMoreFailText: string = Const.LoadMore_Fail_Text
  /**
   * [上拉] 没有更多数据提示文案
   */
  pullUpNoMoreText: string = Const.Pull_Up_NoMore_Text
  /**
   * 是否有更多数据
   */
  hasMore: boolean = true;
}