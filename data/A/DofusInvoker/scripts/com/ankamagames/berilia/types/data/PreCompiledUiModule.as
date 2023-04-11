package com.ankamagames.berilia.types.data
{
   import com.ankamagames.berilia.types.uiDefinition.UiDefinition;
   import com.ankamagames.jerakine.interfaces.IModuleUtil;
   import flash.net.ObjectEncoding;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class PreCompiledUiModule extends UiModule implements IModuleUtil
   {
      
      private static const HEADER_STR:String = "D2UI";
       
      
      private var _uiListPosition:Dictionary;
      
      private var _definitionCount:uint;
      
      private var _uiListStartPosition:uint;
      
      private var _output:ByteArray;
      
      private var _uiBuffer:ByteArray;
      
      private var _input:ByteArray;
      
      private var _cacheDefinition:Dictionary;
      
      public function PreCompiledUiModule()
      {
         super();
      }
      
      public static function fromRaw(input:IDataInput, nativePath:String, id:String) : PreCompiledUiModule
      {
         var instance:PreCompiledUiModule = new PreCompiledUiModule();
         var localInput:ByteArray = new ByteArray();
         instance._input = localInput;
         input.readBytes(localInput);
         localInput.position = 0;
         var headerStr:String = localInput.readUTF();
         if(headerStr != HEADER_STR)
         {
            throw new Error("Malformated ui data file.");
         }
         instance.fillFromXml(new XML(localInput.readUTF()),nativePath,id);
         instance._definitionCount = localInput.readShort();
         instance._uiListPosition = new Dictionary();
         instance._cacheDefinition = new Dictionary();
         for(var i:uint = 0; i < instance._definitionCount; i++)
         {
            instance._uiListPosition[localInput.readUTF()] = localInput.readInt();
         }
         return instance;
      }
      
      public static function create(uiModule:UiModule) : PreCompiledUiModule
      {
         var newInstance:PreCompiledUiModule = new PreCompiledUiModule();
         newInstance.initWriteMode();
         newInstance.makeHeader(uiModule);
         return newInstance;
      }
      
      public function hasDefinition(ui:UiData) : Boolean
      {
         return this._uiListPosition[ui.name] != null;
      }
      
      public function getDefinition(ui:UiData) : UiDefinition
      {
         if(this.hasDefinition(ui))
         {
            if(this._cacheDefinition[ui.name])
            {
               return this._cacheDefinition[ui.name];
            }
            return this.readUidefinition(ui.name);
         }
         return null;
      }
      
      public function addUiDefinition(definition:UiDefinition, ui:UiData) : void
      {
         if(!this._output)
         {
            throw new Error("Call method \'create\' before using this method");
         }
         this.writeUiDefinition(definition,ui);
      }
      
      public function flush(output:IDataOutput) : void
      {
         var uiId:* = null;
         if(!this._output)
         {
            throw new Error("Call method \'create\' before using this method");
         }
         this._output.position = this._uiListStartPosition;
         this._output.writeShort(this._definitionCount);
         output.writeBytes(this._output);
         this._output.position = this._output.length;
         var listBuffer:ByteArray = new ByteArray();
         for(uiId in this._uiListPosition)
         {
            listBuffer.writeUTF(uiId);
            listBuffer.writeInt(0);
         }
         listBuffer.position = 0;
         for(uiId in this._uiListPosition)
         {
            listBuffer.readUTF();
            listBuffer.writeInt(this._uiListPosition[uiId] + this._output.length + listBuffer.length);
         }
         output.writeBytes(listBuffer);
         output.writeBytes(this._uiBuffer);
      }
      
      private function initWriteMode() : void
      {
         this._output = new ByteArray();
         this._uiBuffer = new ByteArray();
         this._uiListPosition = new Dictionary();
         this._uiBuffer.objectEncoding = ObjectEncoding.AMF3;
      }
      
      private function makeHeader(uiModule:UiModule) : void
      {
         this._output.writeUTF("D2UI");
         this._output.writeUTF(uiModule.rawXml.toXMLString());
         this._uiListStartPosition = this._output.position;
         this._output.writeShort(0);
      }
      
      private function readUidefinition(id:String) : UiDefinition
      {
         this._input.objectEncoding = ObjectEncoding.AMF3;
         this._input.position = this._uiListPosition[id];
         return this._input.readObject();
      }
      
      private function writeUiDefinition(definition:UiDefinition, ui:UiData) : void
      {
         ++this._definitionCount;
         this._uiListPosition[ui.name] = this._uiBuffer.position;
         this._uiBuffer.objectEncoding = ObjectEncoding.AMF3;
         this._uiBuffer.writeObject(definition);
      }
   }
}
