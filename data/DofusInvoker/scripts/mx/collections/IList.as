package mx.collections
{
   import flash.events.IEventDispatcher;
   
   [Event(name="collectionChange",type="mx.events.CollectionEvent")]
   public interface IList extends IEventDispatcher
   {
       
      
      function get length() : int;
      
      function addItem(param1:Object) : void;
      
      function addItemAt(param1:Object, param2:int) : void;
      
      function getItemAt(param1:int, param2:int = 0) : Object;
      
      function getItemIndex(param1:Object) : int;
      
      function itemUpdated(param1:Object, param2:Object = null, param3:Object = null, param4:Object = null) : void;
      
      function removeAll() : void;
      
      function removeItemAt(param1:int) : Object;
      
      function setItemAt(param1:Object, param2:int) : Object;
      
      function toArray() : Array;
   }
}
