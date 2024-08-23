/**
 * 上拉、下拉过程组件
 */
@Component
export struct CardBaseLayout {
  @Prop imageSrc: Resource
  @Prop textValue: string
  @Prop layoutHeight: number

  build() {
    Row() {
      Image(this.imageSrc)
        .width(18)
        .height(18)

      Text(this.textValue)
        .margin({ left: 7, bottom: 1 })
        .fontSize(17)
        .textAlign(TextAlign.Center)
    }
    .clip(true)
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .height(this.layoutHeight)
  }
}