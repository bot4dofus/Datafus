package flashx.textLayout.elements
{
   import flash.display.CapsStyle;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.engine.TextBlock;
   import flash.text.engine.TextLine;
   import flash.utils.Dictionary;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.compose.ParcelList;
   import flashx.textLayout.compose.StandardFlowComposer;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.compose.TextFlowTableBlock;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.container.TextContainerManager;
   import flashx.textLayout.factory.FactoryDisplayComposer;
   import flashx.textLayout.formats.BackgroundColor;
   import flashx.textLayout.formats.BorderColor;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class BackgroundManager
   {
      
      public static var BACKGROUND_MANAGER_CACHE:Dictionary = null;
      
      public static var TOP_EXCLUDED:String = "topExcluded";
      
      public static var BOTTOM_EXCLUDED:String = "bottomExcluded";
      
      public static var TOP_AND_BOTTOM_EXCLUDED:String = "topAndBottomExcluded";
       
      
      protected var _lineDict:Dictionary;
      
      protected var _blockElementDict:Dictionary;
      
      protected var _rectArray:Array;
      
      public function BackgroundManager()
      {
         super();
         this._lineDict = new Dictionary(true);
         this._blockElementDict = new Dictionary(true);
         this._rectArray = new Array();
      }
      
      public static function collectTableBlock(_textFlow:TextFlow, block:TextFlowTableBlock, controller:ContainerController) : void
      {
         var bb:BackgroundManager = null;
         var r:Rectangle = null;
         var composer:IFlowComposer = null;
         var cell:TableCellElement = null;
         var row:TableRowElement = null;
         var cells:Vector.<TableCellElement> = block.getTableCells();
         for each(cell in cells)
         {
            if(BackgroundManager.hasBorderOrBackground(cell))
            {
               if(!_textFlow.backgroundManager)
               {
                  _textFlow.getBackgroundManager();
               }
               bb = _textFlow.backgroundManager;
               bb.addBlockElement(cell);
               row = cell.getRow();
               r = new Rectangle(cell.x,cell.y + block.y,cell.width,row.composedHeight);
               bb.addBlockRect(cell,r,controller);
            }
         }
         block.y;
      }
      
      public static function collectBlock(_textFlow:TextFlow, elem:FlowGroupElement, _parcelList:ParcelList = null, tableComposeNotFromBeginning:Boolean = false, tableOutOfView:Boolean = false) : void
      {
         var bb:BackgroundManager = null;
         var r:Rectangle = null;
         var controller:ContainerController = null;
         var composer:IFlowComposer = null;
         var tab:TableElement = null;
         var tb:TextBlock = null;
         var p:ParagraphElement = null;
         var firstLine:TextFlowLine = null;
         var lastLine:TextFlowLine = null;
         var leaf:FlowLeafElement = null;
         var startColumnIndex:int = 0;
         var startController:ContainerController = null;
         var endColumnIndex:int = 0;
         var endController:ContainerController = null;
         var passFirstController:Boolean = false;
         var aidx:Number = NaN;
         var sIdx:int = 0;
         var cc:ContainerController = null;
         var cidx:int = 0;
         var eIdx:int = 0;
         var fLine:TextLine = null;
         var lLine:TextLine = null;
         var leafF:FlowLeafElement = null;
         var tcm:TextContainerManager = null;
         if(elem)
         {
            if(BackgroundManager.hasBorderOrBackground(elem))
            {
               if(!_textFlow.backgroundManager)
               {
                  _textFlow.getBackgroundManager();
               }
               bb = _textFlow.backgroundManager;
               bb.addBlockElement(elem);
               composer = _textFlow.flowComposer;
               if(composer && elem.textLength > 1)
               {
                  if(elem is TableElement)
                  {
                     tab = elem as TableElement;
                  }
                  else
                  {
                     tb = null;
                     p = elem.getFirstLeaf().getParagraph();
                     if(p)
                     {
                        tb = p.getTextBlock();
                     }
                     while(!tb && p)
                     {
                        p = p.getNextParagraph();
                        tb = p.getTextBlock();
                     }
                     if(composer is StandardFlowComposer && composer.numLines > 0)
                     {
                        firstLine = null;
                        lastLine = null;
                        if(tb && tb.firstLine)
                        {
                           firstLine = tb.firstLine.userData;
                           do
                           {
                              tb = p.getTextBlock();
                              if(tb && tb.lastLine)
                              {
                                 lastLine = tb.lastLine.userData;
                              }
                              leaf = p.getLastLeaf().getNextLeaf(elem);
                              if(leaf)
                              {
                                 p = leaf.getParagraph();
                              }
                              else
                              {
                                 p = null;
                              }
                           }
                           while(p);
                           
                        }
                        if(firstLine && lastLine)
                        {
                           startColumnIndex = firstLine.columnIndex;
                           startController = firstLine.controller;
                           endColumnIndex = lastLine.columnIndex;
                           endController = lastLine.controller;
                           if(startController && endController)
                           {
                              if(startController == endController && endColumnIndex == startColumnIndex)
                              {
                                 r = startController.columnState.getColumnAt(startColumnIndex);
                                 r.top = firstLine.y;
                                 r.bottom = lastLine.y + lastLine.height;
                                 bb.addBlockRect(elem,r,startController);
                              }
                              else
                              {
                                 if(startController != endController)
                                 {
                                    for(sIdx = startController.columnCount - 1; sIdx > startColumnIndex; sIdx--)
                                    {
                                       r = startController.columnState.getColumnAt(sIdx);
                                       bb.addBlockRect(elem,r,startController);
                                    }
                                 }
                                 if(endColumnIndex != startColumnIndex)
                                 {
                                    r = startController.columnState.getColumnAt(startColumnIndex);
                                    r.top = firstLine.y;
                                    bb.addBlockRect(elem,r,startController);
                                 }
                                 passFirstController = false;
                                 for(aidx = 0; aidx < composer.numControllers; aidx++)
                                 {
                                    cc = composer.getControllerAt(aidx);
                                    if(passFirstController)
                                    {
                                       for(cidx = 0; cidx < cc.columnCount; cidx++)
                                       {
                                          r = cc.columnState.getColumnAt(cidx);
                                          bb.addBlockRect(elem,r,cc);
                                       }
                                    }
                                    if(cc == endController)
                                    {
                                       break;
                                    }
                                    if(cc == startController)
                                    {
                                       passFirstController = true;
                                    }
                                 }
                                 if(startController != endController)
                                 {
                                    for(eIdx = 0; eIdx < endColumnIndex; eIdx++)
                                    {
                                       r = endController.columnState.getColumnAt(eIdx);
                                       bb.addBlockRect(elem,r,endController);
                                    }
                                 }
                                 r = endController.columnState.getColumnAt(endColumnIndex);
                                 r.bottom = lastLine.y + lastLine.height;
                                 bb.addBlockRect(elem,r,endController);
                              }
                           }
                        }
                     }
                     else if(composer is FactoryDisplayComposer)
                     {
                        fLine = null;
                        lLine = null;
                        if(tb && tb.firstLine)
                        {
                           fLine = tb.firstLine;
                           do
                           {
                              tb = p.getTextBlock();
                              if(tb && tb.lastLine)
                              {
                                 lLine = tb.lastLine;
                              }
                              leafF = p.getLastLeaf().getNextLeaf(elem);
                              if(leafF)
                              {
                                 p = leafF.getParagraph();
                              }
                              else
                              {
                                 p = null;
                              }
                           }
                           while(p);
                           
                        }
                        if(fLine && lLine)
                        {
                           if((composer as Object).hasOwnProperty("tcm"))
                           {
                              tcm = (composer as Object).tcm;
                              if(tcm)
                              {
                                 r = new Rectangle(0,fLine.y - fLine.height,tcm.compositionWidth,lLine.y - fLine.y + fLine.height);
                                 bb.addBlockRect(elem,r,composer.getControllerAt(0));
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public static function hasBorderOrBackground(elem:FlowElement) : Boolean
      {
         var format:ITextLayoutFormat = elem.computedFormat;
         if(format.backgroundColor != BackgroundColor.TRANSPARENT)
         {
            return true;
         }
         if(format.borderLeftWidth != 0 || format.borderRightWidth != 0 || format.borderTopWidth != 0 || format.borderBottomWidth != 0)
         {
            if(format.borderLeftColor != BorderColor.TRANSPARENT || format.borderRightColor != BorderColor.TRANSPARENT || format.borderTopColor != BorderColor.TRANSPARENT || format.borderBottomColor != BorderColor.TRANSPARENT)
            {
               return true;
            }
         }
         return false;
      }
      
      public function clearBlockRecord() : void
      {
         this._rectArray.splice(0,this._rectArray.length);
      }
      
      public function addBlockRect(elem:FlowElement, r:Rectangle, cc:ContainerController = null, style:String = null) : void
      {
         var rect:Object = new Object();
         rect.r = r;
         rect.elem = elem;
         rect.cc = cc;
         rect.style = style;
         this._rectArray.unshift(rect);
      }
      
      public function addBlockElement(elem:FlowElement) : void
      {
         var format:ITextLayoutFormat = null;
         var record:Object = null;
         if(!this._blockElementDict.hasOwnProperty(elem))
         {
            format = elem.computedFormat;
            record = new Object();
            record.backgroundColor = format.backgroundColor;
            record.backgroundAlpha = format.backgroundAlpha;
            record.borderLeftWidth = format.borderLeftWidth;
            record.borderRightWidth = format.borderRightWidth;
            record.borderTopWidth = format.borderTopWidth;
            record.borderBottomWidth = format.borderBottomWidth;
            record.borderLeftColor = format.borderLeftColor;
            record.borderRightColor = format.borderRightColor;
            record.borderTopColor = format.borderTopColor;
            record.borderBottomColor = format.borderBottomColor;
            this._blockElementDict[elem] = record;
         }
      }
      
      public function addRect(tl:TextLine, fle:FlowLeafElement, r:Rectangle, color:uint, alpha:Number) : void
      {
         var currRecord:Object = null;
         var entry:Array = this._lineDict[tl];
         if(entry == null)
         {
            entry = this._lineDict[tl] = new Array();
         }
         var record:Object = new Object();
         record.rect = r;
         record.fle = fle;
         record.color = color;
         record.alpha = alpha;
         var fleAbsoluteStart:int = fle.getAbsoluteStart();
         for(var i:int = 0; i < entry.length; i++)
         {
            currRecord = entry[i];
            if(currRecord.hasOwnProperty("fle") && currRecord.fle.getAbsoluteStart() == fleAbsoluteStart)
            {
               entry[i] = record;
               return;
            }
         }
         entry.push(record);
      }
      
      public function addNumberLine(tl:TextLine, numberLine:TextLine) : void
      {
         var entry:Array = this._lineDict[tl];
         if(entry == null)
         {
            entry = this._lineDict[tl] = new Array();
         }
         entry.push({"numberLine":numberLine});
      }
      
      public function finalizeLine(line:TextFlowLine) : void
      {
      }
      
      tlf_internal function getEntry(line:TextLine) : *
      {
         return !!this._lineDict ? this._lineDict[line] : undefined;
      }
      
      public function drawAllRects(textFlow:TextFlow, bgShape:Shape, constrainWidth:Number, constrainHeight:Number) : void
      {
         var block:Object = null;
         var rec:Rectangle = null;
         var style:Object = null;
         var line:* = null;
         var g:Graphics = null;
         var entry:Array = null;
         var columnRect:Rectangle = null;
         var r:Rectangle = null;
         var record:Object = null;
         var i:int = 0;
         var numberLine:TextLine = null;
         var backgroundManager:BackgroundManager = null;
         var numberEntry:Array = null;
         var ii:int = 0;
         var numberRecord:Object = null;
         for(var idx:int = 0; idx < this._rectArray.length; idx++)
         {
            block = this._rectArray[idx];
            rec = block.r;
            style = this._blockElementDict[block.elem];
            if(rec && style)
            {
               g = bgShape.graphics;
               if(style.backgroundColor != BackgroundColor.TRANSPARENT)
               {
                  g.lineStyle(NaN,style.backgroundColor,style.backgroundAlpha,true);
                  g.beginFill(style.backgroundColor,style.backgroundAlpha);
                  g.drawRect(rec.x,rec.y,rec.width,rec.height);
                  g.endFill();
               }
               g.moveTo(rec.x + Math.floor(style.borderLeftWidth / 2),rec.y + Math.floor(style.borderTopWidth / 2));
               if(block.style != BackgroundManager.TOP_EXCLUDED && block.style != BackgroundManager.TOP_AND_BOTTOM_EXCLUDED && style.borderTopWidth != 0 && style.borderTopColor != BorderColor.TRANSPARENT)
               {
                  g.lineStyle(style.borderTopWidth,style.borderTopColor,style.backgroundAlpha,true,"normal",CapsStyle.SQUARE);
                  g.lineTo(rec.x + rec.width - Math.floor(style.borderLeftWidth / 2),rec.y + Math.floor(style.borderTopWidth / 2));
               }
               g.moveTo(rec.x + rec.width - Math.floor(style.borderRightWidth / 2),rec.y + Math.floor(style.borderTopWidth / 2));
               if(style.borderRightWidth != 0 && style.borderRightColor != BorderColor.TRANSPARENT)
               {
                  g.lineStyle(style.borderRightWidth,style.borderRightColor,style.backgroundAlpha,true,"normal",CapsStyle.SQUARE);
                  g.lineTo(rec.x + rec.width - Math.floor(style.borderRightWidth / 2),rec.y + rec.height - Math.floor(style.borderTopWidth / 2));
               }
               g.moveTo(rec.x + rec.width - Math.floor(style.borderLeftWidth / 2),rec.y + rec.height - Math.floor(style.borderBottomWidth / 2));
               if(block.style != BackgroundManager.BOTTOM_EXCLUDED && block.style != BackgroundManager.TOP_AND_BOTTOM_EXCLUDED && style.borderBottomWidth != 0 && style.borderBottomColor != BorderColor.TRANSPARENT)
               {
                  g.lineStyle(style.borderBottomWidth,style.borderBottomColor,style.backgroundAlpha,true,"normal",CapsStyle.SQUARE);
                  g.lineTo(rec.x + Math.floor(style.borderLeftWidth / 2),rec.y + rec.height - Math.floor(style.borderBottomWidth / 2));
               }
               g.moveTo(rec.x + Math.floor(style.borderLeftWidth / 2),rec.y + rec.height - Math.floor(style.borderTopWidth / 2));
               if(style.borderLeftWidth != 0 && style.borderLeftColor != BorderColor.TRANSPARENT)
               {
                  g.lineStyle(style.borderLeftWidth,style.borderLeftColor,style.backgroundAlpha,true,"normal",CapsStyle.SQUARE);
                  g.lineTo(rec.x + Math.floor(style.borderLeftWidth / 2),rec.y + Math.floor(style.borderTopWidth / 2));
               }
            }
         }
         for(line in this._lineDict)
         {
            entry = this._lineDict[line];
            if(entry.length)
            {
               columnRect = entry[0].columnRect;
               for(i = 0; i < entry.length; i++)
               {
                  record = entry[i];
                  if(record.hasOwnProperty("numberLine"))
                  {
                     numberLine = record.numberLine;
                     backgroundManager = TextFlowLine.getNumberLineBackground(numberLine);
                     numberEntry = backgroundManager._lineDict[numberLine];
                     for(ii = 0; ii < numberEntry.length; ii++)
                     {
                        numberRecord = numberEntry[ii];
                        r = numberRecord.rect;
                        r.x += line.x + numberLine.x;
                        r.y += line.y + numberLine.y;
                        TextFlowLine.constrainRectToColumn(textFlow,r,columnRect,0,0,constrainWidth,constrainHeight);
                        bgShape.graphics.beginFill(numberRecord.color,numberRecord.alpha);
                        bgShape.graphics.drawRect(r.x,r.y,r.width,r.height);
                        bgShape.graphics.endFill();
                     }
                  }
                  else
                  {
                     r = record.rect;
                     r.x += line.x;
                     r.y += line.y;
                     TextFlowLine.constrainRectToColumn(textFlow,r,columnRect,0,0,constrainWidth,constrainHeight);
                     bgShape.graphics.beginFill(record.color,record.alpha);
                     bgShape.graphics.drawRect(r.x,r.y,r.width,r.height);
                     bgShape.graphics.endFill();
                  }
               }
            }
         }
      }
      
      public function removeLineFromCache(tl:TextLine) : void
      {
         delete this._lineDict[tl];
      }
      
      public function onUpdateComplete(controller:ContainerController) : void
      {
         var bgShape:Shape = null;
         var rec:Rectangle = null;
         var style:Object = null;
         var block:Object = null;
         var idx:int = 0;
         var childIdx:int = 0;
         var g:Graphics = null;
         var line:* = undefined;
         var tl:TextLine = null;
         var entry:Array = null;
         var r:Rectangle = null;
         var tfl:TextFlowLine = null;
         var i:int = 0;
         var record:Object = null;
         var numberLine:TextLine = null;
         var backgroundManager:BackgroundManager = null;
         var numberEntry:Array = null;
         var ii:int = 0;
         var numberRecord:Object = null;
         var container:Sprite = controller.container;
         if(container && container.numChildren)
         {
            bgShape = controller.getBackgroundShape();
            bgShape.graphics.clear();
            for(idx = 0; idx < this._rectArray.length; idx++)
            {
               block = this._rectArray[idx];
               if(block.cc == controller)
               {
                  style = this._blockElementDict[block.elem];
                  if(style != null)
                  {
                     rec = block.r;
                     g = bgShape.graphics;
                     if(style.backgroundColor != BackgroundColor.TRANSPARENT)
                     {
                        g.lineStyle(NaN,style.backgroundColor,style.backgroundAlpha,true);
                        g.beginFill(style.backgroundColor,style.backgroundAlpha);
                        g.drawRect(rec.x,rec.y,rec.width,rec.height);
                        g.endFill();
                     }
                     g.moveTo(rec.x + Math.floor(style.borderLeftWidth / 2),rec.y + Math.floor(style.borderTopWidth / 2));
                     if(block.style != BackgroundManager.TOP_EXCLUDED && block.style != BackgroundManager.TOP_AND_BOTTOM_EXCLUDED && style.borderTopWidth != 0 && style.borderTopColor != BorderColor.TRANSPARENT)
                     {
                        g.lineStyle(style.borderTopWidth,style.borderTopColor,style.backgroundAlpha,true,"normal",CapsStyle.SQUARE);
                        g.lineTo(rec.x + rec.width - Math.floor(style.borderLeftWidth / 2),rec.y + Math.floor(style.borderTopWidth / 2));
                     }
                     g.moveTo(rec.x + rec.width - Math.floor(style.borderRightWidth / 2),rec.y + Math.floor(style.borderTopWidth / 2));
                     if(style.borderRightWidth != 0 && style.borderRightColor != BorderColor.TRANSPARENT)
                     {
                        g.lineStyle(style.borderRightWidth,style.borderRightColor,style.backgroundAlpha,true,"normal",CapsStyle.SQUARE);
                        g.lineTo(rec.x + rec.width - Math.floor(style.borderRightWidth / 2),rec.y + rec.height - Math.floor(style.borderTopWidth / 2));
                     }
                     g.moveTo(rec.x + rec.width - Math.floor(style.borderLeftWidth / 2),rec.y + rec.height - Math.floor(style.borderBottomWidth / 2));
                     if(block.style != BackgroundManager.BOTTOM_EXCLUDED && block.style != BackgroundManager.TOP_AND_BOTTOM_EXCLUDED && style.borderBottomWidth != 0 && style.borderBottomColor != BorderColor.TRANSPARENT)
                     {
                        g.lineStyle(style.borderBottomWidth,style.borderBottomColor,style.backgroundAlpha,true,"normal",CapsStyle.SQUARE);
                        g.lineTo(rec.x + Math.floor(style.borderLeftWidth / 2),rec.y + rec.height - Math.floor(style.borderBottomWidth / 2));
                     }
                     g.moveTo(rec.x + Math.floor(style.borderLeftWidth / 2),rec.y + rec.height - Math.floor(style.borderTopWidth / 2));
                     if(style.borderLeftWidth != 0 && style.borderLeftColor != BorderColor.TRANSPARENT)
                     {
                        g.lineStyle(style.borderLeftWidth,style.borderLeftColor,style.backgroundAlpha,true,"normal",CapsStyle.SQUARE);
                        g.lineTo(rec.x + Math.floor(style.borderLeftWidth / 2),rec.y + Math.floor(style.borderTopWidth / 2));
                     }
                  }
               }
            }
            for(childIdx = 0; childIdx < controller.textLines.length; childIdx++)
            {
               line = controller.textLines[childIdx];
               if(line is TextLine)
               {
                  tl = line;
                  entry = this._lineDict[tl];
                  if(entry)
                  {
                     tfl = tl.userData as TextFlowLine;
                     for(i = 0; i < entry.length; i++)
                     {
                        record = entry[i];
                        if(record.hasOwnProperty("numberLine"))
                        {
                           numberLine = record.numberLine;
                           backgroundManager = TextFlowLine.getNumberLineBackground(numberLine);
                           numberEntry = backgroundManager._lineDict[numberLine];
                           if(numberEntry)
                           {
                              for(ii = 0; ii < numberEntry.length; ii++)
                              {
                                 numberRecord = numberEntry[ii];
                                 r = numberRecord.rect.clone();
                                 r.x += numberLine.x;
                                 r.y += numberLine.y;
                                 tfl.convertLineRectToContainer(r,true);
                                 bgShape.graphics.beginFill(numberRecord.color,numberRecord.alpha);
                                 bgShape.graphics.drawRect(r.x,r.y,r.width,r.height);
                                 bgShape.graphics.endFill();
                              }
                           }
                        }
                        else
                        {
                           r = record.rect.clone();
                           tfl.convertLineRectToContainer(r,true);
                           bgShape.graphics.beginFill(record.color,record.alpha);
                           bgShape.graphics.drawRect(r.x,r.y,r.width,r.height);
                           bgShape.graphics.endFill();
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function getShapeRectArray() : Array
      {
         return this._rectArray;
      }
   }
}
