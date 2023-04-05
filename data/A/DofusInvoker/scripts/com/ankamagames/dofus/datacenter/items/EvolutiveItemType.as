package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class EvolutiveItemType implements IDataCenter
   {
      
      public static const MODULE:String = "EvolutiveItemTypes";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EvolutiveItemType));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getEvolutiveItemTypeById,getEvolutiveItemTypes);
       
      
      public var id:int;
      
      public var maxLevel:uint;
      
      public var experienceBoost:Number;
      
      public var experienceByLevel:Vector.<int>;
      
      public function EvolutiveItemType()
      {
         super();
      }
      
      public static function getEvolutiveItemTypeById(id:uint) : EvolutiveItemType
      {
         return GameData.getObject(MODULE,id) as EvolutiveItemType;
      }
      
      public static function getEvolutiveItemTypes() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function getLevelFromExperiencePoints(experience:int) : int
      {
         for(var i:int = 1; i <= this.maxLevel; )
         {
            if(this.experienceByLevel[i] > experience)
            {
               break;
            }
            i++;
         }
         return i - 1;
      }
      
      public function getMaxExperienceForLevel(level:int) : int
      {
         var experienceForNextLevel:int = this.experienceByLevel[level + 1];
         return experienceForNextLevel - 1;
      }
   }
}
