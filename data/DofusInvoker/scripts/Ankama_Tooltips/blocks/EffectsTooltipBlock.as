package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blockParams.EffectsTooltipBlockParameters;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.MonsterGrade;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   
   public class EffectsTooltipBlock extends AbstractTooltipBlock
   {
      
      public static const DAMAGE:uint = 0;
      
      public static const RESISTANCE:uint = 1;
      
      public static const SPELL_BOOST:uint = 3;
      
      public static const OTHER:uint = 4;
       
      
      private var _effect:Object;
      
      private var _setInfo:String;
      
      private var _showDamages:Boolean;
      
      private var _showTheoreticalEffects:Boolean;
      
      private var _showSpecialEffects:Boolean;
      
      private var _isCriticalEffects:Boolean;
      
      private var _showLabel:Boolean;
      
      private var _showDuration:Boolean;
      
      private var _fromBuff:Boolean;
      
      private var _length:int;
      
      private var _customli:String = "customlirightmargin";
      
      public function EffectsTooltipBlock(params:EffectsTooltipBlockParameters)
      {
         super();
         this._effect = params.effects;
         this._showDamages = params.showDamages;
         this._showTheoreticalEffects = params.showTheoreticalEffects;
         this._showSpecialEffects = params.showSpecialEffects;
         this._isCriticalEffects = params.isCriticalEffects;
         this._length = params.length;
         this._showLabel = params.showLabel;
         this._showDuration = params.showDuration;
         this._customli = params.customli;
         this._fromBuff = params.fromBuff;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         var chunkList:Array = [Api.tooltip.createChunkData("subTitle","chunks/base/subTitle.txt"),Api.tooltip.createChunkData("effect","chunks/effect/effect.txt"),Api.tooltip.createChunkData("subEffect","chunks/effect/subEffect.txt"),Api.tooltip.createChunkData("separator","chunks/base/separator.txt")];
         if(params.setInfo)
         {
            this._setInfo = params.setInfo;
            chunkList.unshift(Api.tooltip.createChunkData("setInfo","chunks/text/namelessContent.txt"));
         }
         _block.initChunk(chunkList);
      }
      
      public function onAllChunkLoaded() : void
      {
         var ei:EffectInstance = null;
         var sortedCategory:Array = null;
         var effectsPart:_EffectPart = null;
         var currentCategory:int = 0;
         _content = "";
         var category:Array = [];
         for each(ei in this._effect)
         {
            if(ei.category == -1 || (this._fromBuff && !ei.visibleInBuffUi || !this._fromBuff && !ei.visibleInTooltip))
            {
               continue;
            }
            switch(ei.effectId)
            {
               case ActionIds.ACTION_ITEM_CHANGE_DURABILITY:
                  break;
               default:
                  if(ei.category == DataEnum.ACTION_TYPE_DAMAGES)
                  {
                     currentCategory = 0;
                  }
                  else
                  {
                     currentCategory = 1;
                  }
                  if(!category[currentCategory])
                  {
                     category[currentCategory] = [];
                  }
                  category[currentCategory].push(ei);
                  break;
            }
         }
         sortedCategory = [];
         if(category[0] && this._showDamages)
         {
            sortedCategory.push(new _EffectPart(!!this._isCriticalEffects ? Api.ui.getText("ui.common.criticalDamages") : Api.ui.getText("ui.stats.damagesBonus"),DAMAGE,category[0]));
         }
         if(category[1])
         {
            sortedCategory.push(new _EffectPart(Api.ui.processText(!!this._isCriticalEffects ? Api.ui.getText("ui.common.criticalEffects") : Api.ui.getText("ui.common.effects"),"",category[1].length == 1,category[1].length == 0),SPELL_BOOST,category[1]));
         }
         if(this._setInfo)
         {
            _content += _block.getChunk("setInfo").processContent({
               "content":this._setInfo,
               "css":"[local.css]tooltip_monster.css"
            });
         }
         for each(effectsPart in sortedCategory)
         {
            if(this._showLabel && effectsPart.title)
            {
               _content += _block.getChunk("subTitle").processContent({
                  "text":effectsPart.title + Api.ui.getText("ui.common.colon"),
                  "length":this._length
               });
            }
            for each(ei in effectsPart.effects)
            {
               _content += this.processEffect(effectsPart,ei,"effect");
            }
         }
      }
      
      private function processEffect(effectsPart:_EffectPart, ei:Object, chunk:String, chunkArgs:Object = null, showSubEffect:Boolean = true) : String
      {
         var description:* = null;
         var spell:SpellWrapper = null;
         var myPattern:RegExp = null;
         var result:Object = null;
         var monster:Monster = null;
         var gradeId:int = 0;
         var grade:MonsterGrade = null;
         var level:int = 0;
         var lifePoints:int = 0;
         var bonusDodge:int = 0;
         var subSpell:Object = null;
         var subEffect:Object = null;
         var bombData:Object = null;
         var content:String = "";
         if(ei.effectId == ActionIds.ACTION_CAST_STARTING_SPELL)
         {
            spell = Api.data.getSpellWrapper(ei.diceNum,ei.diceSide);
            description = spell.spell.description;
         }
         else if(!this._showTheoreticalEffects)
         {
            description = ei.description;
         }
         else
         {
            description = ei.theoreticalDescription;
         }
         if(!description)
         {
            return "";
         }
         if(!chunkArgs)
         {
            chunkArgs = {};
         }
         var duration:* = null;
         if(this._showDuration)
         {
            if(ei.durationString)
            {
               duration = " (" + ei.durationString + ")";
            }
         }
         var cssClass:String = "p";
         if(ei.category != DataEnum.ACTION_TYPE_DAMAGES)
         {
            if(effectsPart.type == SPELL_BOOST)
            {
               if(ei.bonusType == -1)
               {
                  cssClass = "malus";
               }
               else if(ei.bonusType == 1)
               {
                  cssClass = "bonus";
               }
            }
         }
         else if(effectsPart.type == DAMAGE)
         {
            cssClass = "damages";
         }
         if(ei.trigger)
         {
            description = Api.ui.getText("ui.spell.trigger",description);
         }
         if(duration)
         {
            description = "• " + description + duration;
         }
         else
         {
            description = "• " + description;
         }
         if(ei.targetMask && ei.targetMask.length && (ei.targetMask.indexOf("i") != -1 || ei.targetMask.indexOf("s") != -1 || ei.targetMask.indexOf("I") != -1 || ei.targetMask.indexOf("S") != -1 || ei.targetMask.indexOf("j") != -1 || ei.targetMask.indexOf("J") != -1))
         {
            myPattern = new RegExp(/^[iIsSjJfFeE0-9,]+$/);
            result = myPattern.exec(ei.targetMask);
            if(result)
            {
               description = description + " (" + Api.ui.getText("ui.common.summon") + ")";
            }
         }
         chunkArgs.text = description;
         chunkArgs.cssClass = cssClass;
         chunkArgs.customli = this._customli;
         chunkArgs.length = this._length;
         content += _block.getChunk(chunk).processContent(chunkArgs);
         if(showSubEffect)
         {
            if(ei.effectId == ActionIds.ACTION_SUMMON_CREATURE || ei.effectId == ActionIds.ACTION_FIGHT_KILL_AND_SUMMON || ei.effectId == ActionIds.ACTION_FIGHT_KILL_AND_SUMMON_SLAVE || ei.effectId == ActionIds.ACTION_SUMMON_SLAVE)
            {
               monster = Api.data.getMonsterFromId(int(ei.parameter0));
               if(monster)
               {
                  gradeId = int(ei.parameter1);
                  if(gradeId < 1 || gradeId > monster.grades.length)
                  {
                     gradeId = monster.grades.length;
                  }
                  grade = monster.grades[gradeId - 1];
                  level = 1;
                  if(Api.player.getPlayedCharacterInfo())
                  {
                     level = Api.player.getPlayedCharacterInfo().limitedLevel;
                  }
                  lifePoints = Math.floor(grade.lifePoints + grade.lifePoints * level / 100);
                  content += _block.getChunk("subEffect").processContent({
                     "text":"• " + Api.ui.getText("ui.stats.HP") + Api.ui.getText("ui.common.colon") + lifePoints,
                     "rightText":"• " + Api.ui.getText("ui.stats.neutralReductionPercent") + Api.ui.getText("ui.common.colon") + grade.neutralResistance,
                     "rightTextVisible":true
                  });
                  content += _block.getChunk("subEffect").processContent({
                     "text":"• " + Api.ui.getText("ui.stats.shortAP") + Api.ui.getText("ui.common.colon") + grade.actionPoints,
                     "rightText":"• " + Api.ui.getText("ui.stats.earthReductionPercent") + Api.ui.getText("ui.common.colon") + grade.earthResistance,
                     "rightTextVisible":true
                  });
                  content += _block.getChunk("subEffect").processContent({
                     "text":"• " + Api.ui.getText("ui.stats.shortMP") + Api.ui.getText("ui.common.colon") + grade.movementPoints,
                     "rightText":"• " + Api.ui.getText("ui.stats.fireReductionPercent") + Api.ui.getText("ui.common.colon") + grade.fireResistance,
                     "rightTextVisible":true
                  });
                  bonusDodge = Math.floor((grade.wisdom + grade.wisdom * level / 100) / 10);
                  content += _block.getChunk("subEffect").processContent({
                     "text":"• " + Api.ui.getText("ui.stats.dodgeAP") + Api.ui.getText("ui.common.colon") + (grade.paDodge + bonusDodge),
                     "rightText":"• " + Api.ui.getText("ui.stats.waterReductionPercent") + Api.ui.getText("ui.common.colon") + grade.waterResistance,
                     "rightTextVisible":true
                  });
                  content += _block.getChunk("subEffect").processContent({
                     "text":"• " + Api.ui.getText("ui.stats.dodgeMP") + Api.ui.getText("ui.common.colon") + (grade.pmDodge + bonusDodge),
                     "rightText":"• " + Api.ui.getText("ui.stats.airReductionPercent") + Api.ui.getText("ui.common.colon") + grade.airResistance,
                     "rightTextVisible":true
                  });
               }
            }
            if(ei.effectId == ActionIds.ACTION_FIGHT_ADD_TRAP_CASTING_SPELL || ei.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL || ei.effectId == ActionIds.ACTION_SUMMON_BOMB || ei.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_CASTING_SPELL_ENDTURN || ei.effectId == ActionIds.ACTION_FIGHT_ADD_GLYPH_AURA || ei.effectId == ActionIds.ACTION_FIGHT_ADD_RUNE_CASTING_SPELL)
            {
               if(ei.effectId != ActionIds.ACTION_SUMMON_BOMB)
               {
                  subSpell = Api.data.getSpellWrapper(int(ei.parameter0),int(ei.parameter1));
               }
               else
               {
                  bombData = Api.data.getBomb(int(ei.parameter0));
                  subSpell = Api.data.getSpellWrapper(bombData.explodSpellId,int(ei.parameter1));
               }
               for each(subEffect in subSpell.effects)
               {
                  if(subEffect.visibleInTooltip)
                  {
                     content += this.processEffect(effectsPart,subEffect,"subEffect",{"rightTextVisible":false},false);
                  }
               }
            }
         }
         return content;
      }
   }
}

class _EffectPart
{
    
   
   public var title:String;
   
   public var type:uint;
   
   public var effects:Array;
   
   function _EffectPart(title:String, type:uint, effects:Array)
   {
      super();
      this.title = title;
      this.type = type;
      this.effects = effects;
   }
}
