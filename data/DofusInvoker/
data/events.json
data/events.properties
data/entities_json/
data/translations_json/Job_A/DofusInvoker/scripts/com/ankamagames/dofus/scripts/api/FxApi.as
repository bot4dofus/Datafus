package com.ankamagames.dofus.scripts.api
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.scripts.FxRunner;
   import com.ankamagames.dofus.scripts.SpellFxRunner;
   import com.ankamagames.dofus.types.entities.ParticuleEmitterEntity;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.dofus.types.entities.TailEntity;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObject;
   import flash.utils.getQualifiedClassName;
   
   public class FxApi
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FxApi));
      
      public static const ANIMEVENT_SHOT:String = TiphonEvent.ANIMATION_SHOT;
       
      
      public function FxApi()
      {
         super();
      }
      
      public static function GetCurrentTargetedCell(runner:FxRunner) : MapPoint
      {
         return runner.target;
      }
      
      public static function GetCurrentCaster(runner:SpellFxRunner) : IEntity
      {
         return runner.caster;
      }
      
      public static function IsCasterPlayer(runner:SpellFxRunner) : Boolean
      {
         return runner.caster.id == PlayedCharacterManager.getInstance().id;
      }
      
      public static function GetOrientationTo(fromPoint:MapPoint, toPoint:MapPoint, use4Dir:Boolean = true) : uint
      {
         return fromPoint.advancedOrientationTo(toPoint,use4Dir);
      }
      
      public static function GetAngleTo(fromPoint:MapPoint, toPoint:MapPoint) : Number
      {
         var ac:int = CellUtil.getPixelXFromMapPoint(toPoint) - CellUtil.getPixelXFromMapPoint(fromPoint);
         var bc:int = CellUtil.getPixelYFromMapPoint(fromPoint) - CellUtil.getPixelYFromMapPoint(toPoint);
         return Math.acos(ac / Math.sqrt(Math.pow(ac,2) + Math.pow(bc,2))) * 180 / Math.PI * (CellUtil.getPixelYFromMapPoint(toPoint) > CellUtil.getPixelYFromMapPoint(fromPoint) ? 1 : -1);
      }
      
      public static function SetGfxRotation(gfx:DisplayObject, angle:Number) : void
      {
         gfx.rotation = angle;
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
      
      public static function GetEntityOnCell(point:MapPoint) : IEntity
      {
         return Atouin.getInstance().getEntityOnCell(point.cellId);
      }
      
      public static function GetEntityId(entity:IEntity) : int
      {
         return entity.id;
      }
      
      public static function GetEntityPosition(entity:IEntity) : MapPoint
      {
         return entity.position;
      }
      
      public static function CreateGfxEntity(gfxId:uint, cell:MapPoint, randomRotationMin:Number = 0, randomRotationMax:Number = 0, randomFlip:Boolean = false, startPlayingOnlyWhenDisplayed:Boolean = true) : IEntity
      {
         var id:int = -10000;
         while(DofusEntities.getEntity(id))
         {
            id = -10000 + Math.random() * 10000;
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
      
      public static function CreateTailEntity() : TailEntity
      {
         return new TailEntity();
      }
      
      public static function SetEntityAnimation(target:TiphonSprite, animName:String) : void
      {
         target.setAnimation(animName);
      }
      
      public static function SetSubEntity(target:TiphonSprite, subentity:DisplayObject, category:uint, slot:uint) : void
      {
         if(target)
         {
            target.addSubEntity(subentity,category,slot);
         }
      }
      
      public static function CreateParticlesEntity(rendererType:uint) : ParticuleEmitterEntity
      {
         var id:int = -10000;
         while(DofusEntities.getEntity(id))
         {
            id = -10000 + Math.random() * 10000;
         }
         return new ParticuleEmitterEntity(id,rendererType);
      }
   }
}
