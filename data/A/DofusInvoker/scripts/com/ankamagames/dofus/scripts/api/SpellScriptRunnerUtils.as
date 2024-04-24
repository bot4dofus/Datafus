package com.ankamagames.dofus.scripts.api
{
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObject;
   import flash.utils.getQualifiedClassName;
   
   public class SpellScriptRunnerUtils
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpellScriptRunnerUtils));
      
      private static const HIGHEST_GFX_ENTITY_ID:int = 10000;
       
      
      public function SpellScriptRunnerUtils()
      {
         super();
      }
      
      public static function GetAngleTo(fromPoint:MapPoint, toPoint:MapPoint) : Number
      {
         var ac:int = CellUtil.getPixelXFromMapPoint(toPoint) - CellUtil.getPixelXFromMapPoint(fromPoint);
         var bc:int = CellUtil.getPixelYFromMapPoint(fromPoint) - CellUtil.getPixelYFromMapPoint(toPoint);
         return Math.acos(ac / Math.sqrt(Math.pow(ac,2) + Math.pow(bc,2))) * 180 / Math.PI * (CellUtil.getPixelYFromMapPoint(toPoint) > CellUtil.getPixelYFromMapPoint(fromPoint) ? 1 : -1);
      }
      
      public static function GetEntityCell(entity:IEntity) : MapPoint
      {
         if(entity)
         {
            return entity.position;
         }
         _log.warn("GetEntityCell() is returning a null position, because specified entity is null");
         return null;
      }
      
      public static function IsPositionsEquals(pointOne:MapPoint, pointTwo:MapPoint) : Boolean
      {
         if(!pointOne || !pointTwo)
         {
            return false;
         }
         return pointOne.cellId == pointTwo.cellId;
      }
      
      public static function CreateGfxEntity(gfxId:uint, cell:MapPoint, randomRotationMin:Number = 0, randomRotationMax:Number = 0, randomFlip:Boolean = false, startPlayingOnlyWhenDisplayed:Boolean = true) : IEntity
      {
         var id:int = -HIGHEST_GFX_ENTITY_ID;
         while(DofusEntities.getEntity(id))
         {
            id = -HIGHEST_GFX_ENTITY_ID + Math.random() * HIGHEST_GFX_ENTITY_ID;
         }
         var entity:Projectile = new Projectile(id,TiphonEntityLook.fromString("{" + gfxId + "}"),false);
         entity.position = cell;
         entity.rotation = Math.random() * (randomRotationMax - randomRotationMin) + randomRotationMin;
         if(randomFlip && Math.random() < 0.5)
         {
            entity.scaleX = -1;
         }
         return entity;
      }
      
      public static function SetSubEntity(target:TiphonSprite, subentity:DisplayObject, category:uint, slot:uint) : void
      {
         if(target)
         {
            target.addSubEntity(subentity,category,slot);
         }
      }
   }
}
