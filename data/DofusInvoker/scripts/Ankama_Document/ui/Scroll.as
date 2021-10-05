package Ankama_Document.ui
{
   import Ankama_Document.data.ImageData;
   import Ankama_Document.tools.HtmlParser;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.documents.Document;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.DocumentApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.jerakine.types.Uri;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   
   public class Scroll extends DocumentBase
   {
      
      private static var EXP_TAG:RegExp = /(<[a-zA-Z]+\s*[^>]*+>)+([^<].*?)/gi;
       
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      [Api(name="DocumentApi")]
      public var docApi:DocumentApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      public var btn_close:ButtonContainer;
      
      public var btn_close2:ButtonContainer;
      
      public var btn_link:ButtonContainer;
      
      public var btn_arrowRight:ButtonContainer;
      
      public var btn_arrowLeft:ButtonContainer;
      
      private var _lbl_title:Label;
      
      public var lbl_title:Label;
      
      public var lbl_title2:Label;
      
      public var lbl_link:Label;
      
      public var lbl_content:Label;
      
      public var tx_illu:Texture;
      
      public var mainCtr:GraphicContainer;
      
      public var tx_deco:Texture;
      
      public var tx_background:Texture;
      
      public var tx_cartouche:TextureBitmap;
      
      public var mask_container:GraphicContainer;
      
      public var mask_content:GraphicContainer;
      
      private var _styleSheet:StyleSheet;
      
      private var _title:String;
      
      private var _pages:Array;
      
      private var _image:ImageData;
      
      private var _illuUri:Uri;
      
      private var _properties:Object;
      
      private var _hasText:Boolean = true;
      
      private var _showtitle:Boolean;
      
      private var _showBackgroundImage:Boolean;
      
      private var _btn_Close:ButtonContainer;
      
      private var _hideTitleDecoration:Boolean;
      
      private var _updateIlluPosition:Boolean;
      
      private var _link:String;
      
      private var _numLines:int;
      
      private var _numPages:int;
      
      private var _page:int = 1;
      
      private const MULTIPLIER:Number = 0.83;
      
      private var _illuX:Number;
      
      private var _illuY:Number;
      
      private var _contentX:Number;
      
      private var _contentY:Number;
      
      private var _contentXWithIllu:Number;
      
      public function Scroll()
      {
         super();
      }
      
      public function main(params:Object) : void
      {
         this.soundApi.playSound(SoundTypeEnum.MAP_OPEN);
         uiApi.addShortcutHook("closeUi",this.onShortcut);
         if(sysApi.getBuildType() == 4 || sysApi.getBuildType() == 5)
         {
            this.lbl_content.textfield.doubleClickEnabled = true;
            uiApi.addComponentHook(this.lbl_content,"onDoubleClick");
         }
         var document:Document = this.docApi.getDocument(params.documentId);
         this._title = document.title;
         this._pages = [];
         this._pages[0] = document.pages[0];
         this._properties = getProperties(document.clientProperties);
         this._showtitle = document.showTitle;
         this._showBackgroundImage = document.showBackgroundImage;
         this._illuX = uiApi.me().getConstant("illuX");
         this._illuY = uiApi.me().getConstant("illuY");
         this._contentX = uiApi.me().getConstant("contentX");
         this._contentY = uiApi.me().getConstant("contentY");
         this._contentXWithIllu = uiApi.me().getConstant("contentXWithIllu");
         this.lbl_content.mask = this.mask_content;
         this.mask_content.finalized = false;
         this.mask_container.finalized = false;
         if(this._showBackgroundImage)
         {
            this.tx_background.width = 1090;
            this.tx_background.height = 806;
            this.tx_illu.scale = this.MULTIPLIER;
            this._illuX *= this.MULTIPLIER;
            this._illuY *= this.MULTIPLIER;
            this._contentX *= this.MULTIPLIER;
            this._contentY *= this.MULTIPLIER;
            this._contentXWithIllu *= this.MULTIPLIER;
            this.lbl_content.width *= this.MULTIPLIER;
            this.lbl_content.height *= this.MULTIPLIER;
            this.mask_container.height = this.lbl_content.height;
            this._lbl_title = this.lbl_title2;
            this.tx_cartouche.scale = this.MULTIPLIER;
            this.btn_close.x *= this.MULTIPLIER;
            this.btn_close.y *= this.MULTIPLIER;
            this.mainCtr.x = 107;
            this.mainCtr.y = 80;
         }
         else
         {
            this._lbl_title = this.lbl_title;
         }
         this._lbl_title.visible = true;
         if(this._pages[0] && this._pages[0].length)
         {
            this.preInitData();
            this.initCss(document);
            this._initScroll();
         }
         else
         {
            sysApi.enableWorldInteraction();
            sysApi.sendAction(new LeaveDialogRequestAction([]));
            uiApi.unloadUi(uiApi.me().name);
         }
      }
      
      private function preInitData() : void
      {
         this._hasText = this.documentHasText(this._pages[0]);
         this._image = getImageData(this._pages[0]);
         if(this._image != null)
         {
            this._illuUri = uiApi.createUri(uiApi.me().getConstant("illus") + this._image.src);
         }
      }
      
      private function initCss(document:Document) : void
      {
         if(document.contentCSS && document.contentCSS != "null")
         {
            this._styleSheet = new StyleSheet();
            this._styleSheet.parseCSS(document.contentCSS);
            overrideLinkStyleInCss(this._styleSheet);
            this.lbl_content.setStyleSheet(this._styleSheet);
         }
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.MAP_CLOSE);
         sysApi.enableWorldInteraction();
         sysApi.sendAction(new LeaveDialogRequestAction([]));
      }
      
      private function _initScroll() : void
      {
         var text:String = null;
         var isWantedNotice:Boolean = false;
         var linkParams:Array = null;
         var quest:Quest = null;
         var lineText:String = null;
         this._lbl_title.text = this._title.search("<b>") == -1 ? "<b>" + this._title + "</b>" : this._title;
         if(this._styleSheet)
         {
            text = formateText(this._pages[0]);
         }
         else
         {
            text = HtmlParser.parseText(this._pages[0]);
         }
         var lastLinkIndex:int = text.lastIndexOf("<a href");
         if(lastLinkIndex != -1)
         {
            linkParams = text.substring(text.indexOf(":",lastLinkIndex) + 1,text.indexOf(">",lastLinkIndex) - 1).split(",");
            if(linkParams[0] == "startquest")
            {
               quest = this.dataApi.getQuest(linkParams[1]);
               if(quest.category.id == 6)
               {
                  this._link = text.substring(lastLinkIndex,text.lastIndexOf("</a>") + 4);
                  text = text.replace(text.substr(text.lastIndexOf("<p></p>")),"");
                  this.lbl_link.text = this._link;
                  this.btn_link.visible = true;
                  isWantedNotice = true;
               }
            }
         }
         if(!isWantedNotice)
         {
            this.btn_link.visible = false;
         }
         if(!this._hasText && this._image != null)
         {
            this.btn_close.visible = this._showBackgroundImage;
            this.tx_background.visible = this._showBackgroundImage;
            if(!this._showtitle)
            {
               this.showTitle(false);
            }
            this.lbl_content.visible = false;
            if(this._image.width > 0)
            {
               this.tx_illu.width = this._image.width;
            }
            else
            {
               this.tx_illu.width = 354;
            }
            if(this._image.height > 0)
            {
               this.tx_illu.height = this._image.height;
            }
            else
            {
               this.tx_illu.height = 539;
            }
            this.tx_illu.x = 240 + (800 - this.tx_illu.width) / 2;
            if(this.tx_illu.x < 0)
            {
               this.tx_illu.x = 0;
            }
            this.tx_illu.y = 150 + (600 - this.tx_illu.height) / 2;
            if(this.tx_illu.y < 0)
            {
               this.tx_illu.y = 0;
            }
            if(!this._showBackgroundImage)
            {
               this.btn_close2.x = this.tx_illu.x + this._image.width - this.btn_close.width - 8;
               this.btn_close2.y = this.tx_illu.y - this.btn_close.height - 8;
               if(this._showtitle)
               {
                  this.showTitle(false);
               }
               this.btn_close2.visible = false;
               this.tx_illu.dispatchMessages = true;
               uiApi.addComponentHook(this.tx_illu,"onTextureReady");
            }
            if(this._properties.hasOwnProperty("fullscreen"))
            {
               this.tx_illu.visible = false;
               this._updateIlluPosition = true;
            }
            this.tx_illu.uri = this._illuUri;
         }
         else
         {
            if(this._showBackgroundImage)
            {
               this.btn_close2.visible = false;
               this.btn_close.visible = true;
            }
            if(!this._illuUri)
            {
               this.lbl_content.width = 800;
            }
            this.lbl_content.textfield.multiline = true;
            this.lbl_content.wordWrap = true;
            this.lbl_content.visible = true;
            this.lbl_content.text = text;
            this.lbl_content.textfield.mouseEnabled = true;
            uiApi.addComponentHook(this.lbl_content,"onTextClick");
            this.lbl_content.textfield.width = this.lbl_content.width - 10;
            if(this.lbl_content.textHeight > this.lbl_content.height && this.lbl_content.textHeight - this.lbl_content.height < 10)
            {
               this.mask_container.height = Math.ceil(this.lbl_content.textHeight);
            }
            this.lbl_content.height = Math.ceil(this.lbl_content.textHeight);
            this.lbl_content.textfield.height = this.lbl_content.height + 4;
            this.tx_illu.x = this._illuX;
            this.tx_illu.y = this._illuY;
            this.lbl_content.y = this._contentY;
            this.lbl_content.x = !!this._illuUri ? Number(this._contentXWithIllu) : Number(this._contentX);
            if(this._image != null)
            {
               if(this._image.width > 0)
               {
                  this.tx_illu.width = this._image.width;
               }
               if(this._image.height > 0)
               {
                  this.tx_illu.height = this._image.height;
               }
               this.tx_illu.uri = this._illuUri;
            }
         }
         this._numLines = this.lbl_content.textfield.numLines;
         var h:Number = 0;
         for(var i:int = 0; i < this._numLines; i++)
         {
            lineText = this.lbl_content.textfield.getLineText(i);
            h += this.lbl_content.textfield.getLineMetrics(i).height;
            if(h > this.mask_container.height && (this.lbl_content.textfield.getLineText(i).length > 0 && lineText != "\n" && lineText != "\r"))
            {
               this._numPages = Math.ceil(this.lbl_content.textfield.numLines / i);
               this.btn_arrowLeft.state = StatesEnum.STATE_DISABLED;
               this.btn_arrowLeft.visible = true;
               this.btn_arrowRight.visible = true;
               break;
            }
         }
         this.applyProperties();
         this.mask_content.width = this.lbl_content.width;
         this.mask_content.finalize();
         this.mask_container.width = this.lbl_content.width;
         this.mask_container.x = this.lbl_content.x;
         this.mask_container.y = this.lbl_content.y;
         this.mask_container.finalize();
         this.displayPage(1);
         if(this._btn_Close && this._showBackgroundImage)
         {
            this._btn_Close.visible = true;
         }
      }
      
      public function documentHasText(page:String) : Boolean
      {
         var data:* = new RegExp(EXP_TAG).exec(page);
         return data != null;
      }
      
      private function showTitle(pShow:Boolean) : void
      {
         this._lbl_title.visible = pShow;
         this.tx_deco.visible = !this._hideTitleDecoration ? Boolean(pShow) : false;
      }
      
      private function applyProperties() : void
      {
         var offsetY:Number = NaN;
         var buttonType:int = 0;
         var btnX:Number = NaN;
         var btnY:Number = NaN;
         if(this._properties)
         {
            this._hideTitleDecoration = this._properties.hasOwnProperty("hideTitleDecoration");
            if(this._hideTitleDecoration)
            {
               this.tx_deco.visible = false;
            }
            if(this._properties.hasOwnProperty("titleOffsetY"))
            {
               offsetY = this._properties["titleOffsetY"];
               this._lbl_title.y += offsetY;
               this.tx_deco.y += offsetY;
            }
            if(this._properties.hasOwnProperty("buttonType"))
            {
               buttonType = this._properties["buttonType"];
               if(buttonType == 1)
               {
                  this.btn_close2.visible = false;
                  this._btn_Close = this.btn_close;
               }
               else if(buttonType == 2)
               {
                  this.btn_close.visible = false;
                  this._btn_Close = this.btn_close2;
               }
            }
            else if(this._properties.hasOwnProperty("cssClass"))
            {
               this._lbl_title.cssClass = this._properties.cssClass;
            }
            if(this._properties.hasOwnProperty("btnX"))
            {
               btnX = this._properties["btnX"];
               this.btn_close.x = btnX;
            }
            if(this._properties.hasOwnProperty("btnY"))
            {
               btnY = this._properties["btnY"];
               this.btn_close.y = btnY;
            }
         }
      }
      
      private function displayPage(pPage:int) : void
      {
         var textHeight:Number = NaN;
         if(pPage == 1)
         {
            this.btn_arrowLeft.state = StatesEnum.STATE_DISABLED;
            this.btn_arrowRight.state = StatesEnum.STATE_NORMAL;
         }
         else if(pPage < this._numPages)
         {
            this.btn_arrowLeft.state = StatesEnum.STATE_NORMAL;
            this.btn_arrowRight.state = StatesEnum.STATE_NORMAL;
         }
         else
         {
            this.btn_arrowLeft.state = StatesEnum.STATE_NORMAL;
            this.btn_arrowRight.state = StatesEnum.STATE_DISABLED;
         }
         var offset:Number = 0;
         var maskHeight:Number = 0;
         var currentPage:uint = 1;
         var pageOffset:Number = 0;
         for(var i:uint = 0; i < this._numLines; i++)
         {
            textHeight = this.lbl_content.textfield.getLineMetrics(i).height;
            if(currentPage != pPage && pageOffset + textHeight > this.mask_container.height)
            {
               currentPage++;
               offset += pageOffset;
               pageOffset = 0;
            }
            if(currentPage != pPage)
            {
               pageOffset += textHeight;
            }
            else
            {
               if(maskHeight + textHeight >= this.mask_container.height)
               {
                  break;
               }
               maskHeight += textHeight;
            }
         }
         this.lbl_content.y = this._contentY - offset - pageOffset - 2;
         this.mask_content.height = maskHeight + 2;
      }
      
      public function onTextClick(target:Object, textEvent:String) : void
      {
         linkHandler(textEvent);
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var startIndex:int = 0;
         switch(target)
         {
            case this.btn_close:
            case this.btn_close2:
               uiApi.unloadUi(uiApi.me().name);
               break;
            case this.btn_link:
               startIndex = this._link.indexOf("href=") + 6;
               linkHandler(this._link.substring(startIndex,this._link.indexOf(">",startIndex) - 1).split(":")[1]);
               break;
            case this.btn_arrowLeft:
               if(this.btn_arrowLeft.state != StatesEnum.STATE_DISABLED && this._page > 1)
               {
                  this.displayPage(--this._page);
               }
               break;
            case this.btn_arrowRight:
               if(this.btn_arrowRight.state != StatesEnum.STATE_DISABLED && this._page < this._numPages)
               {
                  this.displayPage(++this._page);
               }
         }
         super.onRelease(target);
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               uiApi.unloadUi(uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         if(target == this.lbl_content)
         {
            openDebugEditionPanel(this.lbl_content,this._pages[0],480);
         }
      }
      
      override public function updateDocumentContent(pParentCtr:GraphicContainer, pNewText:String) : void
      {
         this._pages[0] = pNewText;
         this.preInitData();
         this._initScroll();
      }
      
      override public function copyAllDataToClipBoard() : void
      {
         sysApi.copyToClipboard(this._pages[0]);
      }
      
      public function onTextureReady(pTexture:Texture) : void
      {
         var r:Rectangle = null;
         var p:Point = null;
         if(pTexture == this.tx_illu)
         {
            if(this._updateIlluPosition)
            {
               this.tx_illu.height = Object(this.tx_illu.child).bitmapData.height;
               this.tx_illu.width = Object(this.tx_illu.child).bitmapData.width;
               r = uiApi.getVisibleStageBounds();
               p = this.tx_illu.getParent()["globalToLocal"](new Point(r.x + r.width / 2,r.y + r.height / 2));
               this.tx_illu.x = p.x - this.tx_illu.width / 2;
               this.tx_illu.y = p.y - this.tx_illu.height / 2;
               pTexture.visible = true;
               this.btn_close2.y = pTexture.y + 35;
            }
            if(this._showtitle)
            {
               this.showTitle(true);
            }
            if(this._btn_Close)
            {
               this._btn_Close.visible = true;
            }
            else
            {
               this.btn_close2.visible = true;
            }
         }
      }
   }
}
