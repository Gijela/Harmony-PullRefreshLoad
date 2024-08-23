import { PullRefreshLoadModel } from '../modal/PullRefreshLoadModel';
import { LoadMoreState, RefreshState } from '../modal/PullRefreshLoadConstant'
import { touchMovePullRefresh, touchUpPullRefresh } from './RefreshVM'
import { touchMoveLoadMore, touchUpLoadMore } from './LoadMoreVM'

/**
 * @description 前置知识 onTouch 的 event 事件
 * event.type: 事件类型
 *  TouchType.Down: 手指首次按下屏幕
 *  TouchType.Move: 按下后在屏幕上移动
 *  TouchType.Up: 手指离开屏幕
 * event.touches 是一个数组，包含了所有当前活动的触摸点信息。
 *  event.touches[0].y 表示触摸事件发生时，触摸点的纵坐标（垂直坐标）。
 *  这个值是相对于视口或屏幕的坐标系而言的。
 */

/**
 * @description 入口函数，处理用户触摸事件 onTouch
 * @param {PullRefreshLoadModel} dataModel 组件共享数据
 * @param {TouchEvent} event
 * @param {(isLoadMore: boolean) => void} getDataCallBack 刷新回调钩子或者加载更多回调钩子
 * @returns void
 */
export function handleTouchEvent(dataModel: PullRefreshLoadModel, event: TouchEvent, getDataCallBack: (isLoadMore: boolean) => void) {
  switch (event.type) {
    // 手指首次按下屏幕
    case TouchType.Down:
      // 初始化首个触摸点的纵坐标
      dataModel.downY = event.touches[0].y;
      // 初始化最新触摸点的纵坐标
      dataModel.lastMoveY = event.touches[0].y;
      break;

    // 手指按住屏幕移动
    case TouchType.Move:
      // 边界：正在刷新或加载中，直接返回
      if ((dataModel.refreshStateNum === RefreshState.Refreshing) || dataModel.loadMoreStateNum === LoadMoreState.LoadingMore) {
        console.log(`[请求数据] 正在${dataModel.loadMoreStateNum === LoadMoreState.LoadingMore ? '加载更多' : '刷新'}中`);
        return;
      }

      // [是否处于下拉] 判断条件：当前触摸点纵坐标 > 前一个触摸点的纵坐标
      let isDownPull = event.touches[0].y - dataModel.lastMoveY > 0;

      if (isDownPull) {
        !dataModel.banRefresh && touchMovePullRefresh(dataModel, event);
      } else {
        !dataModel.banLoadMore && touchMoveLoadMore(dataModel, event);
      }

      // 更新最新触摸点的纵坐标
      dataModel.lastMoveY = event.touches[0].y;
      break;

    // 手指离开屏幕
    case TouchType.Up:
      // 边界：已经在刷新或者加载中，直接返回
      if (dataModel.refreshStateNum === RefreshState.Refreshing || dataModel.loadMoreStateNum === LoadMoreState.LoadingMore) {
        return;
      }

      // 下拉偏移量达到阈值，触发回调钩子
      if (dataModel.refreshStateNum === RefreshState.Release) {
        !dataModel.banRefresh && touchUpPullRefresh(dataModel, getDataCallBack);
      }

      // 上拉偏移量达到阈值，触发回调钩子
      if (dataModel.loadMoreStateNum === LoadMoreState.Release) {
        !dataModel.banLoadMore && touchUpLoadMore(dataModel, getDataCallBack);
      }

      break;

    default:
      break;
  }
}