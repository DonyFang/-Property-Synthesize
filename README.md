# -Property-Synthesize
@Property&amp;@Synthesize

探究重写set和get方法的错误原因

因为平时都很少同时重写setter和getter方法，一般的话，我们大概都是使用懒加载方法，
然后重写getter方法，做一个非空判断。然后有时候根据需求，要同时重写属性的setter和getter方法。
系统就会报错误：：Use of undeclared identifier '_name';did you mean 'name'

详解一下：
OC最初设定@property和@synthesize的作用：
@property的作用是定义属性，声明getter,setter方法。(注意：属性不是变量)
@synthesize的作用是实现属性的,如getter，setter方法.
在声明属性的情况下如果重写setter,getter,方法，就需要把未识别的变量在@synthesize中定义，把属性的存取方法作用于变量。如：

.h文件中

后来因为使用@property灰常频繁，就简略了@synthesize的表达。

从Xcode4.4以后@property已经独揽了@synthesize的功能主要有三个作用：

(1)生成了私有的带下划线的的成员变量因此子类不可以直接访问，但是可以通过get/set方法访问。那么如果想让定义的成员变量让子类直接访问那么只能
在.h文件中定义成员变量了，因为它默认是@protected
（2)生成了get/set方法的实现
当：用@property声明的成员属性,相当于自动生成了setter getter方法,如果重写了set和get方法,与@property声明的成员属性就不是一个成员属性了,
是另外一个实例变量,而这个实例变量需要手动声明。所以会报错误。
总结：一定要分清属性和变量的区别，不能混淆。@synthesize 声明的属性=变量。意思是，将属性的setter,getter方法，作用于这个变量。



一些常用属性的解释
//1. 一般属性会对应一个类的实例变量，用来保存状态的, 而实际上把该行代码注释掉也可以输出相同的结果，也就是这行代码可有可无，
有它后面的 @property 就够了。
//2. 指明属性变量，类型及一些其他特性，这里的特性就比较多了，你可以简单写为 @property NSString* gender; 会采用默认值，但编译时会出现警告，
不建议这么做。
这里如果没有显式的声明一个 NSString * gender 成员变量，它会帮你补上与这里的属性同名成员变量。
即使是 IBOutlet 的属性也可以不用显式的声明这个成员变量，同样写在 @property 中就行的：
如：@property(nonatomic, retain) IBOutlet UIButton *button_screen;
关键是括号中的内容：当然，最好的教程莫过于 官方的权威 Declared Properties.
@property 括号中的属性用逗号分隔来写, 对于对象 (atomic, assign) 是它的默认值, 基本类型默认为 (atomic, readwrite), 有三组值可以设置，
互斥的就不要写在一起：
1) atomic 和 nonatomic, 原子还是非原子性操作，前者为默认，表示属 性是原子的,支持多线程并发访问(实际就是 setter 的实现中加入了同步锁),后者是非原 
子的,也就是适合在非多线程的环境提升效率(因为 setter 中没有同步锁的代码)。没有特别的多线程要求用 nonatomic 有助于提高性能。
2) readonly, readwrite 表示属性的可读写特性;
如果是对象类型，还有 retain, assign, copy, 这决定了 setter 方法内部实现时对传入的对象的持有方式。retain 会增加引用计数，强引用类型, 
assign 是给变量直接赋值，弱引用类型，也是默认值, copy 是把 setter 的参数复制一份再赋给成员变量。注意它们对引用计数产生的影响，如果外部不再使用的话，用了 retain 或 copy 赋值的可以
release 掉那个对象。
3) getter=getterName 和 setter=setterName, 显式设置 getter/setter 方法名, 未指定它们时 Objective-C 会为我们生成默认的 setter/getter 
方法, 有一定的规则，比如上面的 NSString* gender 属性生成默认的setter 方法是: -(void) setGender:(NSString *);
getter 方法是: -(NSString *) gender;
想看看 Objective-C 为我们生成什么 getter/setter 方法, 不用点号来隐式调用 setter/getter 方法，
而是显式的用 [unmi setGender] 或 [unmi gender], 输入式这两个方法会自动提示出来的。注意这里的 getter 方法名并非是像 Java 的 getGender, 
而是和属性名同.
假如你想要自己个性的 getter/setter 方法，比如写成 @property(getter=getGender, setter=setSex:) NSString* gender; 那么相应的就会生成：
setter 方法是: -(void) setSex:(NSString *);
getter 方法是: -(NSString *) getGender;
在 Xcode 中 esc unmi 就能看到相应的 setter/getter 方法名的. 可以只用其中一个了，那另一个保持默认。这两个较少用，用途就是可用来生成
自己个性的但要符合某个范围内规范的 setter/getter 方法。像 @property(getter = isOnline) BOOL online; 则会生成 -(BOOL) isOnline; 
这样的 getter 方法，而不是 -(BOOL) online; 当然我们也很少且不推荐直接调用 getter/setter 方法，而是用点号的方式，
但是有意思的去覆盖 getter/setter 方法时就较象明确了。

//3. @synthesize 后跟上前面用 @property 声明的属性名列表，这样 Objective-C 就能自动按照 @property 规则生成相应的 setter/getter 方法。
你也可以不对前面某个属性使用 @synthesize，那么它相应的 setter/getter 方法就得自己按照规则亲自实现了。
所以，到这里我们可以理解到，@property 相当于声明 setter/getter 的方法原型，@synthesize 就是那些 setter/getter 相应实现。
只是它们俩都自动完成了，连存储状态的变量也自动添加了。
前面讲过，如果类中没有声明与 @property 相应成员变量，会自动加上一个与属性同名的成员变量，如果你不想要与属性同名的成员变量，这里可以自定义，方法是：
@property gender=_gender;
那就相当于在类中声明了一个 (NSString *) _gender 成员变量来存储 gender 属性的值, 而不再存在 (NSString *) gender 这个成员变量了。
这样在类 Unmi 实例方法中可以直接访问 _gender 变量的. 另外，据我刚刚试验过的，用 @property gender=_gender; 
自动生成的成员变量 (NSString *) _gender 同样可以在断点时光标停在某个 Unmi 实例上能显示出来的。
接着，这里又会牵涉到 @dynamic 的用法，当 @property(getter=getGender) 只为 gender 指定了 getter 方法名时，而后不用 @synthesize 自动合成，
而是自己实现的 -(NSString *) getGender; 方法，编译器会警告 setGender 未实现，这时就用 @dynamic gender, 此处不细究 @dynamic 的用法了。

//4. 用点号(.) 来使用属性，这和 C# 中的属性较类似了，凡是对属性进行赋值，会调用相应的 setter 方法，这里调用 -(void) setGender:(NSString *);

//5. 点号获取属性值时，实际调用了相应的 getter 方法，这里调用了 -(NSString *) gender;
这里的例子是通过实例变量来使用属性，读写时分别会走 getter/setter 方法，然而在类的内部可以直接访问该成员变量，也可以用点号属性的方式, 
在类内部怎么访问都无所谓的，来看下面的例子，变动了一下：

