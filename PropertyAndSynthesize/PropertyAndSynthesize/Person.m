//
//  Person.m
//  PropertyAndSynthesize
//
//  Created by 方冬冬 on 2017/8/9.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import "Person.h"

@implementation Person
/*
 从Xcode4.4以后@property已经独揽了@synthesize的功能主要有三个作用：
 
 (1)生成了私有的带下划线的的成员变量因此子类不可以直接访问，但是可以通过get/set方法访问。那么如果想让定义的成员变量让子类直接访问那么只能在.h文件中定义成员　　　　变量了，因为它默认是@protected
 （2)生成了get/set方法的实现
 当：
nonatomic, nonatomic, nonatomic,  用@property声明的成员属性,相当于自动生成了setter getter方法,如果重写了set和get方法,与@property声明的成员属性就不是一个成员属性了,是另外一个实例变量,而这个实例变量需要手动声明。所以会报错误。
 总结：一定要分清属性和变量的区别，不能混淆。@synthesize 声明的属性=变量。意思是，将属性的setter,getter方法，作用于这个变量。
 */
@synthesize name = _name,isChange=_isChange,gender = _gender,age = _bigAge;

- (void)setName:(NSString *)name{
    _name = name;
}

- (NSString *)name{
    return _name;
}

- (void)setIsChange:(BOOL)isChange{
    _isChange = isChange;
}

- (BOOL)isChangeMethod{
    return _isChange;
}

- (void)setSex:(NSString *)gender{
    _gender = gender;
    
}

- (NSString *)getGender{
    return _gender;
}

- (void)setAge:(NSString *)age{
    _bigAge = age;
}

- (NSString *)age{

    return _bigAge;
}
@end
