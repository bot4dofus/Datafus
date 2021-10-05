package mx.collections
{
   import flash.events.IEventDispatcher;
   
   [Event(name="cursorUpdate",type="mx.events.FlexEvent")]
   public interface IViewCursor extends IEventDispatcher
   {
       
      
      [Bindable("cursorUpdate")]
      function get afterLast() : Boolean;
      
      [Bindable("cursorUpdate")]
      function get beforeFirst() : Boolean;
      
      [Bindable("cursorUpdate")]
      function get bookmark() : CursorBookmark;
      
      [Bindable("cursorUpdate")]
      function get current() : Object;
      
      function get view() : ICollectionView;
      
      function findAny(param1:Object) : Boolean;
      
      function findFirst(param1:Object) : Boolean;
      
      function findLast(param1:Object) : Boolean;
      
      function insert(param1:Object) : void;
      
      function moveNext() : Boolean;
      
      function movePrevious() : Boolean;
      
      function remove() : Object;
      
      function seek(param1:CursorBookmark, param2:int = 0, param3:int = 0) : void;
   }
}
