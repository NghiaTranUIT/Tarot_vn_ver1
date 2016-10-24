# Problem
When working at feels-v2 and feels-v3. We're facing the problem of how to make data consistent in all screens with as little cost performance as possible.  
  
We have tried many solutions, such as pushing notifications when data changes, updating visible screen, or reloading data. But all these old-fashioned solutions hit CPU too much as well as cost a lot of time for maintenance.
  
# Solution

![Caching](https://farm9.staticflickr.com/8139/29666910634_0711aacf85_o_d.jpg)
  
+ After fetching data, All model data must be sent to memory-cache through CachingManager.  
+ Only get data from caching, by using KVO-helper.  
+ Automatically handles the removal of KVO out of object carefully.  
+ Support minion checker to the store and expire caching correctly.  
+ Automatically release all KVO-Observe when receiving memory warning.  
  
# Classes
+ **BaseCachingObj** is base-class. It holds important data such as objectId, updateAt, createdAt,...  
It also supports method for caching on background.  
+ UserCaching, ItemCaching is a sub-class of BaseCachingObj. It contains observable information.
+ CachingManager is manager class which helps to store and process data before saving it to memory. It also handles expiration time and validates data before processing.  
  
# How to use 
````
// Like Count
let itemCache: ItemCachingObj = CachingManager.shareInstance.cachingObjWithObjModel(itemObj) as! ItemCachingObj
    KVO._observeNormalObj(itemCache, keyPath: "likeCount", block: {[weak self] (_, _, value) in
                
    guard let `self` = self else {return}
                
    guard let value = value as? Int else {
        self.likeCountLbl.text = String(value)
            return
        }
                
        self.likeCountLbl.text = "0"
    })
````
  
# Advantages
+ By using KVO to observe specific kind of data in individual model, we don't need to reload the whole tableView or CollectionView. Neither do we need to reload when viewController appears.  
+ KVO will notify and update new data in each label. Reduce hit CPU-performance.
+ Automatically remove observer.  
  
# Disadvantages
+ Swift doesn't fully support KVO. So currently, we're using some tricks to make it work.  
+ Using `dynamic` and BoolState (Bool)