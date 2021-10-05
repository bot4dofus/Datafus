package Ankama_Grimoire.ui
{
   import Ankama_Grimoire.enum.EnumTab;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.ScrollContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.jerakine.types.Uri;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   
   public class GameplayClassWindow
   {
      
      private static const SUBTITLE:String = "subtitle";
      
      private static const TITLE:String = "title";
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      private var _characterInfos;
      
      private var _isUnloading:Boolean;
      
      private var _resetPopupName:String;
      
      public var gameplayClassWindow:GraphicContainer;
      
      public var ctr_charTitleButton:GraphicContainer;
      
      private var tabSpell:GraphicContainer;
      
      public var scroll_mecanic:ScrollContainer;
      
      public var lbl_class:Label;
      
      public var lbl_mecanicTitle:Label;
      
      public var lbl_mecanicDesc:Label;
      
      public var tx_basicCharPortrait:Texture;
      
      public var tx_mecanicIcon:Texture;
      
      public function GameplayClassWindow()
      {
         super();
      }
      
      public function main(params:Object) : void
      {
         this._isUnloading = false;
         this.soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_OPEN);
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
         this.uiApi.addShortcutHook("closeUi",this.onShortCut);
         this.uiApi.addComponentHook(this.ctr_charTitleButton,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_charTitleButton,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_charTitleButton,ComponentHookList.ON_ROLL_OUT);
         this._characterInfos = this.playerApi.getPlayedCharacterInfo();
         var charSexString:String = !!this._characterInfos.sex ? "1" : "0";
         var charPortraitUri:* = this.uiApi.me().getConstant("illus_uri") + this._characterInfos.breed + "_" + charSexString + ".png";
         this.tx_basicCharPortrait.uri = this.uiApi.createUri(charPortraitUri);
         this.createMecanic();
      }
      
      private function createMecanic() : void
      {
         var nodeName:String = null;
         var node:XML = null;
         var xmlText:* = "<desc>\n" + this.dataApi.getBreed(this._characterInfos.breed).gameplayClassDescription + "\n</desc>";
         var formatedDescription:XML = XML(xmlText);
         this.scroll_mecanic.verticalScrollSpeed = 20;
         var iconId:int = 0;
         var title:String = "";
         var desc:* = "";
         var statesUri:String = this.uiApi.me().getConstant("states_uri");
         var groupPos:int = 0;
         var marginY:int = 30;
         var oldNodeName:String = "base";
         for each(node in formatedDescription.children())
         {
            nodeName = node.name();
            if(nodeName == TITLE || nodeName == SUBTITLE)
            {
               if(desc != "")
               {
                  groupPos += !(oldNodeName == TITLE || oldNodeName == SUBTITLE) ? marginY : 0;
                  groupPos += this.addDesc(groupPos,desc);
                  desc = "";
               }
               iconId = 0;
               if((iconId = parseInt(node.attribute("iconSpellId"))) > 0)
               {
                  this.addIcon(new Vector3D(15,15),oldNodeName,groupPos,marginY,this.dataApi.getSpellWrapper(iconId).iconUri);
               }
               else if((iconId = parseInt(node.attribute("iconStateId"))) > 0)
               {
                  this.addIcon(new Vector3D(40,60),oldNodeName,groupPos,marginY,this.uiApi.createUri(statesUri + this.dataApi.getSpellState(iconId).icon));
               }
               this.addTitle(title,node,iconId,nodeName,marginY,oldNodeName,groupPos);
               groupPos += oldNodeName == "base" ? 0 : (iconId > 0 || nodeName == TITLE ? marginY : 0);
               groupPos += this.tx_mecanicIcon.height;
            }
            else
            {
               if(desc != "")
               {
                  desc += " ";
               }
               desc += !!node.name() ? node.toXMLString() : node.toString();
            }
            oldNodeName = nodeName;
         }
         if(desc != "")
         {
            groupPos += marginY;
            groupPos += this.addDesc(groupPos,desc);
            groupPos += marginY;
            this.addDesc(groupPos,"");
         }
      }
      
      private function addDesc(groupPos:int, desc:String) : int
      {
         var labelDesc:Label = new Label();
         labelDesc.width = this.lbl_mecanicDesc.width;
         labelDesc.x = this.lbl_mecanicDesc.x;
         labelDesc.y = this.lbl_mecanicDesc.y + groupPos;
         labelDesc.multiline = this.lbl_mecanicDesc.multiline;
         labelDesc.wordWrap = this.lbl_mecanicDesc.wordWrap;
         labelDesc.css = this.lbl_mecanicDesc.css;
         labelDesc.cssClass = this.lbl_mecanicDesc.cssClass;
         labelDesc.htmlText = desc;
         labelDesc.height = labelDesc.textHeight;
         this.scroll_mecanic.addContent(labelDesc);
         return labelDesc.height;
      }
      
      private function addTitle(title:String, node:XML, iconId:int, nodeName:String, marginY:int, oldNodeName:String, groupPos:int) : void
      {
         title = node.toString();
         var labelTitle:Label = new Label();
         labelTitle.x = iconId <= 0 ? (nodeName == SUBTITLE ? Number(marginY) : Number(this.tx_mecanicIcon.x)) : Number(this.lbl_mecanicTitle.x);
         labelTitle.y = oldNodeName == "base" ? Number(this.lbl_mecanicTitle.y) : Number(this.lbl_mecanicTitle.y + groupPos + (oldNodeName == TITLE && nodeName != SUBTITLE ? 0 : marginY));
         labelTitle.height = this.lbl_mecanicTitle.height;
         labelTitle.width = this.lbl_mecanicTitle.width;
         labelTitle.verticalAlign = this.lbl_mecanicTitle.verticalAlign;
         labelTitle.multiline = this.lbl_mecanicTitle.multiline;
         labelTitle.wordWrap = this.lbl_mecanicTitle.wordWrap;
         labelTitle.css = this.lbl_mecanicTitle.css;
         labelTitle.cssClass = nodeName == TITLE ? "bigboldorangeleft" : "extrawhitebigleft";
         labelTitle.text = title;
         this.scroll_mecanic.addContent(labelTitle);
      }
      
      private function addIcon(posIcon:Vector3D, oldNodeName:String, groupPos:int, marginY:int, iconUri:Uri) : void
      {
         var iconTitle:Texture = new Texture();
         iconTitle.x = posIcon.x;
         iconTitle.y = oldNodeName == "base" ? Number(posIcon.y) : Number(posIcon.y + groupPos + marginY);
         iconTitle.width = this.tx_mecanicIcon.width;
         iconTitle.height = this.tx_mecanicIcon.height;
         iconTitle.visible = iconUri != null;
         iconTitle.uri = iconUri;
         iconTitle.finalize();
         this.scroll_mecanic.addContent(iconTitle);
      }
      
      public function unload() : void
      {
         if(!this._isUnloading)
         {
            this._isUnloading = true;
            this.uiApi.hideTooltip();
            this.soundApi.playSound(SoundTypeEnum.CHARACTER_SHEET_CLOSE);
            this.uiApi.unloadUi("statBoost");
         }
         if(this.uiApi.getUi(this._resetPopupName))
         {
            this.uiApi.unloadUi(this._resetPopupName);
         }
      }
      
      private function updateLabel() : void
      {
         this.lbl_class.text = this.dataApi.getBreed(this._characterInfos.breed).shortName;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.ctr_charTitleButton)
         {
            this.sysApi.sendAction(new OpenBookAction(["titleTab"]));
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onShortCut(s:String) : Boolean
      {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(!this.uiApi.getUi("statBoost") ? this.uiApi.me().name : "statBoost");
            return true;
         }
         return false;
      }
      
      public function onUiLoaded(pUiName:String) : void
      {
         var rectTabSpell:Rectangle = null;
         if(pUiName == "gameplayClassWindow")
         {
            this.uiApi.me().setOnTop();
            this.tabSpell = this.uiApi.getUi(EnumTab.SPELL_TAB);
            if(this.tabSpell)
            {
               rectTabSpell = this.tabSpell.getStageRect();
               this.gameplayClassWindow.x = rectTabSpell.x - this.gameplayClassWindow.width + 20;
               this.gameplayClassWindow.y = rectTabSpell.y + 10;
               this.updateLabel();
            }
         }
      }
      
      public function onUiUnloaded(pUiName:String) : void
      {
         if(pUiName == "statBoost")
         {
            this.uiApi.me().setOnTopBeforeMe = [];
         }
      }
   }
}
