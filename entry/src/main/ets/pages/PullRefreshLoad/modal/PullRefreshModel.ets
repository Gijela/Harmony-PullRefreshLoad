import { PullRefreshConstant as Const, RefreshState } from './PullRefreshConstant';

@Observed
export class PullRefreshModel {
  /**
   * [下拉刷新阈值] 触发刷新钩子的下拉偏移量
   */
  pullDownRefreshHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
  /**
   * [上拉加载更多阈值] 触发加载钩子的上拉偏移量
   */
  pullUpLoadHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
  /**
   * 当前偏移量(上拉偏移量或下拉偏移量)
   */
  offsetY: number = 0;
  /**
   * 是否有更多数据
   */
  hasMore: boolean = true;
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
  /**
   * [下拉] 下拉过程状态的数字枚举
   */
  refreshStateNum: RefreshState = RefreshState.default;
  /**
   * 是否正在加载更多数据(正在请求中)
   */
  isLoadingMore: boolean = false;
  /**
   * 上拉偏移量达到阈值
   * 相当于刷新的释放过程 RefreshState.Release
   */
  isPullUpReachThreshold: boolean = false;
  /**
   * [下拉] 是否到达顶部
   */
  isReachStart: boolean = false
  /**
   * 是否到达底部
   */
  isReachEnd: boolean = false
  /**
   * [下拉] 禁用下拉刷新
   */
  banRefresh: boolean = false
  /**
   * 禁用上拉加载
   */
  banLoadMore: boolean = false
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
  /**
   * [上拉] 加载中提示文案
   */
  pullUpLoadText: string = Const.Pull_Up_Load_Text
  /**
   * [上拉] 没有更多数据提示文案
   */
  pullUpNoMoreText: string = Const.Pull_Up_NoMore_Text
  /**
   * [下拉-动画时间] 延迟多少秒后，再执行「加载ing动画」的结束逻辑
   */
  pullDownLoadingDelay: number = Const.DelayTime_Enter_RefreshLoading_Animation
  /**
   * [下拉-动画时间] 刷新完成后提示持续时间
   */
  pullDownAnimationOverDelay: number = Const.RefreshConstant_CLOSE_PULL_DOWN_REFRESH_TIME
}