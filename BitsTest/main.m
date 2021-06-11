//
//  main.m
//  BitsTest
//
//  Created by ZP on 2021/6/10.
//

#import "HPDirectionItem.h"
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

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
  printf("\nDirection size:%zu\nHPDirection size:%zu\n", sizeof(dir),
         sizeof(hpDir));
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

//模拟isa
union isa_t {
  uintptr_t bits;
  struct {
    uintptr_t nonpointer : 1;
    uintptr_t has_assoc : 1;
    uintptr_t has_cxx_dtor : 1;
    uintptr_t shiftcls : 44;
    uintptr_t magic : 6;
    uintptr_t weakly_referenced : 1;
    uintptr_t unused : 1;
    uintptr_t has_sidetable_rc : 1;
    uintptr_t extra_rc : 8;
  };
};

//模拟class
struct HPClass {
  union isa_t isa;
};

#define ISA_MASK 0x00007ffffffffff8ULL

void testISAResolve() {
  NSObject *obj = [NSObject alloc];
  struct HPClass *p = (__bridge void *)obj;
  NSLog(@"nonponinter ISA:0x%lx", p->isa.bits);
  NSLog(@"nonponinter:0x%x", p->isa.nonpointer);
  NSLog(@"has_assoc:0x%x", p->isa.has_assoc);
  NSLog(@"has_cxx_dtor:0x%x", p->isa.has_cxx_dtor);
  NSLog(@"shiftcls:0x%lx", p->isa.shiftcls);
  NSLog(@"cls(p->isa.bits):0x%llx == NSObject.class:0x%llx",
        p->isa.bits & ISA_MASK, NSObject.class);
  NSLog(@"magic:0x%x", p->isa.magic);
  NSLog(@"weakly_referenced:0x%x", p->isa.weakly_referenced);
  NSLog(@"unused:0x%x", p->isa.unused);
  NSLog(@"has_sidetable_rc:0x%x", p->isa.has_sidetable_rc);
  NSLog(@"extra_rc:0x%x", p->isa.extra_rc);
}

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    //结构体位域
    // testStructDirection();
    //结构体联合体对比
    //        testStructAndUnion();
    //共用体
    //        testUnionBits();
    testISAResolve();
    NSLog(@"Hello, World!");
  }
  return 0;
}
