package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class RandomDropGroup implements IDataCenter
   {
      
      public static const MODULE:String = "RandomDropGroups";
       
      
      public var id:uint;
      
      public var name:String;
      
      public var description:String;
      
      public var randomDropItems:Vector.<RandomDropItem>;
      
      public var displayContent:Boolean;
      
      public var displayChances:Boolean;
      
      private var _groupWeight:uint;
      
      public function RandomDropGroup()
      {
         super();
      }
      
      public static function getRandomDropGroupById(id:int) : RandomDropGroup
      {
         return GameData.getObject(MODULE,id) as RandomDropGroup;
      }
      
      public static function getAllRandomDropGroup() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get groupWeight() : uint
      {
         var item:RandomDropItem = null;
         this._groupWeight = 0;
         for each(item in this.randomDropItems)
         {
            this._groupWeight += item.probability;
         }
         return this._groupWeight;
      }
   }
}
