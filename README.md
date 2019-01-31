# 介绍
ZXLCornerRadiusImage 是解决 UIImageView 设置圆角产生FPS过低问题。
支持SDWebImage
支持图片来源于本地或者服务器。
支持 UIImageView 部分圆角设置。
支持 UIImageView 添加 borderWidth 、 borderColor。
# 对比
IOS 8.4 系统对比，目前我使用xcode 10.1 测试FPS时崩溃，不过感觉使用很流畅。
IOS 9.0 没有测试手机。
IOS 10.3.3系统对比 
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190131115437245.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NreV9sb25nX2ZseQ==,size_16,color_FFFFFF,t_70)
IOS 11.1.2 对比
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190131134328157.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NreV9sb25nX2ZseQ==,size_16,color_FFFFFF,t_70)
IOS 12.1.3对比
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190131134826393.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NreV9sb25nX2ZseQ==,size_16,color_FFFFFF,t_70)

通过优化前后对比可以看出，imageView.layer.cornerRadius 、 imageView.layer.masksToBounds 对系统版本FPS影响随着版本越高影响也就越小。如果你的App要兼容IOS10以及其以下版本不妨可以考虑以下使用我优化过的代码。
# 使用说明
```javascript
    /**
 圆角值，其设置必须在 setImage 函数之前
 */
@property (nonatomic,assign) CGFloat cornerRadius;

/**
 圆角控制 （依赖 cornerRadius > 0）
 */
@property (nonatomic,assign) UIRectCorner roundingCorners;

/**
 边框宽度（依赖 cornerRadius > 0 和 borderColor 有值）
 */
@property (assign, nonatomic) CGFloat borderWidth;

/**
 边框颜色 （依赖 cornerRadius > 0 和 borderWidth > 0）
 */
@property (strong, nonatomic) UIColor* borderColor;

```


```javascript
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.cornerRadius = kHeight/2;
            imageView.borderColor = [UIColor redColor];
            imageView.borderWidth = 1;
            imageView.roundingCorners = UIRectCornerTopLeft | UIRectCornerTopRight;
```


