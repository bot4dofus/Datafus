package com.ankamagames.dofus.types.entities
{
   import flash.display.DisplayObject;
   
   public class BasicParticle implements IParticule
   {
       
      
      protected var _sprite:DisplayObject;
      
      protected var _life:uint;
      
      protected var _subExplosion:Boolean;
      
      protected var _initialLife:uint;
      
      protected var _deathDispatched:Boolean;
      
      protected var _deathCallback:Function;
      
      public function BasicParticle(sprite:DisplayObject, life:uint, subExplosion:Boolean, deathCallback:Function)
      {
         super();
         this._sprite = sprite;
         this._life = this._initialLife = life;
         this._subExplosion = subExplosion;
         this._deathCallback = deathCallback;
      }
      
      public function update() : void
      {
         var explode:Boolean = false;
         var prcLife:Number = this._life / this._initialLife;
         if(this._subExplosion && Math.random() > prcLife)
         {
            explode = true;
         }
         if((!this._life || explode) && !this._deathDispatched)
         {
            this._deathCallback(this,explode);
         }
         this._sprite.alpha = prcLife > 1 / 2 ? Number(1) : Number(prcLife * 2);
         if(this._life)
         {
            --this._life;
         }
      }
      
      public function get sprite() : DisplayObject
      {
         return this._sprite;
      }
      
      public function get life() : uint
      {
         return this._life;
      }
      
      public function get subExplosion() : Boolean
      {
         return this._subExplosion;
      }
      
      public function set subExplosion(v:Boolean) : void
      {
         this._subExplosion = v;
      }
   }
}
