# Purpose
Please read this page carefully. It contains all the configurations you need.  
All configurations are described in *Contants.swift*

# Key

````    
// Key Chain
struct KeyChain {
    static let IV = "jaspocf.1209sekk"
    static let AESSecret = "com.feelsfashionltd.feels.e07b3e"
}

// Feels
static let FeelsAPISecret = "JN/OWbPi7x5ZvBUZFDwyRhxXPUKkK8KYOANNH/vm3+qX3cqEKNrsI9qgAW4swaHMTGtQO/vCTTKFX+FgK0goBQ=="

// Twitter
struct Twitter {
    static let ClientKey = "fV1yCHodoT2BEylu3ULKjAR4G"
    static let SecretKey = "clRVvDVtsemNYyClJMZklnL9otRT0Li28I6lK8h5j5m0DIAh3W"
}

// Pushwoosh
struct PushWoosh {
    static let PushWooshAppID = "448E6-FD3CD"
}

// Instagram
struct Instagram {
    
    static let ClientKey = "702c24dc254f497a9472503312f7164f"
    static let SecretKey = "00691f0f3c6648d98134aa680c3f04c9"
    static let CallbackURL = "http://oauth-callback/instagram"
    
    static let OauthURL = "https://api.instagram.com/oauth/authorize"
    static let TokenURL = "https://api.instagram.com/oauth/access_token"
    static let ResponseType = "token"
    static let Scope = "basic+public_content"
    static let RequesetMeURL = "https://api.instagram.com/v1/users/self/"
}

// S3 amazon
struct S3Amazon {
    static let BucketName = "eu-photos"
    static let SecretKey = "bK0+TnrYq6eMK02F/E8J6IvnDAxJm6v18HCatNmo"
    static let AccessKey = "AKIAI3E4VGRGC5MNH2FQ"
}

// Youtube
struct Youtube {
    static let ClientKey = "272497596334-mj0dqdn1voja5obm47lpl0s3g9rja5ek.apps.googleusercontent.com"
    static let SecretKey = "KhEu5-g0LlTuHiVUJHDgiQV2"
    static let OauthURL = "https://accounts.google.com/o/oauth2/auth"
    static let TokenURL = "https://accounts.google.com/o/oauth2/token"
    static let CallbackURL = "com.feelsfashionltd.feels:/oauth2Callback"
    static let ResponseType = "code"
    static let Scope = "https://www.googleapis.com/auth/youtube.readonly https://www.googleapis.com/auth/userinfo.profile"
    static let RequesetMeURL = "https://www.googleapis.com/youtube/v3/channels?part=id,snippet&mine=true"
}

// Rollout
struct Rollout {
    static let Key = "56e8e305d7d04c02119cac48"
}
````
# Slack report
````
// Slack Report
struct Slack {
    static let Token = "E4YJuN1mix8r3MbqyqVAjJHG"
    static let ErrorChannel = "%23feels-v3-error"
    static let ResponseChannel = "%23feels-v3-response"
    
    // Webhook integration
    static let ErrorChannel_Webhook = "https://hooks.slack.com/services/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"
    static let ResponseChannel_Webhook = "https://hooks.slack.com/services/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"
}
````
# Guest key
````
// Key ID and GUEST ID
static let GuestKey = "Mg8j9ssa9qZZkoQLlZ2BCAii"
static let GuestHashID = "b6589fc6ab0dc82cf12099d1c2d40ab994e8410c"
````
# Endpoint
````
struct APIEndPoint {
    static let CastingList = "/v5/castings"
    static let CastingDetail = "/v5/functions/casting_entries"
    static let UserProfile = "/v5/feeds/profile"
    static let Notification = "/v5/feeds/notification_final"
    static let CreateItemUploadObject = "/v1/users/upload"
    static let SetCompletionObject = "/v1/users/upload_completed"
    static let Like = "/v1/users/like"
    static let Unlike = "/v1/users/unlike"
    static let Follow = "/v1/users/follow"
    static let Unfollow = "/v1/users/unfollow"
    static let UserFind = "/v1/users/find"
    static let UserLogin = "/v5/users/login"
    static let ForgotPassword = "/v1/mails/send"
    static let SetBadge = "/v1/functions/set_badge"
    static let FlagContent = "/v1/users/flag"
    static let DeleteItem = "/v1/users/delete"
    
    static let SeenAll = "/v5/notifications/seen-all"
    static let Seen = "/v5/items/:id/likes/seen-all"
    static let ClearNotification = "/v5/notifications/destroy-all"
    
    static let LikerUserNotification = "/v5/items/:id/likers"
    
    // Social
    static let SocialLoginSignUp = "v5/users/social_login"
    
    static func RefreshObject(classname: String) -> String {
        if classname == Constants.Obj.Classname.Item || classname == Constants.Obj.FullClassname.Item {
            return "/v5"
        }
        else if classname == Constants.Obj.Classname.User || classname == Constants.Obj.FullClassname.User {
            return "/v5"
        }
        else {
            return "/v1"
        }
    }
    
    static func FetchObject(classname: String) -> String {
        if classname == Constants.Obj.Classname.Item || classname == Constants.Obj.FullClassname.Item {
            return "/v5"
        }
        else if classname == Constants.Obj.Classname.User || classname == Constants.Obj.FullClassname.User {
            return "/v5"
        }
        else {
            return "/v1"
        }
    }
    
    static func SaveObject(classname: String) -> String {
        if classname == Constants.Obj.Classname.User || classname == Constants.Obj.FullClassname.User {
            return "/v5"
        }
        else {
            return "/v1"
        }
    }

}
````