import { RefreshState } from '../modal/PullRefreshConstant';
import { PullRefreshModel } from '../modal/PullRefreshModel';

/**
 * @description [手指下拉移动处理函数] 更新刷新过程变量 refreshStateNum
 * @param {PullRefreshModel} dataModel 组件共享数据
 * @param {TouchEvent} event 鸿蒙原生触摸事件
 * @returns void
 */
export function touchMovePullRefresh(dataModel: PullRefreshModel, event: TouchEvent) {
  if (dataModel.isReachStart) {
    // 当前下拉偏移量 = 当前位置纵坐标 - 首次按下屏幕时的纵坐标
    dataModel.offsetY = event.touches[0].y - dataModel.downY;

    // 下拉偏移量 >= 触发刷新阈值时，变更多「释放」状态，否则为「继续下拉」
    if (dataModel.offsetY >= dataModel.pullDownRefreshHeight) {
      pullRefreshState(dataModel, RefreshState.Release);
    } else {
      pullRefreshState(dataModel, RefreshState.DropDown);
    }

    // 边界：下拉距离为负数，已经变成上拉了，退出下拉流程
    if (dataModel.offsetY < 0) {
      dataModel.offsetY = 0;
    }
  }
}

/**
 * @description [手指松开的处理函数] 调用刷新回调钩子
 * @param {PullRefreshModel} dataModel 组件共享数据
 * @param {(isLoadMore: boolean) => void)} getDataCallBack 刷新回调钩子
 * @returns void
 */
export function touchUpPullRefresh(dataModel: PullRefreshModel, getDataCallBack: (isLoadMore: boolean) => void) {
  dataModel.offsetY = dataModel.pullDownRefreshHeight;
  pullRefreshState(dataModel, RefreshState.Refreshing);
  getDataCallBack(false)
}

/**
 * @description 更改刷新过程状态
 * @param {PullRefreshModel} dataModel 组件共享数据
 * @param {RefreshState} state 刷新过程变量
 * @returns void
 */
export function pullRefreshState(dataModel: PullRefreshModel, state: RefreshState) {
  switch (state) {
    case RefreshState.default:
      dataModel.refreshStateNum = RefreshState.default
      break;
    case RefreshState.DropDown:
      dataModel.refreshStateNum = RefreshState.DropDown
      break;
    case RefreshState.Release:
      dataModel.refreshStateNum = RefreshState.Release
      break;
    case RefreshState.Refreshing:
      dataModel.refreshStateNum = RefreshState.Refreshing
      break;
    case RefreshState.Success:
      dataModel.refreshStateNum = RefreshState.Success
      break;
    case RefreshState.Fail:
      dataModel.refreshStateNum = RefreshState.Fail
      break;
    default:
      break;
  }
}

/**
 * @description 关闭刷新
 * @param {PullRefreshModel} dataModel 组件共享数据
 * @param {boolean} isRefreshSuccess 是否刷新成功
 * @returns void
 */
export function closeRefresh(dataModel: PullRefreshModel, isRefreshSuccess: boolean) {
  // 在「刷新ing」状态延迟多少秒再进入下一个状态
  setTimeout(() => {
    // 更改状态
    pullRefreshState(dataModel, isRefreshSuccess ? RefreshState.Success : RefreshState.Fail);

    animateTo({
      duration: dataModel.pullDownAnimationOverDelay, // 刷新完成提示持续时间
      onFinish: () => {
        pullRefreshState(dataModel, RefreshState.default);
      }
    }, () => {
      dataModel.offsetY = 0;
    })
  }, dataModel.pullDownLoadingDelay);
}