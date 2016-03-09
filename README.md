# demo list

These demos help a lot :)

# 1.ImageMask

After reading a chapter [Bitmap Images and Image Masks in Quarzt2D Programming Guide](https://developer.apple.com/library/mac/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_images/dq_images.html#//apple_ref/doc/uid/TP30001066-CH212-TPXREF101), I want to write a demo to help to learn.

The demo cover this contents:

1. Mask image with image mask
2. Mask image with image
3. Mask image with color
4. Mask image by clipping context

# 2.TouchDemo

TouchDemo in WWDC 2014 session 235 Advanced scrollviews and touch handling techniques

# 3.performance

performance gives a way to solve the problem that `layer.masksToBounds` causes offscreen rendering. Comparing to drawing the whole content in `drawRect:` method, creating another image mask view and add it as subview is more efficient.

The category `UIView+CornerRadius` helps add a `UIImageView` mask to the receiver, the result like use 
```
  layer.corderRadius = cornerRadius;
  layer.masksToBounds = YES;
```

There're two methods in the category.

```
 - (void)cornerRadius_addCornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor;
 - (void)cornerRadius_addCornerRadius:(CGFloat)radius backgroundColor:(UIColor *)bgColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
```

There is a example in `TableViewPerformanceViewController.m`

```
  UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, [self.class imageHeight], [self.class imageHeight])];
  [v cornerRadius_addCornerRadius:10.0 backgroundColor:[UIColor whiteColor]];
```
