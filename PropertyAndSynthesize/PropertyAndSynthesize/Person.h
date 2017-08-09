//
//  Person.h
//  PropertyAndSynthesize
//
//  Created by 方冬冬 on 2017/8/9.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,readwrite,copy)NSString *name;

@property(nonatomic,assign,getter=isChangeMethod)BOOL isChange;
//声明getter=getGender   setter=setSex
@property(getter=getGender, setter=setSex:) NSString* gender;


@property(nonatomic,copy)NSString *age;

@end
