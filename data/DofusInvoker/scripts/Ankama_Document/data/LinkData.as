package Ankama_Document.data
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class LinkData
   {
       
      
      public var text:String;
      
      public var href:String;
      
      public var page:String;
      
      private var _parent:GraphicContainer;
      
      private var _graphicContainer:GraphicContainer;
      
      public function LinkData(pTxt:String, pHref:String, pPage:String = "")
      {
         super();
         this.text = pTxt;
         this.href = pHref.replace("event:","");
         this.page = pPage;
      }
      
      public function setGraphicData(pCtr:GraphicContainer, pParent:GraphicContainer, pRect:Rectangle, pCtrPadding:Point) : void
      {
         this._parent = pParent;
         this._graphicContainer = pCtr;
         this._graphicContainer.buttonMode = true;
         this._graphicContainer.x = pRect.x + pCtrPadding.x;
         this._graphicContainer.y = pRect.y + pCtrPadding.y;
         this._graphicContainer.width = pRect.width;
         this._graphicContainer.height = pRect.height;
         this._graphicContainer.bgColor = 16711680;
         this._graphicContainer.alpha = 0;
         this._parent.addChild(this._graphicContainer);
      }
      
      public function get graphic() : GraphicContainer
      {
         return this._graphicContainer;
      }
      
      public function set parent(val:GraphicContainer) : void
      {
         this._parent = val;
         this._parent.addChild(this._graphicContainer);
      }
      
      public function destroy() : void
      {
         if(this._parent)
         {
            this._parent.removeChild(this._graphicContainer);
            this._parent = null;
         }
         this._graphicContainer.remove();
         this._graphicContainer = null;
      }
   }
}
