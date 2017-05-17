//
//  NewButton.m
//  Notes
//
//  Created by 徐琬璇 on 2017/5/1.
//  Copyright © 2017年 noneTobacco. All rights reserved.
//

#import "NewButton.h"

@implementation NewButton

- (instancetype)init {
    self = [super initWithFrame:CGRectMake((375 - 156) / 2, 603 - 78, 156, 78)];
    if (self) {
        [self initSetUpView];
    }
    return self;
}

- (void)initSetUpView {
    _nomalView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newBtn"]];
    _nomalView.frame = CGRectMake((156 - 80)/2, (78 - 40), 80, 40);
    [self addSubview:_nomalView];
    
    _biggerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newBig"]];
    _biggerView.frame = CGRectMake((156 - 80)/2, (78 - 40), 80, 40);
    _biggerView.alpha = 0;
    [self addSubview:_biggerView];
    
    self.longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDo:)];
    
    _longPressGes.minimumPressDuration = 0.2f;
//    _longPressGes.allowableMovement = 200.0f;
    [self addGestureRecognizer:_longPressGes];
    
}

- (void)longPressDo:(UILongPressGestureRecognizer *)sender {
    if ([sender isEqual:_longPressGes]) {
        CGPoint point = [sender locationInView:self];
        if (_longPressGes.state == UIGestureRecognizerStateBegan) {
            NSLog(@"long press began");
            [UIView animateWithDuration:0.3f
                             animations:^{
                _nomalView.alpha = 0;
                _biggerView.alpha = 1;
                _biggerView.frame = CGRectMake(0, 0, 156, 78);
                             }];
        }
        else if (_longPressGes.state == UIGestureRecognizerStateChanged) {
//            NSLog(@"long press changed:x = %f, y = %f", point.x, point.y);
        }
        else if (_longPressGes.state == UIGestureRecognizerStateEnded) {
            
            [UIView animateWithDuration:0.3f
                             animations:^{
                                 _biggerView.frame = CGRectMake((156 - 80)/2, (78 - 40), 80, 40);
                                 _biggerView.alpha = 0;
                                 _nomalView.alpha = 1;
                             }];
            if (point.y > 0) {
                if (point.x>0 && point.x<78) {
                    NSLog(@"left touched");
                    if (_delegate && [_delegate respondsToSelector:@selector(leftButtonDidPush)]) {
                        [_delegate leftButtonDidPush];
                    }
                }
                else if (point.x >78 && point.x < 156) {
                    NSLog(@"right touched");
                    if (_delegate && [_delegate respondsToSelector:@selector(rightButtonDidPush)]) {
                        [_delegate rightButtonDidPush];
                    }

                }
                NSLog(@"long press ended");
            }
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
