package flashx.textLayout.conversion
{
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.IConfiguration;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.TextFlow;
   
   [ExcludeClass]
   class PlainTextImporter extends ConverterBase implements ITextImporter
   {
      
      private static const _newLineRegex:RegExp = /\n|\r\n?/g;
       
      
      protected var _config:IConfiguration = null;
      
      function PlainTextImporter()
      {
         super();
      }
      
      public function importToFlow(source:Object) : TextFlow
      {
         if(source is String)
         {
            return this.importFromString(String(source));
         }
         return null;
      }
      
      public function get configuration() : IConfiguration
      {
         return this._config;
      }
      
      public function set configuration(value:IConfiguration) : void
      {
         this._config = value;
      }
      
      protected function importFromString(source:String) : TextFlow
      {
         var paraText:String = null;
         var paragraph:ParagraphElement = null;
         var span:SpanElement = null;
         var lastLeaf:FlowLeafElement = null;
         var paragraphStrings:Array = source.split(_newLineRegex);
         var textFlow:TextFlow = new TextFlow(this._config);
         for each(paraText in paragraphStrings)
         {
            paragraph = new ParagraphElement();
            span = new SpanElement();
            span.replaceText(0,0,paraText);
            paragraph.replaceChildren(0,0,span);
            textFlow.replaceChildren(textFlow.numChildren,textFlow.numChildren,paragraph);
         }
         if(useClipboardAnnotations && source.lastIndexOf("\n",source.length - 1) != source.length - 1)
         {
            lastLeaf = textFlow.getLastLeaf();
            lastLeaf.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE,"true");
            lastLeaf.parent.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE,"true");
            textFlow.setStyle(ConverterBase.MERGE_TO_NEXT_ON_PASTE,"true");
         }
         return textFlow;
      }
   }
}
