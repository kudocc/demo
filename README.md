# demo list

These demos help a lot :)

## 1.TouchDemo

TouchDemo in WWDC 2014 session 235 Advanced scrollviews and touch handling techniques

## 2.URLSessionTest

Goal: Set up a http(https) server, write a demo to send `multipart/form-data` content-type request. Write a demo to use self-signed certificate to test server trust and client certificate.

1. The difference between `application/x-www-form-urlencoded` and `multipart/form-data`, see [this link](http://stackoverflow.com/questions/4007969/application-x-www-form-urlencoded-or-multipart-form-data)

2. I have studied HTTPS for a long time, but it's hard to keep in my mind because it's so complicated. I want to show some links here to help.

 1. [X.509](https://en.wikipedia.org/wiki/X.509) talks about the certificate and how to verify certificate.
 2. [This link](http://blog.lumberlabs.com/2012/04/why-app-developers-should-care-about.html) talks about SSL pinning that we developers should know.
 3. [AFNetworkinig issues and solution to support client certificate](https://github.com/AFNetworking/AFNetworking/issues/2316) AFNetworking don't support client certificate (NSURLAuthenticationMethodClientCertificate), we have to customize the block to accomplish that.

[Click here](https://github.com/kudocc/demo/tree/master/URLSessionTest)

## 3.sqlite

[See here](https://github.com/kudocc/demo/tree/master/sqlite)
