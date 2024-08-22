export class PullRefreshLoadConstant {
  /**
   * 顶部刷新UI 默认高度
   * 底部加载更多UI 默认高度
   * 下拉、上拉 默认阈值
   */
  static readonly CUSTOM_LAYOUT_HEIGHT: number = 70;

  /******* 下拉 ******/
  /**
   * [下拉-动画时间] 延迟多少秒再计算 (RefreshState.Refreshing) 刷新ing动画 的结束逻辑
   */
  static readonly Enter_Refreshing_Delay: number = 300;
  /**
   * [下拉-动画时间] 刷新完成后提示持续时间 RefreshConstant_CLOSE_PULL_DOWN_REFRESH_TIME
   */
  static readonly RefreshOver_Duration: number = 150;
  /**
   * [下拉-提示文案] 未达到刷新的偏移量要求
   */
  static readonly PullDown_Refresh_Text: string = '继续下拉...'
  /**
   * [下拉-提示文案] 达到刷新的偏移量要求
   */
  static readonly Release_Refresh_Text: string = '释放即可刷新...'
  /**
   * [下拉-提示文案] 正在刷新中
   */
  static readonly Refreshing_Text: string = '拼命刷新中...'
  /**
   * [下拉-提示文案] 刷新成功
   */
  static readonly Refresh_Success_Text: string = '刷新成功'
  /**
   * [下拉-提示文案] 刷新失败
   */
  static readonly Refresh_Fail_Text: string = '刷新失败'

  /******* 上拉 ******/
  /**
   * [上拉-动画时间] 延迟多少秒再计算 (LoadMoreState.LoadingMore) 加载ing动画 的结束逻辑
   */
  static readonly Enter_loadingMore_Delay: number = 300;
  /**
   * [上拉-动画时间] 加载完成后提示持续时间
   */
  static readonly LoadOver_Duration: number = 150;
  /**
   * [上拉-提示文案] 未达到加载更多的偏移量要求
   */
  static readonly PullUp_LoadMore_Text: string = '继续上拉...'
  /**
   * [上拉-提示文案] 达到加载更多的偏移量要求
   */
  static readonly Release_LoadMore_Text: string = '释放即可加载...'
  /**
   * [上拉-提示文案] 正在加载中
   */
  static readonly LoadingMore_Text: string = '拼命加载中...'
  /**
   * [上拉-提示文案] 加载更多成功
   */
  static readonly LoadMore_Success_Text: string = '加载成功'
  /**
   * [上拉-提示文案] 加载失败
   */
  static readonly LoadMore_Fail_Text: string = '加载失败'
  /**
   * [上拉-提示文案] 没有更多数据
   */
  static readonly Pull_Up_NoMore_Text: string = '没有更多数据了'
}

export const enum RefreshState {
  /**
   * 未下拉
   */
  default = -1,
  /**
   * [继续下拉] 开始下拉，但下拉偏移量还没达到刷新阈值
   */
  DropDown = 0,
  /**
   * [释放刷新] 下拉偏移量达到刷新阈值
   */
  Release = 1,
  /**
   * 正在刷新中
   */
  Refreshing = 2,
  /**
   * 刷新成功
   */
  Success = 3,
  /**
   * 刷新失败
   */
  Fail = 4
}


export const enum LoadMoreState {
  /**
   * 未上拉
   */
  default = -1,
  /**
   * [继续下拉] 开始上拉，但上拉偏移量还没达到加载更多阈值
   */
  DropUp = 0,
  /**
   * [释放加载更多] 上拉偏移量达到加载更多阈值
   */
  Release = 1,
  /**
   * 正在加载中
   */
  LoadingMore = 2,
  /**
   * 加载成功
   */
  Success = 3,
  /**
   * 加载失败
   */
  Fail = 4
}