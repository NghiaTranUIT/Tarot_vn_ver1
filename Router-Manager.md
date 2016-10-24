# Purpose
The main purpose of RouterManager is for handling all common tasks when pushing/dismissing/presenting.   

![Router Manager](https://farm9.staticflickr.com/8566/29683846494_252708e59e_o_d.jpg)

# Classes
+ **RoutePushData**: It's base-class for all routers. It contains a few basic properties and such kind of data that needs to pass between each screen.
+ **RouterManager**: It gets RouterPushData and determines which screen needs to be shown or presented. We don't need to know rootNavigationController or rootController or initializing viewController from xib/storyboard . Just pass RoutePushData and it's done.
  
RouterManager also implement a few helper classes, such as ***screenshotForVisibleController***, ***isViewInVisibleControllerWithView***, ***_visibleController***,....

# How to use
1. Subclass RoutePushData
2. Store object or any information which you need to pass to screen
3. Define behavior: Push or present, how to get data,...
4. Call RouterManager.shared.pushToControllelWithData(_yourData)
5. Done