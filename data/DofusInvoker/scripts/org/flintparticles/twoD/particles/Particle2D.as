package org.flintparticles.twoD.particles
{
   import flash.geom.Matrix;
   import org.flintparticles.common.particles.Particle;
   
   public class Particle2D extends Particle
   {
       
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var velX:Number = 0;
      
      public var velY:Number = 0;
      
      public var rotation:Number = 0;
      
      public var angVelocity:Number = 0;
      
      private var _previousMass:Number;
      
      private var _previousRadius:Number;
      
      private var _inertia:Number;
      
      public var sortID:uint;
      
      public function Particle2D()
      {
         super();
      }
      
      public function get inertia() : Number
      {
         if(mass != this._previousMass || collisionRadius != this._previousRadius)
         {
            this._inertia = mass * collisionRadius * collisionRadius * 0.5;
            this._previousMass = mass;
            this._previousRadius = collisionRadius;
         }
         return this._inertia;
      }
      
      override public function initialize() : void
      {
         super.initialize();
         this.x = 0;
         this.y = 0;
         this.velX = 0;
         this.velY = 0;
         this.rotation = 0;
         this.angVelocity = 0;
         this.sortID = 0;
      }
      
      public function get matrixTransform() : Matrix
      {
         var cos:Number = scale * Math.cos(this.rotation);
         var sin:Number = scale * Math.sin(this.rotation);
         return new Matrix(cos,sin,-sin,cos,this.x,this.y);
      }
   }
}
