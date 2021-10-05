package flashx.textLayout.utils
{
   import flash.geom.Rectangle;
   import flash.text.engine.TextLine;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.elements.TextRange;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public final class GeometryUtil
   {
       
      
      public function GeometryUtil()
      {
         super();
      }
      
      public static function getHighlightBounds(range:TextRange) : Array
      {
         var nextLine:TextFlowLine = null;
         var heightAndAdj:Array = null;
         var textLine:TextLine = null;
         var rect:Rectangle = null;
         var temp:TextFlowLine = null;
         var obj:Object = null;
         var flowComposer:IFlowComposer = range.textFlow.flowComposer;
         if(!flowComposer)
         {
            return null;
         }
         var resultShapes:Array = new Array();
         var begLine:int = flowComposer.findLineIndexAtPosition(range.absoluteStart);
         var endLine:int = range.absoluteStart == range.absoluteEnd ? int(begLine) : int(flowComposer.findLineIndexAtPosition(range.absoluteEnd));
         if(endLine >= flowComposer.numLines)
         {
            endLine = flowComposer.numLines - 1;
         }
         var prevLine:TextFlowLine = begLine > 0 ? flowComposer.getLineAt(begLine - 1) : null;
         var line:TextFlowLine = flowComposer.getLineAt(begLine);
         var mainRects:Array = [];
         for(var curLineIndex:int = begLine; curLineIndex <= endLine; curLineIndex++)
         {
            nextLine = curLineIndex != flowComposer.numLines - 1 ? flowComposer.getLineAt(curLineIndex + 1) : null;
            heightAndAdj = line.getRomanSelectionHeightAndVerticalAdjustment(prevLine,nextLine);
            textLine = line.getTextLine(true);
            line.calculateSelectionBounds(textLine,mainRects,range.absoluteStart < line.absoluteStart ? int(line.absoluteStart - line.paragraph.getAbsoluteStart()) : int(range.absoluteStart - line.paragraph.getAbsoluteStart()),range.absoluteEnd > line.absoluteStart + line.textLength ? int(line.absoluteStart + line.textLength - line.paragraph.getAbsoluteStart()) : int(range.absoluteEnd - line.paragraph.getAbsoluteStart()),range.textFlow.computedFormat.blockProgression,heightAndAdj);
            for each(rect in mainRects)
            {
               obj = new Object();
               obj.textLine = textLine;
               obj.rect = rect.clone();
               resultShapes.push(obj);
            }
            mainRects.length = 0;
            temp = line;
            line = nextLine;
            prevLine = temp;
         }
         return resultShapes;
      }
   }
}
