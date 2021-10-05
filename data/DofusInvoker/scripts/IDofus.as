package
{
   import com.ankamagames.berilia.interfaces.IApplicationContainer;
   import com.ankamagames.dofus.types.DofusOptions;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.display.Stage;
   import flash.utils.ByteArray;
   
   public interface IDofus extends IApplicationContainer
   {
       
      
      function getRawSignatureData() : ByteArray;
      
      function getUiContainer() : DisplayObjectContainer;
      
      function get useMiniLoader() : Boolean;
      
      function get initialized() : Boolean;
      
      function getWorldContainer() : DisplayObjectContainer;
      
      function get options() : DofusOptions;
      
      function get instanceId() : uint;
      
      function get forcedLang() : String;
      
      function setDisplayOptions(param1:DofusOptions) : void;
      
      function init(param1:DisplayObject, param2:uint = 0, param3:String = null, param4:Array = null) : void;
      
      function quit(param1:int = 0) : void;
      
      function clearCache(param1:Boolean = false, param2:Boolean = false) : void;
      
      function reboot() : void;
      
      function renameApp(param1:String) : void;
      
      function get rootContainer() : DisplayObjectContainer;
      
      function get loaderInfo() : LoaderInfo;
      
      function addChild(param1:DisplayObject) : DisplayObject;
      
      function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void;
      
      function get stage() : Stage;
   }
}
