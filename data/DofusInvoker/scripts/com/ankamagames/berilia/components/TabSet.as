package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.messages.CreateTabMessage;
   import com.ankamagames.berilia.components.messages.DeleteTabMessage;
   import com.ankamagames.berilia.components.messages.RenameTabMessage;
   import com.ankamagames.berilia.components.messages.SelectItemMessage;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.GraphicElement;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import flash.ui.Keyboard;
   import flash.utils.getQualifiedClassName;
   
   public class TabSet extends GraphicContainer implements FinalizableUIComponent
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TabSet));
       
      
      private var _nSelected:int = -1;
      
      private var _nPreviousSelected:int = -1;
      
      private var _nNbTabs:uint = 0;
      
      private var _nTotalWidth:uint = 0;
      
      private var _nNbTabsRequired:uint;
      
      private var _nCurrentMaxIndex:uint = 0;
      
      private var _aTabsList:Array;
      
      private var _aCtrs:Array;
      
      private var _aCloses:Array;
      
      private var _aLbls:Array;
      
      private var _aInputs:Array;
      
      private var _uiClass:UiRootContainer;
      
      private var _tabCtr:GraphicContainer;
      
      private var _btnPlus:ButtonContainer;
      
      private var _sBgTextureUri:Uri;
      
      private var _sCloseTextureUri:Uri;
      
      private var _sPlusTextureUri:Uri;
      
      private var _sTabCss:Uri;
      
      private var _nWidthTab:int;
      
      private var _nWidthLabel:int;
      
      private var _nHeightLabel:int;
      
      private var _nWidthPlusTab:int;
      
      private var _nXCloseTab:int;
      
      private var _nYCloseTab:int;
      
      private var _nXPlusTab:int;
      
      private var _nYPlusTab:int;
      
      private var _nXLabelTab:int;
      
      private var _nYLabelTab:int;
      
      private var _bNameEdition:Boolean = false;
      
      public function TabSet()
      {
         super();
         this._aTabsList = new Array();
         this._aCtrs = new Array();
         this._aCloses = new Array();
         this._aLbls = new Array();
         this._aInputs = new Array();
         this._tabCtr = new GraphicContainer();
         this._tabCtr.width = __width;
         this._tabCtr.height = __height;
         addChild(this._tabCtr);
      }
      
      public function get widthTab() : int
      {
         return this._nWidthTab;
      }
      
      public function set widthTab(i:int) : void
      {
         this._nWidthTab = i;
      }
      
      public function get widthLabel() : int
      {
         return this._nWidthLabel;
      }
      
      public function set widthLabel(i:int) : void
      {
         this._nWidthLabel = i;
      }
      
      public function get heightLabel() : int
      {
         return this._nHeightLabel;
      }
      
      public function set heightLabel(i:int) : void
      {
         this._nHeightLabel = i;
      }
      
      public function get widthPlusTab() : int
      {
         return this._nWidthPlusTab;
      }
      
      public function set widthPlusTab(i:int) : void
      {
         this._nWidthPlusTab = i;
      }
      
      public function get tabUri() : Uri
      {
         return this._sBgTextureUri;
      }
      
      public function set tabUri(s:Uri) : void
      {
         this._sBgTextureUri = s;
      }
      
      public function get closeUri() : Uri
      {
         return this._sCloseTextureUri;
      }
      
      public function set closeUri(s:Uri) : void
      {
         this._sCloseTextureUri = s;
      }
      
      public function get plusUri() : Uri
      {
         return this._sPlusTextureUri;
      }
      
      public function set plusUri(s:Uri) : void
      {
         this._sPlusTextureUri = s;
      }
      
      public function get cssUri() : Uri
      {
         return this._sTabCss;
      }
      
      public function set cssUri(s:Uri) : void
      {
         this._sTabCss = s;
      }
      
      public function get xClose() : int
      {
         return this._nXCloseTab;
      }
      
      public function set xClose(i:int) : void
      {
         this._nXCloseTab = i;
      }
      
      public function get yClose() : int
      {
         return this._nYCloseTab;
      }
      
      public function set yClose(i:int) : void
      {
         this._nYCloseTab = i;
      }
      
      public function get xLabel() : int
      {
         return this._nXLabelTab;
      }
      
      public function set xLabel(i:int) : void
      {
         this._nXLabelTab = i;
      }
      
      public function get yLabel() : int
      {
         return this._nYLabelTab;
      }
      
      public function set yLabel(i:int) : void
      {
         this._nYLabelTab = i;
      }
      
      public function get xPlus() : int
      {
         return this._nXPlusTab;
      }
      
      public function set xPlus(i:int) : void
      {
         this._nXPlusTab = i;
      }
      
      public function get yPlus() : int
      {
         return this._nYPlusTab;
      }
      
      public function set yPlus(i:int) : void
      {
         this._nYPlusTab = i;
      }
      
      public function get length() : int
      {
         return this._nNbTabs;
      }
      
      public function set length(i:int) : void
      {
         this._nNbTabsRequired = i;
         if(this._btnPlus && this._nNbTabsRequired >= 1)
         {
            if(this._nNbTabsRequired > this._nNbTabs)
            {
               while(this._nNbTabsRequired > this._nNbTabs)
               {
                  this.addTab();
               }
            }
            if(this._nNbTabsRequired < this._nNbTabs)
            {
               while(this._nNbTabsRequired < this._nNbTabs)
               {
                  this.removeTab();
               }
            }
         }
      }
      
      public function get tabCtr() : GraphicContainer
      {
         return this._tabCtr;
      }
      
      public function set tabCtr(ctr:GraphicContainer) : void
      {
         this._tabCtr = ctr;
      }
      
      public function get selectedTab() : int
      {
         return this._nSelected;
      }
      
      public function set selectedTab(i:int) : void
      {
         if(!this._aCtrs[i])
         {
            if(i < 0)
            {
               this.selectedTab = ++i;
            }
            else
            {
               this.selectedTab = --i;
            }
         }
         this._nPreviousSelected = this._nSelected;
         this._nSelected = i;
         if(this._nPreviousSelected != -1 && this._aCtrs[this._nPreviousSelected])
         {
            this._aCtrs[this._nPreviousSelected].selected = false;
            this._aCloses[this._nPreviousSelected].visible = false;
            this._aLbls[this._nPreviousSelected].cssClass = "p";
         }
         if(this._nSelected != -1)
         {
            this._aCtrs[this._nSelected].selected = false;
            this._aCtrs[this._nSelected].selected = true;
            this._aCloses[this._nSelected].visible = true;
         }
         if(UIEventManager.getInstance().isRegisteredInstance(this,SelectItemMessage))
         {
            Berilia.getInstance().handler.process(new SelectItemMessage(this,this._aCtrs[this._nSelected]));
         }
      }
      
      public function get lastTab() : int
      {
         return this._nNbTabs - 1;
      }
      
      public function set dataProvider(data:*) : void
      {
         if(!this.isIterable(data))
         {
            throw new ArgumentError("dataProvider must be either Array or Vector.");
         }
         this._aTabsList = data;
         this.finalize();
      }
      
      public function get dataProvider() : *
      {
         return this._aTabsList;
      }
      
      override public function finalize() : void
      {
         this._uiClass = getUi();
         if(this._aTabsList && this._aTabsList.length > 0)
         {
            this._nNbTabs = this._aTabsList.length;
            if(this._nNbTabs > 0)
            {
               this.tabsDisplay();
            }
         }
         else
         {
            this.tabsDisplay();
         }
         _finalized = true;
         super.finalize();
         if(this._uiClass)
         {
            this._uiClass.iAmFinalized(this);
         }
      }
      
      override public function remove() : void
      {
         if(!__removed)
         {
            this._uiClass = null;
            this._tabCtr.remove();
            this._btnPlus.remove();
            this._tabCtr = null;
            this._btnPlus = null;
         }
         super.remove();
      }
      
      public function highlight(tabId:uint, show:Boolean = true) : void
      {
         if(show)
         {
            this._aLbls[tabId].cssClass = "highlighted";
         }
         else
         {
            this._aLbls[tabId].cssClass = "p";
         }
      }
      
      public function renameTab(tabId:uint, name:String = null) : void
      {
         this._aInputs[this._nSelected].text = "";
         this._aLbls[tabId].caretIndex = 0;
         if(tabId >= this._nCurrentMaxIndex)
         {
            return;
         }
         if(this._aCtrs[tabId].selected)
         {
            this._aCtrs[tabId].selected = false;
            this._aLbls[tabId].text = name;
            this._aCtrs[tabId].reset();
            this._aCtrs[tabId].selected = true;
         }
         else
         {
            this._aLbls[tabId].text = name;
            this._aCtrs[tabId].reset();
         }
      }
      
      private function tabsDisplay() : void
      {
         this.addPlusTab();
         this.addTab();
         this.length = this._nNbTabsRequired;
         this.selectedTab = 0;
      }
      
      private function addTab() : void
      {
         var btn:ButtonContainer = new ButtonContainer();
         btn.soundId = "16009";
         btn.width = this._nWidthTab;
         btn.height = __height;
         btn.name = "btn_tab" + this._nCurrentMaxIndex;
         var texBg:Texture = new Texture();
         texBg.width = this._nWidthTab;
         texBg.height = __height;
         texBg.autoGrid = true;
         texBg.uri = this._sBgTextureUri;
         texBg.name = "tx_bgTab" + this._nCurrentMaxIndex;
         texBg.finalize();
         var lbl:Label = new Label();
         lbl.width = this._nWidthLabel;
         lbl.height = this._nHeightLabel;
         lbl.x = this._nXLabelTab;
         lbl.y = this._nYLabelTab;
         lbl.css = this._sTabCss;
         lbl.cssClass = "p";
         lbl.name = "lbl_tab" + this._nCurrentMaxIndex;
         lbl.text = "tab " + (this._nCurrentMaxIndex + 1);
         var inp:Input = new Input();
         inp.width = this._nWidthLabel;
         inp.height = this._nHeightLabel;
         inp.x = this._nXLabelTab;
         inp.y = this._nYLabelTab;
         inp.css = this._sTabCss;
         inp.cssClass = "p";
         inp.name = "inp_tab" + this._nCurrentMaxIndex;
         btn.addChild(texBg);
         btn.addChild(lbl);
         btn.addChild(inp);
         getUi().registerId(btn.name,new GraphicElement(btn,null,btn.name));
         getUi().registerId(texBg.name,new GraphicElement(texBg,null,texBg.name));
         getUi().registerId(lbl.name,new GraphicElement(lbl,null,lbl.name));
         getUi().registerId(inp.name,new GraphicElement(inp,null,inp.name));
         var stateChangingProperties:Array = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER] = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER][texBg.name] = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER][texBg.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         stateChangingProperties[StatesEnum.STATE_CLICKED] = new Array();
         stateChangingProperties[StatesEnum.STATE_CLICKED][texBg.name] = new Array();
         stateChangingProperties[StatesEnum.STATE_CLICKED][texBg.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         stateChangingProperties[StatesEnum.STATE_SELECTED] = new Array();
         stateChangingProperties[StatesEnum.STATE_SELECTED][texBg.name] = new Array();
         stateChangingProperties[StatesEnum.STATE_SELECTED][texBg.name]["gotoAndStop"] = StatesEnum.STATE_SELECTED_STRING.toLocaleLowerCase();
         stateChangingProperties[StatesEnum.STATE_SELECTED][lbl.name] = new Array();
         stateChangingProperties[StatesEnum.STATE_SELECTED][lbl.name]["cssClass"] = "selected";
         btn.changingStateData = stateChangingProperties;
         btn.finalize();
         var btnClose:ButtonContainer = new ButtonContainer();
         btnClose.x = this._nXCloseTab;
         btnClose.y = this._nYCloseTab;
         btnClose.width = this._nWidthPlusTab;
         btnClose.height = __height;
         btnClose.name = "btn_closeTab" + this._nCurrentMaxIndex;
         var texClose:Texture = new Texture();
         texClose.uri = this._sCloseTextureUri;
         texClose.name = "tx_closeTab" + this._nCurrentMaxIndex;
         texClose.finalize();
         btnClose.addChild(texClose);
         getUi().registerId(btnClose.name,new GraphicElement(btnClose,null,btnClose.name));
         getUi().registerId(texClose.name,new GraphicElement(texClose,null,texClose.name));
         var stateChangingPropertiesClose:Array = new Array();
         stateChangingPropertiesClose[StatesEnum.STATE_OVER] = new Array();
         stateChangingPropertiesClose[StatesEnum.STATE_OVER][texClose.name] = new Array();
         stateChangingPropertiesClose[StatesEnum.STATE_OVER][texClose.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         stateChangingPropertiesClose[StatesEnum.STATE_CLICKED] = new Array();
         stateChangingPropertiesClose[StatesEnum.STATE_CLICKED][texClose.name] = new Array();
         stateChangingPropertiesClose[StatesEnum.STATE_CLICKED][texClose.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         btnClose.changingStateData = stateChangingPropertiesClose;
         btnClose.finalize();
         btnClose.visible = false;
         this._tabCtr.addChild(btn);
         this._tabCtr.addChild(btnClose);
         this._aCtrs[this._nNbTabs] = btn;
         this._aCloses[this._nNbTabs] = btnClose;
         this._aLbls[this._nNbTabs] = lbl;
         this._aInputs[this._nNbTabs] = inp;
         this._nTotalWidth += this._nWidthTab;
         ++this._nCurrentMaxIndex;
         this.replaceTab();
      }
      
      private function addPlusTab() : void
      {
         this._btnPlus = new ButtonContainer();
         this._btnPlus.soundId = "16090";
         this._btnPlus.width = this._nWidthPlusTab;
         this._btnPlus.height = __height;
         this._btnPlus.name = "btn_plus";
         var texBgPlus:Texture = new Texture();
         texBgPlus.width = this._nWidthPlusTab;
         texBgPlus.height = __height;
         texBgPlus.autoGrid = true;
         texBgPlus.uri = this._sBgTextureUri;
         texBgPlus.name = "tx_bgPlus";
         texBgPlus.finalize();
         var texPlus:Texture = new Texture();
         texPlus.x = this._nXPlusTab;
         texPlus.y = this._nYPlusTab;
         texPlus.uri = this._sPlusTextureUri;
         texPlus.name = "tx_plus";
         texPlus.finalize();
         this._btnPlus.addChild(texBgPlus);
         this._btnPlus.addChild(texPlus);
         getUi().registerId(this._btnPlus.name,new GraphicElement(this._btnPlus,null,this._btnPlus.name));
         getUi().registerId(texBgPlus.name,new GraphicElement(texBgPlus,null,texBgPlus.name));
         getUi().registerId(texPlus.name,new GraphicElement(texPlus,null,texPlus.name));
         addChild(this._btnPlus);
         var stateChangingProperties:Array = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER] = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER][texBgPlus.name] = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER][texBgPlus.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         stateChangingProperties[StatesEnum.STATE_OVER][texPlus.name] = new Array();
         stateChangingProperties[StatesEnum.STATE_OVER][texPlus.name]["gotoAndStop"] = StatesEnum.STATE_OVER_STRING.toLocaleLowerCase();
         stateChangingProperties[StatesEnum.STATE_CLICKED] = new Array();
         stateChangingProperties[StatesEnum.STATE_CLICKED][texBgPlus.name] = new Array();
         stateChangingProperties[StatesEnum.STATE_CLICKED][texBgPlus.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         stateChangingProperties[StatesEnum.STATE_CLICKED][texPlus.name] = new Array();
         stateChangingProperties[StatesEnum.STATE_CLICKED][texPlus.name]["gotoAndStop"] = StatesEnum.STATE_CLICKED_STRING.toLocaleLowerCase();
         this._btnPlus.changingStateData = stateChangingProperties;
         this._btnPlus.finalize();
         this._nTotalWidth += this._nWidthPlusTab;
      }
      
      private function removeTab() : void
      {
         var indexAlmostRemoved:int = 0;
         if(this._nNbTabs > 1)
         {
            indexAlmostRemoved = this._nSelected;
            this._nPreviousSelected = indexAlmostRemoved - 1;
            this.removeContainerContent(this._aCtrs[indexAlmostRemoved]);
            this._aCtrs.splice(indexAlmostRemoved,1);
            this.removeContainerContent(this._aCloses[indexAlmostRemoved]);
            this._aCloses.splice(indexAlmostRemoved,1);
            this._aLbls.splice(indexAlmostRemoved,1);
            this._nTotalWidth -= this._nWidthTab;
            this.replaceTab();
            this.selectedTab = this._nPreviousSelected;
         }
      }
      
      private function replaceTab() : void
      {
         var index:* = undefined;
         var currentPos:int = 0;
         for(index in this._aCtrs)
         {
            this._aCtrs[index].state = 0;
            this._aCtrs[index].x = currentPos;
            this._aCloses[index].x = currentPos + this._nXCloseTab;
            this._aCtrs[index].reset();
            currentPos += this._aCtrs[index].width;
         }
         this._btnPlus.x = currentPos;
         if(this._nSelected == -1)
         {
            this.selectedTab = index;
         }
         this._nNbTabs = this._aCtrs.length;
         if(this._nTotalWidth + this._nWidthTab < __width)
         {
            this._btnPlus.visible = true;
         }
         else
         {
            this._btnPlus.visible = false;
         }
      }
      
      private function isIterable(obj:*) : Boolean
      {
         if(obj is Array)
         {
            return true;
         }
         if(obj["length"] != null && obj["length"] != 0 && !isNaN(obj["length"]) && obj[0] != null && !(obj is String))
         {
            return true;
         }
         return false;
      }
      
      private function removeContainerContent(target:GraphicContainer) : void
      {
         target.remove();
      }
      
      private function switchToEdition(value:Boolean) : void
      {
         this._bNameEdition = value;
         if(value)
         {
            this._aInputs[this._nSelected].text = this._aLbls[this._nSelected].text;
            this._aInputs[this._nSelected].focus();
            this._aInputs[this._nSelected].setSelection(0,this._aInputs[this._nSelected].text.length);
         }
         this._aInputs[this._nSelected].disabled = !value;
         this._aInputs[this._nSelected].visible = value;
         this._aLbls[this._nSelected].visible = !value;
      }
      
      override public function process(msg:Message) : Boolean
      {
         var mcm:MouseClickMessage = null;
         var mrcm:MouseRightClickMessage = null;
         var kkum:KeyboardKeyUpMessage = null;
         var name:String = null;
         var i:* = undefined;
         var nameEdition:String = null;
         switch(true)
         {
            case msg is MouseClickMessage:
               mcm = msg as MouseClickMessage;
               if(this._bNameEdition)
               {
                  this._bNameEdition = false;
                  name = this._aInputs[this._nSelected].text;
                  this.renameTab(this._nSelected,name);
                  if(UIEventManager.getInstance().isRegisteredInstance(this,RenameTabMessage))
                  {
                     Berilia.getInstance().handler.process(new RenameTabMessage(this,this._nSelected,name));
                  }
               }
               switch(mcm.target.name)
               {
                  case this._btnPlus.name:
                     if(this._nTotalWidth + this._nWidthTab < __width)
                     {
                        this.addTab();
                        this.selectedTab = this._nNbTabs - 1;
                        if(UIEventManager.getInstance().isRegisteredInstance(this,CreateTabMessage))
                        {
                           Berilia.getInstance().handler.process(new CreateTabMessage(this));
                        }
                     }
                     break;
                  default:
                     for(i in this._aCtrs)
                     {
                        if(mcm.target == this._aCtrs[i])
                        {
                           this.selectedTab = i;
                        }
                     }
                     if(mcm.target == this._aCloses[this._nSelected])
                     {
                        if(this._nNbTabs > 1)
                        {
                           if(UIEventManager.getInstance().isRegisteredInstance(this,DeleteTabMessage))
                           {
                              Berilia.getInstance().handler.process(new DeleteTabMessage(this,this._nSelected));
                           }
                           this.removeTab();
                        }
                     }
               }
               break;
            case msg is MouseRightClickMessage:
               mrcm = msg as MouseRightClickMessage;
               if(mrcm.target == this._aCtrs[this._nSelected] && !this._bNameEdition)
               {
                  this.switchToEdition(true);
               }
               else if(this._bNameEdition)
               {
                  this.switchToEdition(false);
               }
               break;
            case msg is KeyboardKeyUpMessage:
               kkum = msg as KeyboardKeyUpMessage;
               if(this._bNameEdition)
               {
                  if(kkum.keyboardEvent.keyCode == Keyboard.ENTER)
                  {
                     this._bNameEdition = false;
                     nameEdition = this._aInputs[this._nSelected].text;
                     this.renameTab(this._nSelected,nameEdition);
                     if(UIEventManager.getInstance().isRegisteredInstance(this,RenameTabMessage))
                     {
                        Berilia.getInstance().handler.process(new RenameTabMessage(this,this._nSelected,nameEdition));
                     }
                  }
                  else if(kkum.keyboardEvent.keyCode == Keyboard.ESCAPE)
                  {
                     this.switchToEdition(false);
                  }
               }
         }
         return false;
      }
   }
}
