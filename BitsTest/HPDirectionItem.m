//
//  HPDirectionItem.m
//  BitsTest
//
//  Created by ZP on 2021/6/10.
//


#define HPDirectionLeftMask   (1 << 0)
#define HPDirectionRightMask  (1 << 1)
#define HPDirectionFrontMask  (1 << 2)
#define HPDirectionBackMask   (1 << 3)

#import "HPDirectionItem.h"

@interface HPDirectionItem () {
    //这里bits和struct用任一一个就可以，结构体相当于是对bits的解释。因为是共用体用同一块内存。
    union {
        char bits;
        //位域,这里是匿名结构体(anonymous struct)
        struct {
            char left  : 1;
            char right : 1;
            char front : 1;
            char back  : 1;
        };
    }_direction;
}

@end

@implementation HPDirectionItem

- (instancetype)init {
    self = [super init];
    if (self) {
        _direction.bits = 0b00000000;
    }
    return self;
}

// 通过操作bits和结构体都能达到目的，混合使用当然也可以了。根本原因是操作的是同一块内存空间。
- (void)setLeft:(BOOL)left {
    _direction.left = left;
}

- (BOOL)left {
//    return _direction.left;
    return _direction.bits & HPDirectionLeftMask;
}

- (void)setRight:(BOOL)right {
    _direction.right = right;
}

- (BOOL)right {
    return _direction.right;
}

- (void)setFront:(BOOL)front {
    _direction.front = front;
}

- (BOOL)front {
    return _direction.front;
}

- (void)setBack:(BOOL)back {
    _direction.back = back;
}

- (BOOL)back {
    return _direction.back;
}

//操作bits的方式
//- (void)setLeft:(BOOL)left {
//    if (left) {
//        _direction.bits |= HPDirectionLeftMask;
//    } else {
//        _direction.bits &= ~HPDirectionLeftMask;
//    }
//}
//
//- (BOOL)left {
//    return _direction.bits & HPDirectionLeftMask;
//}
//
//- (void)setRight:(BOOL)right {
//    if (right) {
//        _direction.bits |= HPDirectionRightMask;
//    } else {
//        _direction.bits &= ~HPDirectionRightMask;
//    }
//}
//
//- (BOOL)right {
//    return _direction.bits & HPDirectionRightMask;
//}
//
//- (void)setFront:(BOOL)front {
//    if (front) {
//        _direction.bits |= HPDirectionFrontMask;
//    } else {
//        _direction.bits &= ~HPDirectionFrontMask;
//    }
//}
//
//- (BOOL)front {
//    return _direction.bits & HPDirectionFrontMask;
//}
//
//- (void)setBack:(BOOL)back {
//    if (back) {
//        _direction.bits |= HPDirectionBackMask;
//    } else {
//        _direction.bits &= ~HPDirectionBackMask;
//    }
//}
//
//- (BOOL)back {
//    return _direction.bits & HPDirectionBackMask;
//}

@end
