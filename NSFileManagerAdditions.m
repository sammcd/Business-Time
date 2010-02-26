//
//  NSFileManagerAdditions.m
//  TRKit
//

#import "NSFileManagerAdditions.h"
#import <Carbon/Carbon.h>
#import <Security/Security.h>
#import "stdlib.h"
#import "time.h"

static AuthorizationRef authorizationRef = NULL;

@implementation NSFileManager (TRAdditions)

- (NSString *)newTmpFilePath
{
	NSString * tmpDirectory = NSTemporaryDirectory();
	NSString * identifier = @"Hosts";
	
	if (tmpDirectory == nil || identifier == nil) return nil;
	
	for (;;)
	{
        srand(time(nil));
        int random = rand() % 100000;
		NSString * tmpFileName = [NSString stringWithFormat:@"%@_%i",identifier,random];
		NSString * path = [tmpDirectory stringByAppendingPathComponent:tmpFileName];
		path = [path stringByStandardizingPath];
		
		if ([self fileExistsAtPath:path])
		{
			continue;
		}
		else
		{
			// 'Touch' a file here so that it guarentees that another won't be created (rare chance).
			//[self createFileAtPath:path contents:nil attributes:nil];
			return path;
		}
	}
}

- (BOOL)authorizedMovePath:(NSString *)source toPath:(NSString *)destination
{
	//NSBundle * trkitBundle = [NSBundle bundleForClass:NSClassFromString(@"TRIntegration")];
	//NSString * trkitResourcePath = [[NSBundle mainBundle] resourcePath];
	//NSString * trkitMoveUtilityPath = [trkitResourcePath stringByAppendingPathComponent:@"move"];
    NSString * trkitMoveUtilityPath = @"/bin/mv";

	
	if (![self fileExistsAtPath:trkitMoveUtilityPath])
	{
		NSLog(@"Cannot find move utility.");
		return NO;
	}
	
	/* The move utlity exists, we can now procede. */
	OSStatus status;
	
	if (authorizationRef == NULL)
	{
		// Get Authorization.
		status = AuthorizationCreate(NULL,
									 kAuthorizationEmptyEnvironment,
									 kAuthorizationFlagDefaults,
									 &authorizationRef);
	}
	else
	{
		status = noErr;
	}
	
	// Make sure we have authorization.
	if (status != noErr)
	{
		NSLog(@"Could not get authorization, failing.");
		return NO;
	}
	
	// Set up the arguments.
	char * args[4];
    args[0] = "-f";
	args[1] = (char *)[[source stringByStandardizingPath] UTF8String];
	args[2] = (char *)[[destination stringByStandardizingPath] UTF8String];
	args[3] = NULL;
	
	status = AuthorizationExecuteWithPrivileges(authorizationRef,
												[[trkitMoveUtilityPath stringByStandardizingPath] UTF8String],
												0, args, NULL);
	
	if (status != noErr)
	{
		NSLog(@"Could not move file.");
		return NO;
	}
	else
	{
		return YES;
	}
	
	return NO;
}

- (BOOL)authorizedCopyPath:(NSString *)source toPath:(NSString *)destination
{
	NSString * tempFile = [self newTmpFilePath];
	[self copyItemAtPath:source toPath:tempFile error:nil];
	[self authorizedMovePath:tempFile toPath:destination];
    return YES;
}

@end