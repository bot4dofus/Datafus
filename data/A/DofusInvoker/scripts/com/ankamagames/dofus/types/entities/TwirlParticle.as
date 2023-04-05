package com.ankamagames.dofus.types.entities
{
   import flash.display.DisplayObject;
   
   public class TwirlParticle extends BasicParticle
   {
       
      
      private var vyi:Number;
      
      private var x:Number;
      
      private var y:Number;
      
      private var g:Number = 5.81;
      
      private var halfg:Number;
      
      private var t:Number = 0;
      
      private var vx:Number = 0;
      
      private var vy:Number = 0;
      
      private var speed:Number;
      
      private var _rotationDir:int;
      
      private var _rotationOffset:Number;
      
      private var _rotationRayon:Number;
      
      private var _startX:Number;
      
      private var _startY:Number;
      
      private var _yLimitTop:Number;
      
      public function TwirlParticle(sprite:DisplayObject, life:uint, subExplosion:Boolean, deathCallback:Function, yLimitTop:int, maxRotationRay:uint = 10)
      {
         this.halfg = this.g / 2;
         super(sprite,life,subExplosion,deathCallback);
         var speed:Number = 0.1;
         this.speed = speed * 3 / 4 + speed * Math.random() / 2;
         _sprite.scaleX = _sprite.scaleY = Math.random() * 0.5 + 0.5;
         var angle:Number = Math.random() * Math.PI * 2;
         this.vx = Math.cos(angle) * Math.random() * 75;
         this.vy = Math.sin(angle) * Math.random() * 75;
         this._rotationRayon = Math.random() * maxRotationRay;
         this._rotationOffset = Math.random() * Math.PI * 2;
         this._rotationDir = Math.random() > 0.5 ? 1 : -1;
         this._startX = _sprite.x;
         this._startY = _sprite.y;
         this._yLimitTop = yLimitTop;
      }
      
      override public function update() : void
      {
         this.vyi = this.vy + this.g * this.t;
         this.y = this.t * this.halfg * Math.pow(this.t,2) + this.vy * this.t + Math.sin(this.t * 2 * this._rotationDir + this._rotationOffset) * (-this.t / Math.PI * this._rotationRayon * 10);
         if(this.y >= this._yLimitTop)
         {
            this.y = this._yLimitTop;
         }
         else
         {
            this.x = this.t * this.vx + Math.cos(this.t * this._rotationDir * 2 + this._rotationOffset) * (-this.t / Math.PI * this._rotationRayon * 10);
         }
         this.t += this.speed;
         _sprite.x = this.x + this._startX;
         _sprite.y = this.y + this._startY;
         _sprite.rotation = Math.atan(this.vyi / this.vx) * 180 / Math.PI;
         super.update();
      }
   }
}
