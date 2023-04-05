package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayCharacterInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class MapCharactersItemCriterion extends ItemCriterion implements IDataCenter
   {
       
      
      private var _mapId:Number;
      
      private var _nbCharacters:uint;
      
      public function MapCharactersItemCriterion(pCriterion:String)
      {
         super(pCriterion);
         var params:Array = _criterionValueText.split(",");
         if(params.length == 1)
         {
            this._mapId = PlayedCharacterManager.getInstance().currentMap.mapId;
            this._nbCharacters = uint(params[0]);
         }
         else if(params.length == 2)
         {
            this._mapId = Number(params[0]);
            this._nbCharacters = uint(params[1]);
         }
      }
      
      override public function get text() : String
      {
         var readableCriterionRef:String = I18n.getUiText("ui.criterion.MK",[this._mapId]);
         return readableCriterionRef + " " + _operator.text + " " + this._nbCharacters;
      }
      
      override public function clone() : IItemCriterion
      {
         return new MapCharactersItemCriterion(this.basicText);
      }
      
      override protected function getCriterion() : int
      {
         var nbCharacters:int = 0;
         var entitiesInfos:Dictionary = null;
         var actorInfo:GameContextActorInformations = null;
         var entitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(entitiesFrame)
         {
            entitiesInfos = entitiesFrame.entities;
            for each(actorInfo in entitiesInfos)
            {
               if(actorInfo is GameRolePlayCharacterInformations)
               {
                  nbCharacters++;
               }
            }
         }
         return nbCharacters;
      }
   }
}
