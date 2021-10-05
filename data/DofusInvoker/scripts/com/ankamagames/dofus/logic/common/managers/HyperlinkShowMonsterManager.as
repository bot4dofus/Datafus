package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class HyperlinkShowMonsterManager
   {
       
      
      public function HyperlinkShowMonsterManager()
      {
         super();
      }
      
      public static function showMonster(monsterId:int, loop:int = 0) : Sprite
      {
         var monsterEntity:AnimatedCharacter = null;
         var graphicCell:GraphicCell = null;
         var rect:Rectangle = null;
         var list:Dictionary = null;
         var monster:Object = null;
         var roleplayEntitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(roleplayEntitiesFrame)
         {
            list = roleplayEntitiesFrame.getEntitiesDictionnary();
            for each(monster in list)
            {
               if(monster is GameRolePlayGroupMonsterInformations && (monster.staticInfos.mainCreatureLightInfos.genericId == monsterId || monsterId == -1))
               {
                  monsterEntity = DofusEntities.getEntity(GameRolePlayGroupMonsterInformations(monster).contextualId) as AnimatedCharacter;
                  if(monsterEntity && monsterEntity.stage)
                  {
                     graphicCell = InteractiveCellManager.getInstance().getCell(monsterEntity.position.cellId);
                     rect = new Rectangle(graphicCell.x + AtouinConstants.CELL_HALF_WIDTH,graphicCell.y + AtouinConstants.CELL_HALF_HEIGHT - 80,0,0);
                     return HyperlinkDisplayArrowManager.showAbsoluteArrow(rect,0,0,1,loop);
                  }
                  return null;
               }
               if(monster is GameFightMonsterInformations && (monster.creatureGenericId == monsterId || monsterId == -1))
               {
                  monsterEntity = DofusEntities.getEntity(GameFightMonsterInformations(monster).contextualId) as AnimatedCharacter;
                  if(monsterEntity && monsterEntity.stage)
                  {
                     graphicCell = InteractiveCellManager.getInstance().getCell(monsterEntity.position.cellId);
                     rect = new Rectangle(graphicCell.x + AtouinConstants.CELL_HALF_WIDTH,graphicCell.y + AtouinConstants.CELL_HALF_HEIGHT - 80,0,0);
                     return HyperlinkDisplayArrowManager.showAbsoluteArrow(rect,0,0,1,loop);
                  }
                  return null;
               }
            }
         }
         return null;
      }
      
      public static function getMonsterName(monsterId:uint) : String
      {
         var m:Monster = Monster.getMonsterById(monsterId);
         if(m)
         {
            return m.name;
         }
         return "[null]";
      }
   }
}
