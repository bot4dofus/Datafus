package mx.managers
{
   import flash.display.DisplayObject;
   
   [ExcludeClass]
   public interface ISystemManagerChildManager
   {
       
      
      function addingChild(param1:DisplayObject) : void;
      
      function childAdded(param1:DisplayObject) : void;
      
      function childRemoved(param1:DisplayObject) : void;
      
      function removingChild(param1:DisplayObject) : void;
      
      function initializeTopLevelWindow(param1:Number, param2:Number) : void;
   }
}
