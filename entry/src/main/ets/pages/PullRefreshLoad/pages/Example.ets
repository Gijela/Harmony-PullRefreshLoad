import { PullRefreshModel, PullRefreshLoad, closeRefresh, closeLoadMore } from '../index'

@Entry
@Component
struct Example {
  @State data: string[] = ['a', 'b', 'c']
  @State moreCnt: number = 3
  @State dataModel: PullRefreshModel = new PullRefreshModel()

  // 刷新请求
  refreshQuery(dataModel: PullRefreshModel) {
    setTimeout(() => {
      this.reset()
      closeRefresh(this.dataModel, true)
      this.dataModel.hasMore = true
    }, 1200)
  }

  reset() {
    this.data = ['a', 'b', 'c']
    this.moreCnt = 3
  }

  // 加载更多请求
  loadMoreQuery(dataModel: PullRefreshModel) {
    setTimeout(() => {
      // 数据请求
      this.data.push('11')
      this.moreCnt--

      // 处理
      dataModel.hasMore = this.moreCnt > 0
      dataModel.isReachEnd = dataModel.hasMore
      closeLoadMore(dataModel)
    }, 1000)
  }

  build() {
    Column() {
      PullRefreshLoad({
        dataModel: this.dataModel,
        contentLayout: this.Content.bind(this),
        refreshCallBack: this.refreshQuery.bind(this),
        loadMoreCallBack: this.loadMoreQuery.bind(this),
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
            .height('60%')
            .width('80%')
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
}
