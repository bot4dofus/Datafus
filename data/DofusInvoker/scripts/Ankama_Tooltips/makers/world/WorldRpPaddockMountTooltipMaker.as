package Ankama_Tooltips.makers.world
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.TextTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class WorldRpPaddockMountTooltipMaker implements ITooltipMaker
   {
       
      
      public function WorldRpPaddockMountTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt","chunks/base/container.txt","chunks/base/separator.txt");
         var text:String = data.name;
         if(data.name == "")
         {
            text = Api.ui.getText("ui.common.noName");
         }
         else
         {
            text = data.name;
         }
         if(Api.player.getPlayedCharacterInfo().name != data.ownerName)
         {
            text += "\n" + Api.ui.getText("ui.mount.mountOf",data.ownerName);
         }
         text += "\n" + Api.ui.getText("ui.common.level") + " " + data.level;
         tooltip.addBlock(new TextTooltipBlock(text,{
            "css":"[local.css]tooltip_title.css",
            "classCss":"center",
            "parseText":false
         }).block);
         return tooltip;
      }
   }
}
