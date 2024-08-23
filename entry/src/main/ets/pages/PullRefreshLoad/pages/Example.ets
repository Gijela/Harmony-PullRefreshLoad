import { PullRefreshLoadModel, PullRefreshLoad, closeRefresh, closeLoadMore } from '../index'

@Entry
@Component
struct Example {
  private readonly initData: string[] = [
    '改变文案在父组件通过 this.dataModel 赋值即可',
    '改变 UI 需要将新 UI 传入 PullRefreshLoad',
    '下拉刷新钩子执行完成后，要通过 closeRefresh 告知是否刷新成功，同时要处理 dataModel.hasMore',
    '上拉加载更多钩子执行完成后，要通过 closeLoadMore 告知是否刷新成功，同时要处理 dataModel.hasMore 和 dataModel.isReachEnd'
  ]
  @State data: string[] = [...this.initData]
  @State moreCnt: number = 3
  @State dataModel: PullRefreshLoadModel = new PullRefreshLoadModel()

  // 刷新请求
  refreshQuery() {
    setTimeout(() => {
      // 数据请求
      this.reset()

      // 处理
      closeRefresh(this.dataModel, true)
      this.dataModel.hasMore = true
    }, 1200)
  }

  reset() {
    this.data = [...this.initData]
    this.moreCnt = 3
  }

  // 加载更多请求
  loadMoreQuery() {
    setTimeout(() => {
      // 数据请求
      this.data.push('添加的内容')
      this.moreCnt--

      // 处理
      closeLoadMore(this.dataModel, true)
      this.dataModel.hasMore = this.moreCnt > 0
      this.dataModel.isReachEnd = this.dataModel.hasMore
    }, 1000)
  }

  build() {
    Column() {
      PullRefreshLoad({
        dataModel: this.dataModel,
        contentLayout: this.Content.bind(this),
        refreshCallBack: this.refreshQuery.bind(this),
        loadMoreCallBack: this.loadMoreQuery.bind(this),
        // refreshingLayout: this.customRefreshLayout
      })
    }
  }

  // 传入的内容
  @Builder
  Content() {
    Column() {

      ForEach(this.data, (item: string, index: number) => {
        Row() {
          Text(item)
            .border({ width: 2, color: 'red' })
            .height('10%')
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .margin({ bottom: 10 })
        .onClick(() => {
          if (index === 1) {
            console.log('点击第二个元素成功~~')
          }
        })
      })

    }
  }

  // @Builder
  // customRefreshLayout() {
  //   Row() {
  //     Text('覆盖默认刷新ing状态时的UI')
  //   }
  // }
}
