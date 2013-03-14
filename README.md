NSData+IDZGunzip
================

A category on NSData that provides a simple way to gunzip gzipped data.

Using the category is very straight forward.
1. Add libz.dylib to your project. 
2. Add NSData+IDZGunzip.m and NSData+IDZGunzip.h to your project.
3. Then you do something like this:
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
