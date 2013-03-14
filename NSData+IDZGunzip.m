//
//  NSData+IDZInflate.m
//  Autoingestion
//
//  Created by idz on 3/13/13.
//  Copyright (c) 2013 idz. All rights reserved.
//

#import "NSData+IDZGunzip.h"
#import <zlib.h>

NSString* const IDZZLibErrorDomain = @"com.iosdeveloperzone.zlib";

@implementation NSData (IDZInflate)

- (NSData*)gunzip:(NSError *__autoreleasing *)error
{
    /*
     * A minimal gzip header/trailer is 18 bytes long.
     * See: RFC 1952 http://www.gzip.org/zlib/rfc-gzip.html
     */
    if(self.length < 18)
    {
        if(error)
            *error = [NSError errorWithDomain:IDZZLibErrorDomain code:Z_DATA_ERROR userInfo:nil];
        return nil;
    }
    z_stream zStream;
    memset(&zStream, 0, sizeof(zStream));
    /* 
     * 16 is a magic number that allows inflate to handle gzip 
     * headers.
     */
    int iResult = inflateInit2(&zStream, 16);
    if(iResult != Z_OK)
    {
        if(error)
            *error = [NSError errorWithDomain:IDZZLibErrorDomain code:iResult userInfo:nil];
        return nil;
    }
    /*
     * The last four bytes of a gzipped file/buffer contain the the number 
     * of uncompressed bytes expressed as a 32-bit little endian unsigned integer.
     * See: RFC 1952 http://www.gzip.org/zlib/rfc-gzip.html
     */
    UInt32 nUncompressedBytes = *(UInt32*)(self.bytes + self.length - 4);
    NSMutableData* gunzippedData = [NSMutableData dataWithLength:nUncompressedBytes];
    
    zStream.next_in = (Bytef*)self.bytes;
    zStream.avail_in = self.length;
    zStream.next_out = (Bytef*)gunzippedData.bytes;
    zStream.avail_out = gunzippedData.length;
    
    iResult = inflate(&zStream, Z_FINISH);
    if(iResult != Z_STREAM_END)
    {
        if(error)
            *error = [NSError errorWithDomain:IDZZLibErrorDomain code:iResult userInfo:nil];
        gunzippedData = nil;
    }
    inflateEnd(&zStream);
    return gunzippedData;
}

@end
