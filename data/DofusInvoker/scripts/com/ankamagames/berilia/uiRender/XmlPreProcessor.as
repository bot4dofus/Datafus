package com.ankamagames.berilia.uiRender
{
   import com.ankamagames.berilia.enums.XmlAttributesEnum;
   import com.ankamagames.berilia.enums.XmlTagsEnum;
   import com.ankamagames.berilia.managers.TemplateManager;
   import com.ankamagames.berilia.types.event.PreProcessEndEvent;
   import com.ankamagames.berilia.types.event.TemplateLoadedEvent;
   import com.ankamagames.berilia.types.template.TemplateParam;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.files.FileUtils;
   import flash.events.EventDispatcher;
   import flash.utils.getQualifiedClassName;
   import flash.xml.XMLDocument;
   import flash.xml.XMLNode;
   
   public class XmlPreProcessor extends EventDispatcher
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(XmlPreProcessor));
       
      
      private var _xDoc:XMLDocument;
      
      private var _bMustBeRendered:Boolean = true;
      
      private var _aImportFile:Array;
      
      public function XmlPreProcessor(xDoc:XMLDocument)
      {
         super();
         this._xDoc = xDoc;
      }
      
      public function get importedFiles() : int
      {
         return this._aImportFile.length;
      }
      
      public function processTemplate() : void
      {
         this._aImportFile = [];
         TemplateManager.getInstance().addEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED,this.onTemplateLoaded);
         this.matchImport(this._xDoc.firstChild);
         if(!this._aImportFile.length)
         {
            dispatchEvent(new PreProcessEndEvent(this));
            TemplateManager.getInstance().removeEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED,this.onTemplateLoaded);
            return;
         }
         EnterFrameDispatcher.worker.addForeachTreatment(this,this.registerImportFile,[],this._aImportFile);
      }
      
      private function registerImportFile(file:String) : void
      {
         TemplateManager.getInstance().register(file);
      }
      
      private function matchImport(node:XMLNode) : void
      {
         var currNode:XMLNode = null;
         if(node == null)
         {
            return;
         }
         for(var i:uint = 0; i < node.childNodes.length; i++)
         {
            currNode = node.childNodes[i];
            if(currNode.nodeName == XmlTagsEnum.TAG_IMPORT)
            {
               if(currNode.attributes[XmlAttributesEnum.ATTRIBUTE_URL] == null)
               {
                  _log.warn("Attribute \'" + XmlAttributesEnum.ATTRIBUTE_URL + "\' is missing in " + XmlTagsEnum.TAG_IMPORT + " tag.");
               }
               else
               {
                  this._aImportFile.push(LangManager.getInstance().replaceKey(currNode.attributes[XmlAttributesEnum.ATTRIBUTE_URL]));
               }
               currNode.removeNode();
               i--;
            }
            else if(currNode != null)
            {
               this.matchImport(currNode);
            }
         }
      }
      
      private function replaceTemplateCall(node:XMLNode, depthRecursion:int = 0) : Boolean
      {
         var currNode:XMLNode = null;
         var currVarNode:XMLNode = null;
         var templateNode:XMLNode = null;
         var insertedNode:XMLNode = null;
         var childNodes:Array = null;
         var j:uint = 0;
         var s:* = null;
         var n:uint = 0;
         var sFileName:String = null;
         var aTemplateVar:Array = null;
         var currAttributes:Object = null;
         var content:String = null;
         var varNode:XMLNode = null;
         var bRes:Boolean = false;
         if(depthRecursion > 128)
         {
            _log.error("replaceTemplateCall : Recursion depth is too high :" + depthRecursion);
            return bRes;
         }
         for(var i:uint = 0; i < node.childNodes.length; i++)
         {
            currNode = node.childNodes[i];
            for(j = 0; j < this._aImportFile.length; j++)
            {
               if(this._aImportFile[j].indexOf(currNode.nodeName) != -1)
               {
                  sFileName = FileUtils.getFileStartName(this._aImportFile[j]);
                  if(sFileName == currNode.nodeName)
                  {
                     aTemplateVar = [];
                     currAttributes = currNode.attributes;
                     for(s in currAttributes)
                     {
                        aTemplateVar[s] = new TemplateParam(s,currAttributes[s]);
                     }
                     childNodes = currNode.childNodes;
                     for(n = 0; n < childNodes.length; n++)
                     {
                        currVarNode = childNodes[n];
                        content = "";
                        for each(varNode in currVarNode.childNodes)
                        {
                           content += varNode;
                        }
                        aTemplateVar[currVarNode.nodeName] = new TemplateParam(currVarNode.nodeName,content);
                     }
                     templateNode = TemplateManager.getInstance().getTemplate(sFileName).makeTemplate(aTemplateVar);
                     childNodes = templateNode.firstChild.childNodes;
                     for(n = 0; n < childNodes.length; n++)
                     {
                        insertedNode = childNodes[n].cloneNode(true);
                        currNode.parentNode.insertBefore(insertedNode,currNode);
                     }
                     currNode.removeNode();
                     currNode = node.childNodes[i];
                     bRes = true;
                  }
               }
            }
            bRes = this.replaceTemplateCall(currNode,depthRecursion + 1) || bRes;
         }
         return bRes;
      }
      
      private function onTemplateLoaded(e:TemplateLoadedEvent) : void
      {
         if(TemplateManager.getInstance().areLoaded(this._aImportFile) && this._bMustBeRendered)
         {
            this._bMustBeRendered = this.replaceTemplateCall(this._xDoc.firstChild);
            if(this._bMustBeRendered)
            {
               this.processTemplate();
            }
            else
            {
               dispatchEvent(new PreProcessEndEvent(this));
               TemplateManager.getInstance().removeEventListener(TemplateLoadedEvent.EVENT_TEMPLATE_LOADED,this.onTemplateLoaded);
            }
         }
      }
   }
}
