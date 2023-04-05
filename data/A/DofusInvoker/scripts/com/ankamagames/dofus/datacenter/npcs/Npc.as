package com.ankamagames.dofus.datacenter.npcs
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class Npc implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Npc));
      
      public static const MODULE:String = "Npcs";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getNpcById,getNpcs);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var dialogMessages:Vector.<Vector.<int>>;
      
      public var dialogReplies:Vector.<Vector.<int>>;
      
      public var actions:Vector.<uint>;
      
      public var gender:uint;
      
      public var look:String;
      
      public var tokenShop:int;
      
      public var animFunList:Vector.<AnimFunNpcData>;
      
      public var fastAnimsFun:Boolean;
      
      public var tooltipVisible:Boolean;
      
      private var _name:String;
      
      public function Npc()
      {
         super();
      }
      
      public static function getNpcById(id:int) : Npc
      {
         return GameData.getObject(MODULE,id) as Npc;
      }
      
      public static function getNpcs() : Array
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
