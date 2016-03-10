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

# 4.URLSessionTest

Goal: Set up a http(https) server, write a demo to send `multipart/form-data` content-type request. Write a demo to use self-signed certificate to test server trust and client certificate.

1. The difference between `application/x-www-form-urlencoded` and `multipart/form-data`, see [this link](http://stackoverflow.com/questions/4007969/application-x-www-form-urlencoded-or-multipart-form-data)

2. I have studied HTTPS for a long time, but it's hard to keep in my mind because it's so complicated. I want to show some links here to help.

 1. [X.509](https://en.wikipedia.org/wiki/X.509) talks about the certificate and how to verify certificate.
 2. [This link](http://blog.lumberlabs.com/2012/04/why-app-developers-should-care-about.html) talks about SSL pinning that we developers should know.
 3. [AFNetworkinig issues and solution to support client certificate](https://github.com/AFNetworking/AFNetworking/issues/2316) AFNetworking don't support client certificate (NSURLAuthenticationMethodClientCertificate), we have to customize the block to accomplish that.

