package org.flintparticles.common.renderers
{
   import flash.display.Sprite;
   import flash.events.Event;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.events.EmitterEvent;
   import org.flintparticles.common.events.ParticleEvent;
   import org.flintparticles.common.particles.Particle;
   
   public class SpriteRendererBase extends Sprite implements Renderer
   {
       
      
      protected var _emitters:Array;
      
      public function SpriteRendererBase()
      {
         super();
         this._emitters = new Array();
         mouseEnabled = false;
         mouseChildren = false;
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStage,false,0,true);
      }
      
      public function addEmitter(emitter:Emitter) : void
      {
         var p:Particle = null;
         this._emitters.push(emitter);
         if(stage)
         {
            stage.invalidate();
         }
         emitter.addEventListener(EmitterEvent.EMITTER_UPDATED,this.emitterUpdated,false,0,true);
         emitter.addEventListener(ParticleEvent.PARTICLE_CREATED,this.particleAdded,false,0,true);
         emitter.addEventListener(ParticleEvent.PARTICLE_ADDED,this.particleAdded,false,0,true);
         emitter.addEventListener(ParticleEvent.PARTICLE_DEAD,this.particleRemoved,false,0,true);
         for each(p in emitter.particles)
         {
            this.addParticle(p);
         }
         if(this._emitters.length == 1)
         {
            addEventListener(Event.RENDER,this.updateParticles,false,0,true);
         }
      }
      
      public function removeEmitter(emitter:Emitter) : void
      {
         var p:Particle = null;
         for(var i:int = 0; i < this._emitters.length; i++)
         {
            if(this._emitters[i] == emitter)
            {
               this._emitters.splice(i,1);
               emitter.removeEventListener(EmitterEvent.EMITTER_UPDATED,this.emitterUpdated);
               emitter.removeEventListener(ParticleEvent.PARTICLE_CREATED,this.particleAdded);
               emitter.removeEventListener(ParticleEvent.PARTICLE_ADDED,this.particleAdded);
               emitter.removeEventListener(ParticleEvent.PARTICLE_DEAD,this.particleRemoved);
               for each(p in emitter.particles)
               {
                  this.removeParticle(p);
               }
               if(this._emitters.length == 0)
               {
                  removeEventListener(Event.RENDER,this.updateParticles);
                  this.renderParticles([]);
               }
               else
               {
                  stage.invalidate();
               }
               return;
            }
         }
      }
      
      private function addedToStage(ev:Event) : void
      {
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      private function particleAdded(ev:ParticleEvent) : void
      {
         this.addParticle(ev.particle);
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      private function particleRemoved(ev:ParticleEvent) : void
      {
         this.removeParticle(ev.particle);
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      private function emitterUpdated(ev:EmitterEvent) : void
      {
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      private function updateParticles(ev:Event) : void
      {
         var particles:Array = new Array();
         for(var i:int = 0; i < this._emitters.length; i++)
         {
            particles = particles.concat(this._emitters[i].particles);
         }
         this.renderParticles(particles);
      }
      
      protected function addParticle(particle:Particle) : void
      {
      }
      
      protected function removeParticle(particle:Particle) : void
      {
      }
      
      protected function renderParticles(particles:Array) : void
      {
      }
      
      public function get emitters() : Array
      {
         return this._emitters;
      }
   }
}
