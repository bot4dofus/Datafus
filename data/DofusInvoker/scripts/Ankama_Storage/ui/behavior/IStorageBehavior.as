package Ankama_Storage.ui.behavior
{
   import Ankama_Storage.ui.AbstractStorageUi;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   
   public interface IStorageBehavior
   {
       
      
      function dropValidator(param1:Object, param2:Object, param3:Object) : Boolean;
      
      function processDrop(param1:Object, param2:Object, param3:Object) : void;
      
      function attach(param1:AbstractStorageUi) : void;
      
      function detach() : void;
      
      function filterStatus(param1:Boolean) : void;
      
      function onRelease(param1:GraphicContainer) : void;
      
      function onSelectItem(param1:GraphicContainer, param2:uint, param3:Boolean) : void;
      
      function transfertAll() : void;
      
      function transfertList() : void;
      
      function transfertExisting() : void;
      
      function onUnload() : void;
      
      function getStorageUiName() : String;
      
      function getName() : String;
      
      function get replacable() : Boolean;
      
      function doubleClickGridItem(param1:Object) : void;
   }
}
