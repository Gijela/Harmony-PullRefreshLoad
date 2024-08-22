import { PullRefreshModel } from '../modal/PullRefreshModel';
import { PullRefreshConstant as Const } from '../modal/PullRefreshConstant';

/**
 * @description [手指上拉移动处理函数] 更新上拉满足阈值标识变量 isPullUpReachThreshold
 * @param {PullRefreshModel} dataModel 组件共享数据
 * @param {TouchEvent} event 鸿蒙原生触摸事件
 * @returns void
 */
export function touchMoveLoadMore(dataModel: PullRefreshModel, event: TouchEvent) {
  if (dataModel.isReachEnd) {
    // 当前上拉偏移量, 取正值
    dataModel.offsetY = -(event.touches[0].y - dataModel.downY);

    // 当前上拉偏移量 >= 阈值, 更新 isPullUpReachThreshold，松开手指后，就能执行回调钩子
    if (dataModel.offsetY >= dataModel.pullUpLoadHeight) {
      dataModel.isPullUpReachThreshold = true;
      dataModel.offsetY = dataModel.pullUpLoadHeight
    }
  }
}

/**
 * @description [手指松开的处理函数] 调用加载数据钩子
 * @param {PullRefreshModel} dataModel 组件共享数据
 * @param {(isLoadMore: boolean) => void)} getDataCallBack 加载回调钩子
 * @returns void
 */
export function touchUpLoadMore(dataModel: PullRefreshModel, getDataCallBack: (isLoadMore: boolean) => void) {
  animateTo({
    duration: Const.LoadMore_Loading_Animation_Duration
  }, () => {
    dataModel.offsetY = 0;
  })

  // 有更多数据就执行回调钩子，没有就结束
  if (dataModel.hasMore) {
    dataModel.isLoadingMore = true;
    getDataCallBack(true)
  } else {
    closeLoadMore(dataModel);
  }
}

/**
 * @description 关闭加载更多
 * @param {PullRefreshModel} dataModel 组件共享数据
 * @returns void
 */
export function closeLoadMore(dataModel: PullRefreshModel) {
  dataModel.isPullUpReachThreshold = false;
  dataModel.isLoadingMore = false;
}