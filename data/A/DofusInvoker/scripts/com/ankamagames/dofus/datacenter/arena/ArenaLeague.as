package com.ankamagames.dofus.datacenter.arena
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ArenaLeague implements IDataCenter
   {
      
      public static const MODULE:String = "ArenaLeagues";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getArenaLeagueById,getArenaLeagues);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      public var ornamentId:uint;
      
      public var icon:String;
      
      public var illus:String;
      
      public var isLastLeague:Boolean;
      
      private var _name:String;
      
      private var _iconWithExtension:String;
      
      public function ArenaLeague()
      {
         super();
      }
      
      public static function getArenaLeagueById(id:int) : ArenaLeague
      {
         return GameData.getObject(MODULE,id) as ArenaLeague;
      }
      
      public static function getArenaLeagues() : Array
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
      
      public function get iconWithExtension() : String
      {
         if(!this._iconWithExtension)
         {
            this._iconWithExtension = this.icon + ".png";
         }
         return this._iconWithExtension;
      }
   }
}
