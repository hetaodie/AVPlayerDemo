//
//  PlayerEnum-all.h
//  AVPlayerDemo
//
//  Created by Weixu on 16/2/18.
//  Copyright © 2016年 Netease. All rights reserved.
//

#ifndef PlayerEnum_all_h
#define PlayerEnum_all_h

typedef NS_ENUM(NSUInteger,PlayerStatus) {
    PlayerPlay = 1,
    PlayerReuse,
    PlayerStop,
};

typedef NS_ENUM(NSUInteger,PlayerVideoResize) {
    PlayerVideoResizeFit = 201,  // 非均匀模式。两个维度完全填充至整个视图区域
    PlayerVideoResizeAspect,     // 等比例填充，直到一个维度到达区域边界
    PlayerVideoAspectFill,       // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
};

#endif /* PlayerEnum_all_h */
