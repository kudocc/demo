# demo list

These demos help a lot :)

# 1.performance

performance gives a way to solve the problem that `layer.masksToBounds` causes offscreen rendering. Comparing to drawing the whole content in `drawRect:` method, creating another image mask view and add it as subview is more efficient.

The `UIImage` category `UIImage+CornerRadius` creates a `UIImage` object which has transparent background except the four corner, we use the image object to create a `UIImageView` instance and add it as subview in UIView you want to mask.
