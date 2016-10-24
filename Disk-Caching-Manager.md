# Purpose
**Disk Caching Manager** is a singleton manager class. It helps to handle all functionalities with disk, such as saving/reading/encrypting data of CurrentUser and Installation.

![DiskManager](https://farm6.staticflickr.com/5337/30227308971_cfeb4aef5c_o_d.jpg)
  
# Write to disk
    
    private func saveToFile<N: BaseModel>(object: N, type: FileType)   
     
***saveToFile*** profile methods to write ***BaseModel*** into disk.  
It automatically encrypt, decode ***BaseModel*** to ***JSON***.
  
# Read file
    
    private func loadModelFromFileWithType<N: Mappable>(type: FileType) -> N?{}    
    
***loadModelFromFileWithType*** profile methods to read JSON from disk. It includes decoding, decrypting and parsing to BaseModel easily.  
**loadModelFromFileWithType** need to provide generic class.