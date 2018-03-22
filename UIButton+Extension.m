//
//  UIButton+Extension.m
//  music
//
//  Created by kent on 2017/8/27.
//  Copyright © 2017年 kent. All rights reserved.


#import "UIButton+Extension.h"

@implementation UIButton (Extension)


- (void)setEdgeType:(EdgeType)edge_type{
    
    //默认情况下imageView在左边，titleLabel在右边
    //UIEdgeInsets是相对于imageView或者titleLabel原来的位置作调整
    //UIEdgeInsetsMake(top, left, bottom, right)默认值都为0
    //top 如果为正值，则表示控件相对于父控件的top增加了top的距离，反正则减少
    
    //必须先取imageViewWidth的值，
    //再去titleLabWidth,totalWidth的值，否则titleLabWidth和totalWidth为0.不知为何
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat imageViewHeight = CGRectGetHeight(self.imageView.frame);
    CGFloat titleLabWidth = CGRectGetWidth(self.titleLabel.frame);
    CGFloat titleLabHeight = CGRectGetHeight(self.titleLabel.frame);

    CGFloat totalWidth = CGRectGetWidth(self.frame);
    CGFloat totalHeight = CGRectGetHeight(self.frame);
    CGFloat w_gap = (totalWidth - (imageViewWidth + titleLabWidth))/2.0;
    
    CGFloat lab_h_gap = (totalHeight - titleLabHeight)/2.0 - 3;
    CGFloat image_h_gap = (totalHeight - imageViewHeight)/2.0 - 3;

    switch (edge_type) {
        case imageRight:
            self.titleEdgeInsets = UIEdgeInsetsMake(0,-(imageViewWidth+w_gap), 0,+(imageViewWidth + w_gap));
            self.imageEdgeInsets = UIEdgeInsetsMake(0, +(titleLabWidth+w_gap), 0, -(titleLabWidth+w_gap));
            break;
        case imageLeft:{
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -w_gap, 0, +w_gap);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, +w_gap, 0, -w_gap);
        }
            break;
        case imageTop:{
            //把imageView，titleLabel水平居中，并处理让imageView在上面。
            if (imageViewWidth < titleLabWidth) {
                CGFloat half_gap = (imageViewWidth + titleLabWidth)/2.0 - (0.5 * imageViewWidth);
                self.imageEdgeInsets = UIEdgeInsetsMake(-image_h_gap, +half_gap, +image_h_gap, -half_gap);
                self.titleEdgeInsets = UIEdgeInsetsMake(+lab_h_gap, -imageViewWidth/2.0, -lab_h_gap, +imageViewWidth/2.0);
            }else{
                CGFloat half_gap = (imageViewWidth + titleLabWidth)/2.0 - (0.5 * titleLabWidth);
                self.imageEdgeInsets = UIEdgeInsetsMake(-image_h_gap, +titleLabWidth/2.0, +image_h_gap, -titleLabWidth/2.0);
                self.titleEdgeInsets = UIEdgeInsetsMake(+lab_h_gap, -half_gap, -lab_h_gap,  +half_gap);
            }
        }
            break;
        case imageBottom:{
            //把imageView，titleLabel水平居中，并处理让imageView在下面。
            if (imageViewWidth < titleLabWidth) {
                CGFloat half_gap = (imageViewWidth + titleLabWidth)/2.0 - (0.5 * imageViewWidth);
                self.imageEdgeInsets = UIEdgeInsetsMake(+image_h_gap, +half_gap, -image_h_gap, -half_gap);
                self.titleEdgeInsets = UIEdgeInsetsMake(-lab_h_gap, -imageViewWidth/2.0, +lab_h_gap, +imageViewWidth/2.0);
            }else{
                CGFloat half_gap = (imageViewWidth + titleLabWidth)/2.0 - (0.5 * titleLabWidth);
                self.imageEdgeInsets = UIEdgeInsetsMake(+image_h_gap, +titleLabWidth/2.0, -image_h_gap, -titleLabWidth/2.0);
                self.titleEdgeInsets = UIEdgeInsetsMake(-lab_h_gap, -half_gap, +lab_h_gap,  +half_gap);
            }
        }
            break;

        default:
            break;
    }
}

@end
