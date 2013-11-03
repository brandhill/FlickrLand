//
//  FKFlickrPlacesPlacesForTags.h
//  FlickrKit
//
//  Generated by FKAPIBuilder on 12 Jun, 2013 at 17:19.
//  Copyright (c) 2013 DevedUp Ltd. All rights reserved. http://www.devedup.com
//
//  DO NOT MODIFY THIS FILE - IT IS MACHINE GENERATED


#import "FKFlickrAPIMethod.h"

typedef enum {
	FKFlickrPlacesPlacesForTagsError_InvalidAPIKey = 100,		 /* The API key passed was not valid or has expired. */
	FKFlickrPlacesPlacesForTagsError_ServiceCurrentlyUnavailable = 105,		 /* The requested service is temporarily unavailable. */
	FKFlickrPlacesPlacesForTagsError_FormatXXXNotFound = 111,		 /* The requested response format was not found. */
	FKFlickrPlacesPlacesForTagsError_MethodXXXNotFound = 112,		 /* The requested method was not found. */
	FKFlickrPlacesPlacesForTagsError_InvalidSOAPEnvelope = 114,		 /* The SOAP envelope send in the request could not be parsed. */
	FKFlickrPlacesPlacesForTagsError_InvalidXMLRPCMethodCall = 115,		 /* The XML-RPC request document could not be parsed. */
	FKFlickrPlacesPlacesForTagsError_BadURLFound = 116,		 /* One or more arguments contained a URL that has been used for abuse on Flickr. */

} FKFlickrPlacesPlacesForTagsError;

/*

Return a list of the top 100 unique places clustered by a given placetype for set of tags or machine tags. 


Response:

<places total="1">
   <place place_id="kH8dLOubBZRvX_YZ" woeid="2487956"
               latitude="37.779" longitude="-122.420"
               place_url="/United+States/California/San+Francisco"
               place_type="locality"
               photo_count="156">San Francisco, California</place>
</places>

*/
@interface FKFlickrPlacesPlacesForTags : NSObject <FKFlickrAPIMethod>

/* The numeric ID for a specific place type to cluster photos by. <br /><br />

Valid place type IDs are :

<ul>
<li><strong>22</strong>: neighbourhood</li>
<li><strong>7</strong>: locality</li>
<li><strong>8</strong>: region</li>
<li><strong>12</strong>: country</li>
<li><strong>29</strong>: continent</li>
</ul> */
@property (nonatomic, strong) NSString *place_type_id; /* (Required) */

/* A Where on Earth identifier to use to filter photo clusters. For example all the photos clustered by <strong>locality</strong> in the United States (WOE ID <strong>23424977</strong>).
<br /><br />
<span style="font-style:italic;">(While optional, you must pass either a valid Places ID or a WOE ID.)</span> */
@property (nonatomic, strong) NSString *woe_id;

/* A Flickr Places identifier to use to filter photo clusters. For example all the photos clustered by <strong>locality</strong> in the United States (Place ID <strong>4KO02SibApitvSBieQ</strong>).
<br /><br />
<span style="font-style:italic;">(While optional, you must pass either a valid Places ID or a WOE ID.)</span> */
@property (nonatomic, strong) NSString *place_id;

/* The minimum number of photos that a place type must have to be included. If the number of photos is lowered then the parent place type for that place will be used.<br /><br />

For example if you only have <strong>3</strong> photos taken in the locality of Montreal</strong> (WOE ID 3534) but your threshold is set to <strong>5</strong> then those photos will be "rolled up" and included instead with a place record for the region of Quebec (WOE ID 2344924). */
@property (nonatomic, strong) NSString *threshold;

/* A comma-delimited list of tags. Photos with one or more of the tags listed will be returned. */
@property (nonatomic, strong) NSString *tags;

/* Either 'any' for an OR combination of tags, or 'all' for an AND combination. Defaults to 'any' if not specified. */
@property (nonatomic, strong) NSString *tag_mode;

/* Aside from passing in a fully formed machine tag, there is a special syntax for searching on specific properties :

<ul>
  <li>Find photos using the 'dc' namespace :    <code>"machine_tags" => "dc:"</code></li>

  <li> Find photos with a title in the 'dc' namespace : <code>"machine_tags" => "dc:title="</code></li>

  <li>Find photos titled "mr. camera" in the 'dc' namespace : <code>"machine_tags" => "dc:title=\"mr. camera\"</code></li>

  <li>Find photos whose value is "mr. camera" : <code>"machine_tags" => "*:*=\"mr. camera\""</code></li>

  <li>Find photos that have a title, in any namespace : <code>"machine_tags" => "*:title="</code></li>

  <li>Find photos that have a title, in any namespace, whose value is "mr. camera" : <code>"machine_tags" => "*:title=\"mr. camera\""</code></li>

  <li>Find photos, in the 'dc' namespace whose value is "mr. camera" : <code>"machine_tags" => "dc:*=\"mr. camera\""</code></li>

 </ul>

Multiple machine tags may be queried by passing a comma-separated list. The number of machine tags you can pass in a single query depends on the tag mode (AND or OR) that you are querying with. "AND" queries are limited to (16) machine tags. "OR" queries are limited
to (8). */
@property (nonatomic, strong) NSString *machine_tags;

/* Either 'any' for an OR combination of tags, or 'all' for an AND combination. Defaults to 'any' if not specified. */
@property (nonatomic, strong) NSString *machine_tag_mode;

/* Minimum upload date. Photos with an upload date greater than or equal to this value will be returned. The date should be in the form of a unix timestamp. */
@property (nonatomic, strong) NSString *min_upload_date;

/* Maximum upload date. Photos with an upload date less than or equal to this value will be returned. The date should be in the form of a unix timestamp. */
@property (nonatomic, strong) NSString *max_upload_date;

/* Minimum taken date. Photos with an taken date greater than or equal to this value will be returned. The date should be in the form of a mysql datetime. */
@property (nonatomic, strong) NSString *min_taken_date;

/* Maximum taken date. Photos with an taken date less than or equal to this value will be returned. The date should be in the form of a mysql datetime. */
@property (nonatomic, strong) NSString *max_taken_date;


@end
