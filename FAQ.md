**1. Does feels-iOS-v3 support Swift 3.0 ?**  
+ Currently, feels-iOS-v3 doesn't support Swift 3.0.  
  
**2. Which minimum iOS version will it work ?**  
+ **>= 8.0**

**3. Does it support iPAD ?**  
+ We haven't supported iPAD version yet. But It still be able on iPAD too.  
  
**4. How can I extend a request-endpoint ?**  
- Please take a look at [Networking](https://github.com/feels/feels-v3-ios/wiki/Networking) in Wiki.
- Basically, we just need to subclass BaseOperation and provide new endpoint, param and it's done. 
  
**5. How can I add new socials (authentication and fetch @me)?**  
+ We have already described carefully the step-by-step instructions in [Authentication](https://github.com/feels/feels-v3-ios/wiki/Authentication) section.  
  
***Here is the quick answer*** 
+ Subclass BaseAuthentication  
+ Override 3 methods: **authenticateWithCompletion**, **fetchUserInfoForSignUp**  
+ Subclass BaseSocialClient and override **authenticateWithCompletion**, **requestMeCompletionForAuthData**  
+ Using OauthWebviewController to support Oauth with your social accounts.  

**6. Why don't we use Storyboard for all screens ?**  
+ Yeah, we know we can use Storyboard for all screens. But it has a big disadvantage here. Feels app supports pushing directly to different screens. So it means more work to be implemented if we use Storyboard.
+ Storyboard costs more CPU capacity to render and decode XML.
+ So, **less code, less bug**, XIB for each screen is our best solution for now.

**7. Any secret things we need to know ?**  
+ We're using [PSPDFUIKitMainThreadGuard.m](https://gist.github.com/steipete/5664345) to notify if any UI code is being executed in the background.