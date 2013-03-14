NSData+IDZGunzip
================

A category on NSData that provides a simple way to gunzip gzipped data.

Using the category is very straight forward. First make sure you add libz.dylib to your project. Then you do something like this:
```objective-c
#import "NSData+IDZGunzip.h"

...

// Assuming data holds valid gzipped data
NSError* error = nil;

NSData* gunzippedData = [data gunzip:&error];
if(!gunzippedData)
{
  // Handle error
}
else
{
  // Success use gunzippedData
}
```
