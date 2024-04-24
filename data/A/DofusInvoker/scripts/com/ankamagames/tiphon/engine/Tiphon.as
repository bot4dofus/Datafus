package com.ankamagames.tiphon.engine
{
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.interfaces.IFLAEventHandler;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.tiphon.TiphonConstants;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.AdvancedColoredSprite;
   import com.ankamagames.tiphon.types.CarriedSprite;
   import com.ankamagames.tiphon.types.ColoredSprite;
   import com.ankamagames.tiphon.types.EquipmentSprite;
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public final class Tiphon extends EventDispatcher implements IFLAEventHandler
   {
      
      private static var _self:Tiphon;
      
      public static const skullLibrary:LibrariesManager = TiphonLibraries.skullLibrary;
      
      public static const skinLibrary:LibrariesManager = TiphonLibraries.skinLibrary;
       
      
      protected var coloredSprite:ColoredSprite;
      
      protected var advancedColoredSprite:AdvancedColoredSprite;
      
      protected var carriedSprite:CarriedSprite;
      
      protected var equipmentSprite:EquipmentSprite;
      
      protected var scriptedAnimation:ScriptedAnimation;
      
      private var _toOptions;
      
      private var _waitForInit:Boolean;
      
      public var useOptimization:Boolean = true;
      
      public function Tiphon()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("Tiphon is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : Tiphon
      {
         if(_self == null)
         {
            _self = new Tiphon();
         }
         return _self;
      }
      
      public function get options() : *
      {
         return this._toOptions;
      }
      
      public function init(sSwfSkullPath:String, sSwfSkinPath:String, animIndexPath:String = null, pUseOptimization:Boolean = true) : void
      {
         this.useOptimization = pUseOptimization;
         if(sSwfSkullPath.split("://").length == 1)
         {
            sSwfSkullPath = "file://" + sSwfSkullPath;
         }
         if(sSwfSkinPath.split("://").length == 1)
         {
            sSwfSkinPath = "file://" + sSwfSkinPath;
         }
         TiphonConstants.SWF_SKULL_PATH = sSwfSkullPath;
         TiphonConstants.SWF_SKIN_PATH = sSwfSkinPath;
         if(animIndexPath)
         {
            this._waitForInit = true;
            BoneIndexManager.getInstance().addEventListener(Event.INIT,this.onBoneIndexManagerInit);
            BoneIndexManager.getInstance().init(animIndexPath);
         }
         TiphonFpsManager.init();
         TiphonEventsManager.addListener(this,TiphonEvent.PLAYANIM_EVENT);
         if(!this._waitForInit)
         {
            dispatchEvent(new Event(Event.INIT));
         }
      }
      
      public function setDisplayOptions(topt:*) : void
      {
         this._toOptions = topt;
      }
      
      public function handleFLAEvent(pAnimationName:String, pType:String, pParams:String, pSprite:Object = null) : void
      {
         var tiphonSprite:TiphonSprite = pSprite as TiphonSprite;
         if(pParams == TiphonEvent.EVENT_SHOT)
         {
            tiphonSprite.onAnimationEvent(TiphonEvent.EVENT_SHOT);
         }
         else if(pParams == TiphonEvent.EVENT_END)
         {
            tiphonSprite.onAnimationEvent(TiphonEvent.EVENT_END);
         }
         else if(pParams == TiphonEvent.PLAYER_STOP)
         {
            tiphonSprite.onAnimationEvent(TiphonEvent.PLAYER_STOP);
         }
         else if(pType == TiphonEvent.PLAYANIM_EVENT)
         {
            tiphonSprite.onAnimationEvent(TiphonEvent.PLAYANIM_EVENT,pParams);
         }
      }
      
      public function removeEntitySound(pEntityId:IEntity) : void
      {
      }
      
      private function onBoneIndexManagerInit(e:Event) : void
      {
         BoneIndexManager.getInstance().removeEventListener(Event.INIT,this.onBoneIndexManagerInit);
         dispatchEvent(new Event(Event.INIT));
      }
   }
}
