//
//  NSFileManagerAdditions.h
//  TRKit
//
// Code pulled from:
// http://www.cocoadev.com/index.pl?AuthenticatingNSFileManager
//
// Used for moving files.

#import <Cocoa/Cocoa.h>


@interface NSFileManager (TRAdditions)
- (NSString *)newTmpFilePath;
- (BOOL)authorizedMovePath:(NSString *)source toPath:(NSString *)destination;
- (BOOL)authorizedCopyPath:(NSString *)source toPath:(NSString *)destination;
@end