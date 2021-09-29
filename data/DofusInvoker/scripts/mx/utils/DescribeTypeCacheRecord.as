package mx.utils
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   [ExcludeClass]
   public dynamic class DescribeTypeCacheRecord extends Proxy
   {
       
      
      private var cache:Object;
      
      public var typeDescription:XML;
      
      public var typeName:String;
      
      public function DescribeTypeCacheRecord()
      {
         this.cache = {};
         super();
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var result:* = this.cache[name];
         if(result === undefined)
         {
            result = DescribeTypeCache.extractValue(name,this);
            this.cache[name] = result;
         }
         return result;
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         if(name in this.cache)
         {
            return true;
         }
         var value:* = DescribeTypeCache.extractValue(name,this);
         if(value === undefined)
         {
            return false;
         }
         this.cache[name] = value;
         return true;
      }
   }
}
