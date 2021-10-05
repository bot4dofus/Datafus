package flashx.textLayout.compose
{
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextLine;
   import flash.text.engine.TextLineValidity;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.elements.BackgroundManager;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [Exclude(kind="method",name="checkFirstDamage")]
   [Exclude(kind="method",name="debugCheckTextFlowLines")]
   [Exclude(kind="property",name="lines")]
   [Exclude(kind="method",name="addLine")]
   [Exclude(kind="method",name="initializeLines")]
   public class FlowComposerBase
   {
       
      
      private var _lines:Array;
      
      protected var _textFlow:TextFlow;
      
      protected var _damageAbsoluteStart:int;
      
      protected var _swfContext:ISWFContext;
      
      public function FlowComposerBase()
      {
         super();
         this._lines = new Array();
         this._swfContext = null;
      }
      
      tlf_internal static function computeBaseSWFContext(context:ISWFContext) : ISWFContext
      {
         return context && Object(context).hasOwnProperty("getBaseSWFContext") ? context["getBaseSWFContext"]() : context;
      }
      
      public function get lines() : Array
      {
         return this._lines;
      }
      
      public function getLineAt(index:int) : TextFlowLine
      {
         return this._lines[index];
      }
      
      public function get numLines() : int
      {
         return this._lines.length;
      }
      
      public function get textFlow() : TextFlow
      {
         return this._textFlow;
      }
      
      public function get damageAbsoluteStart() : int
      {
         return this._damageAbsoluteStart;
      }
      
      protected function initializeLines() : void
      {
         var line:TextFlowLine = null;
         var textLine:TextLine = null;
         var textBlock:TextBlock = null;
         var backgroundManager:BackgroundManager = !!this._textFlow ? this._textFlow.backgroundManager : null;
         if(TextLineRecycler.textLineRecyclerEnabled)
         {
            for each(line in this._lines)
            {
               textLine = line.peekTextLine();
               if(textLine && !textLine.parent)
               {
                  if(textLine.validity != TextLineValidity.INVALID)
                  {
                     textBlock = textLine.textBlock;
                     textBlock.releaseLines(textBlock.firstLine,textBlock.lastLine);
                  }
                  textLine.userData = null;
                  TextLineRecycler.addLineForReuse(textLine);
                  if(backgroundManager)
                  {
                     backgroundManager.removeLineFromCache(textLine);
                  }
               }
            }
         }
         this._lines.splice(0);
         this._damageAbsoluteStart = 0;
      }
      
      protected function finalizeLinesAfterCompose() : void
      {
         var line:TextFlowLine = null;
         var lineEnd:int = 0;
         if(this._lines.length == 0)
         {
            line = new TextFlowLine(null,null);
            line.setTextLength(this.textFlow.textLength);
            this._lines.push(line);
         }
         else
         {
            line = this._lines[this._lines.length - 1];
            lineEnd = line.absoluteStart + line.textLength;
            if(lineEnd < this.textFlow.textLength)
            {
               line = new TextFlowLine(null,null);
               line.setAbsoluteStart(lineEnd);
               line.setTextLength(this.textFlow.textLength - lineEnd);
               this._lines.push(line);
            }
         }
      }
      
      public function updateLengths(startPosition:int, deltaLength:int) : void
      {
         var line:TextFlowLine = null;
         var lenToDel:int = 0;
         var curPos:int = 0;
         var lineEndIdx:int = 0;
         var deleteChars:int = 0;
         if(this.numLines == 0)
         {
            return;
         }
         var lineIdx:int = this.findLineIndexAtPosition(startPosition);
         var damageStart:int = int.MAX_VALUE;
         if(deltaLength > 0)
         {
            if(lineIdx == this._lines.length)
            {
               line = this._lines[this._lines.length - 1];
               line.setTextLength(line.textLength + deltaLength);
            }
            else
            {
               line = this._lines[lineIdx++];
               line.setTextLength(line.textLength + deltaLength);
            }
            damageStart = line.absoluteStart;
         }
         else
         {
            lenToDel = -deltaLength;
            curPos = 0;
            do
            {
               line = this._lines[lineIdx];
               line.setAbsoluteStart(line.absoluteStart + lenToDel + deltaLength);
               curPos = startPosition > line.absoluteStart ? int(startPosition) : int(line.absoluteStart);
               lineEndIdx = line.absoluteStart + line.textLength;
               deleteChars = 0;
               if(curPos + lenToDel <= lineEndIdx)
               {
                  if(curPos == line.absoluteStart)
                  {
                     deleteChars = lenToDel;
                  }
                  else if(curPos == startPosition)
                  {
                     deleteChars = lenToDel;
                  }
               }
               else if(curPos == line.absoluteStart)
               {
                  deleteChars = line.textLength;
               }
               else
               {
                  deleteChars = lineEndIdx - curPos;
               }
               if(curPos == line.absoluteStart && curPos + deleteChars == lineEndIdx)
               {
                  lenToDel -= deleteChars;
                  this._lines.splice(lineIdx,1);
               }
               else
               {
                  if(damageStart > line.absoluteStart)
                  {
                     damageStart = line.absoluteStart;
                  }
                  line.setTextLength(line.textLength - deleteChars);
                  lenToDel -= deleteChars;
                  lineIdx++;
               }
            }
            while(lenToDel > 0);
            
         }
         while(lineIdx < this._lines.length)
         {
            line = this._lines[lineIdx];
            if(deltaLength >= 0)
            {
               line.setAbsoluteStart(line.absoluteStart + deltaLength);
            }
            else
            {
               line.setAbsoluteStart(line.absoluteStart > -deltaLength ? int(line.absoluteStart + deltaLength) : 0);
            }
            lineIdx++;
         }
         if(this._damageAbsoluteStart > damageStart)
         {
            this._damageAbsoluteStart = damageStart;
         }
      }
      
      public function damage(startPosition:int, damageLength:int, damageType:String) : void
      {
         var line:TextFlowLine = null;
         if(ContainerController.usesDiscretionaryHyphens)
         {
            damageLength += startPosition;
            startPosition = 0;
         }
         if(this._lines.length == 0 || this.textFlow.textLength == 0)
         {
            return;
         }
         if(startPosition == this.textFlow.textLength)
         {
            return;
         }
         var lineIndex:int = this.findLineIndexAtPosition(startPosition);
         var leaf:FlowLeafElement = this.textFlow.findLeaf(startPosition);
         if(leaf && lineIndex > 0)
         {
            lineIndex--;
         }
         if(this.lines[lineIndex].absoluteStart < this._damageAbsoluteStart)
         {
            this._damageAbsoluteStart = this._lines[lineIndex].absoluteStart;
         }
         while(lineIndex < this._lines.length)
         {
            line = this._lines[lineIndex];
            if(line.absoluteStart >= startPosition + damageLength)
            {
               break;
            }
            line.damage(damageType);
            lineIndex++;
         }
      }
      
      public function isDamaged(absolutePosition:int) : Boolean
      {
         if(this._lines.length == 0)
         {
            return true;
         }
         return this._damageAbsoluteStart <= absolutePosition && this._damageAbsoluteStart != this.textFlow.textLength;
      }
      
      public function isPotentiallyDamaged(absolutePosition:int) : Boolean
      {
         return this.isDamaged(absolutePosition);
      }
      
      public function findLineIndexAtPosition(absolutePosition:int, preferPrevious:Boolean = false) : int
      {
         var mid:int = 0;
         var line:TextFlowLine = null;
         var lo:int = 0;
         var hi:int = this._lines.length - 1;
         while(lo <= hi)
         {
            mid = (lo + hi) / 2;
            line = this._lines[mid];
            if(line.absoluteStart <= absolutePosition)
            {
               if(preferPrevious)
               {
                  if(line.absoluteStart + line.textLength >= absolutePosition)
                  {
                     return mid;
                  }
               }
               else if(line.absoluteStart + line.textLength > absolutePosition)
               {
                  return mid;
               }
               lo = mid + 1;
            }
            else
            {
               hi = mid - 1;
            }
         }
         return this._lines.length;
      }
      
      public function findLineAtPosition(absolutePosition:int, preferPrevious:Boolean = false) : TextFlowLine
      {
         return this._lines[this.findLineIndexAtPosition(absolutePosition,preferPrevious)];
      }
      
      public function addLine(newLine:TextFlowLine, workIndex:int) : void
      {
         var afterLine:TextFlowLine = null;
         var oldCharCount:int = 0;
         var deleteCount:int = 0;
         var amtRemaining:int = 0;
         var nextLine:int = 0;
         var backgroundManager:BackgroundManager = null;
         var recycleIdx:int = 0;
         var textLine:TextLine = null;
         var workLine:TextFlowLine = this._lines[workIndex];
         var damageStart:int = int.MAX_VALUE;
         if(this._damageAbsoluteStart == newLine.absoluteStart)
         {
            this._damageAbsoluteStart = newLine.absoluteStart + newLine.textLength;
         }
         if(workLine == null)
         {
            this.lines.push(newLine);
         }
         else if(workLine is TextFlowTableBlock && workLine != newLine)
         {
            this._lines.splice(workIndex,1,newLine);
         }
         else if(newLine is TextFlowTableBlock)
         {
            if(workLine != newLine)
            {
               this._lines.splice(workIndex,0,newLine);
               if(workLine.absoluteStart == newLine.absoluteStart)
               {
                  workLine.setAbsoluteStart(workLine.absoluteStart + 1);
               }
            }
         }
         else if(workLine.absoluteStart != newLine.absoluteStart)
         {
            if(workLine.absoluteStart + workLine.textLength > newLine.absoluteStart + newLine.textLength)
            {
               afterLine = new TextFlowLine(null,newLine.paragraph);
               afterLine.setAbsoluteStart(newLine.absoluteStart + newLine.textLength);
               oldCharCount = workLine.textLength;
               workLine.setTextLength(newLine.absoluteStart - workLine.absoluteStart);
               afterLine.setTextLength(oldCharCount - newLine.textLength - workLine.textLength);
               this._lines.splice(workIndex + 1,0,newLine,afterLine);
            }
            else
            {
               workLine.setTextLength(newLine.absoluteStart - workLine.absoluteStart);
               afterLine = this._lines[workIndex + 1];
               afterLine.setTextLength(newLine.absoluteStart + newLine.textLength - afterLine.absoluteStart);
               afterLine.setAbsoluteStart(newLine.absoluteStart + newLine.textLength);
               this._lines.splice(workIndex + 1,0,newLine);
            }
            damageStart = workLine.absoluteStart;
         }
         else if(workLine.textLength > newLine.textLength)
         {
            workLine.setTextLength(workLine.textLength - newLine.textLength);
            workLine.setAbsoluteStart(newLine.absoluteStart + newLine.textLength);
            workLine.damage(TextLineValidity.INVALID);
            this._lines.splice(workIndex,0,newLine);
            damageStart = workLine.absoluteStart;
         }
         else
         {
            deleteCount = 1;
            if(workLine.textLength != newLine.textLength)
            {
               amtRemaining = newLine.textLength - workLine.textLength;
               nextLine = workIndex + 1;
               while(amtRemaining > 0)
               {
                  afterLine = this._lines[nextLine];
                  if(amtRemaining < afterLine.textLength)
                  {
                     afterLine.setTextLength(afterLine.textLength - amtRemaining);
                     afterLine.damage(TextLineValidity.INVALID);
                     break;
                  }
                  deleteCount++;
                  amtRemaining -= afterLine.textLength;
                  nextLine++;
                  afterLine = nextLine < this._lines.length ? this._lines[nextLine] : null;
               }
               if(afterLine && afterLine.absoluteStart != newLine.absoluteStart + newLine.textLength)
               {
                  afterLine.setAbsoluteStart(newLine.absoluteStart + newLine.textLength);
                  afterLine.damage(TextLineValidity.INVALID);
               }
               damageStart = newLine.absoluteStart + newLine.textLength;
            }
            if(TextLineRecycler.textLineRecyclerEnabled)
            {
               backgroundManager = this.textFlow.backgroundManager;
               for(recycleIdx = workIndex; recycleIdx < workIndex + deleteCount; recycleIdx++)
               {
                  textLine = TextFlowLine(this._lines[recycleIdx]).peekTextLine();
                  if(textLine && !textLine.parent)
                  {
                     if(textLine.validity != TextLineValidity.VALID)
                     {
                        textLine.userData = null;
                        TextLineRecycler.addLineForReuse(textLine);
                        if(backgroundManager)
                        {
                           backgroundManager.removeLineFromCache(textLine);
                        }
                     }
                  }
               }
            }
            this._lines.splice(workIndex,deleteCount,newLine);
         }
         if(this._damageAbsoluteStart > damageStart)
         {
            this._damageAbsoluteStart = damageStart;
         }
      }
      
      public function get swfContext() : ISWFContext
      {
         return this._swfContext;
      }
      
      public function set swfContext(context:ISWFContext) : void
      {
         var newBaseContext:ISWFContext = null;
         var oldBaseContext:ISWFContext = null;
         if(context != this._swfContext)
         {
            if(this.textFlow)
            {
               newBaseContext = computeBaseSWFContext(context);
               oldBaseContext = computeBaseSWFContext(this._swfContext);
               this._swfContext = context;
               if(newBaseContext != oldBaseContext)
               {
                  this.damage(0,this.textFlow.textLength,FlowDamageType.INVALID);
                  this.textFlow.invalidateAllFormats();
               }
            }
            else
            {
               this._swfContext = context;
            }
         }
      }
   }
}
