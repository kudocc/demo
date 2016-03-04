# WebCacheDemo
For Studying Http Cache in iOS

Cache保存在哪里呢？我在我的iphone4上做一下测试，系统是iOS7

在没有任何请求之前，沙盒中是这样的

首先是使用UIWebView，请求http://www.baidu.com

在Library/Caches/com.kudocc.WebCache/ 下面多了几个文件和一个目录fsCachedData
Library下面增加了一个Cookies文件夹 Library/Cookies，应该是保存Cookies

之后我来使用NSURLSession来请求，使用defaultSessionConfiguration

好像没什么变化的样子，接下来我把App删掉，然后修改一下defaultSessionConfiguration，再次请求

    NSString *pathToCache = @"urlsessioncache";
    NSURLCache *urlCache = [[NSURLCache alloc] initWithMemoryCapacity:10*1024*1024 diskCapacity:10*1024*1024 diskPath:pathToCache];
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    defaultSessionConfiguration.URLCache = urlCache;

代码增加了我们自定义的urlCache，给出了路径，这个路径基于Library/Caches/com.kudocc.WebCache/的路径。

一般Http的Cache应该是存放到Library/Caches/$bundleId/目录下，结构上都会有Cache.db Cache.db-shm Cache.db-wal和一个目录 fsCachedData，个人认为Cache.db Cache.db-shm Cache.db-wal都是与缓存相关的数据库表结构，存放数据等等，fsCachedData目录中是真正存放Cache的地方。我们自定义的url cache的目录中urlsessoincache/ 也是这种结构

接下来想做一个测试，从上面的测试看出在App内的请求得到的Cache都存放到沙盒内，所以在其他App或者Safari中可能用不到，但是我想弄清楚如果在Safari中请求某一个网页，然后在App中再请求相同的网页，会使用之前的Cache么？
用Charles抓了百度的包，发现在请求和响应的http header中都是no-cache，所以不能用百度来测，还是使用我自己的server吧，嘿嘿。

我用Safari请求后，抓到了包

删掉应用，修改代码，发现还是发了请求，也就是说没有用Safari的Cache，看来Cache不是跨应用的。

    - (NSURLRequest *)request {
        NSString *strURL = @"http://192.168.2.139:8080";
        _request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
        return _request;
    }
    
    - (NSURLRequest *)request {
        NSString *strURL = @"http://192.168.2.139:8080";
        _request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:strURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
        return _request;
    }
    
    - (void)viewDidLoad {
        [super viewDidLoad];
    
        NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
        _dataTask = [session dataTaskWithRequest:[self request] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSLog(@"dataLen:%lu", (unsigned long)[data length]);
        }];
        [_dataTask resume];
    }
