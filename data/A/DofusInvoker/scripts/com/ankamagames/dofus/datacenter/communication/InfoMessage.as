package com.ankamagames.dofus.datacenter.communication
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class InfoMessage implements IDataCenter
   {
      
      public static const MODULE:String = "InfoMessages";
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(InfoMessage));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getInfoMessageById,getInfoMessages);
       
      
      public var typeId:uint;
      
      public var messageId:uint;
      
      public var textId:uint;
      
      private var _text:String;
      
      public function InfoMessage()
      {
         super();
      }
      
      public static function getInfoMessageById(id:uint) : InfoMessage
      {
         return GameData.getObject(MODULE,id) as InfoMessage;
      }
      
      public static function getInfoMessages() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get text() : String
      {
         if(!this._text)
         {
            this._text = I18n.getText(this.textId);
         }
         return this._text;
      }
   }
}
