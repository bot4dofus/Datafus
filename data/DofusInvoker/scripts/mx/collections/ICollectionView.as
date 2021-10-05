package mx.collections
{
   import flash.events.IEventDispatcher;
   
   [Event(name="collectionChange",type="mx.events.CollectionEvent")]
   public interface ICollectionView extends IEventDispatcher
   {
       
      
      function get length() : int;
      
      function get filterFunction() : Function;
      
      function set filterFunction(param1:Function) : void;
      
      function get sort() : ISort;
      
      function set sort(param1:ISort) : void;
      
      function createCursor() : IViewCursor;
      
      function contains(param1:Object) : Boolean;
      
      function disableAutoUpdate() : void;
      
      function enableAutoUpdate() : void;
      
      function itemUpdated(param1:Object, param2:Object = null, param3:Object = null, param4:Object = null) : void;
      
      function refresh() : Boolean;
   }
}
