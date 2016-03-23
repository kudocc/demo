# sqlite

I want to test the select performance on table with index and table withot index. The test is on iPhone4. The table `downloaded_image_url` has 24852 rows.

There are two sqlite statements:

1.`select * from downloaded_image_url where image_url=?`
2.`select * from downloaded_image_url order by image_size desc limit 5`

Let's go:

#1 limit 5, keep the time just after execute sql statement.

```
- (NSTimeInterval)testSelect:(FMDatabase *)database {
    NSString *url = @"http://imgsrc.baidu.com/forum/wh%3D160%2C90/sign=2fb54fb05eee3d6d22938fca7526411b/157adab44aed2e73f55cda3b8001a18b87d6fa74.jpg";
    NSDate *dateBefore = [NSDate date];
    FMResultSet *resultSet = [database executeQuery:@"select * from downloaded_image_url where image_url=?", url];
    NSDate *dateAfter = [NSDate date];
    while ([resultSet next]) {
        NSString *imageUrl = [resultSet stringForColumn:@"image_url"];
        int imageSize = [resultSet intForColumn:@"image_size"];
        NSLog(@"select resultset %@, %d", imageUrl, imageSize);
    }
    [resultSet close];
    return [dateAfter timeIntervalSinceDate:dateBefore];
}

- (NSTimeInterval)testSort:(FMDatabase *)database {
    NSDate *dateBefore = [NSDate date];
    FMResultSet *resultSet = [database executeQuery:@"select * from downloaded_image_url order by image_size desc limit 1000"];
    NSDate *dateAfter = [NSDate date];
    if ([resultSet next]) {
        NSString *imageUrl = [resultSet stringForColumn:@"image_url"];
        int imageSize = [resultSet intForColumn:@"image_size"];
        NSLog(@"sort resultset %@, %d", imageUrl, imageSize);
    }
    [resultSet close];
    return [dateAfter timeIntervalSinceDate:dateBefore];
}
```

The result is :
```
2016-03-23 16:27:18.026 sqlite[571:60b] select resultset http://imgsrc.baidu.com/forum/wh%3D160%2C90/sign=2fb54fb05eee3d6d22938fca7526411b/157adab44aed2e73f55cda3b8001a18b87d6fa74.jpg, 5331
2016-03-23 16:27:18.571 sqlite[571:60b] sort resultset http://imgsrc.baidu.com/forum/w%3D580/sign=9c3610ac573d26972ed3085565fab24f/43277083b2b7d0a2302e29fbcdef76094a369a81.jpg?v=tbs, 5137659
2016-03-23 16:27:18.577 sqlite[571:60b] sort resultset http://b.hiphotos.bdimg.com/album/h%3D820%3Bq%3D90/sign=a3bfd83848fbfbedc3593b7d48cb860b/4a36acaf2edda3cc85c9f12702e93901213f928c.jpg?v=tbs, 4856633
2016-03-23 16:27:18.582 sqlite[571:60b] sort resultset http://e.hiphotos.bdimg.com/album/s%3D1100%3Bq%3D90/sign=1a9e58d2af6eddc422e7b0fa09eb8d8c/5ab5c9ea15ce36d3c153f50738f33a87e950b1b5.jpg?v=tbs, 4362401
2016-03-23 16:27:18.588 sqlite[571:60b] sort resultset http://c.hiphotos.bdimg.com/album/s%3D1000%3Bq%3D90/sign=cac959bbf9f2b211e02e814efab05e49/e7cd7b899e510fb3d5d5485fdb33c895d0430c2d.jpg?v=tbs, 4187176
2016-03-23 16:27:18.593 sqlite[571:60b] sort resultset http://imgsrc.baidu.com/forum/w%3D580/sign=7db375fd60380cd7e61ea2e59145ad14/788b97315c6034a8931232ccce1349540823763e.jpg?v=tbs, 4157945
2016-03-23 16:27:18.608 sqlite[571:60b] select resultset http://imgsrc.baidu.com/forum/wh%3D160%2C90/sign=2fb54fb05eee3d6d22938fca7526411b/157adab44aed2e73f55cda3b8001a18b87d6fa74.jpg, 5331
2016-03-23 16:27:18.624 sqlite[571:60b] sort resultset http://imgsrc.baidu.com/forum/w%3D580/sign=9c3610ac573d26972ed3085565fab24f/43277083b2b7d0a2302e29fbcdef76094a369a81.jpg?v=tbs, 5137659
2016-03-23 16:27:18.635 sqlite[571:60b] sort resultset http://b.hiphotos.bdimg.com/album/h%3D820%3Bq%3D90/sign=a3bfd83848fbfbedc3593b7d48cb860b/4a36acaf2edda3cc85c9f12702e93901213f928c.jpg?v=tbs, 4856633
2016-03-23 16:27:18.643 sqlite[571:60b] sort resultset http://e.hiphotos.bdimg.com/album/s%3D1100%3Bq%3D90/sign=1a9e58d2af6eddc422e7b0fa09eb8d8c/5ab5c9ea15ce36d3c153f50738f33a87e950b1b5.jpg?v=tbs, 4362401
2016-03-23 16:27:18.652 sqlite[571:60b] sort resultset http://c.hiphotos.bdimg.com/album/s%3D1000%3Bq%3D90/sign=cac959bbf9f2b211e02e814efab05e49/e7cd7b899e510fb3d5d5485fdb33c895d0430c2d.jpg?v=tbs, 4187176
2016-03-23 16:27:18.662 sqlite[571:60b] sort resultset http://imgsrc.baidu.com/forum/w%3D580/sign=7db375fd60380cd7e61ea2e59145ad14/788b97315c6034a8931232ccce1349540823763e.jpg, 4157945
2016-03-23 16:27:18.668 sqlite[571:60b] ----------------------------------
2016-03-23 16:27:18.672 sqlite[571:60b] common select 0.004235, sort:0.000352
2016-03-23 16:27:18.677 sqlite[571:60b] index select 0.002006, sort:0.000264
2016-03-23 16:27:18.682 sqlite[571:60b] ----------------------------------
```

Indexed table is fast but not as fast as I thought, hmm, what't wrong ? let's move the "keep time" method after all '[resultSet next]' method.

#2 Keep the time at the end

The code is 
 
 ```
 - (NSTimeInterval)testSelect:(FMDatabase *)database {
    NSString *url = @"http://imgsrc.baidu.com/forum/wh%3D160%2C90/sign=2fb54fb05eee3d6d22938fca7526411b/157adab44aed2e73f55cda3b8001a18b87d6fa74.jpg";
    NSDate *dateBefore = [NSDate date];
    FMResultSet *resultSet = [database executeQuery:@"select * from downloaded_image_url where image_url=?", url];
    while ([resultSet next]) {
        NSString *imageUrl = [resultSet stringForColumn:@"image_url"];
        int imageSize = [resultSet intForColumn:@"image_size"];
    }
    NSDate *dateAfter = [NSDate date];
    [resultSet close];
    return [dateAfter timeIntervalSinceDate:dateBefore];
}

- (NSTimeInterval)testSort:(FMDatabase *)database {
    NSDate *dateBefore = [NSDate date];
    FMResultSet *resultSet = [database executeQuery:@"select * from downloaded_image_url order by image_size desc limit 1000"];
    if ([resultSet next]) {
        NSString *imageUrl = [resultSet stringForColumn:@"image_url"];
        int imageSize = [resultSet intForColumn:@"image_size"];
    }
    NSDate *dateAfter = [NSDate date];
    [resultSet close];
    return [dateAfter timeIntervalSinceDate:dateBefore];
}
```

Wooooow!!! Indexed table is much faster than the table without index.

```
 2016-03-23 16:30:01.440 sqlite[585:60b] ----------------------------------
 2016-03-23 16:30:01.448 sqlite[585:60b] common select 0.128370, sort:0.415636
 2016-03-23 16:30:01.450 sqlite[585:60b] index select 0.002612, sort:0.001613
 2016-03-23 16:30:01.452 sqlite[585:60b] ----------------------------------
```

#3 Execute `[result next]` only once.

Modify the code, change `while` to `if`, so we only execute `[result next]` at most once.

```
 2016-03-23 16:32:41.777 sqlite[592:60b] ----------------------------------
 2016-03-23 16:32:41.783 sqlite[592:60b] common select 0.129737, sort:0.416323
 2016-03-23 16:32:41.785 sqlite[592:60b] index select 0.002643, sort:0.000862
 2016-03-23 16:32:41.787 sqlite[592:60b] ----------------------------------
```

The indexed table become faster, the reason if ........, see the [link](http://www.sqlite.org/queryplanner.html)

#4 Limit from 5 to 10, use while other than if.

```
 2016-03-23 16:34:19.840 sqlite[604:60b] ----------------------------------
 2016-03-23 16:34:19.846 sqlite[604:60b] common select 0.129006, sort:0.425875
 2016-03-23 16:34:19.848 sqlite[604:60b] index select 0.002638, sort:0.007542
 2016-03-23 16:34:19.850 sqlite[604:60b] ----------------------------------
```

#5 Limit from 10 to 100, use while.

```
 2016-03-23 16:35:38.800 sqlite[611:60b] ----------------------------------
 2016-03-23 16:35:38.805 sqlite[611:60b] common select 0.128036, sort:0.548708
 2016-03-23 16:35:38.807 sqlite[611:60b] index select 0.002631, sort:0.079286
 2016-03-23 16:35:38.809 sqlite[611:60b] ----------------------------------
```

The time of executing in indexed table is almost 10 times than "limit 10".

#6 Limit from 100 to 1000

```
 2016-03-23 16:36:37.763 sqlite[617:60b] ----------------------------------
 2016-03-23 16:36:37.768 sqlite[617:60b] common select 0.131462, sort:1.066768
 2016-03-23 16:36:37.770 sqlite[617:60b] index select 0.002712, sort:0.332531
 2016-03-23 16:36:37.772 sqlite[617:60b] ----------------------------------
```

#7 Limit 1000, but use if other than while

```
 2016-03-23 16:37:47.327 sqlite[624:60b] ----------------------------------
 2016-03-23 16:37:47.333 sqlite[624:60b] common select 0.128068, sort:1.026709
 2016-03-23 16:37:47.335 sqlite[624:60b] index select 0.002645, sort:0.000860
 2016-03-23 16:37:47.337 sqlite[624:60b] ----------------------------------
```
