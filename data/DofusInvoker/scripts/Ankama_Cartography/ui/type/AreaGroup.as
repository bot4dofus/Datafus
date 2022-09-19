package Ankama_Cartography.ui.type
{
   public class AreaGroup
   {
       
      
      public var label:String;
      
      public var labelColor:String;
      
      public var type:String;
      
      public var uri:String;
      
      public var layer:String;
      
      public var colorKey:String;
      
      public var children:Array;
      
      public var expend:Boolean;
      
      public function AreaGroup(label:String, infoType:String, uri:String, layer:String, colorKey:String = null, labelColor:String = null)
      {
         super();
         this.label = label;
         this.labelColor = labelColor;
         this.type = infoType;
         this.uri = uri;
         this.layer = layer;
         this.colorKey = colorKey;
         this.children = [];
         this.expend = false;
      }
   }
}
