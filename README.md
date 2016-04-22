# NeteaseNews
网易新闻首页高仿

###4月22日
Github上的网易新闻已经非常多了，基本功能在这里就不做赘述，下面介绍几个我自己觉得很有意思的功能，也是调试了一段时间，在这里分享给大家，也当作是我自己思路的一个总结

---
######1.天气窗口动画
打开的动画加高斯模糊的背景<br />
首先做了一个view，然后对当前屏幕进行截图，尺寸设置为没有导航栏的大小，然后进行高斯模糊处理，添加到view上

<img src="https://raw.githubusercontent.com/ruoxiwang/NeteaseNews/master/screenshots/weather.gif" alt="Drawing" width="250px" />

---
######2.打开cell的卷轴式动画
在didSelectedRowAtIndexpath中进行如下操作。<br />
首先通过cellForRowAtIndexpath方法获取到cell，同时对之前屏幕进行截图，做高斯模糊处理<br />
然后将cell视图和背景图片赋值给present出来的详情页面控制器，再修改cell的位置属性做动画<br />
同时让显示详情的tabelview也做动画，就能完成这一的效果<br />

<img src="https://raw.githubusercontent.com/ruoxiwang/NeteaseNews/master/screenshots/openAnimation.gif" alt="Drawing" width="250px" />

---
######3.详情页面保存图片到相册
HTML语言的混合编程<br />
把获取的图片地址添加到div中<br />
增加一个点击图片位置的function<br />
在webView的代理方法中，剪切图片HTML的地址，通过alertController保存到相册<br />
<br />
_这一部分的实现借鉴了别人的方法，也咨询了做网页开发的同学，自己确实不太懂HTML语言，通过这次开发，吸收了不少经验，对HTML也有了新认识_

<img src="https://raw.githubusercontent.com/ruoxiwang/NeteaseNews/master/screenshots/savePictrue.gif" alt="Drawing" width="250px" />

---
######4.下一步
>1.详情页面底部的内容，如回复、类似新闻<br />
2.评论详情页面<br />
3.现在只能对文字新闻进行展示，还有图片新闻的页面没有搭建<br />
4.搜索<br />


---
###随时更新
