//
//  RXNewsDetail.h
//  NeteaseNews
//
//  Created by 王若曦 on 16/4/19.
//  Copyright © 2016年 wrx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  {
 "AHHQIG5B00014JB6": {
 "body": "<!--IMG#0--><p>　　中新网2月3日电 朝鲜官媒3日刊文称，有些国家经常通过展示卫星照片来批评朝鲜“缺乏灯光”、“夜晚一片黑暗”，但社会的本质不是由绚烂的灯光展现的。朝鲜正走在幸福的道路上，这一点确定无疑。</p><p>　　报道称，就如同这寒冷的冬季一样，朝鲜依旧面临着磨练，“我们还没能完全解开裤腰带”。但是，“朝鲜人民的心和面容都是明朗的，祖国也一天比一天年轻”。朝鲜正在打开复兴的大门。</p><p>　　报道还称，在金正恩的领导下，朝鲜的经济建设取得了显著成就，比如成功建设了平壤幼儿园、卫星科学家住宅区和嬉水游乐场等，朝鲜如今正走在幸福的道路上。</p><p>　　报道指出，在“吃的问题”上，朝鲜发生了巨大的变化。朝鲜政府鼓励各个经济主体发挥主动性，农民开始使用新的技术，昔日荒凉的农场变成了温暖的都市。</p><p>　　报道强调，朝鲜虽然没有闪闪的灯光，却有着完全没有政治污染的社会，虽然不太富足，却有着美好的风俗。在与“帝国主义”国家对峙的情况下，朝鲜人民能有现在的生活已经是非常幸福了。</p><p>　　延伸阅读：</p><p>　　<b>NASA发布朝鲜夜晚卫星图 除平壤外一片黑暗</b></p><p>　　据英国《每日邮报》网站2月24日报道，美国国家航空航天局(NASA)卫星图片显示，1月30日，夜晚来临后，朝鲜的两个邻国中国和韩国灯火通明，而朝鲜上空看上去，除东南部首都平壤外，整个国家几乎是一片黑暗。媒体分析称，很显然，朝鲜目前电力能源供应不足。</p><p>　　NASA地球观测台的网站对这张照片发表评论称，与韩国和中国比起来，朝鲜在晚上几乎是黑暗的，这片土地似乎成了连接黄海和日本海的一片海洋。韩国东部海岸线在夜晚清晰可见，而朝鲜的海岸线则很难目测到。另外朝鲜和韩国的人均能源消耗量也存在很大差距，分别是739千瓦时和10162千瓦时。</p>",
 "users": [],
 "replyCount": 130606,
 "ydbaike": [],
 "source_url": "http://www.chinanews.com/gj/2015/02-03/7030995.shtml",
 "link": [],
 "votes": [],
 "img": [
 {
 "ref": "<!--IMG#0-->",
 "pixel": "549*365",
 "alt": "NASA早前发布的朝鲜夜晚卫星图",
 "src": "http://img6.cache.netease.com/3g/2015/2/3/20150203160030899db.jpg"
 }
 ],
 "shareLink": "http://3g.163.com/ntes/special/0034073A/wechat_article.html?docid=AHHQIG5B00014JB6&spst=0&spss=newsapp&spsf=wx&spsw=1",
 "digest": "",
 "topiclist_news": [],
 "dkeys": "卫星图,朝鲜,灯光",
 "topiclist": [
 {
 "hasCover": false,
 "subnum": "611.2万",
 "alias": "24小时即时国际重大新闻资讯",
 "tname": "网易国际",
 "ename": "guoji",
 "tid": "T1348648122539",
 "cid": "C1378977941637"
 }
 ],
 "docid": "AHHQIG5B00014JB6",
 "picnews": true,
 "title": "朝媒谈卫星图上朝鲜一片漆黑",
 "tid": "",
 "template": "normal",
 "threadVote": 0,
 "threadAgainst": 0,
 "boboList": [],
 "replyBoard": "news3_bbs",
 "source": "中国新闻网",
 "voicecomment": "off",
 "hasNext": false,
 "relative_sys": [],
 "apps": [],
 "ptime": "2015-02-03 15:35:00"
 }
 }
 */

@interface RXNewsDetail : NSObject

//标题
@property (nonatomic,copy) NSString *title;

//回复人数
@property (nonatomic,copy) NSNumber *replyCount;

//新闻内容
@property (nonatomic,copy) NSString *body;

//图片数组(存放图片模型)
@property (nonatomic,strong) NSArray *img;

//发布时间
@property (nonatomic,copy) NSString *ptime;

//回复模块
@property (nonatomic,copy) NSString *replyBoard;

+ (instancetype)newsDetailWithDict:(NSDictionary *)dict;

@end
