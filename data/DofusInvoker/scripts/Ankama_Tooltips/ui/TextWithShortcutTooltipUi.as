package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   
   public class TextWithShortcutTooltipUi
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      public var mainCtr:GraphicContainer;
      
      public var lbl_text:Label;
      
      public function TextWithShortcutTooltipUi()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this.lbl_text.useCustomFormat = true;
         var shortcut:* = oParam.data.shortcut;
         if(shortcut.indexOf("(") == 0 && shortcut.indexOf(")") == shortcut.length - 1)
         {
            shortcut = shortcut.substr(1,shortcut.length - 2);
         }
         var shortcutColor:String = this.sysApi.getConfigEntry("colors.shortcut");
         shortcutColor = shortcutColor.replace("0x","#");
         this.lbl_text.text = oParam.data.text + " <font color=\'" + shortcutColor + "\'>(" + shortcut + ")</font>";
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset);
      }
   }
}
