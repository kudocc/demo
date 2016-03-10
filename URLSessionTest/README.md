# Set up a http server

# Basic auth

Go to `/etc/apache2`, edit httpd.conf file.

Before edit:

```
DocumentRoot "/Users/kudocc/WebServer/Documents"
<Directory "/Users/kudocc/WebServer/Documents">
    #
    # Possible values for the Options directive are "None", "All",
    # or any combination of:
    #   Indexes Includes FollowSymLinks SymLinksifOwnerMatch ExecCGI MultiViews
    #
    # Note that "MultiViews" must be named *explicitly* --- "Options All"
    # doesn't give it to you.
    #
    # The Options directive is both complicated and important.  Please see
    # http://httpd.apache.org/docs/2.4/mod/core.html#options
    # for more information.
    #
    Options FollowSymLinks Multiviews
    MultiviewsMatch Any

    #
    # AllowOverride controls what directives may be placed in .htaccess files.
    # It can be "All", "None", or any combination of the keywords:
    #   AllowOverride FileInfo AuthConfig Limit
    #
    AllowOverride AuthConfig

    #
    # Controls who can get stuff from this server.
    #
    Require all granted

</Directory>
```

After config

```
DocumentRoot "/Users/kudocc/WebServer/Documents"
<Directory "/Users/kudocc/WebServer/Documents">
    #
    # Possible values for the Options directive are "None", "All",
    # or any combination of:
    #   Indexes Includes FollowSymLinks SymLinksifOwnerMatch ExecCGI MultiViews
    #
    # Note that "MultiViews" must be named *explicitly* --- "Options All"
    # doesn't give it to you.
    #
    # The Options directive is both complicated and important.  Please see
    # http://httpd.apache.org/docs/2.4/mod/core.html#options
    # for more information.
    #
    #Options FollowSymLinks Multiviews
    #MultiviewsMatch Any

    #
    # AllowOverride controls what directives may be placed in .htaccess files.
    # It can be "All", "None", or any combination of the keywords:
    #   AllowOverride FileInfo AuthConfig Limit
    #
    #AllowOverride None

    #
    # Controls who can get stuff from this server.
    #
    #Require all granted

    AuthType Basic
    AuthName "Restricted Files"
    # (Following line optional)
    AuthBasicProvider file
    AuthUserFile "/Users/kudocc/passwords"
    Require user yuanrui

</Directory>
```

Then I add a user and password using command `htpasswd -c /usr/kudocc/passwords yuanrui`, it will prompt you enter a password.

Restart the apache with `sudo apachectl graceful`

Done

# what I want to know

What I want to know is : if I add basic in http header, would I receive a challenge from server ? Let's have a try.

1. I don't set username:password in http header, then I receive a challenge from server.

```
Connection = "Keep-Alive";
    "Content-Length" = 381;
    "Content-Type" = "text/html; charset=iso-8859-1";
    Date = "Thu, 10 Mar 2016 05:18:06 GMT";
    "Keep-Alive" = "timeout=5, max=99";
    Server = "Apache/2.4.16 (Unix) PHP/5.5.30";
    "Www-Authenticate" = "Basic realm=\"Restricted Files\"";
```

I handle it :

```
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler {
    NSLog(@"%@, challenge authenticationMethod method:%@", NSStringFromSelector(_cmd), challenge.protectionSpace.authenticationMethod);
    
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic) {
        NSURLCredential *newCredential = [NSURLCredential credentialWithUser:@"yuanrui"
                                                                    password:@"xxxx"
                                                                 persistence:NSURLCredentialPersistenceForSession];
        completionHandler(NSURLSessionAuthChallengeUseCredential, newCredential);
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, challenge.proposedCredential);
    }
}
```

Success.

2. I set Authorization header in http header field with user name and password, then we don't receive any challenge.

```
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://localhost"]];
    
    NSString *username = @"yuanrui";
    NSString *password = @"xxxx";
    NSString *basicAuthCredentials = [NSString stringWithFormat:@"%@:%@", username, password];
    NSString *value = [NSString stringWithFormat:@"Basic %@", AFBase64EncodedStringFromString(basicAuthCredentials)];
    [req setValue:value forHTTPHeaderField:@"Authorization"];
    
    _operationQueue = [[NSOperationQueue alloc] init];

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 15.0;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:self
                                                     delegateQueue:_operationQueue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:req];
    [dataTask resume];
```

Done!
