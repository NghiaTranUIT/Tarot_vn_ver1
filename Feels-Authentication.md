# Purpose 
Describe how feels-app authenticates with feels-server.
The important things is we mainly reuse all logic, classes from [SocialAuthentication](https://github.com/feels/feels-v3-ios/wiki/Social-Authentication).  
So, please take a look at **SocialAuthentication** first before reading.  
  
The difference part is we need to provide some methods to convert into CurrentUser. Also handle few additional case, such as Store to disk, encrypt, decrypt ([DiskManager](https://github.com/feels/feels-v3-ios/wiki/Disk-Caching-Manager)), forget password, validate password for sign-up,....

# Architecture
![Feels Authentication](https://farm9.staticflickr.com/8140/29746554833_329ae05932_o_d.jpg)

# Classes
+ **FeelsAuthentication**: We reused all parts from [SocialAuthentication](https://github.com/feels/feels-v3-ios/wiki/Social-Authentication). After sign-up, sign-in, we use **DiskManager** to store into Disk, also convert it into singleton CurrentUser.  
We also implements helper methods for: ForgetPass, ValidateEmail, ValidatePassword, ...

