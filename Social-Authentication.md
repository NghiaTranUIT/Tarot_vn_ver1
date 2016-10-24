# Purpose
This allows Feels app to connect/authenticate with other social platforms easily.

# Architecture
**BaseAuthentication**
![BaseAuthentication](https://farm9.staticflickr.com/8270/30261111582_91a1778409_o_d.jpg)
  
**BaseSocialClient**
![BaseSocialClient](https://farm6.staticflickr.com/5810/29746136773_8af82f9615_o_d.jpg)
  
# Classes
+ **BaseAuthentication**: is base-class. It provides many useful methods, helps the authentication with different social platforms more easily. Behind-the-scene, **BaseAuthentication** uses OAuthSwift (https://github.com/OAuthSwift/OAuthSwift) as logic-side.  
We need to override **authenticateWithCompletion** -> Use SocialSDKs or provide input for OauthSwift for authentication.  
**fetchUserInfoForSignUp**: Override this methods to provide custom request @me depending on your social platform. Otherwise, each social platform has different approach of authentication, so we also implemented loginInWithCompletion, linkWithCompletion, unlinkWithCompletion too.
+ We also have built-in subclass of **BaseAuthentication**, such as: FacebookAuthentication, TwitterAuthentication, InstagramAuthentication and YoutubeAuthentication.  
+ **BaseSocialClient** is base class. It describes how we can interact with social Oauth via OAuthSwift lib. It provides **authenticateWithCompletion** and **requestMeCompletionForAuthData**. We must pass token, secret, key,... to OauthSwift, and then use it to call authentication and request@me to each server which we provided before.  
+ Besides, we have built-in classes, such as InstagramClient, TwitterClient,....
+ **AuthenticationManager**: It can perform wrapper-class on all things we implemented before.

# How to extend to new social platforms
1. Subclass **BaseSocialClient**. Override **authenticateWithCompletion** and provide token, secret,... and describe how we can authenticate with new social platform.
2. Override **requestMeCompletionForAuthData** and fetch @me info. We can make request separately or through OauthSwift.
3. Subclass **BaseAuthentication**, override those required methods. Reuse your SocialClient in step 1.
4. Use AuthenticationManager to call for authentication.