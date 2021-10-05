package Ankama_Common.ui
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.idols.Idol;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import damageCalculation.tools.StatIds;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class ItemBox
   {
      
      private static var _itemIconX:Number;
      
      private static var _itemIconY:Number;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:Object;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      private var _currentTab:uint = 0;
      
      private var _item:ItemWrapper;
      
      private var _sameItem:Boolean = false;
      
      private var _showTheoretical:Boolean = false;
      
      private var _ownedItem:Boolean = false;
      
      private var _etherealRes:String;
      
      private var _subareaId:int;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var lbl_weight:Label;
      
      public var lbl_description:TextArea;
      
      public var tx_item:Texture;
      
      public var tx_etherealGauge:Texture;
      
      public var tx_2hands:Texture;
      
      public var tx_mimicry:Texture;
      
      public var btn_info:ButtonContainer;
      
      public var btn_effects:ButtonContainer;
      
      public var btn_conditions:ButtonContainer;
      
      public var btn_caracteristics:ButtonContainer;
      
      public var gd_lines:Grid;
      
      public function ItemBox()
      {
         super();
      }
      
      public function main(pParam:Object = null) : void
      {
         this.btn_info.soundId = SoundEnum.GEN_BUTTON;
         this.btn_effects.soundId = SoundEnum.GEN_BUTTON;
         this.btn_conditions.soundId = SoundEnum.GEN_BUTTON;
         this.btn_caracteristics.soundId = SoundEnum.GEN_BUTTON;
         this.sysApi.addHook(InventoryHookList.ObjectModified,this.onObjectModified);
         this.sysApi.addHook(BeriliaHookList.TextureLoadFailed,this.onTextureLoadFailed);
         this.sysApi.addHook(HookList.MapComplementaryInformationsData,this.onMapComplementaryInformationsData);
         this.uiApi.addComponentHook(this.tx_etherealGauge,"onRollOver");
         this.uiApi.addComponentHook(this.tx_etherealGauge,"onRollOut");
         this.uiApi.addComponentHook(this.tx_2hands,"onRollOver");
         this.uiApi.addComponentHook(this.tx_2hands,"onRollOut");
         this.uiApi.addComponentHook(this.tx_mimicry,"onRollOver");
         this.uiApi.addComponentHook(this.tx_mimicry,"onRollOut");
         if(isNaN(_itemIconX))
         {
            _itemIconX = this.tx_item.x;
         }
         if(isNaN(_itemIconY))
         {
            _itemIconY = this.tx_item.y;
         }
         this.tx_item.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_item,"onTextureReady");
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_effects,this.uiApi.me());
         this.btn_effects.selected = true;
         if(pParam.showTheoretical)
         {
            this._showTheoretical = pParam.showTheoretical;
         }
         if(pParam.ownedItem)
         {
            this._ownedItem = pParam.ownedItem;
         }
         this.updateItem(pParam.item);
      }
      
      public function unload() : void
      {
      }
      
      private function updateItem(pItem:ItemWrapper = null) : void
      {
         var desc:String = null;
         var resPos:uint = 0;
         var effect:Object = null;
         var diceNum:uint = 0;
         if(pItem)
         {
            if(this._item && this._item.objectUID == pItem.objectUID)
            {
               this._sameItem = true;
            }
            else
            {
               this._sameItem = false;
            }
            this._item = pItem;
            this.lbl_name.cssClass = "light";
            if(this._item.etheral)
            {
               this.lbl_name.cssClass = "itemetheral";
            }
            if(this._item.itemSetId != -1)
            {
               this.lbl_name.cssClass = "itemset";
            }
            this.lbl_name.text = this._item.name;
            if(this.sysApi.getPlayerManager().hasRights)
            {
               this.lbl_name.text += " (" + this._item.id + ")";
            }
            this.lbl_level.text = this.uiApi.getText("ui.common.short.level") + " " + this._item.level;
            this.lbl_weight.text = this.uiApi.processText(this.uiApi.getText("ui.common.short.weight",this._item.weight),"m",this._item.weight <= 1,this._item.weight == 0);
            desc = "";
            if(this._item.hasOwnProperty("itemSetId") && this._item.itemSetId != -1)
            {
               desc += this.dataApi.getItemSet(this._item.itemSetId).name + " - ";
            }
            if(this._item.type)
            {
               desc += this.uiApi.getText("ui.common.category") + this.uiApi.getText("ui.common.colon") + this._item.type.name;
            }
            desc += "\n" + this._item.description;
            this.lbl_description.text = desc;
            if(!this._sameItem)
            {
               this.tx_item.visible = false;
            }
            this.tx_item.uri = this._item.fullSizeIconUri;
            this.tx_etherealGauge.visible = false;
            if(!this._showTheoretical)
            {
               for each(effect in this._item.effects)
               {
                  if(effect.effectId == ActionIds.ACTION_ITEM_CHANGE_DURABILITY)
                  {
                     this._etherealRes = effect.description;
                     if(effect.hasOwnProperty("diceNum"))
                     {
                        diceNum = effect.diceNum;
                     }
                     else
                     {
                        diceNum = 0;
                     }
                     resPos = int(diceNum / effect.value * 100);
                     this.tx_etherealGauge.gotoAndStop = resPos.toString();
                     this.tx_etherealGauge.visible = true;
                  }
               }
            }
            if(this._item.isWeapon && this._item.twoHanded)
            {
               this.tx_2hands.visible = true;
            }
            else
            {
               this.tx_2hands.visible = false;
            }
            if(this._item.isMimicryObject || this._item.isObjectWrapped)
            {
               this.tx_mimicry.visible = true;
            }
            else
            {
               this.tx_mimicry.visible = false;
            }
            if(!this._item.isWeapon)
            {
               this.btn_caracteristics.visible = false;
               if(this._currentTab == 2)
               {
                  this._currentTab = 0;
                  this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_effects,this.uiApi.me());
                  this.btn_effects.selected = true;
               }
            }
            else
            {
               this.btn_caracteristics.visible = true;
            }
            this.updateGrid();
         }
         else
         {
            this.sysApi.log(2,"item null, rien à afficher dans ItemBox");
         }
      }
      
      private function updateGrid() : void
      {
         var pattern0:RegExp = null;
         var pattern1:RegExp = null;
         var weapon:WeaponWrapper = null;
         var ap:String = null;
         var range:String = null;
         var criterion:Object = null;
         var index:uint = 0;
         var criteriaRespected:Boolean = false;
         var css:String = null;
         var ORindex:int = 0;
         var i:int = 0;
         var firstParenthesisIndex:int = 0;
         var logicOperatorIndex:int = 0;
         var newLineOperator:String = null;
         var criteriaText:* = null;
         var inlineCriteria:Object = null;
         var targetCriterion:Object = null;
         var indexT:uint = 0;
         var criteriaTextT:String = null;
         var criteriaRespectedT:Boolean = false;
         var cssT:String = null;
         var inlineCriteriaT:Object = null;
         var CC_EC:String = null;
         var sign:String = null;
         var stats:EntityStats = null;
         var totalCriticalHit:int = 0;
         var totalAgility:int = 0;
         var critikRate:int = 0;
         var criticalPercent:int = 0;
         var list:Array = [];
         switch(this._currentTab)
         {
            case 0:
               this.showEffect(list);
               break;
            case 1:
               pattern0 = /</g;
               pattern1 = />/g;
               if(this._item.conditions)
               {
                  for each(criterion in this._item.conditions.criteria)
                  {
                     index = 0;
                     criteriaRespected = criterion.isRespected;
                     css = "p";
                     ORindex = criterion.text.indexOf("|");
                     firstParenthesisIndex = 0;
                     logicOperatorIndex = 0;
                     for(i = 0; i < criterion.inlineCriteria.length; i++)
                     {
                        criteriaText = "";
                        inlineCriteria = criterion.inlineCriteria[i];
                        if(inlineCriteria.text != "")
                        {
                           if(index > 0)
                           {
                              if(ORindex > 0)
                              {
                                 criteriaText = " " + this.uiApi.getText("ui.common.or") + " ";
                              }
                           }
                           criteriaText += inlineCriteria.text;
                           if(criterion.inlineCriteria.length > 1 && i == firstParenthesisIndex)
                           {
                              criteriaText = "(" + criteriaText;
                           }
                           if(newLineOperator == "|")
                           {
                              criteriaText = this.uiApi.getText("ui.common.or") + " " + criteriaText;
                              newLineOperator = "null";
                           }
                           else if(newLineOperator == "&")
                           {
                              criteriaText = this.uiApi.getText("ui.common.and") + " " + criteriaText;
                              newLineOperator = "null";
                           }
                           if(criterion.inlineCriteria.length > 1)
                           {
                              if(i != firstParenthesisIndex && i == criterion.inlineCriteria.length - 1)
                              {
                                 criteriaText += ")";
                                 if(this._item.conditions.operators && this._item.conditions.operators.length > logicOperatorIndex)
                                 {
                                    newLineOperator = this._item.conditions.operators[logicOperatorIndex];
                                 }
                                 logicOperatorIndex++;
                              }
                           }
                           else if(this._item.conditions.criteria.length > 1)
                           {
                              if(this._item.conditions.operators[logicOperatorIndex] == "|")
                              {
                                 newLineOperator = this._item.conditions.operators[logicOperatorIndex];
                                 logicOperatorIndex++;
                              }
                           }
                           index++;
                        }
                        else if(i == 0)
                        {
                           firstParenthesisIndex++;
                        }
                        criteriaText = criteriaText.replace(pattern0,"&lt;");
                        criteriaText = criteriaText.replace(pattern1,"&gt;");
                        if(criteriaText)
                        {
                           list.push({
                              "label":criteriaText,
                              "cssClass":css
                           });
                        }
                     }
                  }
               }
               if(this._item.targetConditions)
               {
                  for each(targetCriterion in this._item.targetConditions.criteria)
                  {
                     indexT = 0;
                     criteriaTextT = "";
                     criteriaRespectedT = targetCriterion.isRespected;
                     cssT = "p";
                     for each(inlineCriteriaT in targetCriterion.inlineCriteria)
                     {
                        if(inlineCriteriaT.text != "")
                        {
                           if(indexT > 0)
                           {
                              criteriaTextT += " " + this.uiApi.getText("ui.common.or") + " ";
                           }
                           criteriaTextT += inlineCriteriaT.text;
                           indexT++;
                        }
                     }
                     criteriaTextT = criteriaTextT.replace(pattern0,"&lt;");
                     criteriaTextT = criteriaTextT.replace(pattern1,"&gt;");
                     if(criteriaTextT)
                     {
                        list.push({
                           "label":"(" + this.uiApi.getText("ui.item.target") + ") " + criteriaTextT,
                           "cssClass":cssT
                        });
                     }
                  }
               }
               break;
            case 2:
               weapon = this._item as WeaponWrapper;
               ap = this.uiApi.getText("ui.stats.shortAP") + this.uiApi.getText("ui.common.colon") + weapon.apCost;
               if(weapon.maxCastPerTurn)
               {
                  ap += " (" + this.uiApi.processText(this.uiApi.getText("ui.item.usePerTurn",weapon.maxCastPerTurn),"n",weapon.maxCastPerTurn <= 1,weapon.maxCastPerTurn == 0) + ")";
               }
               list.push(ap);
               if(weapon.range == weapon.minRange)
               {
                  range = String(weapon.range);
               }
               else
               {
                  range = weapon.minRange + " - " + weapon.range;
               }
               list.push(this.uiApi.getText("ui.common.range") + this.uiApi.getText("ui.common.colon") + range);
               if(weapon.criticalFailureProbability || weapon.criticalHitProbability)
               {
                  CC_EC = "";
                  if(weapon.criticalHitProbability)
                  {
                     if(weapon.criticalHitBonus > 0)
                     {
                        sign = "+";
                     }
                     else if(weapon.criticalHitBonus < 0)
                     {
                        sign = "-";
                     }
                     if(sign)
                     {
                        list.push(this.uiApi.getText("ui.item.critical.bonus",weapon.criticalHitBonus));
                     }
                     CC_EC += this.uiApi.getText("ui.common.short.CriticalHit") + this.uiApi.getText("ui.common.colon") + weapon.criticalHitProbability + "%";
                     stats = StatsManager.getInstance().getStats(this.playerApi.id());
                     if(this.playerApi.characteristics() != null)
                     {
                        totalCriticalHit = stats.getStatTotalValue(StatIds.CRITICAL_HIT) - stats.getStatAdditionalValue(StatIds.CRITICAL_HIT);
                        totalAgility = stats.getStatTotalValue(StatIds.AGILITY);
                        if(totalAgility < 0)
                        {
                           totalAgility = 0;
                        }
                        critikRate = 55 - weapon.criticalHitProbability - totalCriticalHit;
                        if(critikRate > 55)
                        {
                           critikRate = 55;
                        }
                        criticalPercent = 55 - 1 / (1 / critikRate);
                        if(criticalPercent > 100)
                        {
                           criticalPercent = 100;
                        }
                        list.push(this.uiApi.getText("ui.itemtooltip.itemCriticalReal",criticalPercent + "%"));
                     }
                  }
                  list.push(CC_EC);
               }
               if(weapon.castInLine && weapon.range > 1)
               {
                  list.push(this.uiApi.getText("ui.spellInfo.castInLine"));
               }
               if(!weapon.castTestLos && weapon.range > 1)
               {
                  list.push(this.uiApi.getText("ui.spellInfo.castWithoutLos"));
               }
         }
         var scrollValue:int = this.gd_lines.verticalScrollValue;
         this.gd_lines.dataProvider = list;
         if(this._sameItem)
         {
            this.gd_lines.moveTo(scrollValue,true);
         }
      }
      
      public function updateLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            if(data is String)
            {
               componentsRef.lbl_text.text = data;
               componentsRef.lbl_text.cssClass = "p";
            }
            else
            {
               componentsRef.lbl_text.text = data.label;
               componentsRef.lbl_text.cssClass = data.cssClass;
            }
            componentsRef.tx_picto.visible = false;
         }
         else
         {
            componentsRef.lbl_text.text = "";
            componentsRef.tx_picto.visible = false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var contextMenu:ContextMenuData = null;
         switch(target)
         {
            case this.btn_info:
               if(this._item && !(this._item is MountWrapper))
               {
                  contextMenu = this.menuApi.create(this._item,null,[{"ownedItem":this._ownedItem},this.uiApi.me()["name"]]);
                  if(contextMenu.content.length > 0)
                  {
                     this.modContextMenu.createContextMenu(contextMenu);
                  }
               }
               break;
            case this.btn_effects:
               this._currentTab = 0;
               this.updateGrid();
               break;
            case this.btn_conditions:
               this._currentTab = 1;
               this.updateGrid();
               break;
            case this.btn_caracteristics:
               this._currentTab = 2;
               this.updateGrid();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         switch(target)
         {
            case this.tx_etherealGauge:
               text = this._etherealRes;
               break;
            case this.tx_2hands:
               text = this.uiApi.getText("ui.common.twoHandsWeapon");
               break;
            case this.tx_mimicry:
               text = this.uiApi.getText("ui.mimicry.itemTooltip");
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onTextureLoadFailed(target:Texture, behavior:Boolean) : void
      {
         if(target == this.tx_item)
         {
            this.tx_item.uri = this._item.fullSizeErrorIconUri;
         }
      }
      
      public function onTextureReady(pTarget:Texture) : void
      {
         var iconBounds:Rectangle = pTarget.child.getBounds(pTarget as DisplayObject);
         if(iconBounds.x != 0 && iconBounds.y != 0)
         {
            pTarget.x = _itemIconX - iconBounds.x * (pTarget.width / iconBounds.width);
            pTarget.y = _itemIconY - iconBounds.y * (pTarget.height / iconBounds.height);
         }
         else
         {
            pTarget.x = _itemIconX;
            pTarget.y = _itemIconY;
         }
         pTarget.visible = true;
      }
      
      public function onItemSelected(pItem:ItemWrapper, showTheoretical:Boolean = false) : void
      {
         this._showTheoretical = showTheoretical;
         this.updateItem(pItem);
      }
      
      public function onObjectModified(item:ItemWrapper) : void
      {
         if(this._item.objectUID == item.objectUID)
         {
            this.updateItem(item);
         }
      }
      
      public function onMapComplementaryInformationsData(map:Object, subAreaId:uint, show:Boolean) : void
      {
         var itemObject:Item = null;
         if(this._subareaId != subAreaId)
         {
            if(this._item)
            {
               itemObject = this.dataApi.getItem(this._item.objectGID);
               if(itemObject.favoriteSubAreas && itemObject.favoriteSubAreas.length > 0)
               {
                  this.updateGrid();
               }
            }
         }
         this._subareaId = subAreaId;
      }
      
      public function showEffect(list:Array) : void
      {
         var effects:Object = null;
         var ei:EffectInstance = null;
         var localEffects:Array = null;
         var sortedCategory:Array = null;
         var lineDmg:Object = null;
         var cssClass:String = null;
         var desc:String = null;
         var line:Object = null;
         var waitingBonus:Object = null;
         var idol:Idol = null;
         var currentCategory:int = 0;
         var theoItem:Item = null;
         var exotic:Boolean = false;
         var theoEffect:EffectInstance = null;
         var theoretical:Boolean = false;
         if(this._item.typeId == 178)
         {
            idol = this.dataApi.getIdolByItemId(this._item.objectGID);
            list.push({
               "label":"{spellPair," + idol.spellPairId + "::[" + idol.spellPair.name + "]}",
               "cssClass":"p"
            });
         }
         if(!this._showTheoretical && (this._item.effects && this._item.effects.length > 0 || this._item.possibleEffects && this._item.possibleEffects.length > 0))
         {
            if(this._item.effects && this._item.effects.length > 0)
            {
               effects = this._item.effects;
            }
            else if(this._item.objectUID == 0)
            {
               effects = this._item.possibleEffects;
               theoretical = true;
            }
            localEffects = [];
            for each(ei in effects)
            {
               localEffects.push(ei);
            }
            effects = this._item.favoriteEffect;
            for each(ei in effects)
            {
               localEffects.push(ei);
            }
            effects = localEffects;
         }
         else if(this._showTheoretical || this._item.objectUID == 0 && this._item.category == 0)
         {
            if(this._item.hideEffects)
            {
               list.push({
                  "label":this.uiApi.getText("ui.set.secretBonus"),
                  "cssClass":"p"
               });
               return;
            }
            effects = this._item.possibleEffects;
            localEffects = [];
            for each(ei in effects)
            {
               localEffects.push(ei);
            }
            effects = localEffects;
            theoretical = true;
         }
         else
         {
            effects = this._item.effects;
            localEffects = [];
            for each(ei in effects)
            {
               localEffects.push(ei);
            }
            effects = this._item.favoriteEffect;
            for each(ei in effects)
            {
               localEffects.push(ei);
            }
            effects = localEffects;
         }
         effects.sortOn("order",Array.NUMERIC);
         var category:Array = [];
         for each(ei in effects)
         {
            if(ei.category != -1)
            {
               if(ei.effectId != ActionIds.ACTION_ITEM_CHANGE_DURABILITY)
               {
                  currentCategory = ei.category;
                  if(!ei.showInSet)
                  {
                     currentCategory = 3;
                  }
                  if(!category[currentCategory])
                  {
                     category[currentCategory] = [];
                  }
                  category[currentCategory].push({
                     "effect":ei,
                     "cat":currentCategory
                  });
               }
            }
         }
         sortedCategory = [];
         for each(lineDmg in category[2])
         {
            desc = lineDmg.effect.description;
            if(!(!desc || desc.length == 0))
            {
               cssClass = "p";
               list.push({
                  "label":desc,
                  "cssClass":cssClass
               });
            }
         }
         if(category[0] && category[1])
         {
            sortedCategory = sortedCategory.concat(category[0],category[1]);
         }
         else if(category[0] || category[1])
         {
            sortedCategory = sortedCategory.concat(!!category[0] ? category[0] : category[1]);
         }
         if(category[3])
         {
            sortedCategory = sortedCategory.concat(category[3]);
         }
         var waitingBonusList:Array = [];
         for each(line in sortedCategory)
         {
            if(theoretical)
            {
               desc = line.effect.theoreticalDescription;
            }
            else
            {
               desc = line.effect.description;
            }
            if(!(!desc || desc.length == 0))
            {
               if(line.effect.bonusType == -1)
               {
                  cssClass = "malus";
               }
               else if(line.effect.bonusType == 1)
               {
                  cssClass = "bonus";
               }
               else
               {
                  cssClass = "p";
               }
               theoItem = this.dataApi.getItem(this._item.id);
               if(!this._item.hideEffects && line.effect.showInSet && this._item.enhanceable)
               {
                  exotic = true;
                  for each(theoEffect in theoItem.possibleEffects)
                  {
                     if(line.effect.effectId == theoEffect.effectId)
                     {
                        exotic = false;
                     }
                  }
                  if(exotic)
                  {
                     cssClass = "exotic";
                     list.push({
                        "label":desc,
                        "cssClass":cssClass
                     });
                     continue;
                  }
               }
               waitingBonusList.push({
                  "label":desc,
                  "cssClass":cssClass
               });
            }
         }
         for each(waitingBonus in waitingBonusList)
         {
            list.push(waitingBonus);
         }
      }
   }
}
