package org.flintparticles.common.initializers
{
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.utils.construct;
   
   public class ImageClass extends InitializerBase
   {
       
      
      private var _imageClass:Class;
      
      private var _parameters:Array;
      
      public function ImageClass(imageClass:Class, ... parameters)
      {
         super();
         this._imageClass = imageClass;
         this._parameters = parameters;
      }
      
      public function get imageClass() : Class
      {
         return this._imageClass;
      }
      
      public function set imageClass(value:Class) : void
      {
         this._imageClass = value;
      }
      
      public function get parameters() : Array
      {
         return this._parameters;
      }
      
      public function set parameters(value:Array) : void
      {
         this._parameters = value;
      }
      
      override public function initialize(emitter:Emitter, particle:Particle) : void
      {
         particle.image = construct(this._imageClass,this._parameters);
      }
   }
}
