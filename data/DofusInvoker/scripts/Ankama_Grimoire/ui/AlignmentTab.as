package Ankama_Grimoire.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentRank;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.SetEnablePVPRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.network.enums.AlignmentSideEnum;
   import com.ankamagames.dofus.uiApi.AlignmentApi;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.display.Shape;
   
   public class AlignmentTab
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="AlignmentApi")]
      public var alignApi:AlignmentApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _characterInfos:Object;
      
      private var _alignmentInfos:Object;
      
      private var _listRanksID:Vector.<int>;
      
      private var _pvpEnabled:Boolean = false;
      
      private var _is_aggression:Boolean = false;
      
      private var _tx_progressBar1Width:uint;
      
      public var lbl_title:Label;
      
      public var lbl_alignment:Label;
      
      public var lbl_alignmentInfo:Label;
      
      public var lbl_alignmentGrade:Label;
      
      public var lbl_order:Label;
      
      public var lbl_levelHover:Label;
      
      public var tx_alignmentIcon:Texture;
      
      public var tx_orderIcon:Texture;
      
      public var tx_wing:Texture;
      
      public var tx_pvpOff:Texture;
      
      public var tx_neutralAlignment:Texture;
      
      public var tx_progressBar1:ProgressBar;
      
      public var btn_pvp:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var entityDisplayer:EntityDisplayer;
      
      public var gd_specializations:Grid;
      
      public var ctr_entity:GraphicContainer;
      
      public function AlignmentTab()
      {
         this._listRanksID = new Vector.<int>(6,true);
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var list:Array = null;
         var numBtn:int = 0;
         var ar:Object = null;
         var i:int = 0;
         var shortcut:String = this.bindsApi.getShortcutBindStr("openBookAlignment");
         if(shortcut != "")
         {
            this.lbl_title.text += " (" + shortcut + ")";
         }
         this._is_aggression = this.dataApi.getMapInfo(this.playerApi.currentMap().mapId).allowAggression;
         var mask:Shape = new Shape();
         mask.graphics.beginFill(0);
         mask.graphics.drawRect(0,0,this.ctr_entity.width,this.ctr_entity.height);
         this.ctr_entity.addChild(mask);
         this.ctr_entity.mask = mask;
         this.tx_wing.visible = false;
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         if(this.configApi.isFeatureWithKeywordEnabled("server.conf.alignmentWar"))
         {
            this.btn_pvp.disabled = true;
            this.uiApi.loadUi("alignmentWarEffortTab");
            this.uiApi.loadUi("alignmentGiftsTab");
         }
         this.sysApi.addHook(HookList.CharacterStatsList,this.onCharacterStatsList);
         this.uiApi.addComponentHook(this.tx_progressBar1,"onRollOver");
         this.uiApi.addComponentHook(this.tx_progressBar1,"onRollOut");
         this.uiApi.addComponentHook(this.btn_pvp,"onRollOver");
         this.uiApi.addComponentHook(this.btn_pvp,"onRollOut");
         this.uiApi.addComponentHook(this.lbl_levelHover,"onRollOver");
         this.uiApi.addComponentHook(this.lbl_levelHover,"onRollOut");
         this.uiApi.addComponentHook(this.entityDisplayer,"onEntityReady");
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this._characterInfos = this.playerApi.getPlayedCharacterInfo();
         this._alignmentInfos = this.playerApi.characteristics().alignmentInfos;
         var alignment:int = this._alignmentInfos.alignmentSide;
         var alignmentSide:AlignmentSide = this.alignApi.getSide(alignment);
         this.lbl_alignment.text = this.uiApi.getText("ui.common.alignment") + " " + alignmentSide.name;
         var playerRank:int = this.alignApi.getPlayerRank();
         var alignmentRank:AlignmentRank = this.alignApi.getRank(playerRank);
         this.lbl_alignmentInfo.text = alignmentRank.name + " - " + this.uiApi.getText("ui.common.level") + " " + this._alignmentInfos.alignmentValue;
         this.lbl_order.text = this.alignApi.getOrder(alignmentRank.orderId).name;
         this.entityDisplayer.look = this._characterInfos.entityLook;
         this._tx_progressBar1Width = this.tx_progressBar1.width;
         this.displayPvpInformations();
         if(alignment == AlignmentSideEnum.ALIGNMENT_NEUTRAL)
         {
            this.tx_neutralAlignment.visible = true;
            this.tx_alignmentIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "Alignement_tx_IllusNeutre.png");
         }
         else
         {
            this.tx_neutralAlignment.visible = false;
            if(alignment == AlignmentSideEnum.ALIGNMENT_ANGEL)
            {
               this.tx_alignmentIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "Alignement_tx_IllusBontarien.png");
            }
            else if(alignment == AlignmentSideEnum.ALIGNMENT_EVIL)
            {
               this.tx_alignmentIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "Alignement_tx_IllusBrakmarien.png");
            }
         }
         if((alignment == AlignmentSideEnum.ALIGNMENT_ANGEL || alignment == AlignmentSideEnum.ALIGNMENT_EVIL) && alignmentRank)
         {
            this.tx_orderIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "order_" + alignmentRank.orderId + ".png");
         }
         else if(alignment == AlignmentSideEnum.ALIGNMENT_NEUTRAL)
         {
            this.tx_orderIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "order_" + alignment + ".png");
         }
         if(alignment != AlignmentSideEnum.ALIGNMENT_NEUTRAL)
         {
            this.btn_pvp.visible = true;
            list = this.alignApi.getOrderRanks(alignmentRank.orderId);
            this.gd_specializations.dataProvider = list;
            if(alignmentRank.minimumAlignment < 20)
            {
               this.gd_specializations.selectedIndex = Math.floor(alignmentRank.minimumAlignment / 20);
            }
            else
            {
               this.gd_specializations.selectedIndex = Math.floor(alignmentRank.minimumAlignment / 20) - 1;
            }
            numBtn = 0;
            for each(ar in list)
            {
               this._listRanksID[numBtn] = ar.id;
               numBtn++;
            }
            for(i = numBtn; i < 6; i++)
            {
               this._listRanksID[numBtn] = -1;
               numBtn++;
            }
            if(this.configApi.isFeatureWithKeywordEnabled("server.heroic"))
            {
               this.btn_pvp.softDisabled = true;
            }
            else
            {
               this.btn_pvp.softDisabled = this._is_aggression && (this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE || this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE);
            }
         }
         else
         {
            this.btn_pvp.visible = false;
         }
         this.gd_specializations.slots[this.gd_specializations.selectedIndex].bgColor = this.sysApi.getConfigEntry("colors.grid.selected");
         this.gd_specializations.mouseEnabled = false;
      }
      
      public function updateAliBonusLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            componentsRef.lbl_name.text = data.name;
            componentsRef.lbl_valueP.text = data.valueP;
            componentsRef.lbl_valueM.text = data.valueM;
         }
         else
         {
            componentsRef.lbl_title.text = "";
            componentsRef.lbl_valueP.text = "";
            componentsRef.lbl_valueM.text = "";
         }
      }
      
      public function updateSpecLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            componentsRef.specItemCtr.selected = selected;
            componentsRef.lbl_name.text = data.name;
            componentsRef.lbl_level.text = data.minimumAlignment;
         }
         else
         {
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_level.text = "";
         }
      }
      
      private function displayPvpInformations() : void
      {
         if(this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE || this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE)
         {
            this._pvpEnabled = true;
            this.tx_pvpOff.visible = false;
            this.tx_wing.uri = this.uiApi.createUri(this.uiApi.me().getConstant("alignment_uri") + "wings.swf|demonAngel");
            this.tx_wing.gotoAndStop = (this._alignmentInfos.alignmentSide - 1) * 10 + 1 + this._alignmentInfos.alignmentGrade;
            this.lbl_alignmentGrade.text = this._alignmentInfos.alignmentGrade + " (" + this.alignApi.getTitleName(this._alignmentInfos.alignmentSide,this._alignmentInfos.alignmentGrade) + ")";
            this.tx_progressBar1.value = this._alignmentInfos.honor / 20000;
            this.tx_progressBar1.width = this._tx_progressBar1Width;
         }
         else
         {
            this._pvpEnabled = false;
            this.tx_pvpOff.visible = true;
            this.tx_wing.uri = null;
            this.lbl_alignmentGrade.text = "-";
            this.tx_progressBar1.width = 0;
         }
         this.btn_pvp.selected = this._pvpEnabled;
      }
      
      private function onCharacterStatsList(oneLifePointRegenOnly:Boolean = false) : void
      {
         if(!oneLifePointRegenOnly)
         {
            this._alignmentInfos = this.playerApi.characteristics().alignmentInfos;
            if(this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE || this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE)
            {
               if(!this._pvpEnabled)
               {
                  this.displayPvpInformations();
               }
            }
            else if(this._pvpEnabled)
            {
               this.displayPvpInformations();
            }
         }
         this.btn_pvp.softDisabled = this._is_aggression && (this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_AGGRESSABLE || this._alignmentInfos.aggressable == AggressableStatusEnum.PvP_ENABLED_NON_AGGRESSABLE);
      }
      
      private function onShortCut(s:String) : Boolean
      {
         if(s == ShortcutHookListEnum.CLOSE_UI)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_pvp:
               this.sysApi.sendAction(new SetEnablePVPRequestAction([!this._pvpEnabled]));
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var textTooltip:String = null;
         if(target == this.tx_progressBar1)
         {
            textTooltip = String(this._alignmentInfos.honor);
         }
         else if(target == this.btn_pvp && this.btn_pvp.softDisabled)
         {
            if(this.configApi.isFeatureWithKeywordEnabled("server.conf.alignmentWar"))
            {
               textTooltip = this.uiApi.getText("ui.grimoire.alignment.hardcore");
            }
            else if(this._is_aggression)
            {
               textTooltip = this.uiApi.getText("ui.pvp.disabledTooltip");
            }
         }
         else if(target == this.lbl_levelHover)
         {
            textTooltip = this.uiApi.getText("ui.pvp.levelTooltip");
         }
         if(textTooltip)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(textTooltip),target,false,"standard",7,1,0,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onEntityReady(target:Object) : void
      {
         var slotPos:* = this.entityDisplayer.getSlotPosition("Cape_2");
         if(slotPos)
         {
            this.tx_wing.x = this.entityDisplayer.x + slotPos.x;
            this.tx_wing.y = this.entityDisplayer.y + this.entityDisplayer.height + slotPos.y;
         }
         else
         {
            this.tx_wing.x = this.entityDisplayer.x + this.entityDisplayer.width / 2;
         }
         this.tx_wing.visible = true;
      }
      
      public function unload() : void
      {
         if(this.configApi.isFeatureWithKeywordEnabled("server.conf.alignmentWar"))
         {
            this.uiApi.unloadUi("alignmentWarEffortTab");
            this.uiApi.unloadUi("alignmentGiftsTab");
         }
      }
   }
}
