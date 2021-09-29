package Ankama_Config.ui
{
   import Ankama_Common.Common;
   import Ankama_Config.types.ConfigProperty;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class ConfigAudio extends ConfigUi
   {
       
      
      public var output:Object;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      public var btn_playSoundForGuildMessage:ButtonContainer;
      
      public var btn_playSoundAtTurnStart:ButtonContainer;
      
      public var btn_lessGlobal:ButtonContainer;
      
      public var btn_moreGlobal:ButtonContainer;
      
      public var btn_lessMusic:ButtonContainer;
      
      public var btn_moreMusic:ButtonContainer;
      
      public var btn_lessSound:ButtonContainer;
      
      public var btn_moreSound:ButtonContainer;
      
      public var btn_lessAmbientSound:ButtonContainer;
      
      public var btn_moreAmbientSound:ButtonContainer;
      
      public var pb_global:ProgressBar;
      
      public var pb_music:ProgressBar;
      
      public var pb_sound:ProgressBar;
      
      public var pb_ambientSound:ProgressBar;
      
      public var btn_globalMute:ButtonContainer;
      
      public var btn_musicMute:ButtonContainer;
      
      public var btn_soundMute:ButtonContainer;
      
      public var btn_ambientSoundMute:ButtonContainer;
      
      public var soundOptionCtr:GraphicContainer;
      
      public var lbl_updater:TextArea;
      
      private var _textfieldDico:Dictionary;
      
      public function ConfigAudio()
      {
         super();
      }
      
      public function main(args:*) : void
      {
         var properties:Array = [];
         properties.push(new ConfigProperty("btn_globalMute","tubulIsDesactivated","tubul"));
         properties.push(new ConfigProperty("","volumeMusic","tubul"));
         properties.push(new ConfigProperty("","volumeSound","tubul"));
         properties.push(new ConfigProperty("","volumeAmbientSound","tubul"));
         properties.push(new ConfigProperty("","globalVolume","tubul"));
         properties.push(new ConfigProperty("btn_musicMute","muteMusic","tubul"));
         properties.push(new ConfigProperty("btn_soundMute","muteSound","tubul"));
         properties.push(new ConfigProperty("btn_ambientSoundMute","muteAmbientSound","tubul"));
         properties.push(new ConfigProperty("btn_playSoundForGuildMessage","playSoundForGuildMessage","tubul"));
         properties.push(new ConfigProperty("btn_playSoundAtTurnStart","playSoundAtTurnStart","tubul"));
         init(properties);
         sysApi.addHook(CustomUiHookList.ActivateSound,this.onActivateSound);
         uiApi.addComponentHook(this.pb_global,"onRelease");
         uiApi.addComponentHook(this.pb_music,"onRelease");
         uiApi.addComponentHook(this.pb_sound,"onRelease");
         uiApi.addComponentHook(this.pb_ambientSound,"onRelease");
         uiApi.addComponentHook(this.btn_moreGlobal,"onRelease");
         uiApi.addComponentHook(this.btn_lessGlobal,"onRelease");
         uiApi.addComponentHook(this.btn_moreMusic,"onRelease");
         uiApi.addComponentHook(this.btn_lessMusic,"onRelease");
         uiApi.addComponentHook(this.btn_moreSound,"onRelease");
         uiApi.addComponentHook(this.btn_lessSound,"onRelease");
         uiApi.addComponentHook(this.btn_moreAmbientSound,"onRelease");
         uiApi.addComponentHook(this.btn_lessAmbientSound,"onRelease");
         uiApi.addComponentHook(this.btn_globalMute,"onRelease");
         uiApi.addComponentHook(this.btn_musicMute,"onRelease");
         uiApi.addComponentHook(this.btn_soundMute,"onRelease");
         uiApi.addComponentHook(this.btn_ambientSoundMute,"onRelease");
         this._textfieldDico = new Dictionary();
         this.displayUpdate();
      }
      
      override public function reset() : void
      {
         super.reset();
         this.displayUpdate();
      }
      
      public function unload() : void
      {
      }
      
      public function displayUpdate() : void
      {
         var volMusic:Number = sysApi.getOption("volumeMusic","tubul");
         var volSound:Number = sysApi.getOption("volumeSound","tubul");
         var volAmbientSound:Number = sysApi.getOption("volumeAmbientSound","tubul");
         var volGlobal:Number = sysApi.getOption("globalVolume","tubul");
         this.btn_musicMute.selected = sysApi.getOption("muteMusic","tubul");
         this.btn_soundMute.selected = sysApi.getOption("muteSound","tubul");
         this.btn_ambientSoundMute.selected = sysApi.getOption("muteAmbientSound","tubul");
         this.btn_playSoundForGuildMessage.selected = sysApi.getOption("playSoundForGuildMessage","tubul");
         this.btn_playSoundAtTurnStart.selected = sysApi.getOption("playSoundAtTurnStart","tubul");
         this.btn_globalMute.selected = sysApi.getOption("tubulIsDesactivated","tubul");
         sysApi.log(2," options de tubul : music " + sysApi.getOption("volumeMusic","tubul") + ", son " + sysApi.getOption("volumeSound","tubul") + ", son d\'ambiance " + sysApi.getOption("volumeAmbientSound","tubul") + "   --> tubul desactivé " + sysApi.getOption("tubulIsDesactivated","tubul"));
         this.pb_global.value = volGlobal;
         this.pb_sound.value = volSound;
         this.pb_music.value = volMusic;
         this.pb_ambientSound.value = volAmbientSound;
         if(this.btn_musicMute.selected)
         {
            this.btn_musicMute.soundId = SoundEnum.CHECKBOX_CHECKED;
         }
         else
         {
            this.btn_musicMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
         }
         if(this.btn_soundMute.selected)
         {
            this.btn_soundMute.soundId = SoundEnum.CHECKBOX_CHECKED;
         }
         else
         {
            this.btn_soundMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
         }
         if(this.btn_ambientSoundMute.selected)
         {
            this.btn_ambientSoundMute.soundId = SoundEnum.CHECKBOX_CHECKED;
         }
         else
         {
            this.btn_ambientSoundMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
         }
         this.activeOptions(this.btn_globalMute.selected);
      }
      
      private function onVolChange(pEvent:Event) : void
      {
         if(pEvent.target.text == "")
         {
            pEvent.target.text = 0;
         }
         this.soundApi.setBusVolume(this._textfieldDico[pEvent.target.name],pEvent.target.text);
      }
      
      private function saveOptions() : void
      {
      }
      
      private function undoOptions() : void
      {
      }
      
      private function activeOptions(pActivate:Boolean) : void
      {
         this.soundOptionCtr.disabled = pActivate;
         sysApi.dispatchHook(CustomUiHookList.ActivateSound,pActivate);
      }
      
      private function onActivateSound(pActive:Boolean) : void
      {
         this.soundOptionCtr.disabled = pActive;
         this.btn_globalMute.selected = pActive;
      }
      
      override public function onRelease(target:Object) : void
      {
         super.onRelease(target);
         switch(target)
         {
            case this.btn_globalMute:
               this.activeOptions(this.btn_globalMute.selected);
               break;
            case this.pb_global:
               this.fixSoundValue(this.pb_global,"globalVolume");
               this.fixButtonState(this.pb_global.value,this.btn_lessGlobal,this.btn_moreGlobal);
               break;
            case this.btn_moreGlobal:
               this.pb_global.value += 0.1;
               this.fixSoundValue(this.pb_global,"globalVolume");
               this.fixButtonState(this.pb_global.value,this.btn_lessGlobal,this.btn_moreGlobal);
               break;
            case this.btn_lessGlobal:
               this.pb_global.value -= 0.21;
               this.fixSoundValue(this.pb_global,"globalVolume");
               this.fixButtonState(this.pb_global.value,this.btn_lessGlobal,this.btn_moreGlobal);
               break;
            case this.pb_music:
               this.fixSoundValue(this.pb_music,"volumeMusic");
               this.fixButtonState(this.pb_music.value,this.btn_lessMusic,this.btn_moreMusic);
               break;
            case this.btn_moreMusic:
               this.pb_music.value += 0.1;
               this.fixSoundValue(this.pb_music,"volumeMusic");
               this.fixButtonState(this.pb_music.value,this.btn_lessMusic,this.btn_moreMusic);
               break;
            case this.btn_lessMusic:
               this.pb_music.value -= 0.21;
               this.fixSoundValue(this.pb_music,"volumeMusic");
               this.fixButtonState(this.pb_music.value,this.btn_lessMusic,this.btn_moreMusic);
               break;
            case this.pb_sound:
               this.fixSoundValue(this.pb_sound,"volumeSound");
               this.fixButtonState(this.pb_sound.value,this.btn_lessSound,this.btn_moreSound);
               break;
            case this.btn_moreSound:
               this.pb_sound.value += 0.1;
               this.fixSoundValue(this.pb_sound,"volumeSound");
               this.fixButtonState(this.pb_sound.value,this.btn_lessSound,this.btn_moreSound);
               break;
            case this.btn_lessSound:
               this.pb_sound.value -= 0.21;
               this.fixSoundValue(this.pb_sound,"volumeSound");
               this.fixButtonState(this.pb_sound.value,this.btn_lessSound,this.btn_moreSound);
               break;
            case this.pb_ambientSound:
               this.fixSoundValue(this.pb_ambientSound,"volumeAmbientSound");
               this.fixButtonState(this.pb_ambientSound.value,this.btn_lessAmbientSound,this.btn_moreAmbientSound);
               break;
            case this.btn_moreAmbientSound:
               this.pb_ambientSound.value += 0.1;
               this.fixSoundValue(this.pb_ambientSound,"volumeAmbientSound");
               this.fixButtonState(this.pb_ambientSound.value,this.btn_lessAmbientSound,this.btn_moreAmbientSound);
               break;
            case this.btn_lessAmbientSound:
               this.pb_ambientSound.value -= 0.21;
               this.fixSoundValue(this.pb_ambientSound,"volumeAmbientSound");
               this.fixButtonState(this.pb_ambientSound.value,this.btn_lessAmbientSound,this.btn_moreAmbientSound);
               break;
            case this.btn_musicMute:
               if(this.btn_musicMute.selected)
               {
                  this.btn_musicMute.soundId = SoundEnum.CHECKBOX_CHECKED;
                  setProperty("tubul","muteMusic",true);
               }
               else
               {
                  this.btn_musicMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
                  setProperty("tubul","muteMusic",false);
               }
               break;
            case this.btn_soundMute:
               if(this.btn_soundMute.selected)
               {
                  this.btn_soundMute.soundId = SoundEnum.CHECKBOX_CHECKED;
                  setProperty("tubul","muteSound",true);
               }
               else
               {
                  this.btn_soundMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
                  setProperty("tubul","muteSound",false);
               }
               break;
            case this.btn_ambientSoundMute:
               if(this.btn_ambientSoundMute.selected)
               {
                  this.btn_ambientSoundMute.soundId = SoundEnum.CHECKBOX_CHECKED;
                  setProperty("tubul","muteAmbientSound",true);
               }
               else
               {
                  this.btn_ambientSoundMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
                  setProperty("tubul","muteAmbientSound",false);
               }
         }
      }
      
      private function fixButtonState(value:Number, btnLess:ButtonContainer, btnMore:ButtonContainer) : void
      {
         btnLess.disabled = value == 0;
         btnMore.disabled = value == 1;
      }
      
      private function fixSoundValue(pb:ProgressBar, property:String) : void
      {
         var value:Number = pb.value;
         pb.value = value;
         setProperty("tubul",property,value);
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:* = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.btn_musicMute:
               if(!this.btn_musicMute.selected)
               {
                  tooltipText = uiApi.getText("ui.option.muteMusic");
               }
               else
               {
                  tooltipText = uiApi.getText("ui.option.unmuteMusic");
               }
               point = 3;
               relPoint = 5;
               break;
            case this.btn_soundMute:
               if(!this.btn_soundMute.selected)
               {
                  tooltipText = uiApi.getText("ui.option.muteSound");
               }
               else
               {
                  tooltipText = uiApi.getText("ui.option.unmuteSound");
               }
               point = 3;
               relPoint = 5;
               break;
            case this.btn_ambientSoundMute:
               if(!this.btn_ambientSoundMute.selected)
               {
                  tooltipText = uiApi.getText("ui.option.muteAmbience");
               }
               else
               {
                  tooltipText = uiApi.getText("ui.option.unmuteAmbience");
               }
               point = 3;
               relPoint = 5;
               break;
            case this.btn_globalMute:
               if(!this.btn_globalMute.selected)
               {
                  tooltipText = uiApi.getText("ui.option.mute");
               }
               else
               {
                  tooltipText = uiApi.getText("ui.option.unmuteGlobal");
               }
               point = 3;
               relPoint = 5;
               break;
            case this.pb_global:
               tooltipText = this.pb_global.value * 100 + "%";
               break;
            case this.pb_music:
               tooltipText = this.pb_music.value * 100 + "%";
               break;
            case this.pb_sound:
               tooltipText = this.pb_sound.value * 100 + "%";
               break;
            case this.pb_ambientSound:
               tooltipText = this.pb_ambientSound.value * 100 + "%";
         }
         uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
   }
}
