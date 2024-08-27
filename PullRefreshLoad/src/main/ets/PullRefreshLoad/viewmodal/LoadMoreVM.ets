import { PullRefreshLoadModel } from '../modal/PullRefreshLoadModel';
import { LoadMoreState } from '../modal/PullRefreshLoadConstant';

/**
 * @description [手指上拉移动处理函数] 更新上拉满足阈值标识变量
 * @param {PullRefreshLoadModel} dataModel 组件共享数据
 * @param {TouchEvent} event 鸿蒙原生触摸事件
 * @returns void
 */
export function touchMoveLoadMore(dataModel: PullRefreshLoadModel, event: TouchEvent) {
  if (dataModel.isReachEnd) {
    // 当前上拉偏移量, 取正值
    dataModel.offsetY = -(event.touches[0].y - dataModel.downY);

    // 上拉偏移量 >= 阈值, 进入「释放」状态，否则为继续上拉
    if (dataModel.offsetY >= dataModel.pullUpLoadHeight) {
      dataModel.loadMoreStateNum = LoadMoreState.Release
    } else {
      dataModel.loadMoreStateNum = LoadMoreState.DropUp
    }

    // 边界：上拉距离为负数，已经变成下拉了，退出上拉流程
    if (event.touches[0].y - dataModel.downY > 0) {
      dataModel.offsetY = 0;
    }
  }
}

/**
 * @description [手指松开的处理函数] 调用加载数据钩子
 * @param {PullRefreshLoadModel} dataModel 组件共享数据
 * @param {(isLoadMore: boolean) => void)} getDataCallBack 加载回调钩子
 * @returns void
 */
export function touchUpLoadMore(dataModel: PullRefreshLoadModel, getDataCallBack: (isLoadMore: boolean) => void) {
  dataModel.offsetY = dataModel.pullUpLoadHeight
  if (dataModel.hasMore) {
    dataModel.loadMoreStateNum = LoadMoreState.LoadingMore
    getDataCallBack(true)
  } else {
    dataModel.loadMoreStateNum = LoadMoreState.default
  }
}

/**
 * @description 关闭加载更多
 * @param {PullRefreshLoadModel} dataModel 组件共享数据
 * @returns void
 */
export function closeLoadMore(dataModel: PullRefreshLoadModel, isLoadMoreSuccess: boolean) {
  // 在「加载ing」状态延迟多少秒再进入下一个状态
  setTimeout(() => {
    // 更新加载结果状态
    dataModel.loadMoreStateNum = isLoadMoreSuccess ? LoadMoreState.Success : LoadMoreState.Fail

    animateTo({
      duration: dataModel.pullUpAnimationOverDelay, // 加载完成提示持续时间
      onFinish: () => {
        dataModel.loadMoreStateNum = LoadMoreState.default
        dataModel.isReachEnd = !dataModel.hasMore
      }
    }, () => {
      dataModel.offsetY = 0;
    })
  }, dataModel.pullUpLoadingDelay);
}
