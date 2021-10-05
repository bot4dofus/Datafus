package flashx.textLayout.edit
{
   import flashx.textLayout.conversion.ConverterBase;
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.elements.SpanElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.elements.TextRange;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class TextScrap
   {
      
      tlf_internal static const MERGE_TO_NEXT_ON_PASTE:String = "mergeToNextOnPaste";
       
      
      private var _textFlow:TextFlow;
      
      private var _plainText:int;
      
      public function TextScrap(textFlow:TextFlow = null)
      {
         super();
         this._textFlow = textFlow;
         this._textFlow.flowComposer = null;
         this._plainText = -1;
      }
      
      public static function createTextScrap(range:TextRange) : TextScrap
      {
         var fl:FlowElement = null;
         var srcElem:FlowElement = null;
         var copyElem:FlowElement = null;
         var startPos:int = range.absoluteStart;
         var endPos:int = range.absoluteEnd;
         var theFlow:TextFlow = range.textFlow;
         if(!theFlow || startPos >= endPos)
         {
            return null;
         }
         var newTextFlow:TextFlow = theFlow.deepCopy(startPos,endPos) as TextFlow;
         newTextFlow.normalize();
         var retTextScrap:TextScrap = new TextScrap(newTextFlow);
         if(newTextFlow.textLength > 0)
         {
            fl = newTextFlow.getLastLeaf();
            srcElem = theFlow.findLeaf(endPos - 1);
            copyElem = newTextFlow.getLastLeaf();
            if(copyElem is SpanElement && !(srcElem is SpanElement))
            {
               copyElem = newTextFlow.findLeaf(newTextFlow.textLength - 2);
            }
            while(copyElem && srcElem)
            {
               if(endPos < srcElem.getAbsoluteStart() + srcElem.textLength)
               {
                  copyElem.setStyle(tlf_internal::MERGE_TO_NEXT_ON_PASTE,"true");
               }
               copyElem = copyElem.parent;
               srcElem = srcElem.parent;
            }
            return retTextScrap;
         }
         return null;
      }
      
      public function get textFlow() : TextFlow
      {
         return this._textFlow;
      }
      
      public function clone() : TextScrap
      {
         return new TextScrap(this.textFlow.deepCopy() as TextFlow);
      }
      
      tlf_internal function setPlainText(plainText:Boolean) : void
      {
         this._plainText = !!plainText ? 0 : 1;
      }
      
      tlf_internal function isPlainText() : Boolean
      {
         var isPlainElement:Function = null;
         var i:int = 0;
         isPlainElement = function(element:FlowElement):Boolean
         {
            var prop:* = null;
            if(!(element is ParagraphElement) && !(element is SpanElement))
            {
               foundAttributes = true;
               return true;
            }
            var styles:Object = element.styles;
            if(styles)
            {
               for(prop in styles)
               {
                  if(prop != ConverterBase.MERGE_TO_NEXT_ON_PASTE)
                  {
                     foundAttributes = true;
                     return true;
                  }
               }
            }
            return false;
         };
         var foundAttributes:Boolean = false;
         if(this._plainText == -1)
         {
            for(i = this._textFlow.numChildren - 1; i >= 0; i--)
            {
               this._textFlow.getChildAt(i).applyFunctionToElements(isPlainElement);
            }
            this._plainText = !!foundAttributes ? 1 : 0;
         }
         return this._plainText == 0;
      }
   }
}
