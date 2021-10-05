package org.flintparticles.common.emitters
{
   import flash.events.EventDispatcher;
   import org.flintparticles.common.actions.Action;
   import org.flintparticles.common.activities.Activity;
   import org.flintparticles.common.counters.Counter;
   import org.flintparticles.common.counters.ZeroCounter;
   import org.flintparticles.common.events.EmitterEvent;
   import org.flintparticles.common.events.ParticleEvent;
   import org.flintparticles.common.events.UpdateEvent;
   import org.flintparticles.common.initializers.Initializer;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.particles.ParticleFactory;
   import org.flintparticles.common.utils.FrameUpdater;
   import org.flintparticles.common.utils.PriorityArray;
   
   [Event(name="emitterUpdated",type="org.flintparticles.common.events.EmitterEvent")]
   [Event(name="emitterEmpty",type="org.flintparticles.common.events.EmitterEvent")]
   [Event(name="particleAdded",type="org.flintparticles.common.events.ParticleEvent")]
   [Event(name="particleCreated",type="org.flintparticles.common.events.ParticleEvent")]
   [Event(name="particleDead",type="org.flintparticles.common.events.ParticleEvent")]
   public class Emitter extends EventDispatcher
   {
       
      
      protected var _particleFactory:ParticleFactory;
      
      protected var _initializers:PriorityArray;
      
      protected var _actions:PriorityArray;
      
      protected var _activities:PriorityArray;
      
      protected var _particles:Array;
      
      protected var _counter:Counter;
      
      protected var _useInternalTick:Boolean = true;
      
      protected var _fixedFrameTime:Number = 0;
      
      protected var _running:Boolean = false;
      
      protected var _started:Boolean = false;
      
      protected var _maximumFrameTime:Number = 0.1;
      
      public function Emitter()
      {
         super();
         this._particles = new Array();
         this._actions = new PriorityArray();
         this._initializers = new PriorityArray();
         this._activities = new PriorityArray();
         this._counter = new ZeroCounter();
      }
      
      public function get maximumFrameTime() : Number
      {
         return this._maximumFrameTime;
      }
      
      public function set maximumFrameTime(value:Number) : void
      {
         this._maximumFrameTime = value;
      }
      
      public function addInitializer(initializer:Initializer, priority:Number = NaN) : void
      {
         if(isNaN(priority))
         {
            priority = initializer.getDefaultPriority();
         }
         this._initializers.add(initializer,priority);
         initializer.addedToEmitter(this);
      }
      
      public function removeInitializer(initializer:Initializer) : void
      {
         if(this._initializers.remove(initializer))
         {
            initializer.removedFromEmitter(this);
         }
      }
      
      public function hasInitializer(initializer:Initializer) : Boolean
      {
         return this._initializers.contains(initializer);
      }
      
      public function hasInitializerOfType(initializerClass:Class) : Boolean
      {
         var len:uint = this._initializers.length;
         for(var i:uint = 0; i < len; i++)
         {
            if(this._initializers[i] is initializerClass)
            {
               return true;
            }
         }
         return false;
      }
      
      public function addAction(action:Action, priority:Number = NaN) : void
      {
         if(isNaN(priority))
         {
            priority = action.getDefaultPriority();
         }
         this._actions.add(action,priority);
         action.addedToEmitter(this);
      }
      
      public function removeAction(action:Action) : void
      {
         if(this._actions.remove(action))
         {
            action.removedFromEmitter(this);
         }
      }
      
      public function hasAction(action:Action) : Boolean
      {
         return this._actions.contains(action);
      }
      
      public function hasActionOfType(actionClass:Class) : Boolean
      {
         var len:uint = this._actions.length;
         for(var i:uint = 0; i < len; i++)
         {
            if(this._actions[i] is actionClass)
            {
               return true;
            }
         }
         return false;
      }
      
      public function addActivity(activity:Activity, priority:Number = NaN) : void
      {
         if(isNaN(priority))
         {
            priority = activity.getDefaultPriority();
         }
         this._activities.add(activity,priority);
         activity.addedToEmitter(this);
      }
      
      public function removeActivity(activity:Activity) : void
      {
         if(this._activities.remove(activity))
         {
            activity.removedFromEmitter(this);
         }
      }
      
      public function hasActivity(activity:Activity) : Boolean
      {
         return this._activities.contains(activity);
      }
      
      public function hasActivityOfType(activityClass:Class) : Boolean
      {
         var len:uint = this._activities.length;
         for(var i:uint = 0; i < len; i++)
         {
            if(this._activities[i] is activityClass)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get counter() : Counter
      {
         return this._counter;
      }
      
      public function set counter(value:Counter) : void
      {
         this._counter = value;
      }
      
      public function get useInternalTick() : Boolean
      {
         return this._useInternalTick;
      }
      
      public function set useInternalTick(value:Boolean) : void
      {
         if(this._useInternalTick != value)
         {
            this._useInternalTick = value;
            if(this._started)
            {
               if(this._useInternalTick)
               {
                  FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE,this.updateEventListener,false,0,true);
               }
               else
               {
                  FrameUpdater.instance.removeEventListener(UpdateEvent.UPDATE,this.updateEventListener);
               }
            }
         }
      }
      
      public function get fixedFrameTime() : Number
      {
         return this._fixedFrameTime;
      }
      
      public function set fixedFrameTime(value:Number) : void
      {
         this._fixedFrameTime = value;
      }
      
      public function get running() : Boolean
      {
         return this._running;
      }
      
      public function get particleFactory() : ParticleFactory
      {
         return this._particleFactory;
      }
      
      public function set particleFactory(value:ParticleFactory) : void
      {
         this._particleFactory = value;
      }
      
      public function get particles() : Array
      {
         return this._particles;
      }
      
      protected function createParticle() : Particle
      {
         var particle:Particle = this._particleFactory.createParticle();
         var len:int = this._initializers.length;
         this.initParticle(particle);
         for(var i:int = 0; i < len; i++)
         {
            this._initializers[i].initialize(this,particle);
         }
         this._particles.push(particle);
         dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_CREATED,particle));
         return particle;
      }
      
      protected function initParticle(particle:Particle) : void
      {
      }
      
      public function addExistingParticles(particles:Array, applyInitializers:Boolean = false) : void
      {
         var i:int = 0;
         var len2:int = 0;
         var j:int = 0;
         var len:int = particles.length;
         if(applyInitializers)
         {
            len2 = this._initializers.length;
            for(j = 0; j < len2; j++)
            {
               for(i = 0; i < len; i++)
               {
                  this._initializers[j].initialize(this,particles[i]);
               }
            }
         }
         for(i = 0; i < len; i++)
         {
            this._particles.push(particles[i]);
            dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_ADDED,particles[i]));
         }
      }
      
      public function killAllParticles() : void
      {
         var len:int = this._particles.length;
         for(var i:int = 0; i < len; i++)
         {
            dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD,this._particles[i]));
            this._particleFactory.disposeParticle(this._particles[i]);
         }
         this._particles.length = 0;
      }
      
      public function start() : void
      {
         if(this._useInternalTick)
         {
            FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE,this.updateEventListener,false,0,true);
         }
         this._started = true;
         this._running = true;
         var len:int = this._activities.length;
         for(var i:int = 0; i < len; i++)
         {
            this._activities[i].initialize(this);
         }
         len = this._counter.startEmitter(this);
         for(i = 0; i < len; i++)
         {
            this.createParticle();
         }
      }
      
      private function updateEventListener(ev:UpdateEvent) : void
      {
         if(this._fixedFrameTime)
         {
            this.update(this._fixedFrameTime);
         }
         else
         {
            this.update(ev.time);
         }
      }
      
      public function update(time:Number) : void
      {
         var i:int = 0;
         var particle:Particle = null;
         var action:Action = null;
         var len2:int = 0;
         var j:int = 0;
         if(!this._running || time > this._maximumFrameTime)
         {
            return;
         }
         var len:int = this._counter.updateEmitter(this,time);
         for(i = 0; i < len; i++)
         {
            this.createParticle();
         }
         this.sortParticles();
         len = this._activities.length;
         for(i = 0; i < len; i++)
         {
            this._activities[i].update(this,time);
         }
         if(this._particles.length > 0)
         {
            len = this._actions.length;
            len2 = this._particles.length;
            for(j = 0; j < len; j++)
            {
               action = this._actions[j];
               for(i = 0; i < len2; i++)
               {
                  particle = this._particles[i];
                  action.update(this,particle,time);
               }
            }
            i = len2;
            while(i--)
            {
               particle = this._particles[i];
               if(particle.isDead)
               {
                  dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD,particle));
                  this._particleFactory.disposeParticle(particle);
                  this._particles.splice(i,1);
               }
            }
         }
         else
         {
            dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_EMPTY));
         }
         dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_UPDATED));
      }
      
      protected function sortParticles() : void
      {
      }
      
      public function pause() : void
      {
         this._running = false;
      }
      
      public function resume() : void
      {
         this._running = true;
      }
      
      public function stop() : void
      {
         if(this._useInternalTick)
         {
            FrameUpdater.instance.removeEventListener(UpdateEvent.UPDATE,this.updateEventListener);
         }
         this._started = false;
         this.killAllParticles();
      }
      
      public function runAhead(time:Number, frameRate:Number = 10) : void
      {
         var maxTime:Number = this._maximumFrameTime;
         var step:Number = 1 / frameRate;
         this._maximumFrameTime = step;
         while(time > 0)
         {
            time -= step;
            this.update(step);
         }
         this._maximumFrameTime = maxTime;
      }
   }
}
