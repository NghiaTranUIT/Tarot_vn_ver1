# Purpose
For mapping JSON <-> Model. We're using [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper), DecoderHelper to handle behind-the-scene.

![JSONModel](https://farm9.staticflickr.com/8580/29689639463_d1545f5740_o_d.jpg)
  
# How it works
1. Response from BaseOperation (such as ListCollabOperation) will be processed
2. Raw JSON will pass into DecoderHelper.
3. Decoder Helper will run recursively into nest structure. Determine which BaseModel should be representation by **c_n** key.
4. While processing, each sub-JSON will map to BaseModel (ObjectMapper).  
The result is Array/Dictionary of subclass of BaseModel.
5. Base Model contains many helper class for saving/fetching/refreshing data from server, or saving to disk (if it's Installation or CurrentUser).  
  
# Classes
+ **BaseModel** is base-class. It contains all logic for model here. Such as
Failable initialization (from swift 2.3): Make sure JSON will be parsed unsuccessfully if missing objectId, c_n, created_at or update_at.  
  
We take advantage of feels-v2. By using the same approach with ParseSDK, each model class will have the ability to save to server by themselves.
  
**saveInBackgroundWithCompletion**: Automatic parse itself to JSON -> POST request to server.  
**refreshInBackgroundWithCompletion**: Refresh itself with up-to-date data from server.
**fetchInBackgroundWithCompletion**: Fetch data from server if needed. We fetch data depending on currentObjectId.
...
  
+ **UserObj**: Contains new property. Override few methods at baseModel. Make sure all data will be stored on disk again after save (for currentUser).
+ **ItemObj**, **CastingObj**, **CommentObj**,..... is subclassing from BaseModel. It provides different properties.
  
# Helper classes
+ **APIClassnameTransform**: An object conforming TransformType protocol. It helps **BaseModel** easily transform from short_class_name (server) to full_class_name (client)
+ **APIDateTransform**: Help BaseModel parses stringDate to NSDate.
+ **JSONDecoder**: It's the copy version of ParseSDK. It receives JSON-Dictionary as input param. Recursive nests object and automatically parses to Model Object by using **c_n**. If there is no **c_n**, it treats that as a normal Dictionary.

# How to use
If we have new model, such as LocationObj, we just need to follow these steps.  
1. Subclass Basemodel.  
2. Define your property.  
3. Override **func mapping(map: Map)**  
4. Get data from server by using subclass of BaseOperation (Network model)  
5. Make sure, your JSON contain ***c_n = location***. BaseOperation will process it, and parse to LocationObj.  
````
override func mapping(map: Map) {
   super.mapping(map)
        
   // Map
   self.lat <- map[Constants.Obj.Location.Lat]
   self.lng <- map[Constants.Obj.Location.Lat]
}
````