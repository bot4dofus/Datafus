package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationSourceTypeEnum;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class AlterationHeaderBlock extends AbstractTooltipBlock
   {
       
      
      private var _alteration:AlterationWrapper;
      
      private var sysApi:SystemApi;
      
      private var uiApi:UiApi;
      
      public function AlterationHeaderBlock(alteration:AlterationWrapper, param:Object, chunkType:String = "chunks")
      {
         super();
         this.sysApi = Api.system;
         this.uiApi = Api.ui;
         this._alteration = alteration;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         var chunkData:Array = [Api.tooltip.createChunkData("separator",chunkType + "/base/separator.txt")];
         var headerFile:String = !!this._alteration.category ? "/alteration/header.txt" : "/alteration/headerNoCategory.txt";
         chunkData.push(Api.tooltip.createChunkData("header",chunkType + headerFile));
         _block.initChunk(chunkData);
      }
      
      public function onAllChunkLoaded() : void
      {
         var chunkParams:Object = this.getAlterationHeaderChunkParams();
         _content = _block.getChunk("header").processContent(chunkParams);
         this.sysApi = null;
         this.uiApi = null;
      }
      
      private function getAlterationHeaderChunkParams() : Object
      {
         var sourceTypeLabel:String = null;
         var chunkParams:Object = {};
         chunkParams.name = this._alteration.name;
         chunkParams.parentCategory = this._alteration.parentCategory;
         if(this._alteration.parentCategory)
         {
            chunkParams.parentCategory = this._alteration.parentCategory;
         }
         else
         {
            chunkParams.parentCategory = "???";
         }
         if(this._alteration.category)
         {
            chunkParams.category = this._alteration.category;
         }
         if(this.sysApi.getPlayerManager().hasRights)
         {
            if(!isNaN(this._alteration.parentCategoryId))
            {
               chunkParams.parentCategory += " (".concat(this._alteration.parentCategoryId).concat(")");
            }
            else
            {
               chunkParams.parentCategory += " (?)";
            }
            if(chunkParams.category)
            {
               if(!isNaN(this._alteration.categoryId))
               {
                  chunkParams.category += " (".concat(this._alteration.categoryId).concat(")");
               }
               else
               {
                  chunkParams.category += " (?)";
               }
            }
            switch(this._alteration.sourceType)
            {
               case AlterationSourceTypeEnum.ALTERATION:
                  sourceTypeLabel = this.uiApi.getText("ui.alteration.alteration");
                  break;
               case AlterationSourceTypeEnum.ITEM:
                  sourceTypeLabel = this._alteration.parentCategory;
                  break;
               default:
                  sourceTypeLabel = "???";
            }
            chunkParams.name += " (" + this._alteration.bddId + ")";
         }
         if(!chunkParams.category)
         {
            chunkParams.parentCategory += "\n";
         }
         chunkParams.cssLvl = "headerp";
         return chunkParams;
      }
   }
}
