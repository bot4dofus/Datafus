package Ankama_Grimoire.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.roleplay.actions.FinishMoveListRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.FinishMoveSetRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.utils.Dictionary;
   
   public class FinishMoveList
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      private var _finishMoves:Array;
      
      private var _enabledFinishMoves:Vector.<int>;
      
      private var _disabledFinishMoves:Vector.<int>;
      
      private var _btnDataAssoc:Dictionary;
      
      public var gd_finishMoves:Grid;
      
      public var tx_illu:Texture;
      
      public var lbl_info:Label;
      
      public var tx_warning:Texture;
      
      public var lbl_warning:Label;
      
      public var ctr_finishMoveList:GraphicContainer;
      
      public var ctr_illu:GraphicContainer;
      
      public function FinishMoveList()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this._enabledFinishMoves = new Vector.<int>(0);
         this._disabledFinishMoves = new Vector.<int>(0);
         this._btnDataAssoc = new Dictionary();
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.sysApi.addHook(HookList.FinishMoveList,this.onFinishMoveList);
         this.sysApi.addHook(HookList.ConfigPropertyChange,this.onConfigPropertyChange);
         this.sysApi.sendAction(new FinishMoveListRequestAction([]));
      }
      
      public function updateFinishMoveLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            componentsRef.lbl_finishMoveName.text = data.name;
            this._btnDataAssoc[componentsRef.btn_finishMove] = data;
            if(data.hasOwnProperty("enabled"))
            {
               componentsRef.btn_finishMove.softDisabled = false;
               componentsRef.btn_finishMove.buttonMode = true;
               componentsRef.btn_finishMove.selected = componentsRef.tx_checkFinishMove.visible = this._enabledFinishMoves.indexOf(data.id) != -1;
            }
            else
            {
               componentsRef.tx_checkFinishMove.visible = false;
               componentsRef.btn_finishMove.softDisabled = true;
               componentsRef.btn_finishMove.buttonMode = false;
               componentsRef.btn_finishMove.selected = false;
            }
         }
         else
         {
            this._btnDataAssoc[componentsRef.btn_finishMove] = null;
            componentsRef.lbl_finishMoveName.text = "";
            componentsRef.tx_checkFinishMove.visible = false;
            componentsRef.btn_finishMove.softDisabled = true;
            componentsRef.btn_finishMove.buttonMode = false;
            componentsRef.btn_finishMove.selected = false;
         }
      }
      
      public function unload() : void
      {
         this.sysApi.sendAction(new FinishMoveSetRequestAction([this._enabledFinishMoves,this._disabledFinishMoves]));
      }
      
      public function showTabHints() : void
      {
         if(this.hintsApi.canDisplayHelp() && this.hintsApi.guidedActivated())
         {
            this.hintsApi.showSubHints();
         }
      }
      
      private function restoreFinishMoves() : void
      {
         var fm:Object = null;
         this._enabledFinishMoves.length = 0;
         this._disabledFinishMoves.length = 0;
         for each(fm in this._finishMoves)
         {
            if(fm.enabled)
            {
               this._enabledFinishMoves.push(fm.id);
            }
            else
            {
               this._disabledFinishMoves.push(fm.id);
            }
         }
      }
      
      public function onFinishMoveList(finishMoves:Array) : void
      {
         var fm:Object = null;
         this._finishMoves = finishMoves;
         this.restoreFinishMoves();
         var fms:Array = this.dataApi.getFinishMoves();
         var tab:Array = [];
         for each(fm in fms)
         {
            if(this._enabledFinishMoves.indexOf(fm.id) == -1 && this._disabledFinishMoves.indexOf(fm.id) == -1)
            {
               tab.push({
                  "id":fm.id,
                  "name":this.dataApi.getSpell(fm.getSpellLevel().spellId).name
               });
            }
         }
         tab = tab.concat(this._finishMoves);
         tab.sortOn("id",Array.NUMERIC);
         this.gd_finishMoves.dataProvider = tab;
         this.tx_warning.visible = this.lbl_warning.visible = this.configApi.getConfigProperty("dofus","showFinishMoves") == false && this._enabledFinishMoves.length > 0;
      }
      
      private function onConfigPropertyChange(target:String, name:String, value:*, oldValue:*) : void
      {
         if(target == "dofus" && name == "showFinishMoves")
         {
            this.tx_warning.visible = this.lbl_warning.visible = value == false && this._enabledFinishMoves.length > 0;
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var enabledIndex:int = 0;
         var disabledIndex:int = 0;
         if(target == this.gd_finishMoves && selectMethod != SelectMethodEnum.AUTO && selectMethod != SelectMethodEnum.UP_ARROW && selectMethod != SelectMethodEnum.DOWN_ARROW && selectMethod != SelectMethodEnum.LEFT_ARROW && selectMethod != SelectMethodEnum.RIGHT_ARROW)
         {
            enabledIndex = this._enabledFinishMoves.indexOf(this.gd_finishMoves.selectedItem.id);
            disabledIndex = this._disabledFinishMoves.indexOf(this.gd_finishMoves.selectedItem.id);
            if(enabledIndex != -1)
            {
               this._enabledFinishMoves.splice(enabledIndex,1);
               this._disabledFinishMoves.push(this.gd_finishMoves.selectedItem.id);
            }
            else if(disabledIndex != -1)
            {
               this._disabledFinishMoves.splice(disabledIndex,1);
               this._enabledFinishMoves.push(this.gd_finishMoves.selectedItem.id);
            }
            this.gd_finishMoves.updateItem(this.gd_finishMoves.selectedIndex);
            this.tx_warning.visible = this.lbl_warning.visible = this.configApi.getConfigProperty("dofus","showFinishMoves") == false && this._enabledFinishMoves.length > 0;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var finishMove:Object = this._btnDataAssoc[target];
         if(finishMove)
         {
            this.tx_illu.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illu" + finishMove.id));
            this.tx_illu.visible = true;
            if(!finishMove.hasOwnProperty("enabled"))
            {
               tooltipText = this.uiApi.getText("ui.grimoire.finishMove.unavailable");
            }
         }
         var strata:int = 0;
         if(this.configApi.isFeatureWithKeywordEnabled("character.spell.forgettable"))
         {
            strata = this.uiApi.getUi(UIEnum.FORGETTABLE_SPELLS_UI).strata - 1;
         }
         else
         {
            strata = SpellBase.getInstance().getTooltipStrata();
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,1,3,null,null,null,"TextInfo",false,strata);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}
