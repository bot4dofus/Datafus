package Ankama_Tooltips.blocks
{
   import com.ankamagames.berilia.types.tooltip.TooltipBlock;
   
   public class AbstractTooltipBlock
   {
       
      
      protected var _content:String = "";
      
      protected var _block:TooltipBlock;
      
      public function AbstractTooltipBlock()
      {
         super();
      }
      
      public function getContent() : String
      {
         return this._content;
      }
      
      public function get block() : TooltipBlock
      {
         return this._block;
      }
   }
}
