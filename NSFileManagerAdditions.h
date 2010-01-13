//
//  NSFileManagerAdditions.h
//  TRKit
//

#import <Cocoa/Cocoa.h>


@interface NSFileManager (TRAdditions)
- (NSString *)newTmpFilePath;
- (BOOL)authorizedMovePath:(NSString *)source toPath:(NSString *)destination;
- (BOOL)authorizedCopyPath:(NSString *)source toPath:(NSString *)destination;
@end