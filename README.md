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

The `UIImage` category `UIImage+CornerRadius` creates a `UIImage` object which has transparent background except the four corner, we use the image object to create a `UIImageView` instance and add it as subview in UIView you want to mask.
