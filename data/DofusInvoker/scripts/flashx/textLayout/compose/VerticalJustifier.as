package flashx.textLayout.compose
{
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Float;
   import flashx.textLayout.formats.VerticalAlign;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public final class VerticalJustifier
   {
       
      
      public function VerticalJustifier()
      {
         super();
      }
      
      public static function applyVerticalAlignmentToColumn(controller:ContainerController, verticalAlignAttr:String, lines:Array, startIndex:int, numLines:int, beginFloatIndex:int, endFloatIndex:int) : Number
      {
         var helper:IVerticalAdjustmentHelper = null;
         var i:int = 0;
         var rslt:Number = NaN;
         var lastLine:IVerticalJustificationLine = null;
         var bottom:Number = NaN;
         var floatIndex:int = 0;
         var floatInfo:FloatCompositionData = null;
         if(controller.rootElement.computedFormat.blockProgression == BlockProgression.RL)
         {
            helper = new RL_VJHelper(controller);
         }
         else
         {
            helper = new TB_VJHelper(controller);
         }
         switch(verticalAlignAttr)
         {
            case VerticalAlign.MIDDLE:
            case VerticalAlign.BOTTOM:
               lastLine = lines[startIndex + numLines - 1];
               bottom = helper.getBottom(lastLine,controller,beginFloatIndex,endFloatIndex);
               rslt = verticalAlignAttr == VerticalAlign.MIDDLE ? Number(helper.computeMiddleAdjustment(bottom)) : Number(helper.computeBottomAdjustment(bottom));
               for(i = startIndex; i < startIndex + numLines; i++)
               {
                  helper.applyAdjustment(lines[i]);
               }
               for(floatIndex = beginFloatIndex; floatIndex < endFloatIndex; floatIndex++)
               {
                  floatInfo = controller.getFloatAt(floatIndex);
                  if(floatInfo.floatType != Float.NONE)
                  {
                     helper.applyAdjustmentToFloat(floatInfo);
                  }
               }
               break;
            case VerticalAlign.JUSTIFY:
               rslt = helper.computeJustifyAdjustment(lines,startIndex,numLines);
               helper.applyJustifyAdjustment(lines,startIndex,numLines);
         }
         return rslt;
      }
   }
}

import flashx.textLayout.compose.FloatCompositionData;
import flashx.textLayout.compose.IVerticalJustificationLine;
import flashx.textLayout.container.ContainerController;

interface IVerticalAdjustmentHelper
{
    
   
   function getBottom(param1:IVerticalJustificationLine, param2:ContainerController, param3:int, param4:int) : Number;
   
   function computeMiddleAdjustment(param1:Number) : Number;
   
   function applyAdjustment(param1:IVerticalJustificationLine) : void;
   
   function applyAdjustmentToFloat(param1:FloatCompositionData) : void;
   
   function computeBottomAdjustment(param1:Number) : Number;
   
   function computeJustifyAdjustment(param1:Array, param2:int, param3:int) : Number;
   
   function applyJustifyAdjustment(param1:Array, param2:int, param3:int) : void;
}

import flashx.textLayout.compose.FloatCompositionData;
import flashx.textLayout.compose.IVerticalJustificationLine;
import flashx.textLayout.compose.TextFlowLine;
import flashx.textLayout.container.ContainerController;
import flashx.textLayout.elements.InlineGraphicElement;
import flashx.textLayout.formats.Float;
import flashx.textLayout.tlf_internal;

use namespace tlf_internal;

class TB_VJHelper implements IVerticalAdjustmentHelper
{
    
   
   private var _textFrame:ContainerController;
   
   private var adj:Number;
   
   function TB_VJHelper(tf:ContainerController)
   {
      super();
      this._textFrame = tf;
   }
   
   public function getBottom(line:IVerticalJustificationLine, controller:ContainerController, beginFloat:int, endFloat:int) : Number
   {
      var floatInfo:FloatCompositionData = null;
      var ilg:InlineGraphicElement = null;
      var maxBottom:Number = this.getBaseline(line) + line.descent;
      for(var i:int = beginFloat; i < endFloat; i++)
      {
         floatInfo = controller.getFloatAt(i);
         if(floatInfo.floatType != Float.NONE)
         {
            ilg = controller.rootElement.findLeaf(floatInfo.absolutePosition) as InlineGraphicElement;
            maxBottom = Math.max(maxBottom,floatInfo.y + ilg.elementHeightWithMarginsAndPadding());
         }
      }
      return maxBottom;
   }
   
   public function getBottomOfLine(line:IVerticalJustificationLine) : Number
   {
      return this.getBaseline(line) + line.descent;
   }
   
   private function getBaseline(line:IVerticalJustificationLine) : Number
   {
      if(line is TextFlowLine)
      {
         return line.y + line.ascent;
      }
      return line.y;
   }
   
   private function setBaseline(line:IVerticalJustificationLine, pos:Number) : void
   {
      if(line is TextFlowLine)
      {
         line.y = pos - line.ascent;
      }
      else
      {
         line.y = pos;
      }
   }
   
   public function computeMiddleAdjustment(contentBottom:Number) : Number
   {
      var frameBottom:Number = this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom());
      this.adj = (frameBottom - contentBottom) / 2;
      if(this.adj < 0)
      {
         this.adj = 0;
      }
      return this.adj;
   }
   
   public function computeBottomAdjustment(contentBottom:Number) : Number
   {
      var frameBottom:Number = this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom());
      this.adj = frameBottom - contentBottom;
      if(this.adj < 0)
      {
         this.adj = 0;
      }
      return this.adj;
   }
   
   public function applyAdjustment(line:IVerticalJustificationLine) : void
   {
      line.y += this.adj;
   }
   
   public function applyAdjustmentToFloat(floatInfo:FloatCompositionData) : void
   {
      floatInfo.y += this.adj;
   }
   
   public function computeJustifyAdjustment(lineArray:Array, firstLineIndex:int, numLines:int) : Number
   {
      this.adj = 0;
      if(numLines == 1)
      {
         return 0;
      }
      var firstLine:IVerticalJustificationLine = lineArray[firstLineIndex];
      var firstBaseLine:Number = this.getBaseline(firstLine);
      var lastLine:IVerticalJustificationLine = lineArray[firstLineIndex + numLines - 1];
      var frameBottom:Number = this._textFrame.compositionHeight - Number(this._textFrame.getTotalPaddingBottom());
      var allowance:Number = frameBottom - this.getBottomOfLine(lastLine);
      if(allowance < 0)
      {
         return 0;
      }
      var lastBaseLine:Number = this.getBaseline(lastLine);
      this.adj = allowance / (lastBaseLine - firstBaseLine);
      return this.adj;
   }
   
   public function applyJustifyAdjustment(lineArray:Array, firstLineIndex:int, numLines:int) : void
   {
      var line:IVerticalJustificationLine = null;
      var currBaseLine:Number = NaN;
      var currBaseLineUnjustified:Number = NaN;
      if(numLines == 1 || this.adj == 0)
      {
         return;
      }
      var firstLine:IVerticalJustificationLine = lineArray[firstLineIndex];
      var prevBaseLine:Number = this.getBaseline(firstLine);
      var prevBaseLineUnjustified:Number = prevBaseLine;
      for(var i:int = 1; i < numLines; i++)
      {
         line = lineArray[i + firstLineIndex];
         currBaseLineUnjustified = this.getBaseline(line);
         currBaseLine = prevBaseLine + (currBaseLineUnjustified - prevBaseLineUnjustified) * (1 + this.adj);
         this.setBaseline(line,currBaseLine);
         prevBaseLineUnjustified = currBaseLineUnjustified;
         prevBaseLine = currBaseLine;
      }
   }
}

import flashx.textLayout.compose.FloatCompositionData;
import flashx.textLayout.compose.IVerticalJustificationLine;
import flashx.textLayout.container.ContainerController;
import flashx.textLayout.formats.Float;
import flashx.textLayout.tlf_internal;

use namespace tlf_internal;

class RL_VJHelper implements IVerticalAdjustmentHelper
{
    
   
   private var _textFrame:ContainerController;
   
   private var adj:Number = 0;
   
   function RL_VJHelper(tf:ContainerController)
   {
      super();
      this._textFrame = tf;
   }
   
   public function getBottom(lastLine:IVerticalJustificationLine, controller:ContainerController, beginFloat:int, endFloat:int) : Number
   {
      var floatInfo:FloatCompositionData = null;
      var frameWidth:Number = this._textFrame.compositionWidth - Number(this._textFrame.getTotalPaddingLeft());
      var maxLeft:Number = frameWidth + lastLine.x - lastLine.descent;
      for(var i:int = beginFloat; i < endFloat; i++)
      {
         floatInfo = controller.getFloatAt(i);
         if(floatInfo.floatType != Float.NONE)
         {
            maxLeft = Math.min(maxLeft,floatInfo.x + frameWidth);
         }
      }
      return maxLeft;
   }
   
   public function computeMiddleAdjustment(contentLeft:Number) : Number
   {
      this.adj = contentLeft / 2;
      if(this.adj < 0)
      {
         this.adj = 0;
      }
      return -this.adj;
   }
   
   public function computeBottomAdjustment(contentLeft:Number) : Number
   {
      this.adj = contentLeft;
      if(this.adj < 0)
      {
         this.adj = 0;
      }
      return -this.adj;
   }
   
   public function applyAdjustment(line:IVerticalJustificationLine) : void
   {
      line.x -= this.adj;
   }
   
   public function applyAdjustmentToFloat(floatInfo:FloatCompositionData) : void
   {
      floatInfo.x -= this.adj;
   }
   
   public function computeJustifyAdjustment(lineArray:Array, firstLineIndex:int, numLines:int) : Number
   {
      this.adj = 0;
      if(numLines == 1)
      {
         return 0;
      }
      var firstLine:IVerticalJustificationLine = lineArray[firstLineIndex];
      var firstBaseLine:Number = firstLine.x;
      var lastLine:IVerticalJustificationLine = lineArray[firstLineIndex + numLines - 1];
      var frameLeft:Number = Number(this._textFrame.getTotalPaddingLeft()) - this._textFrame.compositionWidth;
      var allowance:Number = lastLine.x - lastLine.descent - frameLeft;
      if(allowance < 0)
      {
         return 0;
      }
      var lastBaseLine:Number = lastLine.x;
      this.adj = allowance / (firstBaseLine - lastBaseLine);
      return -this.adj;
   }
   
   public function applyJustifyAdjustment(lineArray:Array, firstLineIndex:int, numLines:int) : void
   {
      var line:IVerticalJustificationLine = null;
      var currBaseLine:Number = NaN;
      var currBaseLineUnjustified:Number = NaN;
      if(numLines == 1 || this.adj == 0)
      {
         return;
      }
      var firstLine:IVerticalJustificationLine = lineArray[firstLineIndex];
      var prevBaseLine:Number = firstLine.x;
      var prevBaseLineUnjustified:Number = prevBaseLine;
      for(var i:int = 1; i < numLines; i++)
      {
         line = lineArray[i + firstLineIndex];
         currBaseLineUnjustified = line.x;
         currBaseLine = prevBaseLine - (prevBaseLineUnjustified - currBaseLineUnjustified) * (1 + this.adj);
         line.x = currBaseLine;
         prevBaseLineUnjustified = currBaseLineUnjustified;
         prevBaseLine = currBaseLine;
      }
   }
}
