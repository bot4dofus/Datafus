package flashx.textLayout.edit
{
   import flashx.textLayout.elements.FlowElement;
   import flashx.textLayout.elements.LinkElement;
   import flashx.textLayout.elements.TCYElement;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.tlf_internal;
   
   [ExcludeClass]
   public class PointFormat extends TextLayoutFormat implements ITextLayoutFormat
   {
       
      
      private var _id;
      
      private var _linkElement:LinkElement;
      
      private var _tcyElement:TCYElement;
      
      public function PointFormat(initialValues:ITextLayoutFormat = null)
      {
         super(initialValues);
      }
      
      public static function isEqual(p1:ITextLayoutFormat, p2:ITextLayoutFormat) : Boolean
      {
         var pf1:PointFormat = null;
         var pf2:PointFormat = null;
         if(!TextLayoutFormat.isEqual(p1,p2))
         {
            return false;
         }
         if(p1 is PointFormat != p2 is PointFormat)
         {
            return false;
         }
         if(p1 is PointFormat)
         {
            pf1 = p1 as PointFormat;
            pf2 = p2 as PointFormat;
            return pf1.id == pf2.id && isEqualLink(pf1.linkElement,pf2.linkElement) && pf1.tcyElement == null == (pf2.tcyElement == null);
         }
         return true;
      }
      
      private static function isEqualLink(l1:LinkElement, l2:LinkElement) : Boolean
      {
         if(l1 == null != (l2 == null))
         {
            return false;
         }
         if(l1 == null)
         {
            return true;
         }
         return l1.href == l2.href && l1.target == l2.target;
      }
      
      tlf_internal static function clone(original:PointFormat) : PointFormat
      {
         var cloneFormat:PointFormat = new PointFormat(original);
         cloneFormat.id = original.id;
         cloneFormat.linkElement = original.linkElement === undefined || !original.linkElement ? original.linkElement : original.linkElement.shallowCopy() as LinkElement;
         cloneFormat.tcyElement = original.tcyElement === undefined || !original.tcyElement ? original.tcyElement : original.tcyElement.shallowCopy() as TCYElement;
         return cloneFormat;
      }
      
      tlf_internal static function createFromFlowElement(element:FlowElement) : PointFormat
      {
         if(!element)
         {
            return new PointFormat();
         }
         var format:PointFormat = new PointFormat(element.format);
         var linkElement:LinkElement = element.getParentByType(LinkElement) as LinkElement;
         if(linkElement)
         {
            format.linkElement = linkElement.shallowCopy() as LinkElement;
         }
         var tcyElement:TCYElement = element.getParentByType(TCYElement) as TCYElement;
         if(tcyElement)
         {
            format.tcyElement = tcyElement.shallowCopy() as TCYElement;
         }
         return format;
      }
      
      public function get linkElement() : *
      {
         return this._linkElement;
      }
      
      public function set linkElement(value:LinkElement) : void
      {
         this._linkElement = value;
      }
      
      public function get tcyElement() : *
      {
         return this._tcyElement;
      }
      
      public function set tcyElement(value:TCYElement) : void
      {
         this._tcyElement = value;
      }
      
      public function get id() : *
      {
         return this._id;
      }
      
      public function set id(value:*) : void
      {
         this._id = value;
      }
   }
}
