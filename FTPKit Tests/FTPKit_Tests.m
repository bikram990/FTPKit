//
//  FTPKit_Tests.m
//  FTPKit Tests
//
//  Created by Eric Chamberlain on 3/7/14.
//  Copyright (c) 2014 Upstart Illustration LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FTPKit.h"
#import "FTPKit+Protected.h"

@interface FTPKit_Tests : XCTestCase

@end

@implementation FTPKit_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNSError
{
    
}

- (void)testNSURL
{
    
}

- (void)testFtp
{
    FTPClient * ftp = [[FTPClient alloc] initWithHost:@"localhost" port:21 username:@"unittest" password:@"unitpass"];
    NSArray *contents = [ftp listContentsAtPath:@"/test" showHiddenFiles:YES];
    for (FTPHandle *handle in contents) {
        FKLogDebug(@"name (%@) size (%llu)", handle.name, handle.size);
    }
    return;
    // Create 'test1.txt' file to upload. Contents are 'testing 1'.
    NSURL *localUrl = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"ftplib.tgz"];
    // Download 'ftplib.tgz'
    [ftp downloadFile:@"/ftplib.tgz" to:localUrl.path progress:NULL];
    
    // Upload 'ftplib.tgz' as 'copy.tgz'
    [ftp uploadFile:localUrl.path to:@"/copy.tgz" progress:NULL];
    
    // chmod 'copy.tgz' to 777
    [ftp chmodPath:@"/copy.tgz" toMode:777];
    
    // Create directory 'test'
    [ftp createDirectoryAtPath:@"/test"];
    
    // chmod 'test' to 777
    [ftp chmodPath:@"/test" toMode:777];
    
    // List contents of 'test'
    contents = [ftp listContentsAtPath:@"/test" showHiddenFiles:YES];
    
    // - Make sure there are no contents.
    XCTAssertEqual(0, contents.count, @"There should be no contents");
    
    // Move 'copy.tgz' to 'test' directory
    [ftp renamePath:@"/copy.tgz" to:@"/test/copy.tgz"];
    
    // Create '/test/test2' directory
    [ftp createDirectoryAtPath:@"/test/test2"];
    
    // List contents of 'test'
    contents = [ftp listContentsAtPath:@"/test" showHiddenFiles:YES];
    
    // - Should have 'copy.tgz' (a file) and 'test2' (a directory)
    // @todo make sure they are the files we requested, including the correct type.
    XCTAssertEqual(2, contents.count, @"");
    
    // Delete 'test'. It should fail as there are contents in the directory.
    
    // Delete 'test2', 'copy.tgz' and then 'test'. All operations should succeed.
    
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
