package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.messages.Frame;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class HyperlinkShowEntityManager
   {
       
      
      public function HyperlinkShowEntityManager()
      {
         super();
      }
      
      public static function showEntity(entityId:Number, showCell:int = 0) : Sprite
      {
         var rect:Rectangle = null;
         var entity:DisplayObject = DofusEntities.getEntity(entityId) as DisplayObject;
         if(entity)
         {
            if(showCell)
            {
               HyperlinkShowCellManager.showCell((entity as IEntity).position.cellId);
               return null;
            }
            rect = entity.getRect(Berilia.getInstance().docMain);
            return HyperlinkDisplayArrowManager.showAbsoluteArrow(new Rectangle(int(rect.x),int(rect.y),0,0));
         }
         return null;
      }
      
      public static function getEntityName(entityId:Number, showCell:int = 0) : String
      {
         var frame:Frame = Kernel.getWorker().getFrame(FightContextFrame);
         if(!frame)
         {
            return "???";
         }
         return (frame as FightContextFrame).getFighterName(entityId);
      }
      
      public static function rollOver(pX:int, pY:int, entityId:Number, showCell:int = 0) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.whereAreYou"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
