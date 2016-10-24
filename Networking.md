# Purpose
It's an architecture used for networking.
We don't use Grand Dispatch Central directly in Feels app.  
We're using BaseOperation and those subclasses to take all advantage of **NSOperation** in high level.  
One important feature is **cancelable**, **retry**, **subclass-able**, **dependency**.  

![Networking model](https://farm6.staticflickr.com/5769/30261401166_98ae80d0cc_o_d.jpg).

# 3rd parties  
We're using Alamofire as 3rd party.
  
# Classes  
+ **BaseOperation** is base-class. All network requests must be subclass BaseOperation, with param and endpoint.
BaseOperation is subclassing from NSOperation so it takes all advantage of such as Cancel Operation, Async, Dependency operation,...  
It also handles all alamofire inside.  
We don't need to work directly with alamofire. BaseOperation can handle all, inlcluding JSON parser, validate, logger and decode json to object-model  

+ **QueueManager** is queue manager. All operation will execute and run on specific queue which has been previously defined.
QueueManager also supports execution of a chain of operations too.  
The important reason of why we use QueueManager is that we can know for certain which operation is running, has finished, or failed and from that we can re-try operating if the internet goes down / re-try if it hits 500-error server code and can automatically retry all operation in queue if internet goes up.  

+ **UIUpdateOperation** is a helper operation which wraps CompletionBlock and executes on main thread.  
  
+ **Subclasses from BaseOperation**: Each subclass represents each individual endpoint. It provides param and URL.
  
# How to use  
Example: We implemented fetch for all collabs.  
1. Create FetchCollabOperation, make sure we subclass BaseOperation.  
2. Override asynchronous: return true if we execute async.  
3. Override func main and provide param and endpoint (via apiRouter from alamofire)
4. Execute operation by using QueueManager.
5. The result is array/dictionary of subclassed of BaseModel (after mapping).