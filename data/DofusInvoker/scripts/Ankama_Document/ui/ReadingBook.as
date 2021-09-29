package Ankama_Document.ui
{
   import Ankama_Common.Common;
   import Ankama_Document.data.ImageData;
   import Ankama_Document.data.LinkData;
   import Ankama_Document.tools.HtmlParser;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.documents.Document;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.uiApi.CaptureApi;
   import com.ankamagames.dofus.uiApi.DocumentApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   import flash.utils.Dictionary;
   
   public class ReadingBook extends DocumentBase
   {
      
      private static const LINKPAGE:String = "linkpage";
      
      private static const CLICKPAGE:String = "clickpage";
      
      private static const IMG_PADDING:int = 5;
       
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Api(name="DocumentApi")]
      public var docApi:DocumentApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="CaptureApi")]
      public var captureApi:CaptureApi;
      
      public var btn_home:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_previous:ButtonContainer;
      
      public var btn_next:ButtonContainer;
      
      public var page_title:GraphicContainer;
      
      public var page_left:GraphicContainer;
      
      public var page_right:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var lbl_subtitle:Label;
      
      public var lbl_author:Label;
      
      public var tx_deco:Texture;
      
      public var lbl_content_left:TextArea;
      
      public var lbl_content_right:TextArea;
      
      public var lbl_page_number_left:Label;
      
      public var lbl_page_number_right:Label;
      
      public var tx_pageLeft:Texture;
      
      public var tx_pageRight:Texture;
      
      public var mainCtr:GraphicContainer;
      
      private var _leftPageTextureList:Vector.<Texture>;
      
      private var _rightPageTextureList:Vector.<Texture>;
      
      private var _title:String;
      
      private var _author:String;
      
      private var _subTitle:String;
      
      private var _pages:Array;
      
      private var _styleSheet:StyleSheet;
      
      private var _lastIndex:int;
      
      private var _currentIndex:int;
      
      private var _nbPages:uint;
      
      private var _bmpDataLeft:BitmapData;
      
      private var _bmpDataRight:BitmapData;
      
      private var _loadingData:Dictionary;
      
      private var _rectList:Vector.<LinkData>;
      
      public function ReadingBook()
      {
         this._leftPageTextureList = new Vector.<Texture>();
         this._rightPageTextureList = new Vector.<Texture>();
         this._loadingData = new Dictionary(true);
         this._rectList = new Vector.<LinkData>();
         super();
      }
      
      public function main(params:Object) : void
      {
         var page:Object = null;
         this.soundApi.playSound(SoundTypeEnum.DOCUMENT_OPEN);
         this.btn_home.soundId = SoundEnum.EMPTY;
         this.btn_close.soundId = SoundEnum.EMPTY;
         this.btn_next.soundId = SoundEnum.EMPTY;
         this.btn_previous.soundId = SoundEnum.EMPTY;
         uiApi.addShortcutHook("closeUi",this.onShortcut);
         uiApi.addShortcutHook("rightArrow",this.onShortcut);
         uiApi.addShortcutHook("leftArrow",this.onShortcut);
         this.lbl_content_left.textfield.mouseEnabled = true;
         this.lbl_content_right.textfield.mouseEnabled = true;
         this.lbl_page_number_left.textfield.mouseEnabled = true;
         this.lbl_page_number_right.textfield.mouseEnabled = true;
         uiApi.addComponentHook(this.lbl_page_number_left,"onTextClick");
         uiApi.addComponentHook(this.lbl_page_number_right,"onTextClick");
         uiApi.addComponentHook(this.page_left,"onRelease");
         uiApi.addComponentHook(this.page_right,"onRelease");
         uiApi.addComponentHook(this.tx_pageLeft,"onTextureReady");
         uiApi.addComponentHook(this.tx_pageRight,"onTextureReady");
         var document:Document = this.docApi.getDocument(params.documentId);
         this._title = document.title;
         this._author = document.author;
         this._subTitle = document.subTitle;
         if(document.contentCSS && document.contentCSS != "null")
         {
            this._styleSheet = new StyleSheet();
            this._styleSheet.parseCSS(document.contentCSS);
            overrideLinkStyleInCss(this._styleSheet);
            this.lbl_content_left.setStyleSheet(this._styleSheet);
            this.lbl_content_right.setStyleSheet(this._styleSheet);
         }
         this._pages = [];
         for each(page in document.pages)
         {
            this._pages.push(page);
         }
         this._lastIndex = -1;
         this._currentIndex = -1;
         this._nbPages = this._pages.length;
         this._initBook();
         if(sysApi.getBuildType() == 4 || sysApi.getBuildType() == 5)
         {
            uiApi.addComponentHook(this.tx_pageLeft,"onDoubleClick");
            uiApi.addComponentHook(this.tx_pageRight,"onDoubleClick");
         }
         this._updateButtons();
         this._updateBook();
      }
      
      public function unload() : void
      {
         if(this._bmpDataRight != null)
         {
            this._bmpDataRight.dispose();
         }
         if(this._bmpDataLeft != null)
         {
            this._bmpDataLeft.dispose();
         }
         this.clearTextures();
         this.clearLinks();
         this.soundApi.playSound(SoundTypeEnum.DOCUMENT_CLOSE);
         sysApi.enableWorldInteraction();
         uiApi.hideTooltip();
      }
      
      private function clearTextures(pPage:String = "") : void
      {
         var t:* = undefined;
         if(pPage == "left" || pPage == "all" || pPage == "")
         {
            while((t = this._leftPageTextureList.pop()) != null)
            {
               this._loadingData[t] = null;
               this.mainCtr.removeChild(t);
               t.free();
               t = null;
            }
            this._leftPageTextureList = new Vector.<Texture>();
         }
         if(pPage == "left" || pPage == "all" || pPage == "")
         {
            while((t = this._rightPageTextureList.pop()) != null)
            {
               this._loadingData[t] = null;
               this.mainCtr.removeChild(t);
               t.free();
               t = null;
            }
            this._rightPageTextureList = new Vector.<Texture>();
         }
      }
      
      private function _initBook() : void
      {
         this.lbl_title.text = "<b>" + this._title + "</b>";
         this.lbl_subtitle.text = this._subTitle;
         this.lbl_author.text = this._author == null ? "" : "<b>" + this._author + "</b>";
         this.lbl_subtitle.x = 615;
         this.lbl_subtitle.y = this.lbl_title.y + this.lbl_title.textHeight + 20;
         this.tx_deco.x = 779;
         this.tx_deco.y = this.lbl_subtitle.y + this.lbl_subtitle.textHeight + 20;
      }
      
      private function _updateBook() : void
      {
         if(this._currentIndex == -1)
         {
            if(this._lastIndex > 2)
            {
               this.soundApi.playSound(SoundTypeEnum.DOCUMENT_BACK_FIRST_PAGE);
            }
            else
            {
               this.soundApi.playSound(SoundTypeEnum.DOCUMENT_TURN_PAGE);
            }
            this.page_title.visible = true;
            this.page_left.visible = false;
            this.page_right.visible = false;
            this.lbl_page_number_left.visible = false;
            this.lbl_page_number_right.visible = true;
            this.lbl_page_number_right.text = "<a href=\"event:" + CLICKPAGE + (this._currentIndex + 1) + "\">" + (this._currentIndex + 2) + "</a>";
         }
         else
         {
            this.clearTextures();
            this.soundApi.playSound(SoundTypeEnum.DOCUMENT_TURN_PAGE);
            this.page_title.visible = false;
            this.page_left.visible = true;
            this.page_right.visible = true;
            this.lbl_page_number_left.visible = true;
            this.lbl_page_number_right.visible = true;
            this.clearLinks();
            this._rectList = new Vector.<LinkData>();
            this._updatePageLeft();
            this._updatePageRight();
         }
         this._lastIndex = this._currentIndex;
      }
      
      private function _updatePageLeft() : void
      {
         var text:* = null;
         if(this._styleSheet)
         {
            text = formateText(this._pages[this._currentIndex - 1]) + "\n\n";
         }
         else
         {
            text = HtmlParser.parseText(this._pages[this._currentIndex - 1]);
         }
         this.tx_pageLeft.dispatchMessages = true;
         this._bmpDataLeft = this.getBitmap(this.lbl_content_left,text,"left");
         this.tx_pageLeft.loadBitmapData(this._bmpDataLeft);
         this.lbl_page_number_left.text = "<a href=\"event:" + CLICKPAGE + this._currentIndex + "\">" + (this._currentIndex + 1) + "</a>";
      }
      
      private function _updatePageRight() : void
      {
         var text:* = null;
         if(this._currentIndex < this._nbPages)
         {
            if(!this.tx_pageRight.visible)
            {
               this.tx_pageRight.visible = true;
            }
            if(this._styleSheet)
            {
               text = formateText(this._pages[this._currentIndex]) + "\n\n";
            }
            else
            {
               text = HtmlParser.parseText(this._pages[this._currentIndex]);
            }
            this.tx_pageRight.dispatchMessages = true;
            this._bmpDataRight = this.getBitmap(this.lbl_content_right,text,"right");
            this.tx_pageRight.loadBitmapData(this._bmpDataRight);
            this.lbl_page_number_right.text = "<a href=\"event:" + CLICKPAGE + (this._currentIndex + 1) + "\">" + (this._currentIndex + 2) + "</a>";
         }
         else
         {
            this.tx_pageRight.visible = false;
            this.lbl_page_number_right.text = "";
         }
      }
      
      private function _updateButtons() : void
      {
         if(this._currentIndex == -1)
         {
            this.btn_home.visible = false;
            this.btn_previous.visible = false;
            this.btn_next.visible = true;
         }
         else if(this._currentIndex + 1 >= this._nbPages)
         {
            this.btn_home.visible = true;
            this.btn_previous.visible = true;
            this.btn_next.visible = false;
         }
         else
         {
            this.btn_home.visible = true;
            this.btn_previous.visible = true;
            this.btn_next.visible = true;
         }
      }
      
      private function _selectPage(index:int) : void
      {
         this._currentIndex = !!(index % 2) ? int(index) : int(index + 1);
         this._updateButtons();
         this._updateBook();
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var l:LinkData = null;
         switch(target)
         {
            case this.btn_home:
               super.hideDebugEditionPanel();
               this._currentIndex = -1;
               this._updateButtons();
               this._updateBook();
               break;
            case this.btn_close:
               super.hideDebugEditionPanel();
               sysApi.sendAction(new LeaveDialogRequestAction([]));
               uiApi.unloadUi(uiApi.me().name);
               break;
            case this.btn_previous:
               super.hideDebugEditionPanel();
               this._currentIndex -= 2;
               this._updateButtons();
               this._updateBook();
               break;
            case this.btn_next:
               super.hideDebugEditionPanel();
               this._currentIndex += 2;
               this._updateButtons();
               this._updateBook();
               break;
            default:
               for each(l in this._rectList)
               {
                  if(target == l.graphic)
                  {
                     this.onTextClick(target,l.href);
                     return;
                  }
               }
         }
         super.onRelease(target);
      }
      
      private function onValidPage(page:Number) : void
      {
         this._selectPage(int(page) - 2);
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.lbl_page_number_left:
            case this.lbl_page_number_right:
               tooltipText = uiApi.getText("ui.common.choosePageNumber");
               point = 0;
               relPoint = 2;
               break;
            case this.btn_close:
               tooltipText = uiApi.getText("ui.common.close");
               break;
            case this.btn_home:
               tooltipText = uiApi.getText("ui.book.titlePage");
               break;
            case this.btn_previous:
               tooltipText = uiApi.getText("ui.book.prevPage");
               break;
            case this.btn_next:
               tooltipText = uiApi.getText("ui.book.nextPage");
         }
         uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onTextClick(target:Object, textEvent:String) : void
      {
         var index:int = 0;
         linkHandler(textEvent);
         if(textEvent.indexOf(LINKPAGE) != -1)
         {
            index = int(textEvent.substr(LINKPAGE.length));
            this._selectPage(index);
         }
         else if(textEvent.indexOf(CLICKPAGE) != -1)
         {
            uiApi.hideTooltip();
            this.modCommon.openQuantityPopup(1,this._nbPages,int(textEvent.substr(CLICKPAGE.length)) + 1,this.onValidPage);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var isDebugModeOpen:Boolean = debugModeIsOpen();
         switch(s)
         {
            case "rightArrow":
               if(this.btn_next.visible && !isDebugModeOpen)
               {
                  hideDebugEditionPanel();
                  this._currentIndex += 2;
                  this._updateButtons();
                  this._updateBook();
               }
               return true;
            case "leftArrow":
               if(this.btn_previous.visible && !isDebugModeOpen)
               {
                  hideDebugEditionPanel();
                  this._currentIndex -= 2;
                  this._updateButtons();
                  this._updateBook();
               }
               return true;
            case "closeUi":
               hideDebugEditionPanel();
               sysApi.sendAction(new LeaveDialogRequestAction([]));
               uiApi.unloadUi(uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      private function getBitmap(lbl:TextArea, str:String, page:String) : BitmapData
      {
         var image:ImageData = null;
         var bmpData:BitmapData = new BitmapData(lbl.width,lbl.height,true,16711680);
         var images:Vector.<ImageData> = getAllImagesData(str);
         var ypos:int = 0;
         var m:Matrix = new Matrix();
         if(images.length == 0)
         {
            m.translate(0,ypos);
            lbl.text = str;
            this.addTextToBitmap(bmpData,lbl,m);
         }
         else
         {
            for each(image in images)
            {
               m.identity();
               if(image.before != "")
               {
                  m.translate(0,ypos);
                  lbl.text = image.before;
                  this.addTextToBitmap(bmpData,lbl,m);
                  ypos += lbl.textHeight;
               }
               this.addImageToBitmap(bmpData,image,ypos,page);
               ypos += image.height;
               str = str.replace(image.regExpResult,"");
            }
            if(str != "")
            {
               m.identity();
               m.translate(0,ypos);
               lbl.text = str;
               this.addTextToBitmap(bmpData,lbl,m);
            }
         }
         return bmpData;
      }
      
      private function addTextToBitmap(bmpData:BitmapData, lbl:TextArea, m:Matrix) : void
      {
         bmpData.draw(lbl.bmpText as BitmapData,m);
         this.formateLinks(lbl,bmpData);
      }
      
      private function addImageToBitmap(bmpData:BitmapData, image:ImageData, ypos:int, page:String) : void
      {
         var uriBase:String = uiApi.me().getConstant("illus");
         var texture:Texture = uiApi.createComponent("Texture") as Texture;
         texture.visible = false;
         texture.uri = uiApi.createUri(uriBase + image.src);
         texture.y = ypos;
         texture.cacheAsBitmap = true;
         texture.dispatchMessages = true;
         uiApi.addComponentHook(texture,"onTextureReady");
         if(page == "left")
         {
            this._leftPageTextureList.push(texture);
         }
         else
         {
            this._rightPageTextureList.push(texture);
         }
         this._loadingData[texture] = {
            "bitmapdata":bmpData,
            "width":image.width,
            "height":image.height,
            "align":image.align,
            "x":image.x,
            "y":image.y
         };
         texture.finalize();
         this.mainCtr.addChild(texture);
      }
      
      public function onTextureReady(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.tx_pageLeft:
               this.finalizePage(this.page_left,"left");
               break;
            case this.tx_pageRight:
               this.finalizePage(this.page_right,"right");
               break;
            default:
               if(this._leftPageTextureList.indexOf(target as Texture) != -1)
               {
                  this.addTextureOnPage(this.page_left,target);
               }
               else
               {
                  this.addTextureOnPage(this.page_right,target);
               }
         }
      }
      
      private function addTextureOnPage(page:GraphicContainer, target:DisplayObject) : void
      {
         var bmpData:BitmapData = this._loadingData[target].bitmapdata;
         var posX:int = target.x;
         var posY:int = target.y;
         var textureData:Object = this._loadingData[target];
         if(textureData.width == null || textureData.width == 0)
         {
            textureData.width = target.width;
         }
         if(textureData.height == null || textureData.height == 0)
         {
            textureData.height = target.height;
         }
         var scaleX:Number = 1;
         if(textureData.width != null && textureData.width > 0)
         {
            scaleX = textureData.width / target.width;
         }
         var scaleY:Number = 1;
         if(textureData.height != null && textureData.height > 0)
         {
            scaleY = textureData.height / target.height;
         }
         switch(textureData.align)
         {
            case "right":
               posX = page.width - textureData.width;
               break;
            case "center":
               posX = (page.width - textureData.width) / 2;
               break;
            case "left":
            default:
               posX = 0;
         }
         posX += textureData.x;
         posY += textureData.y;
         var m:Matrix = new Matrix();
         m.scale(scaleX,scaleY);
         m.translate(posX,posY);
         var bmp:Bitmap = new Bitmap(this.captureApi.getFromTarget(target,null,1,true));
         bmpData.draw(bmp,m);
      }
      
      private function finalizePage(tx:GraphicContainer, page:String) : void
      {
         var l:LinkData = null;
         for each(l in this._rectList)
         {
            if(l.page == page)
            {
               l.parent = tx;
            }
         }
      }
      
      private function clearLinks() : void
      {
         var l:LinkData = null;
         if(this._rectList == null)
         {
            return;
         }
         for each(l in this._rectList)
         {
            l.destroy();
         }
      }
      
      private function formateLinks(lbl:TextArea, bmpData:BitmapData) : void
      {
         var ctr:GraphicContainer = null;
         var link:LinkData = null;
         var startIndex:int = 0;
         var box:Rectangle = null;
         var rect:Rectangle = null;
         var i:int = 0;
         var len:int = 0;
         var strText:String = lbl.text;
         var htmlText:String = lbl.textfield.htmlText;
         var links:Vector.<LinkData> = getAllLinks(htmlText);
         for each(link in links)
         {
            startIndex = strText.indexOf(link.text);
            box = lbl.textfield.getCharBoundaries(startIndex);
            rect = box.clone();
            len = link.text.length;
            for(i = 1; i < len; i++)
            {
               box = lbl.textfield.getCharBoundaries(startIndex + i);
               if(box != null)
               {
                  rect.width += box.width;
               }
            }
            ctr = uiApi.createContainer("GraphicContainer") as GraphicContainer;
            link.setGraphicData(ctr,this.mainCtr,rect,new Point(lbl.x + 91,lbl.y + 22));
            uiApi.addComponentHook(ctr,"onRelease");
            this._rectList.push(link);
         }
         links = null;
      }
      
      private function getNbOccurrencesInSentence(findText:String, inText:String) : int
      {
         var startIndex:int = 0;
         var index:int = 0;
         var subText:String = inText;
         while((startIndex = subText.search(findText)) != -1)
         {
            index++;
            subText = subText.substr(startIndex + findText.length);
         }
         return index;
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.tx_pageLeft:
               openDebugEditionPanel(this.page_right,this._pages[this._currentIndex - 1],this.tx_pageRight.x,this.tx_pageRight.y);
               break;
            case this.tx_pageRight:
               openDebugEditionPanel(this.page_left,this._pages[this._currentIndex],this.tx_pageLeft.x,this.tx_pageLeft.y);
         }
      }
      
      override public function updateDocumentContent(pParentCtr:GraphicContainer, pNewText:String) : void
      {
         switch(pParentCtr)
         {
            case this.page_right:
               this._pages[this._currentIndex - 1] = pNewText;
               this.clearTextures("left");
               this._updatePageLeft();
               break;
            case this.page_left:
               this._pages[this._currentIndex] = pNewText;
               this.clearTextures("right");
               this._updatePageRight();
         }
      }
      
      override public function copyAllDataToClipBoard() : void
      {
         var i:int = 0;
         var result:String = "";
         var len:int = this._pages.length;
         for(i = 0; i < len; i++)
         {
            result += this._pages[i] + (i < len - 1 ? "<pagefeed/>" : "");
         }
         sysApi.copyToClipboard(result);
      }
   }
}
