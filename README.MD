# PullRefreshLoad 上拉加载、下拉刷新组件

## 介绍
上拉加载、下拉刷新基础组件。
不过度封装业务逻辑，提供最基础的上拉下拉回调钩子，支持自定义刷新文案、加载文案，支持自定义刷新UI、加载UI

## 依赖下载
```
ohpm install @gijela/pullrefreshload
```

## 使用
```typescript
import { PullRefreshLoad } from '@gijela/pullrefreshload'
```

## 代码演示
### 基础用法
下拉刷新时会触发 refreshCallBack 事件，在事件的回调函数中可以进行同步或异步操作，操作完成后，需执行`closeRefresh`方法关闭刷新、 重新赋值`this.dataModel.hasMore`；

上拉刷新时会触发 loadMoreCallBack 事件，在事件的回调函数中可以进行同步或异步操作，操作完成后，需执行`closeLoadMore`方法关闭加载更多、 重新赋值 `this.dataModel.hasMore` 和 `this.dataModel.isReachEnd`；
```
PullRefreshLoad({
  dataModel: this.dataModel,
  contentLayout: this.Content.bind(this),
  refreshCallBack: this.refreshQuery.bind(this),
  loadMoreCallBack: this.loadMoreQuery.bind(this),
})
```

```
private readonly initData: string[] = ['a', 'b', 'c']
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

// 传入的内容
@Builder
Content() {
  Column() {
    ForEach(this.data, (item: string, index: number) => {
      Row() {
        Text(item)
          .border({ width: 2, color: 'red' })
          .height('60%')
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
```

### 修改刷新(加载)过程文案
每次使用 PullRefreshLoad 组件都需要 `new PullRefreshLoadModel()` 作为 dataModel，并且将 dataModel 传入到 PullRefreshLoad，如果需要修改刷新、加载某个环节的文案，直接通过 this.dataModel 修改即可

```
@State dataModel: PullRefreshLoadModel = new PullRefreshLoadModel()

aboutToAppear(): void {
  // 修改正在刷新中的文案
  this.dataModal.refreshingText = '我是正在刷新中显示的文案'
}
```

### 修改刷新(加载)过程UI
PullRefreshLoad 组件内置了默认的刷新(加载)过程UI，如果您需要修改某个过程的布局UI，您可以通过属性传入指定过程布局UI，覆盖默认UI

```
PullRefreshLoad({
  dataModel: this.dataModel,
  contentLayout: this.Content.bind(this),
  refreshCallBack: this.refreshQuery.bind(this),
  loadMoreCallBack: this.loadMoreQuery.bind(this),
  refreshingLayout: this.customRefreshingLayout
})
```

```
@Builder
customRefreshingLayout() {
  Row() {
    Text('覆盖默认刷新ing状态时的UI')
  }
}
```

## API
在父组件直接给 `this.dataModel` 赋值， 就可完成 PullRefreshLoad 属性修改

### 下拉属性
| 参数                          | 类型            | 默认值                   | 说明                       |
|:----------------------------|:--------------|:----------------------|:-------------------------|
| banRefresh                  | boolean       | false                 | 禁用下拉刷新                   |
| isReachStart                | boolean       | false                 | 是否到达顶部                   |
| pullDownRefreshHeight       | number        | 70                    | 触发刷新钩子的下拉偏移量             |
| refreshStateNum             | RefreshState  | RefreshState.default  | 下拉过程状态的数字枚举              |
| pullDownRefreshingDelay     | number        | 300                   | 延迟多少秒后，再执行「刷新ing动画」的结束逻辑 |
| pullDownAnimationOverDelay  | number        | 150                   | 刷新完成后提示持续时间              |
| pullDownRefreshText         | string        | 继续下拉...               | 未达到刷新阈值偏移量的提示文案          |
| releaseRefreshText          | string        | 释放即可刷新...             | 达到刷新阈值偏移量的提示文案           |
| refreshingText              | string        | 拼命刷新中...              | 正在刷新时提示文案                |
| refreshSuccessText          | string        | 刷新成功                  | 刷新成功时提示文案                |
| refreshFailText             | string        | 刷新失败                  | 刷新失败时提示文案                |


### 上拉属性
| 参数                          | 类型            | 默认值                   | 说明                       |
|-----------------------------|---------------|-----------------------|--------------------------|
| banLoadMore                 | boolean       | false                 | 禁用上拉加载                   |
| isReachEnd                  | boolean       | false                 | 是否到达底部                   |
| pullUpLoadHeight            | number        | 70                    | 触发加载钩子的上拉偏移量             |
| loadMoreStateNum            | LoadMoreState | LoadMoreState.default | 上拉过程状态的数字枚举              |
| pullUpLoadingDelay          | number        | 300                   | 延迟多少秒后，再执行「加载ing动画」的结束逻辑 |
| pullUpAnimationOverDelay    | number        | 150                   | 加载完成后提示持续时间              |
| pullUpLoadMoreText          | string        | 继续上拉...               | 未达到加载更多阈值偏移量的提示文案        |
| releaseLoadMoreText         | string        | 释放即可刷新...             | 达到加载更多阈值偏移量的提示文案         |
| LoadingMoreText             | string        | 拼命加载中...              | 正在加载时提示文案                |
| loadMoreSuccessText         | string        | 加载成功                  | 加载成功时提示文案                |
| loadMoreFailText            | string        | 加载失败                  | 加载失败时提示文案                |
| pullUpNoMoreText            | string        | 没有更多数据了               | 没有更多数据时提示文案              |
| hasMore                     | boolean       | true                  | 是否有更多数据                  |


### Events
| 事件名              | 类型                                               | 说明      |
|------------------|--------------------------------------------------|---------|
| refreshCallBack  | `(loadFreshModal: PullRefreshLoadModel) => void` | 下拉刷新时触发 |
| loadMoreCallBack | `(loadFreshModal: PullRefreshLoadModel) => void` | 上拉加载时触发 |



### BuilderParams
| 名称                    | 类型               | 说明             |
|-----------------------|------------------|----------------|
| pullingDownLayout     | `@BuilderParam`  | 下拉过程中顶部内容UI    |
| loosingLayout         | `@BuilderParam`  | 下拉释放过程中顶部内容UI  |
| refreshingLayout      | `@BuilderParam`  | 下拉刷新ing顶部内容UI  |
| refreshSuccessLayout  | `@BuilderParam`  | 下拉刷新成功顶部内容UI   |
| refreshFailLayout     | `@BuilderParam`  | 下拉刷新失败顶部内容UI   |
| contentLayout         | `@BuilderParam`  | 内容UI           |
| pullingUpLayout       | `@BuilderParam`  | 上拉过程中底部内容UI    |
| loosingUpLayout       | `@BuilderParam`  | 上拉释放过程中底部内容UI  |
| loadingMoreLayout     | `@BuilderParam`  | 上拉加载ing底部内容UI  |
| loadMoreSuccessLayout | `@BuilderParam`  | 上拉加载成功底部内容UI   |
| loadMoreFailLayout    | `@BuilderParam`  | 上拉加载失败底部内容UI   |
| noMoreLayout          | `@BuilderParam`  | 上拉没有更多数据UI     |

