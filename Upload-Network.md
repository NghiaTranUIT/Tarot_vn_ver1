# Upload Network model

![Upload Network Model](https://farm8.staticflickr.com/7463/30261707516_962e963a2a_o_d.jpg)  
  
# Problem
To upload a Youtube video to Feels, we need to process from 3 to 4 operations. We want to get rid of chain-block and the complexity in uploading functionality, therefore, we need a new approach to make things simpler.  

# Solution
We dive the whole uploading progress to each operation. Such as DownloadYoutubeThumbnailOperation, CreateObjectOperation, UploadImageOperation,.....  
We can reuse these parts with ease.  
  
By subclass BaseOperation. We can also gain the ability to add dependency.  

# Classes  
+ **BaseUploadData** is abstract class that holds all information and responses with data.  
**BaseUploadData** also has an important role. It has container model shared between child-operations, allowing them pass to data and communicate easily.  
+ **AvatarUploadData** is subclassing from BaseUploadData. It handles download Image (or choose from library) -> Upload to S3 -> Save to UserObj.  
+ ItemUploadData handles -> Create ItemObject -> Upload image to S3 -> SetComplete -> Call Reload and Completion Block.  
+ ...  

# Example

![a](https://farm6.staticflickr.com/5599/29666320864_bc6fc3e54b_o_d.png)