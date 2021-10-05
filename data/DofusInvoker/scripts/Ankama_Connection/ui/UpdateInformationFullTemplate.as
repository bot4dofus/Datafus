package Ankama_Connection.ui
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.uiApi.SoundApi;
   
   public class UpdateInformationFullTemplate extends UpdateInformationTemplate
   {
       
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      private var _videoSmallIsPlaying:Boolean = false;
      
      private var _fullScreenMode:Boolean = false;
      
      public function UpdateInformationFullTemplate()
      {
         super();
      }
      
      override public function main(params:Object = null) : void
      {
         uiApi.addComponentHook(ctrCenterSlot,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(ctrCenterSlot,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(ctrCenterSlot,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(ctrTopLeftSlot,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(ctrTopLeftSlot,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(ctrTopLeftSlot,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(ctrBottomLeftSlot,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(ctrBottomLeftSlot,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(ctrBottomLeftSlot,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(ctrTopRightSlot,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(ctrTopRightSlot,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(ctrTopRightSlot,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(ctrBottomRightSlot,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(ctrBottomRightSlot,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(ctrBottomRightSlot,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(ctrBottomCenterSlot,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(ctrBottomCenterSlot,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(ctrBottomCenterSlot,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(tx_videoPlayerSmallExpand,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(tx_videoPlayerSmallExpand,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(tx_videoPlayerSmallExpand,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(videoPlayerSmall,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(tx_closeVideo,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(tx_closeVideo,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(tx_closeVideo,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(tx_videoPlayerSmallSound,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(tx_videoPlayerSmallSound,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(tx_videoPlayerSmallSound,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(btn_play,ComponentHookList.ON_RELEASE);
         super.main(params);
         setAllTextures();
         lbl_update.text = "- " + uiApi.getText("ui.maj.majNumber",_currentMajNumber.replace("-",".")).toUpperCase();
         var titleUpdateTextSize:Number = uiApi.getTextSize(lbl_newFeatures.text,lbl_newFeatures.css,lbl_newFeatures.cssClass).width;
         var updateTextSize:Number = uiApi.getTextSize(lbl_update.text,lbl_update.css,lbl_update.cssClass).width;
         lbl_update.x = (titleUpdateTextSize + updateTextSize) / 2 - updateTextSize;
         lbl_newFeatures.x = lbl_update.x;
         tx_miniature.uri = uiApi.createUri(uiApi.me().getConstant("illus") + "nouveautes_maj/" + _currentMajNumber + "/miniature_maj_" + _currentMajNumber + ".jpg");
         btn_play.y = btnPlayStartPos_Y;
         if(params.hasCinematic)
         {
            btn_play.y += 190;
            ctr_title.y = 0;
            ctrInfos.y = -80;
            ctr_videoPlayerSmall.visible = true;
            tx_videoPlayerSmallPlay.visible = true;
            tx_videoPlayerSmallExpand.handCursor = true;
            videoPlayerSmall.flv = params.cinematicsUri;
            videoPlayerSmall.play();
            videoPlayerSmall.pause();
         }
         else
         {
            ctr_title.y = 180;
            ctrInfos.y = -270;
            ctr_videoPlayerSmall.visible = false;
         }
         if(params.hasBottomCenterImage)
         {
            ctrBottomCenterSlot.visible = true;
            btn_play.y += 70;
         }
         else
         {
            ctrBottomCenterSlot.visible = false;
         }
      }
      
      override public function unload() : void
      {
         super.unload();
      }
      
      public function get fullScreenMode() : Boolean
      {
         return this._fullScreenMode;
      }
      
      public function get videoSmallIsPlaying() : Boolean
      {
         return this._videoSmallIsPlaying;
      }
      
      override protected function setAllText() : void
      {
         lbl_titleTopLeft.text = uiApi.getText("ui.maj." + _currentMajNumber.replace("-","_") + ".feature_TL_Title").toUpperCase();
         lbl_titleCenter.text = uiApi.getText("ui.maj." + _currentMajNumber.replace("-","_") + ".feature_CENTER_Title").toUpperCase();
         lbl_descriptionCenter.text = uiApi.getText("ui.maj." + _currentMajNumber.replace("-","_") + ".feature_CENTER_Details");
         lbl_titleCenter.y = lblTitileCenterStartPos.y + Math.max(0,(120 - (lbl_titleCenter.textHeight + 5 + lbl_descriptionCenter.textHeight)) / 2);
         lbl_descriptionCenter.y = lbl_titleCenter.y + lbl_titleCenter.textHeight + 5;
         lbl_titleTopRight.text = uiApi.getText("ui.maj." + _currentMajNumber.replace("-","_") + ".feature_TR_Title").toUpperCase();
         lbl_titleBottomLeft.text = uiApi.getText("ui.maj." + _currentMajNumber.replace("-","_") + ".feature_BL_Title").toUpperCase();
         lbl_titleBottomRight.text = uiApi.getText("ui.maj." + _currentMajNumber.replace("-","_") + ".feature_BR_Title").toUpperCase();
         lbl_titleBottomCenter.text = uiApi.getText("ui.maj." + _currentMajNumber.replace("-","_") + ".feature_BC_Title").toUpperCase();
      }
      
      private function resizeVideo() : void
      {
         if(!this._fullScreenMode)
         {
            ctr_videoPlayerSmall.width = tx_miniature.width = 1260;
            ctr_videoPlayerSmall.height = tx_miniature.height = 709;
            ctr_videoPlayerSmall.y = 0;
            tx_borderVideo.visible = false;
            tx_videoPlayerSmallExpand.visible = false;
            tx_closeVideo.visible = true;
            videoPlayerSmall.resize(ctr_videoPlayerSmall.width,ctr_videoPlayerSmall.height);
         }
         else
         {
            ctr_videoPlayerSmall.width = tx_miniature.width = 580;
            ctr_videoPlayerSmall.height = tx_miniature.height = 326;
            ctr_videoPlayerSmall.y = -250;
            tx_borderVideo.visible = true;
            tx_videoPlayerSmallExpand.visible = true;
            tx_closeVideo.visible = false;
            videoPlayerSmall.resize(ctr_videoPlayerSmall.width,ctr_videoPlayerSmall.height);
         }
         this._fullScreenMode = !this._fullScreenMode;
         uiApi.me().render();
         onTextureReady(null);
         this.setAllText();
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         if(this._fullScreenMode && (target != tx_closeVideo && target != tx_videoPlayerSmallExpand && target != videoPlayerSmall && target != tx_videoPlayerSmallSound))
         {
            videoPlayerSmall.pause();
            this.resizeVideo();
            if(this._videoSmallIsPlaying)
            {
               videoPlayerSmall.resume();
               this.soundApi.fadeBusVolume(0,0,0);
            }
            else
            {
               this.soundApi.fadeBusVolume(0,1,0);
            }
            return;
         }
         switch(target)
         {
            case ctrCenterSlot:
               OpenWebInformation(uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_CENTER"));
               break;
            case ctrTopLeftSlot:
               OpenWebInformation(uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_TL"));
               break;
            case ctrBottomLeftSlot:
               OpenWebInformation(uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_BL"));
               break;
            case ctrTopRightSlot:
               OpenWebInformation(uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_TR"));
               break;
            case ctrBottomRightSlot:
               OpenWebInformation(uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_BR"));
               break;
            case ctrBottomCenterSlot:
               OpenWebInformation(uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_BC"));
               break;
            case tx_closeVideo:
            case tx_videoPlayerSmallExpand:
               videoPlayerSmall.pause();
               this.resizeVideo();
               if(this._videoSmallIsPlaying)
               {
                  videoPlayerSmall.resume();
                  this.soundApi.fadeBusVolume(0,0,0);
               }
               else
               {
                  this.soundApi.fadeBusVolume(0,1,0);
               }
               break;
            case videoPlayerSmall:
               if(this._videoSmallIsPlaying)
               {
                  videoPlayerSmall.pause();
                  this.soundApi.fadeBusVolume(0,1,0);
               }
               else
               {
                  videoPlayerSmall.resume();
                  tx_miniature.visible = false;
                  this.soundApi.fadeBusVolume(0,0,0);
               }
               this._videoSmallIsPlaying = !this._videoSmallIsPlaying;
               tx_videoPlayerSmallPlay.visible = !this._videoSmallIsPlaying;
               break;
            case tx_videoPlayerSmallSound:
               videoPlayerSmall.mute = !videoPlayerSmall.mute;
               if(videoPlayerSmall.mute)
               {
                  this.soundApi.fadeBusVolume(0,1,0);
                  tx_videoPlayerSmallSound.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_sound_disabled.png");
               }
               else
               {
                  this.soundApi.fadeBusVolume(0,0,0);
                  tx_videoPlayerSmallSound.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_sound_normal.png");
               }
         }
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var currentLink:String = "[UNKNOWN_TEXT_NAME";
         target.handCursor = true;
         switch(target)
         {
            case ctrCenterSlot:
               currentLink = uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_CENTER");
               if(!hasCenterUrl)
               {
                  target.handCursor = false;
                  return;
               }
               hoverFeatureContainer(ctrCenterSlot,true);
               break;
            case ctrTopLeftSlot:
               currentLink = uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_TL");
               if(!hasTopLeftUrl)
               {
                  target.handCursor = false;
                  return;
               }
               hoverFeatureContainer(ctrTopLeftSlot,true);
               break;
            case ctrBottomLeftSlot:
               currentLink = uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_BL");
               if(!hasBottomLeftUrl)
               {
                  target.handCursor = false;
                  return;
               }
               hoverFeatureContainer(ctrBottomLeftSlot,true);
               break;
            case ctrTopRightSlot:
               currentLink = uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_TR");
               if(!hasTopRightUrl)
               {
                  target.handCursor = false;
                  return;
               }
               hoverFeatureContainer(ctrTopRightSlot,true);
               break;
            case ctrBottomRightSlot:
               currentLink = uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_BR");
               if(!hasBottomRightUrl)
               {
                  target.handCursor = false;
                  return;
               }
               hoverFeatureContainer(ctrBottomRightSlot,true);
               break;
            case ctrBottomCenterSlot:
               currentLink = uiApi.getText("ui.link." + _currentMajNumber.replace("-","_") + ".feature_BC");
               if(!hasBottomCenterUrl)
               {
                  target.handCursor = false;
                  return;
               }
               hoverFeatureContainer(ctrBottomCenterSlot,true);
               break;
            case tx_videoPlayerSmallExpand:
               text = uiApi.getText("ui.charcrea.enlargeYourVideo");
               tx_videoPlayerSmallExpand.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_expand_video_over.png");
               uiApi.showTooltip(uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
               break;
            case tx_closeVideo:
               tx_closeVideo.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_cross_white_over.png");
               text = uiApi.getText("ui.charcrea.leaveExpandMode");
               uiApi.showTooltip(uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
               break;
            case tx_videoPlayerSmallSound:
               if(videoPlayerSmall.mute)
               {
                  tx_videoPlayerSmallSound.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_sound_disabled_over.png");
               }
               else
               {
                  tx_videoPlayerSmallSound.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_sound_over.png");
               }
         }
      }
      
      override public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
         target.handCursor = false;
         switch(target)
         {
            case ctrCenterSlot:
               hoverFeatureContainer(ctrCenterSlot,false);
               break;
            case ctrTopLeftSlot:
               hoverFeatureContainer(ctrTopLeftSlot,false);
               break;
            case ctrBottomLeftSlot:
               hoverFeatureContainer(ctrBottomLeftSlot,false);
               break;
            case ctrTopRightSlot:
               hoverFeatureContainer(ctrTopRightSlot,false);
               break;
            case ctrBottomRightSlot:
               hoverFeatureContainer(ctrBottomRightSlot,false);
               break;
            case ctrBottomCenterSlot:
               hoverFeatureContainer(ctrBottomCenterSlot,false);
               break;
            case tx_videoPlayerSmallExpand:
               tx_videoPlayerSmallExpand.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_expand_video.png");
               break;
            case tx_closeVideo:
               tx_closeVideo.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_cross_white.png");
               break;
            case tx_videoPlayerSmallSound:
               if(videoPlayerSmall.mute)
               {
                  tx_videoPlayerSmallSound.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_sound_disabled.png");
               }
               else
               {
                  tx_videoPlayerSmallSound.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_sound_normal.png");
               }
         }
      }
   }
}
