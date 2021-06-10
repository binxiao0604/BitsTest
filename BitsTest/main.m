//
//  main.m
//  BitsTest
//
//  Created by ZP on 2021/6/10.
//

#import <Foundation/Foundation.h>
#import "HPDirectionItem.h"

struct Direction {
    BOOL left;
    BOOL right;
    BOOL front;
    BOOL back;
};

struct HPDirection {
    BOOL left : 1;
    BOOL right : 1;
    BOOL front : 1;
    BOOL back : 1;
};

void testStructDirection() {
    struct Direction dir;
    dir.left = YES;
    dir.right = YES;
    dir.front = YES;
    dir.back = YES;
    struct HPDirection hpDir;
    hpDir.left = YES;
    hpDir.right = YES;
    hpDir.front = YES;
    hpDir.back = YES;
    printf("\nDirection size:%zu\nHPDirection size:%zu\n",sizeof(dir),sizeof(hpDir));
}

//结构体联合体对比
//共存
struct HPStruct {
    char *name;
    int age;
    double height;
};

//互斥
union HPUnion {
    char *name;
    int age;
    double height;
};


void testStructAndUnion() {
    struct HPStruct s;
    union HPUnion u;
    s.name = "HotpotCat";
    u.name = "HotpotCat";
    s.age = 18;
    u.age = 18;
    s.height = 180.0;
    u.height = 180.0;
}

void testUnionBits() {
    HPDirectionItem *item = [HPDirectionItem alloc];
    item.left = 1;
    item.right = 1;
    item.front = 1;
    item.back = 1;
    item.right = 0;
    item.back = 0;
    NSLog(@"testUnionBits");
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //结构体位域
        //testStructDirection();
        //结构体联合体对比
//        testStructAndUnion();
        //共用体
        testUnionBits();
        NSLog(@"Hello, World!");
    }
    return 0;
}
