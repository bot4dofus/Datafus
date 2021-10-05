package mx.messaging.config
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import mx.utils.object_proxy;
   
   use namespace object_proxy;
   
   public dynamic class ConfigMap extends Proxy
   {
       
      
      object_proxy var propertyList:Array;
      
      private var _item:Object;
      
      public function ConfigMap(item:Object = null)
      {
         super();
         if(!item)
         {
            item = {};
         }
         this._item = item;
         this.propertyList = [];
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var result:Object = null;
         return this._item[name];
      }
      
      override flash_proxy function callProperty(name:*, ... rest) : *
      {
         return this._item[name].apply(this._item,rest);
      }
      
      override flash_proxy function deleteProperty(name:*) : Boolean
      {
         var oldVal:Object = this._item[name];
         var deleted:* = delete this._item[name];
         var deleteIndex:int = -1;
         for(var i:int = 0; i < this.propertyList.length; i++)
         {
            if(this.propertyList[i] == name)
            {
               deleteIndex = i;
               break;
            }
         }
         if(deleteIndex > -1)
         {
            this.propertyList.splice(deleteIndex,1);
         }
         return deleted;
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         return name in this._item;
      }
      
      override flash_proxy function nextName(index:int) : String
      {
         return this.propertyList[index - 1];
      }
      
      override flash_proxy function nextNameIndex(index:int) : int
      {
         if(index < this.propertyList.length)
         {
            return index + 1;
         }
         return 0;
      }
      
      override flash_proxy function nextValue(index:int) : *
      {
         return this._item[this.propertyList[index - 1]];
      }
      
      override flash_proxy function setProperty(name:*, value:*) : void
      {
         var i:int = 0;
         var oldVal:* = this._item[name];
         if(oldVal !== value)
         {
            this._item[name] = value;
            for(i = 0; i < this.propertyList.length; i++)
            {
               if(this.propertyList[i] == name)
               {
                  return;
               }
            }
            this.propertyList.push(name);
         }
      }
   }
}
