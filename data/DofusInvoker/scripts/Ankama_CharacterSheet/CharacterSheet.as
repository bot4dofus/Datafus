package Ankama_CharacterSheet
{
   import Ankama_CharacterSheet.ui.CharacterBuildsUi;
   import Ankama_CharacterSheet.ui.CharacterSheetUi;
   import Ankama_CharacterSheet.ui.StatBoost;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   
   public class CharacterSheet extends Sprite
   {
      
      private static var _self:CharacterSheet;
       
      
      protected var characterSheetUi:CharacterSheetUi;
      
      protected var statBoost:StatBoost;
      
      protected var characterBuildsUi:CharacterBuildsUi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      public var statPointsBoostType:int = 0;
      
      private var _newSpellIdsToHighlight:Array;
      
      public function CharacterSheet()
      {
         this._newSpellIdsToHighlight = new Array();
         super();
      }
      
      public static function getInstance() : CharacterSheet
      {
         return _self;
      }
      
      public function main() : void
      {
         this.sysApi.addHook(HookList.OpenStats,this.onCharacterSheetOpen);
         this.sysApi.addHook(HookList.OpenCharacterBuilds,this.onCharacterBuildsOpen);
         this.sysApi.addHook(HookList.SpellsToHighlightUpdate,this.onSpellsToHighlightUpdate);
         _self = this;
      }
      
      public function destroy() : void
      {
         _self = null;
      }
      
      public function get newSpellIdsToHighlight() : Array
      {
         return this._newSpellIdsToHighlight;
      }
      
      protected function onCharacterSheetOpen(inventory:Object, strata:int = 1) : void
      {
         if(!this.uiApi.getUi(UIEnum.CHARACTER_SHEET_UI))
         {
            if(!this.playerApi.characteristics())
            {
               return;
            }
            if(this.uiApi.getUi(UIEnum.GRIMOIRE))
            {
               this.uiApi.unloadUi(UIEnum.GRIMOIRE);
            }
            if(this.uiApi.getUi("characterBuildsUi"))
            {
               this.uiApi.unloadUi("characterBuildsUi");
            }
            this.uiApi.loadUi(UIEnum.CHARACTER_SHEET_UI,UIEnum.CHARACTER_SHEET_UI,{"inventory":inventory},strata);
         }
         else
         {
            this.uiApi.unloadUi(UIEnum.CHARACTER_SHEET_UI);
         }
      }
      
      protected function onCharacterBuildsOpen(buildId:int) : void
      {
         var params:Object = null;
         if(!this.uiApi.getUi("characterBuildsUi"))
         {
            if(this.playerApi.isInFight() && !this.playerApi.isInPreFight())
            {
               return;
            }
            if(this.uiApi.getUi(UIEnum.CHARACTER_SHEET_UI))
            {
               this.uiApi.unloadUi(UIEnum.CHARACTER_SHEET_UI);
            }
            params = {};
            params.buildId = buildId;
            this.uiApi.loadUi("characterBuildsUi","characterBuildsUi",params,!!this.uiApi.getUi("levelUp") ? uint(StrataEnum.STRATA_MAX) : uint(StrataEnum.STRATA_MEDIUM));
         }
         else
         {
            this.uiApi.unloadUi("characterBuildsUi");
         }
      }
      
      protected function onSpellsToHighlightUpdate(newSpellIdsToHighlight:Array) : void
      {
         this._newSpellIdsToHighlight = newSpellIdsToHighlight;
      }
   }
}
