//
//  YRWeiboDataBaseContent.h
//  YR1001WeiboDemo
//
//  Created by Rocky on 14-10-5.
//  Copyright (c) 2014年 Rocky. All rights reserved.
//

#ifndef YR1001WeiboDemo_YRWeiboDataBaseContent_h
#define YR1001WeiboDemo_YRWeiboDataBaseContent_h


#pragma mark - 数据库中的数据

/**
 *  数据库的名字
 */
static NSString * const kDBName = @"status_user_BD.sqlite";

/**
 *  微博(T_STATUS)表的结构
 */
static NSString * const kStatustTableName = @"T_STATUS";
static NSString * const kStatustID = @"id";//
static NSString * const kStatusStatusID = @"status_id";// 这丫是主键
static NSString * const kStatusCreateedAt = @"created_at";//
static NSString * const kStatusMid = @"mid";//
static NSString * const kStatusIdstr = @"idstr";//
static NSString * const kStatusText = @"text";//
static NSString * const kStatusSource = @"source";//
static NSString * const kStatusFavorited = @"favorited";
static NSString * const kStatusTruncated = @"truncated";
static NSString * const kStatusInReplyToStatusId = @"in_reply_to_status_id";
static NSString * const kStatusInReplyToUserId = @"in_reply_to_user_id";
static NSString * const kStatusInReplyToScreenName = @"in_reply_to_screen_name";
static NSString * const kStatusThumbnailPic = @"thumbnail_pic";//
static NSString * const kStatusBmiddlePic = @"bmiddle_pic";
static NSString * const kStatusOriginalPic = @"original_pic";//
static NSString * const kStatusUserInfo = @"user";//
static NSString * const kStatusRetweetedStatus = @"retweeted_status";//
static NSString * const kStatusRetweetedStatusId = @"retweeted_status_id";//
static NSString * const kStatusRepostsCount = @"reposts_count";//
static NSString * const kStatusCommentsCount = @"comments_count";//
static NSString * const kStatusAttitudesCount = @"attitudes_count";//
static NSString * const kStatusMlevel = @"mlevel";
static NSString * const kStatusVisibleId = @"visible_id";
static NSString * const kStatusPicUrls = @"pic_urls";//
static NSString * const kStatusAdId = @"ad_id";


/**
 *  用户(T_USER)表的结构
 */
static NSString * const kUserTableName = @"T_USER";
static NSString * const kUserID = @"id";//
static NSString * const kUserUserId = @"user_id";// 这个是主键
static NSString * const kUserIdstr = @"idstr";
static NSString * const kUserScreenName = @"screen_name";//
static NSString * const kUserName = @"name";//
static NSString * const kUserProvince = @"province";
static NSString * const kUserCity = @"city";
static NSString * const kUserLocation = @"location";
static NSString * const kUserDescription = @"description";//
static NSString * const kUserUrl = @"url";
static NSString * const kUserProfileImageUrl = @"profile_image_url";
static NSString * const kUserProfileUrl = @"profile_url";
static NSString * const kUserDomain = @"domain";
static NSString * const kUserWeihao = @"weihao";
static NSString * const kUserGender = @"gender";
static NSString * const kUserFollowersCount = @"followers_count";// 粉丝数
static NSString * const kUserFriendsCount = @"friends_count";// 关注数
static NSString * const kUserStatusesCount = @"statuses_count";// 微博数
static NSString * const kUserFavouritesCount = @"favourites_count";// 收藏数
static NSString * const kUserCreatedAt = @"created_at";
static NSString * const kUserAllowAllActMsg = @"allow_all_act_msg";
static NSString * const kUserGeoEnabled = @"geo_enabled";
static NSString * const kUserVerified = @"verified";
static NSString * const kUserVerifiedType = @"verified_type";
static NSString * const kUserRemark = @"remark";
static NSString * const kUserStatusId = @"status_id";//
static NSString * const kUserAllowAllActComment = @"allow_all_comment";
static NSString * const kUserAvatarlager = @"avatar_large";//用户头像大图avatar_large
static NSString * const kUserVerifiedReason = @"verified_reason";//
static NSString * const kUserFollowMe = @"follow_me";
static NSString * const kUserOnlineStatus = @"online_status";
static NSString * const kUserBiFollowersCount = @"bi_followers_count";
static NSString * const kUserLang = @"lang";

/**
 *  微博评论列表(T_COMMENT)
 */
static NSString * const kCommentID = @"id";
static NSString * const kCommentCreateedAt = @"created_at";
static NSString * const kCommentCommentId = @"comment_id";
static NSString * const kCommentText = @"text";
static NSString * const kCommentSource = @"source";
static NSString * const kCommentUserId = @"user_id";
static NSString * const kCommentMid = @"mid";
static NSString * const kCommentIdstr = @"idstr";
static NSString * const kCommentStatusId = @"status_id";
static NSString * const kCommentReplyCommentId = @"reply_comment_id";

/**
 *  微博附带图片表(T_PIC_URLS)
 */
static NSString * const kPicID = @"id";
static NSString * const kPicId = @"pic_id";
static NSString * const kPicUrlStr = @"pic_url_str";


/**
 *  草稿箱的数据表(T_DRAFTS)
 */
static NSString * const kDraftsID = @"id";
static NSString * const kDraftsImage = @"image";
//static NSString * const kDraftsRet

#endif
