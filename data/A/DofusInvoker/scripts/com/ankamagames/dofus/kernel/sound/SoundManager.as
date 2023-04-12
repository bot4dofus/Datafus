package com.ankamagames.dofus.kernel.sound
{
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.kernel.sound.manager.RegSoundManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.tubul.types.TubulOptions;
   import flash.utils.getQualifiedClassName;
   
   public class SoundManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SoundManager));
      
      private static var _self:SoundManager;
       
      
      private var _globalVolume:Number;
      
      public var manager:RegSoundManager;
      
      private var _tuOptions:TubulOptions;
      
      public function SoundManager()
      {
         super();
         if(_self)
         {
            throw new Error("Warning : SoundManager is a singleton class and shoulnd\'t be instancied directly!");
         }
      }
      
      public static function getInstance() : SoundManager
      {
         if(!_self)
         {
            _self = new SoundManager();
         }
         return _self;
      }
      
      public function get options() : TubulOptions
      {
         return this._tuOptions;
      }
      
      public function setSoundOptions() : void
      {
         var musicMute:Boolean = false;
         var soundMute:Boolean = false;
         var ambientSoundMute:Boolean = false;
         var soundIsDeactivated:Boolean = false;
         var obj:* = undefined;
         var commonMod:Object = null;
         try
         {
            musicMute = OptionManager.getOptionManager("tubul").getOption("muteMusic");
            soundMute = OptionManager.getOptionManager("tubul").getOption("muteSound");
            ambientSoundMute = OptionManager.getOptionManager("tubul").getOption("muteAmbientSound");
            this._globalVolume = OptionManager.getOptionManager("tubul").getOption("globalVolume");
            this.setMusicVolume(!!musicMute ? Number(0) : Number(OptionManager.getOptionManager("tubul").getOption("volumeMusic")));
            this.setSoundVolume(!!soundMute ? Number(0) : Number(OptionManager.getOptionManager("tubul").getOption("volumeSound")));
            this.setAmbienceVolume(!!ambientSoundMute ? Number(0) : Number(OptionManager.getOptionManager("tubul").getOption("volumeAmbientSound")));
            soundIsDeactivated = OptionManager.getOptionManager("tubul").getOption("tubulIsDesactivated");
            if(soundIsDeactivated)
            {
               this.manager.deactivateSound();
            }
         }
         catch(e:Error)
         {
            _log.warn("Une erreur est survenue lors de la récupération/application des paramètres audio (option audio)");
            try
            {
               obj = UiModuleManager.getInstance().getModule("Ankama_Common");
               if(obj == null)
               {
                  return;
               }
               commonMod = obj.mainClass;
               commonMod.openPopup(I18n.getUiText("ui.popup.warning"),I18n.getUiText("ui.common.soundsDeactivated"),[I18n.getUiText("ui.common.ok")]);
            }
            catch(error:Error)
            {
               _log.warn("Nous n\'étions probablement pas encore en jeu, ni en pré jeu");
            }
         }
      }
      
      public function setDisplayOptions(pOptions:TubulOptions) : void
      {
         this._tuOptions = pOptions;
         this._tuOptions.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         this.setSoundOptions();
      }
      
      public function checkSoundDirectory() : void
      {
         this.manager.soundDirectoryExist = true;
      }
      
      public function setMusicVolume(pVolume:Number) : void
      {
         if(!this.manager.soundIsActivate)
         {
            return;
         }
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_MUSIC_ID,pVolume * this._globalVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_FIGHT_MUSIC_ID,pVolume * this._globalVolume);
      }
      
      public function setSoundVolume(pVolume:Number) : void
      {
         if(!this.manager.soundIsActivate)
         {
            return;
         }
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_UI_ID,pVolume * this._globalVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_BARKS_ID,pVolume * this._globalVolume);
      }
      
      public function setAmbienceVolume(pVolume:Number) : void
      {
         if(!this.manager.soundIsActivate)
         {
            return;
         }
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_AMBIENT_2D_ID,pVolume * this._globalVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_AMBIENT_3D_ID,pVolume * this._globalVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_BARKS_ID,pVolume * this._globalVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_FIGHT_ID,pVolume * this._globalVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_GFX_ID,pVolume * this._globalVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_NPC_FOLEYS_ID,pVolume * this._globalVolume);
         this.manager.setBusVolume(TubulSoundConfiguration.BUS_SFX_ID,pVolume * this._globalVolume);
      }
      
      private function onPropertyChanged(e:PropertyChangeEvent) : void
      {
         switch(e.propertyName)
         {
            case "muteMusic":
               this.setMusicVolume(!!e.propertyValue ? Number(0) : Number(this._tuOptions.getOption("volumeMusic")));
               break;
            case "muteSound":
               this.setSoundVolume(!!e.propertyValue ? Number(0) : Number(this._tuOptions.getOption("volumeSound")));
               break;
            case "muteAmbientSound":
               this.setAmbienceVolume(!!e.propertyValue ? Number(0) : Number(this._tuOptions.getOption("volumeAmbientSound")));
               break;
            case "volumeMusic":
               if(this._tuOptions.getOption("muteMusic") == false)
               {
                  this.setMusicVolume(e.propertyValue);
               }
               break;
            case "volumeSound":
               if(this._tuOptions.getOption("muteSound") == false)
               {
                  this.setSoundVolume(e.propertyValue);
               }
               break;
            case "volumeAmbientSound":
               if(this._tuOptions.getOption("muteAmbientSound") == false)
               {
                  this.setAmbienceVolume(e.propertyValue);
               }
               break;
            case "globalVolume":
               this._globalVolume = e.propertyValue;
               if(this._tuOptions.getOption("muteMusic") == false)
               {
                  this.setMusicVolume(this._tuOptions.getOption("volumeMusic"));
               }
               if(this._tuOptions.getOption("muteSound") == false)
               {
                  this.setSoundVolume(this._tuOptions.getOption("volumeSound"));
               }
               if(this._tuOptions.getOption("muteAmbientSound") == false)
               {
                  this.setAmbienceVolume(this._tuOptions.getOption("volumeAmbientSound"));
               }
               break;
            case "tubulIsDesactivated":
               if(e.propertyValue == true)
               {
                  this.manager.deactivateSound();
               }
               if(e.propertyValue == false)
               {
                  this.manager.activateSound();
               }
               break;
            case "playSoundForGuildMessage":
               break;
            case "playSoundAtTurnStart":
         }
      }
   }
}
