import { RefreshState } from '../modal/PullRefreshLoadConstant';
import { PullRefreshLoadModel } from '../modal/PullRefreshLoadModel';

/**
 * @description [手指下拉移动处理函数] 判断能否达到下拉阈值
 * @param {PullRefreshLoadModel} dataModel 组件共享数据
 * @param {TouchEvent} event 鸿蒙原生触摸事件
 * @returns void
 */
export function touchMovePullRefresh(dataModel: PullRefreshLoadModel, event: TouchEvent) {
  if (dataModel.isReachStart) {
    // 当前下拉偏移量 = 当前位置纵坐标 - 首次按下屏幕时的纵坐标
    dataModel.offsetY = event.touches[0].y - dataModel.downY;

    // 下拉偏移量 >= 触发刷新阈值时，进入「释放」状态，否则为「继续下拉」
    if (dataModel.offsetY >= dataModel.pullDownRefreshHeight) {
      dataModel.refreshStateNum = RefreshState.Release
    } else {
      dataModel.refreshStateNum = RefreshState.DropDown
    }

    // 边界：下拉距离为负数，已经变成上拉了，退出下拉流程
    if (dataModel.offsetY < 0) {
      dataModel.offsetY = 0;
    }
  }
}

/**
 * @description [手指松开的处理函数] 调用刷新回调钩子
 * @param {PullRefreshLoadModel} dataModel 组件共享数据
 * @param {(isLoadMore: boolean) => void)} getDataCallBack 刷新回调钩子
 * @returns void
 */
export function touchUpPullRefresh(dataModel: PullRefreshLoadModel, getDataCallBack: (isLoadMore: boolean) => void) {
  dataModel.offsetY = dataModel.pullDownRefreshHeight;
  dataModel.refreshStateNum = RefreshState.Refreshing
  getDataCallBack(false)
}

/**
 * @description 关闭刷新
 * @param {PullRefreshLoadModel} dataModel 组件共享数据
 * @param {boolean} isRefreshSuccess 是否刷新成功
 * @returns void
 */
export function closeRefresh(dataModel: PullRefreshLoadModel, isRefreshSuccess: boolean) {
  // 在「刷新ing」状态延迟多少秒再进入下一个状态
  setTimeout(() => {
    // 更改状态
    dataModel.refreshStateNum = isRefreshSuccess ? RefreshState.Success : RefreshState.Fail

    animateTo({
      duration: dataModel.pullDownAnimationOverDelay, // 刷新完成提示持续时间
      onFinish: () => {
        dataModel.refreshStateNum = RefreshState.default
      }
    }, () => {
      dataModel.offsetY = 0;
    })
  }, dataModel.pullDownRefreshingDelay);
}