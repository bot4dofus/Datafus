package flashx.textLayout.elements
{
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.FormatValue;
   import flashx.textLayout.formats.IListMarkerFormat;
   import flashx.textLayout.tlf_internal;
   
   public final class ListItemElement extends ContainerFormattedElement
   {
       
      
      tlf_internal var _listNumberHint:int = 2147483647;
      
      public function ListItemElement()
      {
         super();
      }
      
      override protected function get abstract() : Boolean
      {
         return false;
      }
      
      override tlf_internal function get defaultTypeName() : String
      {
         return "li";
      }
      
      tlf_internal function computedListMarkerFormat() : IListMarkerFormat
      {
         var tf:TextFlow = null;
         var format:IListMarkerFormat = this.getUserStyleWorker(ListElement.LIST_MARKER_FORMAT_NAME) as IListMarkerFormat;
         if(format == null)
         {
            tf = this.getTextFlow();
            if(tf)
            {
               format = tf.configuration.defaultListMarkerFormat;
            }
         }
         return format;
      }
      
      tlf_internal function normalizeNeedsInitialParagraph() : Boolean
      {
         var p:FlowGroupElement = this;
         while(p)
         {
            p = p.getChildAt(0) as FlowGroupElement;
            if(p is ParagraphElement)
            {
               return false;
            }
            if(!(p is DivElement))
            {
               return true;
            }
         }
         return true;
      }
      
      override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint) : void
      {
         var p:ParagraphElement = null;
         super.normalizeRange(normalizeStart,normalizeEnd);
         this._listNumberHint = int.MAX_VALUE;
         if(this.normalizeNeedsInitialParagraph())
         {
            p = new ParagraphElement();
            p.replaceChildren(0,0,new SpanElement());
            replaceChildren(0,0,p);
            p.normalizeRange(0,p.textLength);
         }
      }
      
      tlf_internal function getListItemNumber(listMarkerFormat:IListMarkerFormat = null) : int
      {
         var counterReset:Object = null;
         var counterIncrement:Object = null;
         var idx:int = 0;
         var sibling:ListItemElement = null;
         if(this._listNumberHint == int.MAX_VALUE)
         {
            if(listMarkerFormat == null)
            {
               listMarkerFormat = this.computedListMarkerFormat();
            }
            counterReset = listMarkerFormat.counterReset;
            if(counterReset && counterReset.hasOwnProperty("ordered"))
            {
               this._listNumberHint = counterReset.ordered;
            }
            else
            {
               idx = parent.getChildIndex(this);
               this._listNumberHint = 0;
               while(idx > 0)
               {
                  idx--;
                  sibling = parent.getChildAt(idx) as ListItemElement;
                  if(sibling)
                  {
                     this._listNumberHint = sibling.getListItemNumber();
                     break;
                  }
               }
            }
            counterIncrement = listMarkerFormat.counterIncrement;
            this._listNumberHint += counterIncrement && counterIncrement.hasOwnProperty("ordered") ? counterIncrement.ordered : 1;
         }
         return this._listNumberHint;
      }
      
      override tlf_internal function getEffectivePaddingLeft() : Number
      {
         if(getTextFlow().computedFormat.blockProgression == BlockProgression.TB)
         {
            if(computedFormat.paddingLeft == FormatValue.AUTO)
            {
               if(computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
               {
                  return computedFormat.listMarkerFormat.paragraphStartIndent;
               }
               return 0;
            }
            if(computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
            {
               return computedFormat.paddingLeft + computedFormat.listMarkerFormat.paragraphStartIndent;
            }
            return computedFormat.paddingLeft;
         }
         return 0;
      }
      
      override tlf_internal function getEffectivePaddingTop() : Number
      {
         if(getTextFlow().computedFormat.blockProgression == BlockProgression.RL)
         {
            if(computedFormat.paddingTop == FormatValue.AUTO)
            {
               if(computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
               {
                  return computedFormat.listMarkerFormat.paragraphStartIndent;
               }
               return 0;
            }
            if(computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
            {
               return computedFormat.paddingTop + computedFormat.listMarkerFormat.paragraphStartIndent;
            }
            return computedFormat.paddingTop;
         }
         return 0;
      }
      
      override tlf_internal function getEffectivePaddingRight() : Number
      {
         if(getTextFlow().computedFormat.blockProgression == BlockProgression.TB)
         {
            if(computedFormat.paddingRight == FormatValue.AUTO)
            {
               if(computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
               {
                  return computedFormat.listMarkerFormat.paragraphStartIndent;
               }
               return 0;
            }
            if(computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
            {
               return computedFormat.paddingRight + computedFormat.listMarkerFormat.paragraphStartIndent;
            }
            return computedFormat.paddingRight;
         }
         return 0;
      }
      
      override tlf_internal function getEffectivePaddingBottom() : Number
      {
         if(getTextFlow().computedFormat.blockProgression == BlockProgression.RL)
         {
            if(computedFormat.paddingBottom == FormatValue.AUTO)
            {
               if(computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
               {
                  return computedFormat.listMarkerFormat.paragraphStartIndent;
               }
               return 0;
            }
            if(computedFormat.listMarkerFormat !== undefined && computedFormat.listMarkerFormat.paragraphStartIndent !== undefined)
            {
               return computedFormat.paddingBottom + computedFormat.listMarkerFormat.paragraphStartIndent;
            }
            return computedFormat.paddingBottom;
         }
         return 0;
      }
   }
}
