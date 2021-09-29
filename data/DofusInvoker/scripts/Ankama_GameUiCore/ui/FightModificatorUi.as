package Ankama_GameUiCore.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.spells.SpellPair;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.modules.utils.SpellTooltipSettings;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   
   public class FightModificatorUi
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      private var _hidden:Boolean = false;
      
      private var _foldStatus:Boolean;
      
      private var _spellPair:SpellPair;
      
      public var ctr_ui:GraphicContainer;
      
      public var btn_minimArrow:ButtonContainer;
      
      public var tx_background:TextureBitmap;
      
      public var tx_slot:Texture;
      
      public function FightModificatorUi()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this.sysApi.addHook(QuestHookList.AreaFightModificatorUpdate,this.onAreaFightModificatorUpdate);
         this.uiApi.addComponentHook(this.tx_slot,"onRollOver");
         this.uiApi.addComponentHook(this.tx_slot,"onRollOut");
         this.sysApi.addHook(CustomUiHookList.FoldAll,this.onFoldAll);
         this._hidden = false;
         this.ctr_ui.visible = true;
         if(param)
         {
            this._spellPair = this.dataApi.getSpellPair(param.pairId);
            if(this._spellPair)
            {
               this.update();
            }
            else
            {
               this.sysApi.log(2,"La paire " + param.pairId + " n\'existe pas");
            }
         }
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function update() : void
      {
         this.tx_slot.uri = this.uiApi.createUri(this.uiApi.me().getConstant("spells_uri") + this._spellPair.iconId);
         this.uiApi.me().render();
      }
      
      private function onAreaFightModificatorUpdate(spellPairId:int) : void
      {
         if(spellPairId == -1)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         else
         {
            this._spellPair = this.dataApi.getSpellPair(spellPairId);
            this.update();
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_minimArrow:
               this._hidden = !this._hidden;
               this.fold();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var spellTooltipSettings:SpellTooltipSettings = null;
         if(this._spellPair)
         {
            spellTooltipSettings = this.tooltipApi.createSpellSettings();
            spellTooltipSettings.header = true;
            spellTooltipSettings.isTheoretical = this.sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus");
            spellTooltipSettings.footer = false;
            this.uiApi.showTooltip(this._spellPair,this.tx_slot,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_BOTTOMRIGHT,0,null,null,spellTooltipSettings);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onFoldAll(mustFold:Boolean) : void
      {
         this._hidden = mustFold;
         this.fold();
      }
      
      private function fold() : void
      {
         if(this._hidden)
         {
            this.tx_background.width = this.uiApi.me().getConstant("widthBackgroundHidden");
         }
         else
         {
            this.tx_background.width = this.uiApi.me().getConstant("widthBackground");
         }
         this.ctr_ui.visible = !this._hidden;
         this.btn_minimArrow.selected = this._hidden;
         this.uiApi.me().render();
      }
   }
}
