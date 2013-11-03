//
//  FKFlickrActivityUserPhotos.h
//  FlickrKit
//
//  Generated by FKAPIBuilder on 12 Jun, 2013 at 17:19.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrAPIMethod.h"

typedef enum {
	FKFlickrActivityUserPhotosError_InvalidSignature = 96,		 /* The passed signature was invalid. */
	FKFlickrActivityUserPhotosError_MissingSignature = 97,		 /* The call required signing but no signature was sent. */
	FKFlickrActivityUserPhotosError_LoginFailedOrInvalidAuthToken = 98,		 /* The login details or auth token passed were invalid. */
	FKFlickrActivityUserPhotosError_UserNotLoggedInOrInsufficientPermissions = 99,		 /* The method requires user authentication but the user was not logged in, or the authenticated method call did not have the required permissions. */
	FKFlickrActivityUserPhotosError_InvalidAPIKey = 100,		 /* The API key passed was not valid or has expired. */
	FKFlickrActivityUserPhotosError_ServiceCurrentlyUnavailable = 105,		 /* The requested service is temporarily unavailable. */
	FKFlickrActivityUserPhotosError_FormatXXXNotFound = 111,		 /* The requested response format was not found. */
	FKFlickrActivityUserPhotosError_MethodXXXNotFound = 112,		 /* The requested method was not found. */
	FKFlickrActivityUserPhotosError_InvalidSOAPEnvelope = 114,		 /* The SOAP envelope send in the request could not be parsed. */
	FKFlickrActivityUserPhotosError_InvalidXMLRPCMethodCall = 115,		 /* The XML-RPC request document could not be parsed. */
	FKFlickrActivityUserPhotosError_BadURLFound = 116,		 /* One or more arguments contained a URL that has been used for abuse on Flickr. */

} FKFlickrActivityUserPhotosError;

/*

Returns a list of recent activity on photos belonging to the calling user. <b>Do not poll this method more than once an hour</b>.


Response:

<items>
	<item type="photoset" id="395" owner="12037949754@N01" 
		primary="6521" secret="5a3cc65d72" server="2" 
		commentsold="1" commentsnew="1"
		views="33" photos="7" more="0">
		<title>A set of photos</title>
		<activity>
			<event type="comment"
			user="12037949754@N01" username="Bees"
			dateadded="1144086424">yay</event>
		</activity>
	</item>

	<item type="photo" id="10289" owner="12037949754@N01"
		secret="34da0d3891" server="2"
		commentsold="1" commentsnew="1"
		notesold="0" notesnew="1"
		views="47" faves="0" more="0">
		<title>A photo</title>
		<activity>
			<event type="comment"
			user="12037949754@N01" username="Bees"
			dateadded="1133806604">test</event>
			<event type="note"
			user="12037949754@N01" username="Bees"
			dateadded="1118785229">nice</event>
		</activity>
	</item>
</items>

*/
@interface FKFlickrActivityUserPhotos : NSObject <FKFlickrAPIMethod>

/* The timeframe in which to return updates for. This can be specified in days (<code>'2d'</code>) or hours (<code>'4h'</code>). The default behavoir is to return changes since the beginning of the previous user session. */
@property (nonatomic, strong) NSString *timeframe;

/* Number of items to return per page. If this argument is omitted, it defaults to 10. The maximum allowed value is 50. */
@property (nonatomic, strong) NSString *per_page;

/* The page of results to return. If this argument is omitted, it defaults to 1. */
@property (nonatomic, strong) NSString *page;


@end
