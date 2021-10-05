package com.ankamagames.dofus.internalDatacenter.tutorial
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.dofus.datacenter.progression.FeatureDescription;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.LogLevel;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getQualifiedClassName;
   
   public class FeatureDescriptionWrapper implements IDataCenter
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(FeatureDescriptionWrapper));
      
      private static const PARENT_FEATURE:uint = 0;
      
      private static const SUB_FEATURE:uint = 1;
      
      private static const SUB_SUB_FEATURE:uint = 2;
      
      private static const NODE_TEXT:String = "text";
      
      private static const NODE_ILLU:String = "illu";
      
      private static const NODE_SUBTITLE:String = "subtitle";
      
      private static var LEFT:String = "<shortcut=";
      
      private static var RIGHT:String = "/>";
       
      
      public var id:uint;
      
      public var parentId:uint;
      
      public var categoryName:String = "";
      
      public var description:String = "";
      
      public var children:Vector.<int>;
      
      public var parentGC:GraphicContainer;
      
      public var totalHeight:uint = 0;
      
      private var _subtitleCss:Uri;
      
      private var _subtitleCssClass:String;
      
      private var _descriptionCss:Uri;
      
      private var _descriptionCssClass:String;
      
      private var _criterion:String = "";
      
      private var _featureRank:uint;
      
      private var _margin:int = 20;
      
      private var _labels:Array;
      
      private var _illus:Array;
      
      public var searchResult:Array;
      
      public function FeatureDescriptionWrapper()
      {
         this.children = new Vector.<int>();
         this._labels = [];
         this._illus = [];
         this.searchResult = [];
         super();
      }
      
      public static function create(feature:FeatureDescription, css:Uri = null, cssClass:String = "p") : FeatureDescriptionWrapper
      {
         var featureDescriptionWrapper:FeatureDescriptionWrapper = new FeatureDescriptionWrapper();
         featureDescriptionWrapper.id = feature.id;
         featureDescriptionWrapper.parentId = feature.parentId;
         featureDescriptionWrapper.categoryName = feature.name;
         featureDescriptionWrapper.description = feature.description;
         featureDescriptionWrapper.children = feature.children;
         featureDescriptionWrapper._featureRank = featureDescriptionWrapper.getFeatureRank(feature);
         featureDescriptionWrapper._subtitleCss = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal2.css");
         featureDescriptionWrapper._subtitleCssClass = featureDescriptionWrapper._featureRank == SUB_FEATURE ? "orangeleftbold" : "extrawhitebold";
         featureDescriptionWrapper._descriptionCss = css != null ? css : new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal2.css");
         featureDescriptionWrapper._descriptionCssClass = cssClass;
         featureDescriptionWrapper.parentGC = new GraphicContainer();
         featureDescriptionWrapper.createDescription();
         return featureDescriptionWrapper;
      }
      
      private function createDescription() : void
      {
         var formatedDescription:XML = null;
         var subTitleLabel:Label = null;
         var labelDesc:Label = null;
         var node:XML = null;
         var xmlText:String = "<desc>" + this.formatText(this.description) + "</desc>";
         _log.log(LogLevel.INFO,"Création de la feature " + this.categoryName + " (" + this.id + ")");
         try
         {
            formatedDescription = XML(xmlText);
         }
         catch(e:*)
         {
            _log.log(LogLevel.ERROR,"Echec lors de la création de la feature " + categoryName + " (" + id + ")");
            return;
         }
         var desc:String = "";
         var nodeName:String = "";
         if(this.parentId != 0)
         {
            subTitleLabel = this.addSubTitleLabel(this.totalHeight,this.categoryName);
            this.totalHeight += subTitleLabel.contentHeight;
         }
         else
         {
            this.totalHeight = this._margin;
         }
         for each(node in formatedDescription.children())
         {
            nodeName = node.name();
            if(nodeName == NODE_TEXT)
            {
               desc = !!node.name() ? node.toXMLString() : node.toString();
               labelDesc = this.addDecriptionLabel(this.totalHeight,desc,node);
               this.totalHeight = labelDesc.y + labelDesc.contentHeight;
            }
            else if(nodeName == NODE_ILLU)
            {
               this.addIllu(node);
            }
            else if(nodeName == NODE_SUBTITLE && subTitleLabel != null)
            {
               subTitleLabel.x += node.attribute("x");
            }
         }
         this.updateTotalHeightWithIllu();
      }
      
      private function addSubTitleLabel(groupPos:int, title:String) : Label
      {
         var labelTitle:Label = null;
         labelTitle = new Label();
         labelTitle.width = 880;
         labelTitle.x = 0;
         labelTitle.y = groupPos + this.parentGC.y;
         labelTitle.multiline = true;
         labelTitle.wordWrap = true;
         labelTitle.textfield.selectable = true;
         labelTitle.textfield.mouseEnabled = true;
         labelTitle.css = this._subtitleCss;
         labelTitle.cssClass = this._subtitleCssClass;
         labelTitle.htmlText = this.cleanText(title);
         labelTitle.height = labelTitle.textHeight;
         this.parentGC.addContent(labelTitle);
         this._labels.push({
            "label":labelTitle,
            "originalText":labelTitle.htmlText
         });
         return labelTitle;
      }
      
      private function addDecriptionLabel(groupPos:int, desc:String, node:XML) : Label
      {
         var labelDesc:Label = new Label();
         labelDesc.width = node.attribute("width");
         labelDesc.x = node.attribute("x");
         labelDesc.y = groupPos + this.parentGC.y + int(node.attribute("y"));
         labelDesc.multiline = true;
         labelDesc.wordWrap = true;
         labelDesc.hyperlinkEnabled = true;
         labelDesc.useStyleSheet = true;
         labelDesc.textfield.selectable = true;
         labelDesc.textfield.mouseEnabled = true;
         labelDesc.css = this._descriptionCss;
         labelDesc.cssClass = this._descriptionCssClass;
         labelDesc.htmlText = this.cleanText(desc);
         labelDesc.height = labelDesc.textHeight;
         this.parentGC.addContent(labelDesc);
         this._labels.push({
            "label":labelDesc,
            "originalText":labelDesc.htmlText
         });
         return labelDesc;
      }
      
      public function searchWord(search:String) : void
      {
         var data:Object = null;
         for each(data in this._labels)
         {
            this.highlight(data.label.textfield,search,data.label);
         }
      }
      
      public function highlight(block:TextField, search:String, parentLabel:Label) : void
      {
         var tf:TextFormat = new TextFormat();
         tf.color = 15450884;
         tf.underline = true;
         tf.font = "Roboto";
         var positions:Array = this.getPositions(block.text.toLowerCase(),StringUtils.noAccent(search));
         var len:uint = positions.length;
         for(var i:int = 0; i < len; i++)
         {
            this.searchResult.push(new SearchResult(positions[i].posStart,positions[i].posEnd,block,parentLabel));
            block.setTextFormat(tf,positions[i].posStart,positions[i].posEnd);
         }
      }
      
      public function cleanSearch(search:String) : void
      {
         var data:Object = null;
         for each(data in this._labels)
         {
            if(search != "")
            {
               data.label.htmlText = data.originalText;
            }
         }
         this.searchResult = [];
      }
      
      public function getPositions(original:String, search:String) : Array
      {
         var startPosition:Number = NaN;
         var endPosition:Number = NaN;
         var originalNoAccent:String = StringUtils.noAccent(original);
         var positions:Array = [];
         while(startPosition != -1)
         {
            startPosition = originalNoAccent.indexOf(search,endPosition);
            endPosition = startPosition + search.length;
            if(startPosition > -1)
            {
               positions.push({
                  "posStart":startPosition,
                  "posEnd":endPosition
               });
            }
         }
         return positions;
      }
      
      private function addIllu(node:XML) : Texture
      {
         var illu:Texture = new Texture();
         illu.uri = new Uri(XmlConfig.getInstance().getEntry("config.content.path").concat("gfx/guideBook/").concat(node.attribute("name")));
         illu.x = this.parentGC.x + int(node.attribute("x"));
         illu.y = this._margin + int(node.attribute("y"));
         if(node.attribute("width") != "")
         {
            illu.width = node.attribute("width");
         }
         if(node.attribute("height") != "")
         {
            illu.height = node.attribute("height");
         }
         illu.finalize();
         var ignoreIlluHeight:* = false;
         if(node.attribute("ignoreHeight") != "")
         {
            ignoreIlluHeight = node.attribute("ignoreHeight") == "true";
         }
         this.parentGC.addContent(illu);
         if(!ignoreIlluHeight)
         {
            this._illus.push(illu);
         }
         return illu;
      }
      
      private function updateTotalHeightWithIllu() : void
      {
         var currentIllu:Texture = null;
         var maxIlluHeight:int = this._margin;
         for each(currentIllu in this._illus)
         {
            if(currentIllu.y + currentIllu.height > maxIlluHeight)
            {
               maxIlluHeight = currentIllu.y + currentIllu.height;
            }
         }
         if(maxIlluHeight > this.totalHeight)
         {
            this.totalHeight = maxIlluHeight;
         }
      }
      
      private function formatText(t:String) : String
      {
         var newText:String = this.decodeShortCut(t);
         while(newText.search("<b>") != -1 || newText.search("</b>") != -1)
         {
            newText = newText.replace("<b>","#b#");
            newText = newText.replace("</b>","#/b#");
         }
         while(newText.search("<i>") != -1 || newText.search("</i>") != -1)
         {
            newText = newText.replace("<i>","#i#");
            newText = newText.replace("</i>","#/i#");
         }
         while(newText.search("{") != -1 || newText.search("}") != -1)
         {
            newText = newText.replace("{","#[#");
            newText = newText.replace("}","#]#");
         }
         while(newText.search("\n") != -1)
         {
            newText = newText.replace("\n","#n#");
         }
         return newText;
      }
      
      private function cleanText(t:String) : String
      {
         var newText:String = t;
         while(newText.search("#[#") != -1 || newText.search("#]#") != -1)
         {
            newText = newText.replace("#[#","<font color=\'#deff00\'>{");
            newText = newText.replace("#]#","}</font>");
         }
         while(newText.search("#b#") != -1 || newText.search("#/b#") != -1)
         {
            newText = newText.replace("#b#","<font color=\'#ffffff\'><b>");
            newText = newText.replace("#/b#","</b></font>");
         }
         while(newText.search("#i#") != -1 || newText.search("#/i#") != -1)
         {
            newText = newText.replace("#i#","<i>");
            newText = newText.replace("#/i#","</i>");
         }
         while(newText.search("\n") != -1)
         {
            newText = newText.replace("\n","");
         }
         while(newText.search("#n#") != -1)
         {
            newText = newText.replace("#n#","\n");
         }
         var index:int = newText.indexOf("\n");
         if(index != -1)
         {
            newText = newText.substring(index + 1);
         }
         index = newText.lastIndexOf("\n");
         if(index != -1)
         {
            newText = newText.substring(0,index);
         }
         return newText;
      }
      
      private function getFeatureRank(feature:FeatureDescription) : uint
      {
         var parentFeature:FeatureDescription = null;
         if(feature.parentId == 0)
         {
            return PARENT_FEATURE;
         }
         parentFeature = FeatureDescription.getFeatureDescriptionById(feature.parentId);
         if(parentFeature && parentFeature.parentId == 0)
         {
            return SUB_FEATURE;
         }
         if(parentFeature && parentFeature.parentId != 0)
         {
            return SUB_SUB_FEATURE;
         }
         return PARENT_FEATURE;
      }
      
      private function decodeShortCut(t:String) : String
      {
         var leftIndex:int = 0;
         var rightIndex:int = 0;
         var leftBlock:String = null;
         var rightBlock:String = null;
         var middleBlock:String = null;
         var shortcutInfo:Array = null;
         var shortcutName:String = null;
         var shortcut:Shortcut = null;
         var shortcutString:String = null;
         if(!t)
         {
            return "";
         }
         var currentText:String = t;
         while(true)
         {
            leftIndex = currentText.indexOf(LEFT);
            if(leftIndex == -1)
            {
               break;
            }
            rightIndex = currentText.indexOf(RIGHT,leftIndex);
            if(rightIndex == -1)
            {
               break;
            }
            if(leftIndex > rightIndex)
            {
               break;
            }
            leftBlock = currentText.substring(0,leftIndex);
            rightBlock = currentText.substring(rightIndex + 2);
            middleBlock = currentText.substring(leftIndex,rightIndex);
            shortcutInfo = middleBlock.split("=");
            shortcutName = shortcutInfo[1];
            shortcut = Shortcut.getShortcutByName(shortcutName);
            if(shortcut)
            {
               currentText = leftBlock;
               shortcutString = shortcut.defaultBind.toString();
               if(shortcutString != "")
               {
                  currentText += "(" + shortcutString + ")";
               }
               currentText += rightBlock;
            }
            else
            {
               currentText = leftBlock;
               currentText += rightBlock;
            }
         }
         return currentText;
      }
   }
}

import com.ankamagames.berilia.components.Label;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;

class SearchResult
{
    
   
   public var startIndex:int;
   
   public var endIndex:int;
   
   public var bounds:Rectangle;
   
   public var parentLabel:Label;
   
   private var _tf:TextField;
   
   function SearchResult(pStart:int, pEnd:int, pTextField:TextField, pParentLabel:Label)
   {
      super();
      this.startIndex = pStart;
      this.endIndex = pEnd;
      this.bounds = pTextField.getCharBoundaries(pStart);
      this.parentLabel = pParentLabel;
      this._tf = pTextField;
   }
   
   public function highlight() : void
   {
      var tf:TextFormat = new TextFormat();
      tf.color = 15239437;
      tf.underline = true;
      tf.font = "Roboto";
      this._tf.setTextFormat(tf,this.startIndex,this.endIndex);
   }
   
   public function clearHighlight() : void
   {
      var tf:TextFormat = new TextFormat();
      tf.color = 15450884;
      tf.underline = true;
      tf.font = "Roboto";
      this._tf.setTextFormat(tf,this.startIndex,this.endIndex);
   }
}
