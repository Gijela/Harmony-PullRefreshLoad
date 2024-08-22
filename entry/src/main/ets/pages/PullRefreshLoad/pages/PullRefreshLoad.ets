import { handleTouchEvent } from '../viewmodal/TouchVM'
import { PullRefreshModel } from '../modal/PullRefreshModel'
import { RefreshState } from '../modal/PullRefreshConstant'
import { CardBaseLayout } from './CardBaseLayout'

@Component
export struct PullRefreshLoad {
  // 双向绑定的组件驱动 modal
  @Link dataModel: PullRefreshModel

  /* [下拉] 下拉过程中顶部内容UI */
  @BuilderParam pullingDownLayout: () => void = this.defaultPullingDownLayout
  /* [下拉] 释放过程中顶部内容UI */
  @BuilderParam loosingLayout: () => void = this.defaultLoosingLayout
  /* [下拉] 刷新ing顶部内容UI */
  @BuilderParam refreshingLayout: () => void = this.defaultRefreshingLayout
  /* [下拉] 刷新成功顶部内容UI */
  @BuilderParam refreshSuccessLayout: () => void = this.defaultRefreshSuccessLayout
  /* [下拉] 刷新失败顶部内容UI */
  @BuilderParam refreshFailLayout: () => void = this.defaultRefreshFailLayout

  /* 内容UI */
  @BuilderParam contentLayout: () => void = this.defaultEmptyElement

  /* [上拉] 底部加载中UI */
  @BuilderParam customLoadMoreLayout: () => void = this.defaultLoadMoreLayout
  /* [上拉] 没有更多数据UI */
  @BuilderParam customNoMoreLayout: () => void = this.defaultNoMoreLayout

  /* [回调钩子] 下拉刷新 */
  refreshCallBack?: (loadFreshModal: PullRefreshModel) => void
  /* [回调钩子] 上拉加载 */
  loadMoreCallBack?: (loadFreshModal: PullRefreshModel) => void

  build() {
    Scroll() {
      Column() {
        // 下拉显示的刷新UI
        if (this.dataModel.refreshStateNum ===  RefreshState.DropDown) {
          this.pullingDownLayout()
        } else if (this.dataModel.refreshStateNum ===  RefreshState.Release) {
          this.loosingLayout()
        } else if (this.dataModel.refreshStateNum ===  RefreshState.Refreshing) {
          this.refreshingLayout()
        } else if (this.dataModel.refreshStateNum ===  RefreshState.Success) {
          this.refreshSuccessLayout()
        } else if (this.dataModel.refreshStateNum ===  RefreshState.Fail) {
          this.refreshFailLayout()
        }

        // 实质由父组件传入的内容
        this.contentLayout()

        // 上拉显示的加载更多UI
        if (!this.dataModel.banLoadMore) {
          if (this.dataModel.hasMore) {
            this.customLoadMoreLayout()
          } else {
            this.customNoMoreLayout()
          }
        }
      }
    }
    .onScroll((_, yOffset) => {
      // 一旦产生上拉偏移量，就重置 isReachStart
      if (yOffset > 0) {
        this.dataModel.isReachStart = false
      }
    })
    .onReachStart(() => {
      this.dataModel.isReachStart = true
    })
    .onReachEnd(() => {
      this.dataModel.isReachEnd = true
    })
    .onTouch((event: TouchEvent) => {
      if (this.dataModel.isReachStart || this.dataModel.isReachEnd) {
        handleTouchEvent(this.dataModel, event, (isLoadMore: boolean) => {
          if (isLoadMore) {
            this.loadMoreCallBack && this.loadMoreCallBack(this.dataModel)
          } else {
            this.refreshCallBack && this.refreshCallBack(this.dataModel)
          }
        })
      }
    })
  }

  @Builder
  defaultEmptyElement() {}

  @Builder
  defaultPullingDownLayout() {
    CardBaseLayout({
      imageSrc: $r('app.media.icon_pull_down_refresh'),
      textValue: this.dataModel.pullDownRefreshText,
      layoutHeight: this.dataModel.pullDownRefreshHeight
    })
  }

  @Builder
  defaultLoosingLayout() {
    CardBaseLayout({
      imageSrc: $r('app.media.icon_pull_up_refresh'),
      textValue: this.dataModel.releaseRefreshText,
      layoutHeight: this.dataModel.pullDownRefreshHeight
    })
  }

  @Builder
  defaultRefreshingLayout() {
    CardBaseLayout({
      imageSrc: $r('app.media.icon_pull_up_load'),
      textValue: this.dataModel.refreshingText,
      layoutHeight: this.dataModel.pullDownRefreshHeight
    })
  }

  @Builder
  defaultRefreshSuccessLayout() {
    CardBaseLayout({
      imageSrc: $r('app.media.icon_succeed_refresh'),
      textValue: this.dataModel.refreshSuccessText,
      layoutHeight: this.dataModel.pullDownRefreshHeight
    })
  }

  @Builder
  defaultRefreshFailLayout() {
    CardBaseLayout({
      imageSrc: $r('app.media.icon_fail_refresh'),
      textValue: this.dataModel.refreshFailText,
      layoutHeight: this.dataModel.pullDownRefreshHeight
    })
  }

  @Builder
  defaultLoadMoreLayout() {
    CardBaseLayout({
      imageSrc: $r('app.media.icon_pull_up_load'),
      textValue: this.dataModel.pullUpLoadText,
      layoutHeight: this.dataModel.pullUpLoadHeight
    })
  }

  @Builder
  defaultNoMoreLayout() {
    Row() {
      Text(this.dataModel.pullUpNoMoreText)
        .margin({ left: 8 })
        .fontSize('16fp')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .height(this.dataModel.pullUpLoadHeight)
  }
}