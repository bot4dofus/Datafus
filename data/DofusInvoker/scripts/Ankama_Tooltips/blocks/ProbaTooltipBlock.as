package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class ProbaTooltipBlock extends AbstractTooltipBlock
   {
      
      public static var NO_RARITY:String = "";
      
      public static var COMMON:String = "COMMON";
      
      public static var UNCOMMON:String = "UNCOMMON";
      
      public static var RARE:String = "RARE";
      
      public static var EPIC:String = "EPIC";
      
      public static var LEGENDARY:String = "LEGENDARY";
      
      public static var COMMON_CSS:String = "common";
      
      public static var UNCOMMON_CSS:String = "uncommon";
      
      public static var RARE_CSS:String = "rare";
      
      public static var EPIC_CSS:String = "epic";
      
      public static var LEGENDARY_CSS:String = "legendary";
       
      
      private var _chunkType:String;
      
      private var _params:Array;
      
      private var _length:uint;
      
      private var _showProba:Boolean;
      
      public function ProbaTooltipBlock(params:Array, showProba:Boolean = true, chunkType:String = "chunks")
      {
         super();
         this._chunkType = chunkType;
         this._params = params;
         this._showProba = showProba;
         this._length = 400;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         var chunkList:Array = [Api.tooltip.createChunkData("proba",this._chunkType + "/item/proba.txt"),Api.tooltip.createChunkData("subTitle",this._chunkType + "/base/subTitle.txt")];
         _block.initChunk(chunkList);
      }
      
      public function onAllChunkLoaded() : void
      {
         var probaEffect:Object = null;
         var logProba:Number = NaN;
         var probaToShow:String = null;
         _content = "";
         if(this._chunkType != "chunks")
         {
            _content += _block.getChunk("subTitle").processContent({"text":Api.ui.getText("ui.common.randomLoot")});
         }
         for each(probaEffect in this._params)
         {
            logProba = Math.log(probaEffect.proba) / Math.log(10);
            probaToShow = probaEffect.proba.toFixed(2);
            if(logProba < -2)
            {
               probaToShow = probaEffect.proba.toFixed(Math.ceil(-logProba));
            }
            _content += _block.getChunk("proba").processContent({
               "length":this._length,
               "name":probaEffect.name,
               "proba":(probaEffect.showProba && this._showProba ? probaToShow.replace(".",",") + " %" : ""),
               "cssClassProba":this.processProba(probaEffect.rarity),
               "probaVisible":probaEffect.showProba && this._showProba
            });
         }
      }
      
      private function processProba(rarity:String) : String
      {
         switch(rarity)
         {
            case COMMON:
               return COMMON_CSS;
            case UNCOMMON:
               return UNCOMMON_CSS;
            case RARE:
               return RARE_CSS;
            case EPIC:
               return EPIC_CSS;
            case LEGENDARY:
               return LEGENDARY_CSS;
            default:
               return COMMON_CSS;
         }
      }
   }
}
