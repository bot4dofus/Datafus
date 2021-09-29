package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class HyperlinkShowNpcManager
   {
       
      
      public function HyperlinkShowNpcManager()
      {
         super();
      }
      
      public static function showNpc(npcId:int, loop:int = 0) : MovieClip
      {
         var list:Dictionary = null;
         var entitieInfo:Object = null;
         var sprite:TiphonSprite = null;
         var rect:Rectangle = null;
         var i:uint = 0;
         var c:* = undefined;
         var graphicCell:GraphicCell = null;
         var abstractEntitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(abstractEntitiesFrame)
         {
            list = abstractEntitiesFrame.getEntitiesDictionnary();
            for each(entitieInfo in list)
            {
               if(entitieInfo is GameRolePlayNpcInformations && (entitieInfo.npcId == npcId || npcId == -1))
               {
                  sprite = EntitiesManager.getInstance().getEntity(GameRolePlayNpcInformations(entitieInfo).contextualId) as TiphonSprite;
                  if(sprite)
                  {
                     for(i = 0; i < sprite.numChildren; i++)
                     {
                        c = sprite.getChildAt(i);
                        if(c is ScriptedAnimation)
                        {
                           rect = c.getBounds(StageShareManager.stage);
                           break;
                        }
                     }
                     if(!rect)
                     {
                        rect = sprite.getBounds(StageShareManager.stage);
                     }
                  }
                  else
                  {
                     graphicCell = InteractiveCellManager.getInstance().getCell(entitieInfo.disposition.cellId);
                     rect = new Rectangle(graphicCell.x,graphicCell.y,graphicCell.width,graphicCell.height);
                     rect.y -= 80;
                  }
                  return HyperlinkDisplayArrowManager.showAbsoluteArrow(rect,0,0,1,loop);
               }
            }
         }
         return null;
      }
   }
}
