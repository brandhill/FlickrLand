//
//  FKFlickrPhotosRecentlyUpdated.m
//  FlickrKit
//
//  Generated by FKAPIBuilder on 12 Jun, 2013 at 17:19.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrPhotosRecentlyUpdated.h" 

@implementation FKFlickrPhotosRecentlyUpdated

- (BOOL) needsLogin {
    return YES;
}

- (BOOL) needsSigning {
    return YES;
}

- (FKPermission) requiredPerms {
    return 0;
}

- (NSString *) name {
    return @"flickr.photos.recentlyUpdated";
}

- (BOOL) isValid:(NSError **)error {
    BOOL valid = YES;
	NSMutableString *errorDescription = [[NSMutableString alloc] initWithString:@"You are missing required params: "];
	if(!self.min_date) {
		valid = NO;
		[errorDescription appendString:@"'min_date', "];
	}

	if(error != NULL) {
		if(!valid) {	
			NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorDescription};
			*error = [NSError errorWithDomain:FKFlickrKitErrorDomain code:FKErrorInvalidArgs userInfo:userInfo];
		}
	}
    return valid;
}

- (NSDictionary *) args {
    NSMutableDictionary *args = [NSMutableDictionary dictionary];
	if(self.min_date) {
		[args setValue:self.min_date forKey:@"min_date"];
	}
	if(self.extras) {
		[args setValue:self.extras forKey:@"extras"];
	}
	if(self.per_page) {
		[args setValue:self.per_page forKey:@"per_page"];
	}
	if(self.page) {
		[args setValue:self.page forKey:@"page"];
	}

    return [args copy];
}

- (NSString *) descriptionForError:(NSInteger)error {
    switch(error) {
		case FKFlickrPhotosRecentlyUpdatedError_RequiredArgumentMissing:
			return @"Required argument missing.";
		case FKFlickrPhotosRecentlyUpdatedError_NotAValidDate:
			return @"Not a valid date";
		case FKFlickrPhotosRecentlyUpdatedError_InvalidSignature:
			return @"Invalid signature";
		case FKFlickrPhotosRecentlyUpdatedError_MissingSignature:
			return @"Missing signature";
		case FKFlickrPhotosRecentlyUpdatedError_LoginFailedOrInvalidAuthToken:
			return @"Login failed / Invalid auth token";
		case FKFlickrPhotosRecentlyUpdatedError_UserNotLoggedInOrInsufficientPermissions:
			return @"User not logged in / Insufficient permissions";
		case FKFlickrPhotosRecentlyUpdatedError_InvalidAPIKey:
			return @"Invalid API Key";
		case FKFlickrPhotosRecentlyUpdatedError_ServiceCurrentlyUnavailable:
			return @"Service currently unavailable";
		case FKFlickrPhotosRecentlyUpdatedError_FormatXXXNotFound:
			return @"Format \"xxx\" not found";
		case FKFlickrPhotosRecentlyUpdatedError_MethodXXXNotFound:
			return @"Method \"xxx\" not found";
		case FKFlickrPhotosRecentlyUpdatedError_InvalidSOAPEnvelope:
			return @"Invalid SOAP envelope";
		case FKFlickrPhotosRecentlyUpdatedError_InvalidXMLRPCMethodCall:
			return @"Invalid XML-RPC Method Call";
		case FKFlickrPhotosRecentlyUpdatedError_BadURLFound:
			return @"Bad URL found";
  
		default:
			return @"Unknown error code";
    }
}

@end
