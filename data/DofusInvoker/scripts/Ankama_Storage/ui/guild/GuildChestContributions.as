package Ankama_Storage.ui.guild
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowPlayerMenuManager;
   import com.ankamagames.dofus.network.types.game.guild.Contribution;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class GuildChestContributions
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      public var gd_contributions:Grid;
      
      public var btn_valid:ButtonContainer;
      
      public var btn_close_popup:ButtonContainer;
      
      public var inp_search:Input;
      
      public var btn_resetSearch:ButtonContainer;
      
      private var INPUT_SEARCH_DEFAULT_TEXT:String;
      
      private var _currentSearchText:String;
      
      private var _contributions:Vector.<Contribution>;
      
      public function GuildChestContributions()
      {
         this._contributions = new Vector.<Contribution>();
         super();
      }
      
      public function main(params:Object) : void
      {
         this.uiApi.addComponentHook(this.btn_valid,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_search,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.btn_resetSearch,ComponentHookList.ON_RELEASE);
         this.INPUT_SEARCH_DEFAULT_TEXT = this.uiApi.getText("ui.guild.searchGuildChestContributor");
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.inp_search.restrict = "^[&\"~!@#$£%*\\_+=\'[]|;<>./?{},]()";
         this.btn_resetSearch.visible = false;
         this._contributions = params as Vector.<Contribution>;
         this._contributions = this.utilApi.sort(this._contributions,"contributorName");
         this.gd_contributions.dataProvider = this._contributions;
      }
      
      public function updateContributionLine(data:Contribution, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            if(data.contributorId != 0)
            {
               componentsRef.lbl_contributor.text = HyperlinkShowPlayerMenuManager.getLink(data.contributorId,data.contributorName);
            }
            else
            {
               componentsRef.lbl_contributor.text = data.contributorName;
            }
            componentsRef.lbl_contribution.text = this.utilApi.kamasToString(data.amount,"");
            componentsRef.tx_kama.visible = true;
         }
         else
         {
            componentsRef.lbl_contributor.text = "";
            componentsRef.lbl_contribution.text = "";
            componentsRef.tx_kama.visible = false;
         }
      }
      
      private function searchMember() : void
      {
         var contrib:Contribution = null;
         var listDisplayed:Array = [];
         for each(contrib in this._contributions)
         {
            listDisplayed.push(contrib);
         }
         listDisplayed = this.utilApi.filter(listDisplayed,this._currentSearchText,"contributorName");
         this.gd_contributions.dataProvider = listDisplayed;
      }
      
      private function resetSearch() : void
      {
         this._currentSearchText = null;
         this.inp_search.placeholderText = this.INPUT_SEARCH_DEFAULT_TEXT;
         this.btn_resetSearch.visible = false;
         this.gd_contributions.dataProvider = this._contributions;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close_popup:
            case this.btn_valid:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_resetSearch:
               this.resetSearch();
         }
      }
      
      public function onChange(target:Input) : void
      {
         switch(target)
         {
            case this.inp_search:
               if(this.inp_search.text.length && this.inp_search.text != this.INPUT_SEARCH_DEFAULT_TEXT)
               {
                  this._currentSearchText = this.inp_search.text;
                  this.btn_resetSearch.visible = true;
                  this.searchMember();
               }
               else if(this._currentSearchText)
               {
                  this.resetSearch();
               }
         }
      }
   }
}
