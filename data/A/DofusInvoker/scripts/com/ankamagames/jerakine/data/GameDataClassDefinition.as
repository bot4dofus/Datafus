package com.ankamagames.jerakine.data
{
   import flash.utils.IDataInput;
   import flash.utils.getDefinitionByName;
   
   public class GameDataClassDefinition
   {
       
      
      private var _class:Class;
      
      private var _fields:Vector.<GameDataField>;
      
      public function GameDataClassDefinition(packageName:String, className:String)
      {
         super();
         this._class = getDefinitionByName(packageName + "." + className) as Class;
         this._fields = new Vector.<GameDataField>();
      }
      
      public function get fields() : Vector.<GameDataField>
      {
         return this._fields;
      }
      
      public function read(module:String, stream:IDataInput) : *
      {
         var field:GameDataField = null;
         var inst:* = new this._class();
         for each(field in this._fields)
         {
            inst[field.name] = field.readData(module,stream);
         }
         if(inst is IPostInit)
         {
            IPostInit(inst).postInit();
         }
         return inst;
      }
      
      public function addField(fieldName:String, stream:IDataInput) : void
      {
         var field:GameDataField = new GameDataField(fieldName);
         field.readType(stream);
         this._fields.push(field);
      }
   }
}
