package com.ankamagames.dofus.datacenter.communication
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class ChatChannel implements IDataCenter
   {
      
      public static const MODULE:String = "ChatChannels";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ChatChannel));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getChannelById,getChannels);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var descriptionId:uint;
      
      public var shortcut:String;
      
      public var shortcutKey:String;
      
      public var isPrivate:Boolean;
      
      public var allowObjects:Boolean;
      
      private var _name:String;
      
      public function ChatChannel()
      {
         super();
      }
      
      public static function getChannelById(id:int) : ChatChannel
      {
         return GameData.getObject(MODULE,id) as ChatChannel;
      }
      
      public static function getChannels() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
