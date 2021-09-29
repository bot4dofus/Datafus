package Ankama_Connection.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.components.VideoPlayer;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.filesystem.File;
   import flash.geom.Point;
   
   public class UpdateInformationTemplate
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      protected var _currentMajNumber:String = "2-45";
      
      protected var _currentLanguage:String;
      
      private var _params:Object;
      
      protected var hasCenterUrl:Boolean;
      
      protected var hasBottomCenterUrl:Boolean;
      
      protected var hasTopLeftUrl:Boolean;
      
      protected var hasTopRightUrl:Boolean;
      
      protected var hasBottomLeftUrl:Boolean;
      
      protected var hasBottomRightUrl:Boolean;
      
      protected var btnPlayStartPos_Y:int = 700;
      
      protected var txTopLeftStartPos:Point;
      
      protected var txBottomLeftStartPos:Point;
      
      protected var txCenterStartPos:Point;
      
      protected var txTopRightStartPos:Point;
      
      protected var txBottomRightStartPos:Point;
      
      protected var lblTitileCenterStartPos:Point;
      
      protected var lblDescriptionCenterStartPos:Point;
      
      public var tx_TopLeftSlot:Texture;
      
      public var tx_TopRightSlot:Texture;
      
      public var tx_CenterSlot:Texture;
      
      public var tx_BottomLeftSlot:Texture;
      
      public var tx_BottomRightSlot:Texture;
      
      public var tx_BottomCenterSlot:Texture;
      
      public var tx_linkCenter:Texture;
      
      public var tx_linkBottomCenter:Texture;
      
      public var tx_linkTopLeft:Texture;
      
      public var tx_linkTopRight:Texture;
      
      public var tx_linkBottomLeft:Texture;
      
      public var tx_linkBottomRight:Texture;
      
      public var ctr_title:GraphicContainer;
      
      public var ctrInfos:GraphicContainer;
      
      public var videoPlayerSmall:VideoPlayer;
      
      public var ctr_videoPlayerSmall:GraphicContainer;
      
      public var ctrCenterSlot:GraphicContainer;
      
      public var ctrTopLeftSlot:GraphicContainer;
      
      public var ctrBottomLeftSlot:GraphicContainer;
      
      public var ctrTopRightSlot:GraphicContainer;
      
      public var ctrBottomRightSlot:GraphicContainer;
      
      public var ctrBottomCenterSlot:GraphicContainer;
      
      public var tx_videoPlayerSmallPlay:Texture;
      
      public var tx_videoPlayerSmallExpand:Texture;
      
      public var tx_closeVideo:Texture;
      
      public var tx_videoPlayerSmallSound:Texture;
      
      public var tx_miniature:Texture;
      
      public var tx_borderVideo:TextureBitmap;
      
      public var lbl_newFeatures:Label;
      
      public var lbl_update:Label;
      
      public var lbl_titleCenter:Label;
      
      public var lbl_titleTopLeft:Label;
      
      public var lbl_titleBottomLeft:Label;
      
      public var lbl_titleTopRight:Label;
      
      public var lbl_titleBottomRight:Label;
      
      public var lbl_titleBottomCenter:Label;
      
      public var lbl_descriptionCenter:Label;
      
      public var btn_play:ButtonContainer;
      
      public function UpdateInformationTemplate()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
         this.ctrInfos.visible = false;
         this._params = params;
         this.btn_play = this.uiApi.me().parentUiRoot.getElement("btn_play") as ButtonContainer;
         this._currentMajNumber = params.currentMajNumber;
         this._currentLanguage = params.currentLanguage;
         this.initStartPosition();
         this.checkAllUrls();
      }
      
      public function unload() : void
      {
         this.tx_TopLeftSlot = null;
         this.tx_TopRightSlot = null;
         this.tx_CenterSlot = null;
         this.tx_BottomLeftSlot = null;
         this.tx_BottomRightSlot = null;
         this.tx_BottomCenterSlot = null;
         this.hasCenterUrl = false;
         this.hasBottomCenterUrl = false;
         this.hasTopLeftUrl = false;
         this.hasTopRightUrl = false;
         this.hasBottomLeftUrl = false;
         this.hasBottomRightUrl = false;
         if(this.videoPlayerSmall)
         {
            this.videoPlayerSmall.stop();
         }
      }
      
      protected function setAllText() : void
      {
      }
      
      protected function setAllTextures() : void
      {
         var path:* = null;
         var file:File = null;
         var lastTexture:Texture = null;
         if(this.tx_TopLeftSlot)
         {
            this.tx_linkTopLeft.visible = this.hasTopLeftUrl;
            lastTexture = this.tx_TopLeftSlot;
            path = this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_TL_" + this._currentLanguage + ".png";
            file = new File(path);
            if(file.exists)
            {
               this.tx_TopLeftSlot.uri = this.uiApi.createUri(path);
            }
            else
            {
               this.tx_TopLeftSlot.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_TL_fr.png");
            }
         }
         if(this.tx_TopRightSlot)
         {
            this.tx_linkTopRight.visible = this.hasTopRightUrl;
            lastTexture = this.tx_TopRightSlot;
            path = this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_TR_" + this._currentLanguage + ".png";
            file = new File(path);
            if(file.exists)
            {
               this.tx_TopRightSlot.uri = this.uiApi.createUri(path);
            }
            else
            {
               this.tx_TopRightSlot.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_TR_fr.png");
            }
         }
         if(this.tx_CenterSlot)
         {
            this.tx_linkCenter.visible = this.hasCenterUrl;
            lastTexture = this.tx_CenterSlot;
            path = this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_CENTER_" + this._currentLanguage + ".png";
            file = new File(path);
            if(file.exists)
            {
               this.tx_CenterSlot.uri = this.uiApi.createUri(path);
            }
            else
            {
               this.tx_CenterSlot.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_CENTER_fr.png");
            }
         }
         if(this.tx_BottomLeftSlot)
         {
            this.tx_linkBottomLeft.visible = this.hasBottomLeftUrl;
            lastTexture = this.tx_BottomLeftSlot;
            path = this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_BL_" + this._currentLanguage + ".png";
            file = new File(path);
            if(file.exists)
            {
               this.tx_BottomLeftSlot.uri = this.uiApi.createUri(path);
            }
            else
            {
               this.tx_BottomLeftSlot.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_BL_fr.png");
            }
         }
         if(this.tx_BottomRightSlot)
         {
            this.tx_linkBottomRight.visible = this.hasBottomRightUrl;
            lastTexture = this.tx_BottomRightSlot;
            path = this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_BR_" + this._currentLanguage + ".png";
            file = new File(path);
            if(file.exists)
            {
               this.tx_BottomRightSlot.uri = this.uiApi.createUri(path);
            }
            else
            {
               this.tx_BottomRightSlot.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_BR_fr.png");
            }
         }
         if(this._params.hasBottomCenterImage && this.tx_BottomCenterSlot)
         {
            this.tx_linkBottomCenter.visible = this.hasBottomCenterUrl;
            lastTexture = this.tx_BottomCenterSlot;
            path = this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_BC_" + this._currentLanguage + ".png";
            file = new File(path);
            if(file.exists)
            {
               this.tx_BottomCenterSlot.uri = this.uiApi.createUri(path);
            }
            else
            {
               this.tx_BottomCenterSlot.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/feature_BC_fr.png");
            }
         }
         lastTexture.dispatchMessages = true;
         this.uiApi.addComponentHook(lastTexture,ComponentHookList.ON_TEXTURE_READY);
      }
      
      public function onTextureReady(target:Texture) : void
      {
         if(this.tx_TopLeftSlot)
         {
            if(this.tx_TopLeftSlot.width == 0)
            {
               this.tx_TopLeftSlot.dispatchMessages = true;
               this.uiApi.addComponentHook(this.tx_TopLeftSlot,ComponentHookList.ON_TEXTURE_READY);
            }
            else
            {
               this.tx_TopLeftSlot.x = this.txTopLeftStartPos.x - this.tx_TopLeftSlot.width / 2;
               this.tx_TopLeftSlot.y = Math.min(0,80 - this.tx_TopLeftSlot.height / 2);
            }
         }
         if(this.tx_TopRightSlot)
         {
            if(this.tx_TopRightSlot.width == 0)
            {
               this.tx_TopRightSlot.dispatchMessages = true;
               this.uiApi.addComponentHook(this.tx_TopRightSlot,ComponentHookList.ON_TEXTURE_READY);
            }
            else
            {
               this.tx_TopRightSlot.x = this.txTopRightStartPos.x - this.tx_TopRightSlot.width / 2;
               this.tx_TopRightSlot.y = Math.min(0,80 - this.tx_TopRightSlot.height / 2);
            }
         }
         if(this.tx_CenterSlot)
         {
            if(this.tx_CenterSlot.width == 0)
            {
               this.tx_CenterSlot.dispatchMessages = true;
               this.uiApi.addComponentHook(this.tx_CenterSlot,ComponentHookList.ON_TEXTURE_READY);
            }
            else
            {
               this.tx_CenterSlot.x = this.txCenterStartPos.x - this.tx_CenterSlot.width / 2;
               if(this.tx_CenterSlot.height < 240)
               {
                  this.tx_CenterSlot.y = (240 - this.tx_CenterSlot.height) / 2;
               }
               else if(this.tx_CenterSlot.height > 250)
               {
                  this.tx_CenterSlot.y = 250 - this.tx_CenterSlot.height;
               }
            }
         }
         if(this.tx_BottomLeftSlot)
         {
            if(this.tx_BottomLeftSlot.width == 0)
            {
               this.tx_BottomLeftSlot.dispatchMessages = true;
               this.uiApi.addComponentHook(this.tx_BottomLeftSlot,ComponentHookList.ON_TEXTURE_READY);
            }
            else
            {
               this.tx_BottomLeftSlot.x = this.txBottomLeftStartPos.x - this.tx_BottomLeftSlot.width / 2;
               this.tx_BottomLeftSlot.y = Math.min(0,80 - this.tx_BottomLeftSlot.height / 2);
            }
         }
         if(this.tx_BottomRightSlot)
         {
            if(this.tx_BottomRightSlot.width == 0)
            {
               this.tx_BottomRightSlot.dispatchMessages = true;
               this.uiApi.addComponentHook(this.tx_BottomRightSlot,ComponentHookList.ON_TEXTURE_READY);
            }
            else
            {
               this.tx_BottomRightSlot.x = this.txBottomRightStartPos.x - this.tx_BottomRightSlot.width / 2;
               this.tx_BottomRightSlot.y = Math.min(0,80 - this.tx_BottomRightSlot.height / 2);
            }
         }
         this.ctrInfos.visible = true;
         this.setAllText();
      }
      
      protected function hoverFeatureContainer(target:GraphicContainer, rollOver:Boolean) : void
      {
         if(rollOver)
         {
            target.bgAlpha = 0.5;
         }
         else
         {
            target.bgAlpha = 0.7;
         }
      }
      
      protected function OpenWebInformation(url:String) : void
      {
         if(url.indexOf("[UNKNOWN_TEXT_NAME") != -1)
         {
            return;
         }
         this.sysApi.goToUrl(url);
      }
      
      protected function checkAllUrls() : void
      {
         this.hasCenterUrl = this.uiApi.getText("ui.link." + this._currentMajNumber.replace("-","_") + ".feature_CENTER").indexOf("[UNKNOWN_TEXT_NAME") == -1;
         this.hasBottomCenterUrl = this.uiApi.getText("ui.link." + this._currentMajNumber.replace("-","_") + ".feature_BC").indexOf("[UNKNOWN_TEXT_NAME") == -1;
         this.hasTopLeftUrl = this.uiApi.getText("ui.link." + this._currentMajNumber.replace("-","_") + ".feature_TL").indexOf("[UNKNOWN_TEXT_NAME") == -1;
         this.hasTopRightUrl = this.uiApi.getText("ui.link." + this._currentMajNumber.replace("-","_") + ".feature_TR").indexOf("[UNKNOWN_TEXT_NAME") == -1;
         this.hasBottomLeftUrl = this.uiApi.getText("ui.link." + this._currentMajNumber.replace("-","_") + ".feature_BL").indexOf("[UNKNOWN_TEXT_NAME") == -1;
         this.hasBottomRightUrl = this.uiApi.getText("ui.link." + this._currentMajNumber.replace("-","_") + ".feature_BR").indexOf("[UNKNOWN_TEXT_NAME") == -1;
      }
      
      private function initStartPosition() : void
      {
         if(this.tx_TopLeftSlot)
         {
            this.txTopLeftStartPos = new Point(this.tx_TopLeftSlot.x,this.tx_TopLeftSlot.y);
         }
         if(this.tx_BottomLeftSlot)
         {
            this.txBottomLeftStartPos = new Point(this.tx_BottomLeftSlot.x,this.tx_BottomLeftSlot.y);
         }
         if(this.tx_CenterSlot)
         {
            this.txCenterStartPos = new Point(this.tx_CenterSlot.x,this.tx_CenterSlot.y);
         }
         if(this.tx_TopRightSlot)
         {
            this.txTopRightStartPos = new Point(this.tx_TopRightSlot.x,this.tx_TopRightSlot.y);
         }
         if(this.tx_BottomRightSlot)
         {
            this.txBottomRightStartPos = new Point(this.tx_BottomRightSlot.x,this.tx_BottomRightSlot.y);
         }
         if(this.lbl_titleCenter)
         {
            this.lblTitileCenterStartPos = new Point(this.lbl_titleCenter.x,this.lbl_titleCenter.y);
         }
         if(this.lbl_descriptionCenter)
         {
            this.lblDescriptionCenterStartPos = new Point(this.lbl_descriptionCenter.x,this.lbl_descriptionCenter.y);
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
      }
   }
}
