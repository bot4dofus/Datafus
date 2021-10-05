package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   
   public class WorldRpFightTooltipUi
   {
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public var mainCtr:GraphicContainer;
      
      public var levelCtr:GraphicContainer;
      
      public var waveCtr:GraphicContainer;
      
      public var lbl_fightersList:Label;
      
      public var lbl_nbWaves:Label;
      
      public var tx_wave:Texture;
      
      public function WorldRpFightTooltipUi()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var fighter:Object = null;
         var hasWaves:* = oParam.data.nbWaves > 0;
         var fightersList:String = "";
         for each(fighter in oParam.data.fighters)
         {
            if(fighter.allianceTag)
            {
               fightersList += fighter.allianceTag + " ";
            }
            fightersList += fighter.name + " (";
            if(fighter.id > 0 && fighter.level > ProtocolConstantsEnum.MAX_LEVEL)
            {
               fightersList += this.uiApi.getText("ui.common.short.level") + ProtocolConstantsEnum.MAX_LEVEL + ")\n";
            }
            else
            {
               fightersList += this.uiApi.getText("ui.common.short.level") + fighter.level + ")\n";
            }
         }
         this.lbl_fightersList.text = fightersList;
         if(!hasWaves)
         {
            this.waveCtr.visible = false;
            this.lbl_fightersList.y = this.levelCtr.y + this.levelCtr.height;
         }
         else
         {
            this.waveCtr.visible = true;
            this.waveCtr.y = this.levelCtr.y + this.levelCtr.height;
            this.lbl_nbWaves.text = "x " + oParam.data.nbWaves;
            this.lbl_nbWaves.fullWidthAndHeight();
            this.tx_wave.x = this.mainCtr.width / 2 - (this.tx_wave.width + this.lbl_nbWaves.width) / 2;
            this.lbl_nbWaves.x = this.tx_wave.x + this.tx_wave.width;
            this.lbl_fightersList.y = this.waveCtr.y + this.waveCtr.height;
         }
         this.mainCtr.height = this.mainCtr.contentHeight;
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset);
         var w:Number = this.mainCtr.width / 2;
         this.levelCtr.x = int(w - this.levelCtr.width / 2) - 2;
      }
      
      public function unload() : void
      {
      }
   }
}
