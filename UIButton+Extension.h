//
//  UIButton+Extension.h
//  music
//
//  Created by kent on 2017/8/27.
//  Copyright © 2017年 kent. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,EdgeType) {
    imageLeft=0,
    imageRight,
    imageTop,
    imageBottom
};

@interface UIButton (Extension)

/**改变Button内部控件的布局，如果想增加imageView与Title之间的横向距离，
 *那么改变Button的宽度即可*/
- (void)setEdgeType:(EdgeType)edge_type;
@end
