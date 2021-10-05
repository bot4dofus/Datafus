package flashx.textLayout.formats
{
   import flash.text.engine.BreakOpportunity;
   import flash.text.engine.CFFHinting;
   import flash.text.engine.DigitCase;
   import flash.text.engine.DigitWidth;
   import flash.text.engine.FontLookup;
   import flash.text.engine.FontPosture;
   import flash.text.engine.FontWeight;
   import flash.text.engine.JustificationStyle;
   import flash.text.engine.Kerning;
   import flash.text.engine.LigatureLevel;
   import flash.text.engine.RenderingMode;
   import flash.text.engine.TextBaseline;
   import flash.text.engine.TextRotation;
   import flashx.textLayout.property.Property;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   public class TextLayoutFormat implements ITextLayoutFormat
   {
      
      private static var _columnBreakBeforeProperty:Property;
      
      private static var _columnBreakAfterProperty:Property;
      
      private static var _containerBreakBeforeProperty:Property;
      
      private static var _containerBreakAfterProperty:Property;
      
      private static var _colorProperty:Property;
      
      private static var _backgroundColorProperty:Property;
      
      private static var _lineThroughProperty:Property;
      
      private static var _textAlphaProperty:Property;
      
      private static var _backgroundAlphaProperty:Property;
      
      private static var _fontSizeProperty:Property;
      
      private static var _baselineShiftProperty:Property;
      
      private static var _trackingLeftProperty:Property;
      
      private static var _trackingRightProperty:Property;
      
      private static var _lineHeightProperty:Property;
      
      private static var _breakOpportunityProperty:Property;
      
      private static var _digitCaseProperty:Property;
      
      private static var _digitWidthProperty:Property;
      
      private static var _dominantBaselineProperty:Property;
      
      private static var _kerningProperty:Property;
      
      private static var _ligatureLevelProperty:Property;
      
      private static var _alignmentBaselineProperty:Property;
      
      private static var _localeProperty:Property;
      
      private static var _typographicCaseProperty:Property;
      
      private static var _fontFamilyProperty:Property;
      
      private static var _textDecorationProperty:Property;
      
      private static var _fontWeightProperty:Property;
      
      private static var _fontStyleProperty:Property;
      
      private static var _whiteSpaceCollapseProperty:Property;
      
      private static var _renderingModeProperty:Property;
      
      private static var _cffHintingProperty:Property;
      
      private static var _fontLookupProperty:Property;
      
      private static var _textRotationProperty:Property;
      
      private static var _textIndentProperty:Property;
      
      private static var _paragraphStartIndentProperty:Property;
      
      private static var _paragraphEndIndentProperty:Property;
      
      private static var _paragraphSpaceBeforeProperty:Property;
      
      private static var _paragraphSpaceAfterProperty:Property;
      
      private static var _textAlignProperty:Property;
      
      private static var _textAlignLastProperty:Property;
      
      private static var _textJustifyProperty:Property;
      
      private static var _justificationRuleProperty:Property;
      
      private static var _justificationStyleProperty:Property;
      
      private static var _directionProperty:Property;
      
      private static var _wordSpacingProperty:Property;
      
      private static var _tabStopsProperty:Property;
      
      private static var _leadingModelProperty:Property;
      
      private static var _columnGapProperty:Property;
      
      private static var _paddingLeftProperty:Property;
      
      private static var _paddingTopProperty:Property;
      
      private static var _paddingRightProperty:Property;
      
      private static var _paddingBottomProperty:Property;
      
      private static var _columnCountProperty:Property;
      
      private static var _columnWidthProperty:Property;
      
      private static var _firstBaselineOffsetProperty:Property;
      
      private static var _verticalAlignProperty:Property;
      
      private static var _blockProgressionProperty:Property;
      
      private static var _lineBreakProperty:Property;
      
      private static var _listStyleTypeProperty:Property;
      
      private static var _listStylePositionProperty:Property;
      
      private static var _listAutoPaddingProperty:Property;
      
      private static var _clearFloatsProperty:Property;
      
      private static var _styleNameProperty:Property;
      
      private static var _linkNormalFormatProperty:Property;
      
      private static var _linkActiveFormatProperty:Property;
      
      private static var _linkHoverFormatProperty:Property;
      
      private static var _listMarkerFormatProperty:Property;
      
      private static var _borderLeftWidthProperty:Property;
      
      private static var _borderRightWidthProperty:Property;
      
      private static var _borderTopWidthProperty:Property;
      
      private static var _borderBottomWidthProperty:Property;
      
      private static var _borderLeftColorProperty:Property;
      
      private static var _borderRightColorProperty:Property;
      
      private static var _borderTopColorProperty:Property;
      
      private static var _borderBottomColorProperty:Property;
      
      private static var _borderLeftPriorityProperty:Property;
      
      private static var _borderRightPriorityProperty:Property;
      
      private static var _borderTopPriorityProperty:Property;
      
      private static var _borderBottomPriorityProperty:Property;
      
      private static var _marginLeftProperty:Property;
      
      private static var _marginRightProperty:Property;
      
      private static var _marginTopProperty:Property;
      
      private static var _marginBottomProperty:Property;
      
      private static var _cellSpacingProperty:Property;
      
      private static var _cellPaddingProperty:Property;
      
      private static var _tableWidthProperty:Property;
      
      private static var _tableColumnWidthProperty:Property;
      
      private static var _minCellHeightProperty:Property;
      
      private static var _maxCellHeightProperty:Property;
      
      private static var _frameProperty:Property;
      
      private static var _rulesProperty:Property;
      
      private static var _description:Object = {
         "columnBreakBefore":columnBreakBeforeProperty,
         "columnBreakAfter":columnBreakAfterProperty,
         "containerBreakBefore":containerBreakBeforeProperty,
         "containerBreakAfter":containerBreakAfterProperty,
         "color":colorProperty,
         "backgroundColor":backgroundColorProperty,
         "lineThrough":lineThroughProperty,
         "textAlpha":textAlphaProperty,
         "backgroundAlpha":backgroundAlphaProperty,
         "fontSize":fontSizeProperty,
         "baselineShift":baselineShiftProperty,
         "trackingLeft":trackingLeftProperty,
         "trackingRight":trackingRightProperty,
         "lineHeight":lineHeightProperty,
         "breakOpportunity":breakOpportunityProperty,
         "digitCase":digitCaseProperty,
         "digitWidth":digitWidthProperty,
         "dominantBaseline":dominantBaselineProperty,
         "kerning":kerningProperty,
         "ligatureLevel":ligatureLevelProperty,
         "alignmentBaseline":alignmentBaselineProperty,
         "locale":localeProperty,
         "typographicCase":typographicCaseProperty,
         "fontFamily":fontFamilyProperty,
         "textDecoration":textDecorationProperty,
         "fontWeight":fontWeightProperty,
         "fontStyle":fontStyleProperty,
         "whiteSpaceCollapse":whiteSpaceCollapseProperty,
         "renderingMode":renderingModeProperty,
         "cffHinting":cffHintingProperty,
         "fontLookup":fontLookupProperty,
         "textRotation":textRotationProperty,
         "textIndent":textIndentProperty,
         "paragraphStartIndent":paragraphStartIndentProperty,
         "paragraphEndIndent":paragraphEndIndentProperty,
         "paragraphSpaceBefore":paragraphSpaceBeforeProperty,
         "paragraphSpaceAfter":paragraphSpaceAfterProperty,
         "textAlign":textAlignProperty,
         "textAlignLast":textAlignLastProperty,
         "textJustify":textJustifyProperty,
         "justificationRule":justificationRuleProperty,
         "justificationStyle":justificationStyleProperty,
         "direction":directionProperty,
         "wordSpacing":wordSpacingProperty,
         "tabStops":tabStopsProperty,
         "leadingModel":leadingModelProperty,
         "columnGap":columnGapProperty,
         "paddingLeft":paddingLeftProperty,
         "paddingTop":paddingTopProperty,
         "paddingRight":paddingRightProperty,
         "paddingBottom":paddingBottomProperty,
         "columnCount":columnCountProperty,
         "columnWidth":columnWidthProperty,
         "firstBaselineOffset":firstBaselineOffsetProperty,
         "verticalAlign":verticalAlignProperty,
         "blockProgression":blockProgressionProperty,
         "lineBreak":lineBreakProperty,
         "listStyleType":listStyleTypeProperty,
         "listStylePosition":listStylePositionProperty,
         "listAutoPadding":listAutoPaddingProperty,
         "clearFloats":clearFloatsProperty,
         "styleName":styleNameProperty,
         "linkNormalFormat":linkNormalFormatProperty,
         "linkActiveFormat":linkActiveFormatProperty,
         "linkHoverFormat":linkHoverFormatProperty,
         "listMarkerFormat":listMarkerFormatProperty,
         "borderLeftWidth":borderLeftWidthProperty,
         "borderRightWidth":borderRightWidthProperty,
         "borderTopWidth":borderTopWidthProperty,
         "borderBottomWidth":borderBottomWidthProperty,
         "borderLeftColor":borderLeftColorProperty,
         "borderRightColor":borderRightColorProperty,
         "borderTopColor":borderTopColorProperty,
         "borderBottomColor":borderBottomColorProperty,
         "marginLeft":marginLeftProperty,
         "marginRight":marginRightProperty,
         "marginTop":marginTopProperty,
         "marginBottom":marginBottomProperty,
         "cellSpacing":cellSpacingProperty,
         "cellPadding":cellPaddingProperty,
         "tableWidth":tableWidthProperty,
         "tableColumnWidth":tableColumnWidthProperty,
         "frame":frameProperty,
         "rules":rulesProperty,
         "borderLeftPriority":borderLeftPriorityProperty,
         "borderRightPriority":borderRightPriorityProperty,
         "borderTopPriority":borderTopPriorityProperty,
         "borderBottomPriority":borderBottomPriorityProperty,
         "minCellHeight":minCellHeightProperty,
         "maxCellHeight":maxCellHeightProperty
      };
      
      private static var _emptyTextLayoutFormat:ITextLayoutFormat;
      
      private static const _emptyStyles:Object = new Object();
      
      private static var _defaults:TextLayoutFormat;
       
      
      private var _styles:Object;
      
      private var _sharedStyles:Boolean;
      
      public function TextLayoutFormat(initialValues:ITextLayoutFormat = null)
      {
         super();
         this.copy(initialValues);
      }
      
      public static function get columnBreakBeforeProperty() : Property
      {
         if(!_columnBreakBeforeProperty)
         {
            _columnBreakBeforeProperty = Property.NewEnumStringProperty("columnBreakBefore",BreakStyle.AUTO,false,Vector.<String>([Category.PARAGRAPH]),BreakStyle.AUTO,BreakStyle.ALWAYS);
         }
         return _columnBreakBeforeProperty;
      }
      
      public static function get columnBreakAfterProperty() : Property
      {
         if(!_columnBreakAfterProperty)
         {
            _columnBreakAfterProperty = Property.NewEnumStringProperty("columnBreakAfter",BreakStyle.AUTO,false,Vector.<String>([Category.PARAGRAPH]),BreakStyle.AUTO,BreakStyle.ALWAYS);
         }
         return _columnBreakAfterProperty;
      }
      
      public static function get containerBreakBeforeProperty() : Property
      {
         if(!_containerBreakBeforeProperty)
         {
            _containerBreakBeforeProperty = Property.NewEnumStringProperty("containerBreakBefore",BreakStyle.AUTO,false,Vector.<String>([Category.PARAGRAPH]),BreakStyle.AUTO,BreakStyle.ALWAYS);
         }
         return _containerBreakBeforeProperty;
      }
      
      public static function get containerBreakAfterProperty() : Property
      {
         if(!_containerBreakAfterProperty)
         {
            _containerBreakAfterProperty = Property.NewEnumStringProperty("containerBreakAfter",BreakStyle.AUTO,false,Vector.<String>([Category.PARAGRAPH]),BreakStyle.AUTO,BreakStyle.ALWAYS);
         }
         return _containerBreakAfterProperty;
      }
      
      public static function get colorProperty() : Property
      {
         if(!_colorProperty)
         {
            _colorProperty = Property.NewUintOrEnumProperty("color",0,true,Vector.<String>([Category.CHARACTER]),ColorName.BLACK,ColorName.GREEN,ColorName.GRAY,ColorName.BLUE,ColorName.SILVER,ColorName.LIME,ColorName.OLIVE,ColorName.WHITE,ColorName.YELLOW,ColorName.MAROON,ColorName.NAVY,ColorName.RED,ColorName.PURPLE,ColorName.TEAL,ColorName.FUCHSIA,ColorName.AQUA,ColorName.MAGENTA,ColorName.CYAN);
         }
         return _colorProperty;
      }
      
      public static function get backgroundColorProperty() : Property
      {
         if(!_backgroundColorProperty)
         {
            _backgroundColorProperty = Property.NewUintOrEnumProperty("backgroundColor",BackgroundColor.TRANSPARENT,false,Vector.<String>([Category.CHARACTER,Category.PARAGRAPH,Category.CONTAINER,Category.TABLE,Category.TABLEROW,Category.TABLECOLUMN,Category.TABLECELL]),BackgroundColor.TRANSPARENT);
         }
         return _backgroundColorProperty;
      }
      
      public static function get lineThroughProperty() : Property
      {
         if(!_lineThroughProperty)
         {
            _lineThroughProperty = Property.NewBooleanProperty("lineThrough",false,true,Vector.<String>([Category.CHARACTER]));
         }
         return _lineThroughProperty;
      }
      
      public static function get textAlphaProperty() : Property
      {
         if(!_textAlphaProperty)
         {
            _textAlphaProperty = Property.NewNumberProperty("textAlpha",1,true,Vector.<String>([Category.CHARACTER]),0,1);
         }
         return _textAlphaProperty;
      }
      
      public static function get backgroundAlphaProperty() : Property
      {
         if(!_backgroundAlphaProperty)
         {
            _backgroundAlphaProperty = Property.NewNumberProperty("backgroundAlpha",1,false,Vector.<String>([Category.CHARACTER]),0,1);
         }
         return _backgroundAlphaProperty;
      }
      
      public static function get fontSizeProperty() : Property
      {
         if(!_fontSizeProperty)
         {
            _fontSizeProperty = Property.NewNumberProperty("fontSize",12,true,Vector.<String>([Category.CHARACTER]),1,720);
         }
         return _fontSizeProperty;
      }
      
      public static function get baselineShiftProperty() : Property
      {
         if(!_baselineShiftProperty)
         {
            _baselineShiftProperty = Property.NewNumberOrPercentOrEnumProperty("baselineShift",0,true,Vector.<String>([Category.CHARACTER]),-1000,1000,"-1000%","1000%",BaselineShift.SUPERSCRIPT,BaselineShift.SUBSCRIPT);
         }
         return _baselineShiftProperty;
      }
      
      public static function get trackingLeftProperty() : Property
      {
         if(!_trackingLeftProperty)
         {
            _trackingLeftProperty = Property.NewNumberOrPercentProperty("trackingLeft",0,true,Vector.<String>([Category.CHARACTER]),-1000,1000,"-1000%","1000%");
         }
         return _trackingLeftProperty;
      }
      
      public static function get trackingRightProperty() : Property
      {
         if(!_trackingRightProperty)
         {
            _trackingRightProperty = Property.NewNumberOrPercentProperty("trackingRight",0,true,Vector.<String>([Category.CHARACTER]),-1000,1000,"-1000%","1000%");
         }
         return _trackingRightProperty;
      }
      
      public static function get lineHeightProperty() : Property
      {
         if(!_lineHeightProperty)
         {
            _lineHeightProperty = Property.NewNumberOrPercentProperty("lineHeight","120%",true,Vector.<String>([Category.CHARACTER]),-720,720,"-1000%","1000%");
         }
         return _lineHeightProperty;
      }
      
      public static function get breakOpportunityProperty() : Property
      {
         if(!_breakOpportunityProperty)
         {
            _breakOpportunityProperty = Property.NewEnumStringProperty("breakOpportunity",BreakOpportunity.AUTO,true,Vector.<String>([Category.CHARACTER]),BreakOpportunity.ALL,BreakOpportunity.ANY,BreakOpportunity.AUTO,BreakOpportunity.NONE);
         }
         return _breakOpportunityProperty;
      }
      
      public static function get digitCaseProperty() : Property
      {
         if(!_digitCaseProperty)
         {
            _digitCaseProperty = Property.NewEnumStringProperty("digitCase",DigitCase.DEFAULT,true,Vector.<String>([Category.CHARACTER]),DigitCase.DEFAULT,DigitCase.LINING,DigitCase.OLD_STYLE);
         }
         return _digitCaseProperty;
      }
      
      public static function get digitWidthProperty() : Property
      {
         if(!_digitWidthProperty)
         {
            _digitWidthProperty = Property.NewEnumStringProperty("digitWidth",DigitWidth.DEFAULT,true,Vector.<String>([Category.CHARACTER]),DigitWidth.DEFAULT,DigitWidth.PROPORTIONAL,DigitWidth.TABULAR);
         }
         return _digitWidthProperty;
      }
      
      public static function get dominantBaselineProperty() : Property
      {
         if(!_dominantBaselineProperty)
         {
            _dominantBaselineProperty = Property.NewEnumStringProperty("dominantBaseline",FormatValue.AUTO,true,Vector.<String>([Category.CHARACTER]),FormatValue.AUTO,TextBaseline.ROMAN,TextBaseline.ASCENT,TextBaseline.DESCENT,TextBaseline.IDEOGRAPHIC_TOP,TextBaseline.IDEOGRAPHIC_CENTER,TextBaseline.IDEOGRAPHIC_BOTTOM);
         }
         return _dominantBaselineProperty;
      }
      
      public static function get kerningProperty() : Property
      {
         if(!_kerningProperty)
         {
            _kerningProperty = Property.NewEnumStringProperty("kerning",Kerning.AUTO,true,Vector.<String>([Category.CHARACTER]),Kerning.ON,Kerning.OFF,Kerning.AUTO);
         }
         return _kerningProperty;
      }
      
      public static function get ligatureLevelProperty() : Property
      {
         if(!_ligatureLevelProperty)
         {
            _ligatureLevelProperty = Property.NewEnumStringProperty("ligatureLevel",LigatureLevel.COMMON,true,Vector.<String>([Category.CHARACTER]),LigatureLevel.MINIMUM,LigatureLevel.COMMON,LigatureLevel.UNCOMMON,LigatureLevel.EXOTIC);
         }
         return _ligatureLevelProperty;
      }
      
      public static function get alignmentBaselineProperty() : Property
      {
         if(!_alignmentBaselineProperty)
         {
            _alignmentBaselineProperty = Property.NewEnumStringProperty("alignmentBaseline",TextBaseline.USE_DOMINANT_BASELINE,true,Vector.<String>([Category.CHARACTER]),TextBaseline.ROMAN,TextBaseline.ASCENT,TextBaseline.DESCENT,TextBaseline.IDEOGRAPHIC_TOP,TextBaseline.IDEOGRAPHIC_CENTER,TextBaseline.IDEOGRAPHIC_BOTTOM,TextBaseline.USE_DOMINANT_BASELINE);
         }
         return _alignmentBaselineProperty;
      }
      
      public static function get localeProperty() : Property
      {
         if(!_localeProperty)
         {
            _localeProperty = Property.NewStringProperty("locale","en",true,Vector.<String>([Category.CHARACTER,Category.PARAGRAPH]));
         }
         return _localeProperty;
      }
      
      public static function get typographicCaseProperty() : Property
      {
         if(!_typographicCaseProperty)
         {
            _typographicCaseProperty = Property.NewEnumStringProperty("typographicCase",TLFTypographicCase.DEFAULT,true,Vector.<String>([Category.CHARACTER]),TLFTypographicCase.DEFAULT,TLFTypographicCase.CAPS_TO_SMALL_CAPS,TLFTypographicCase.UPPERCASE,TLFTypographicCase.LOWERCASE,TLFTypographicCase.LOWERCASE_TO_SMALL_CAPS);
         }
         return _typographicCaseProperty;
      }
      
      public static function get fontFamilyProperty() : Property
      {
         if(!_fontFamilyProperty)
         {
            _fontFamilyProperty = Property.NewStringProperty("fontFamily","Arial",true,Vector.<String>([Category.CHARACTER]));
         }
         return _fontFamilyProperty;
      }
      
      public static function get textDecorationProperty() : Property
      {
         if(!_textDecorationProperty)
         {
            _textDecorationProperty = Property.NewEnumStringProperty("textDecoration",TextDecoration.NONE,true,Vector.<String>([Category.CHARACTER]),TextDecoration.NONE,TextDecoration.UNDERLINE);
         }
         return _textDecorationProperty;
      }
      
      public static function get fontWeightProperty() : Property
      {
         if(!_fontWeightProperty)
         {
            _fontWeightProperty = Property.NewEnumStringProperty("fontWeight",FontWeight.NORMAL,true,Vector.<String>([Category.CHARACTER]),FontWeight.NORMAL,FontWeight.BOLD);
         }
         return _fontWeightProperty;
      }
      
      public static function get fontStyleProperty() : Property
      {
         if(!_fontStyleProperty)
         {
            _fontStyleProperty = Property.NewEnumStringProperty("fontStyle",FontPosture.NORMAL,true,Vector.<String>([Category.CHARACTER]),FontPosture.NORMAL,FontPosture.ITALIC);
         }
         return _fontStyleProperty;
      }
      
      public static function get whiteSpaceCollapseProperty() : Property
      {
         if(!_whiteSpaceCollapseProperty)
         {
            _whiteSpaceCollapseProperty = Property.NewEnumStringProperty("whiteSpaceCollapse",WhiteSpaceCollapse.COLLAPSE,true,Vector.<String>([Category.CHARACTER]),WhiteSpaceCollapse.PRESERVE,WhiteSpaceCollapse.COLLAPSE);
         }
         return _whiteSpaceCollapseProperty;
      }
      
      public static function get renderingModeProperty() : Property
      {
         if(!_renderingModeProperty)
         {
            _renderingModeProperty = Property.NewEnumStringProperty("renderingMode",RenderingMode.CFF,true,Vector.<String>([Category.CHARACTER]),RenderingMode.NORMAL,RenderingMode.CFF);
         }
         return _renderingModeProperty;
      }
      
      public static function get cffHintingProperty() : Property
      {
         if(!_cffHintingProperty)
         {
            _cffHintingProperty = Property.NewEnumStringProperty("cffHinting",CFFHinting.HORIZONTAL_STEM,true,Vector.<String>([Category.CHARACTER]),CFFHinting.NONE,CFFHinting.HORIZONTAL_STEM);
         }
         return _cffHintingProperty;
      }
      
      public static function get fontLookupProperty() : Property
      {
         if(!_fontLookupProperty)
         {
            _fontLookupProperty = Property.NewEnumStringProperty("fontLookup",FontLookup.DEVICE,true,Vector.<String>([Category.CHARACTER]),FontLookup.DEVICE,FontLookup.EMBEDDED_CFF);
         }
         return _fontLookupProperty;
      }
      
      public static function get textRotationProperty() : Property
      {
         if(!_textRotationProperty)
         {
            _textRotationProperty = Property.NewEnumStringProperty("textRotation",TextRotation.AUTO,true,Vector.<String>([Category.CHARACTER]),TextRotation.ROTATE_0,TextRotation.ROTATE_180,TextRotation.ROTATE_270,TextRotation.ROTATE_90,TextRotation.AUTO);
         }
         return _textRotationProperty;
      }
      
      public static function get textIndentProperty() : Property
      {
         if(!_textIndentProperty)
         {
            _textIndentProperty = Property.NewNumberProperty("textIndent",0,true,Vector.<String>([Category.PARAGRAPH]),-8000,8000);
         }
         return _textIndentProperty;
      }
      
      public static function get paragraphStartIndentProperty() : Property
      {
         if(!_paragraphStartIndentProperty)
         {
            _paragraphStartIndentProperty = Property.NewNumberProperty("paragraphStartIndent",0,true,Vector.<String>([Category.PARAGRAPH]),0,8000);
         }
         return _paragraphStartIndentProperty;
      }
      
      public static function get paragraphEndIndentProperty() : Property
      {
         if(!_paragraphEndIndentProperty)
         {
            _paragraphEndIndentProperty = Property.NewNumberProperty("paragraphEndIndent",0,true,Vector.<String>([Category.PARAGRAPH]),0,8000);
         }
         return _paragraphEndIndentProperty;
      }
      
      public static function get paragraphSpaceBeforeProperty() : Property
      {
         if(!_paragraphSpaceBeforeProperty)
         {
            _paragraphSpaceBeforeProperty = Property.NewNumberProperty("paragraphSpaceBefore",0,true,Vector.<String>([Category.PARAGRAPH]),0,8000);
         }
         return _paragraphSpaceBeforeProperty;
      }
      
      public static function get paragraphSpaceAfterProperty() : Property
      {
         if(!_paragraphSpaceAfterProperty)
         {
            _paragraphSpaceAfterProperty = Property.NewNumberProperty("paragraphSpaceAfter",0,true,Vector.<String>([Category.PARAGRAPH]),0,8000);
         }
         return _paragraphSpaceAfterProperty;
      }
      
      public static function get textAlignProperty() : Property
      {
         if(!_textAlignProperty)
         {
            _textAlignProperty = Property.NewEnumStringProperty("textAlign",TextAlign.START,true,Vector.<String>([Category.PARAGRAPH,Category.TABLE,Category.TABLECELL,Category.TABLEROW,Category.TABLECOLUMN]),TextAlign.LEFT,TextAlign.RIGHT,TextAlign.CENTER,TextAlign.JUSTIFY,TextAlign.START,TextAlign.END);
         }
         return _textAlignProperty;
      }
      
      public static function get textAlignLastProperty() : Property
      {
         if(!_textAlignLastProperty)
         {
            _textAlignLastProperty = Property.NewEnumStringProperty("textAlignLast",TextAlign.START,true,Vector.<String>([Category.PARAGRAPH]),TextAlign.LEFT,TextAlign.RIGHT,TextAlign.CENTER,TextAlign.JUSTIFY,TextAlign.START,TextAlign.END);
         }
         return _textAlignLastProperty;
      }
      
      public static function get textJustifyProperty() : Property
      {
         if(!_textJustifyProperty)
         {
            _textJustifyProperty = Property.NewEnumStringProperty("textJustify",TextJustify.INTER_WORD,true,Vector.<String>([Category.PARAGRAPH]),TextJustify.INTER_WORD,TextJustify.DISTRIBUTE);
         }
         return _textJustifyProperty;
      }
      
      public static function get justificationRuleProperty() : Property
      {
         if(!_justificationRuleProperty)
         {
            _justificationRuleProperty = Property.NewEnumStringProperty("justificationRule",FormatValue.AUTO,true,Vector.<String>([Category.PARAGRAPH]),JustificationRule.EAST_ASIAN,JustificationRule.SPACE,FormatValue.AUTO);
         }
         return _justificationRuleProperty;
      }
      
      public static function get justificationStyleProperty() : Property
      {
         if(!_justificationStyleProperty)
         {
            _justificationStyleProperty = Property.NewEnumStringProperty("justificationStyle",FormatValue.AUTO,true,Vector.<String>([Category.PARAGRAPH]),JustificationStyle.PRIORITIZE_LEAST_ADJUSTMENT,JustificationStyle.PUSH_IN_KINSOKU,JustificationStyle.PUSH_OUT_ONLY,FormatValue.AUTO);
         }
         return _justificationStyleProperty;
      }
      
      public static function get directionProperty() : Property
      {
         if(!_directionProperty)
         {
            _directionProperty = Property.NewEnumStringProperty("direction",Direction.LTR,true,Vector.<String>([Category.PARAGRAPH,Category.TABLE,Category.TABLECELL,Category.TABLEROW,Category.TABLECOLUMN]),Direction.LTR,Direction.RTL);
         }
         return _directionProperty;
      }
      
      public static function get wordSpacingProperty() : Property
      {
         if(!_wordSpacingProperty)
         {
            _wordSpacingProperty = Property.NewSpacingLimitProperty("wordSpacing","100%, 50%, 150%",true,Vector.<String>([Category.PARAGRAPH]),"-1000%","1000%");
         }
         return _wordSpacingProperty;
      }
      
      public static function get tabStopsProperty() : Property
      {
         if(!_tabStopsProperty)
         {
            _tabStopsProperty = Property.NewTabStopsProperty("tabStops",null,true,Vector.<String>([Category.PARAGRAPH]));
         }
         return _tabStopsProperty;
      }
      
      public static function get leadingModelProperty() : Property
      {
         if(!_leadingModelProperty)
         {
            _leadingModelProperty = Property.NewEnumStringProperty("leadingModel",LeadingModel.AUTO,true,Vector.<String>([Category.PARAGRAPH]),LeadingModel.ROMAN_UP,LeadingModel.IDEOGRAPHIC_TOP_UP,LeadingModel.IDEOGRAPHIC_CENTER_UP,LeadingModel.IDEOGRAPHIC_TOP_DOWN,LeadingModel.IDEOGRAPHIC_CENTER_DOWN,LeadingModel.APPROXIMATE_TEXT_FIELD,LeadingModel.ASCENT_DESCENT_UP,LeadingModel.BOX,LeadingModel.AUTO);
         }
         return _leadingModelProperty;
      }
      
      public static function get columnGapProperty() : Property
      {
         if(!_columnGapProperty)
         {
            _columnGapProperty = Property.NewNumberProperty("columnGap",20,false,Vector.<String>([Category.CONTAINER]),0,1000);
         }
         return _columnGapProperty;
      }
      
      public static function get paddingLeftProperty() : Property
      {
         if(!_paddingLeftProperty)
         {
            _paddingLeftProperty = Property.NewNumberOrEnumProperty("paddingLeft",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000,FormatValue.AUTO);
         }
         return _paddingLeftProperty;
      }
      
      public static function get paddingTopProperty() : Property
      {
         if(!_paddingTopProperty)
         {
            _paddingTopProperty = Property.NewNumberOrEnumProperty("paddingTop",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000,FormatValue.AUTO);
         }
         return _paddingTopProperty;
      }
      
      public static function get paddingRightProperty() : Property
      {
         if(!_paddingRightProperty)
         {
            _paddingRightProperty = Property.NewNumberOrEnumProperty("paddingRight",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000,FormatValue.AUTO);
         }
         return _paddingRightProperty;
      }
      
      public static function get paddingBottomProperty() : Property
      {
         if(!_paddingBottomProperty)
         {
            _paddingBottomProperty = Property.NewNumberOrEnumProperty("paddingBottom",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000,FormatValue.AUTO);
         }
         return _paddingBottomProperty;
      }
      
      public static function get columnCountProperty() : Property
      {
         if(!_columnCountProperty)
         {
            _columnCountProperty = Property.NewIntOrEnumProperty("columnCount",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER]),1,50,FormatValue.AUTO);
         }
         return _columnCountProperty;
      }
      
      public static function get columnWidthProperty() : Property
      {
         if(!_columnWidthProperty)
         {
            _columnWidthProperty = Property.NewNumberOrEnumProperty("columnWidth",FormatValue.AUTO,false,Vector.<String>([Category.CONTAINER]),0,8000,FormatValue.AUTO);
         }
         return _columnWidthProperty;
      }
      
      public static function get firstBaselineOffsetProperty() : Property
      {
         if(!_firstBaselineOffsetProperty)
         {
            _firstBaselineOffsetProperty = Property.NewNumberOrEnumProperty("firstBaselineOffset",BaselineOffset.AUTO,true,Vector.<String>([Category.CONTAINER]),0,1000,BaselineOffset.AUTO,BaselineOffset.ASCENT,BaselineOffset.LINE_HEIGHT);
         }
         return _firstBaselineOffsetProperty;
      }
      
      public static function get verticalAlignProperty() : Property
      {
         if(!_verticalAlignProperty)
         {
            _verticalAlignProperty = Property.NewEnumStringProperty("verticalAlign",VerticalAlign.TOP,false,Vector.<String>([Category.CONTAINER,Category.TABLECELL,Category.TABLE,Category.TABLEROW,Category.TABLECOLUMN]),VerticalAlign.TOP,VerticalAlign.MIDDLE,VerticalAlign.BOTTOM,VerticalAlign.JUSTIFY);
         }
         return _verticalAlignProperty;
      }
      
      public static function get blockProgressionProperty() : Property
      {
         if(!_blockProgressionProperty)
         {
            _blockProgressionProperty = Property.NewEnumStringProperty("blockProgression",BlockProgression.TB,true,Vector.<String>([Category.CONTAINER]),BlockProgression.RL,BlockProgression.TB);
         }
         return _blockProgressionProperty;
      }
      
      public static function get lineBreakProperty() : Property
      {
         if(!_lineBreakProperty)
         {
            _lineBreakProperty = Property.NewEnumStringProperty("lineBreak",LineBreak.TO_FIT,false,Vector.<String>([Category.CONTAINER,Category.TABLECELL]),LineBreak.EXPLICIT,LineBreak.TO_FIT);
         }
         return _lineBreakProperty;
      }
      
      public static function get listStyleTypeProperty() : Property
      {
         if(!_listStyleTypeProperty)
         {
            _listStyleTypeProperty = Property.NewEnumStringProperty("listStyleType",ListStyleType.DISC,true,Vector.<String>([Category.LIST]),ListStyleType.UPPER_ALPHA,ListStyleType.LOWER_ALPHA,ListStyleType.UPPER_ROMAN,ListStyleType.LOWER_ROMAN,ListStyleType.NONE,ListStyleType.DISC,ListStyleType.CIRCLE,ListStyleType.SQUARE,ListStyleType.BOX,ListStyleType.CHECK,ListStyleType.DIAMOND,ListStyleType.HYPHEN,ListStyleType.ARABIC_INDIC,ListStyleType.BENGALI,ListStyleType.DECIMAL,ListStyleType.DECIMAL_LEADING_ZERO,ListStyleType.DEVANAGARI,ListStyleType.GUJARATI,ListStyleType.GURMUKHI,ListStyleType.KANNADA,ListStyleType.PERSIAN,ListStyleType.THAI,ListStyleType.URDU,ListStyleType.CJK_EARTHLY_BRANCH,ListStyleType.CJK_HEAVENLY_STEM,ListStyleType.HANGUL,ListStyleType.HANGUL_CONSTANT,ListStyleType.HIRAGANA,ListStyleType.HIRAGANA_IROHA,ListStyleType.KATAKANA,ListStyleType.KATAKANA_IROHA,ListStyleType.LOWER_ALPHA,ListStyleType.LOWER_GREEK,ListStyleType.LOWER_LATIN,ListStyleType.UPPER_ALPHA,ListStyleType.UPPER_GREEK,ListStyleType.UPPER_LATIN);
         }
         return _listStyleTypeProperty;
      }
      
      public static function get listStylePositionProperty() : Property
      {
         if(!_listStylePositionProperty)
         {
            _listStylePositionProperty = Property.NewEnumStringProperty("listStylePosition",ListStylePosition.OUTSIDE,true,Vector.<String>([Category.LIST]),ListStylePosition.INSIDE,ListStylePosition.OUTSIDE);
         }
         return _listStylePositionProperty;
      }
      
      public static function get listAutoPaddingProperty() : Property
      {
         if(!_listAutoPaddingProperty)
         {
            _listAutoPaddingProperty = Property.NewNumberProperty("listAutoPadding",40,true,Vector.<String>([Category.CONTAINER]),-1000,1000);
         }
         return _listAutoPaddingProperty;
      }
      
      public static function get clearFloatsProperty() : Property
      {
         if(!_clearFloatsProperty)
         {
            _clearFloatsProperty = Property.NewEnumStringProperty("clearFloats",ClearFloats.NONE,false,Vector.<String>([Category.PARAGRAPH]),ClearFloats.START,ClearFloats.END,ClearFloats.LEFT,ClearFloats.RIGHT,ClearFloats.BOTH,ClearFloats.NONE);
         }
         return _clearFloatsProperty;
      }
      
      public static function get styleNameProperty() : Property
      {
         if(!_styleNameProperty)
         {
            _styleNameProperty = Property.NewStringProperty("styleName",null,false,Vector.<String>([Category.STYLE]));
         }
         return _styleNameProperty;
      }
      
      public static function get linkNormalFormatProperty() : Property
      {
         if(!_linkNormalFormatProperty)
         {
            _linkNormalFormatProperty = Property.NewTextLayoutFormatProperty("linkNormalFormat",null,true,Vector.<String>([Category.STYLE]));
         }
         return _linkNormalFormatProperty;
      }
      
      public static function get linkActiveFormatProperty() : Property
      {
         if(!_linkActiveFormatProperty)
         {
            _linkActiveFormatProperty = Property.NewTextLayoutFormatProperty("linkActiveFormat",null,true,Vector.<String>([Category.STYLE]));
         }
         return _linkActiveFormatProperty;
      }
      
      public static function get linkHoverFormatProperty() : Property
      {
         if(!_linkHoverFormatProperty)
         {
            _linkHoverFormatProperty = Property.NewTextLayoutFormatProperty("linkHoverFormat",null,true,Vector.<String>([Category.STYLE]));
         }
         return _linkHoverFormatProperty;
      }
      
      public static function get listMarkerFormatProperty() : Property
      {
         if(!_listMarkerFormatProperty)
         {
            _listMarkerFormatProperty = Property.NewListMarkerFormatProperty("listMarkerFormat",null,true,Vector.<String>([Category.STYLE]));
         }
         return _listMarkerFormatProperty;
      }
      
      public static function get borderLeftWidthProperty() : Property
      {
         if(!_borderLeftWidthProperty)
         {
            _borderLeftWidthProperty = Property.NewNumberProperty("borderLeftWidth",0,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),0,128);
         }
         return _borderLeftWidthProperty;
      }
      
      public static function get borderRightWidthProperty() : Property
      {
         if(!_borderRightWidthProperty)
         {
            _borderRightWidthProperty = Property.NewNumberProperty("borderRightWidth",0,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),0,128);
         }
         return _borderRightWidthProperty;
      }
      
      public static function get borderTopWidthProperty() : Property
      {
         if(!_borderTopWidthProperty)
         {
            _borderTopWidthProperty = Property.NewNumberProperty("borderTopWidth",0,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),0,128);
         }
         return _borderTopWidthProperty;
      }
      
      public static function get borderBottomWidthProperty() : Property
      {
         if(!_borderBottomWidthProperty)
         {
            _borderBottomWidthProperty = Property.NewNumberProperty("borderBottomWidth",0,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),0,128);
         }
         return _borderBottomWidthProperty;
      }
      
      public static function get borderLeftColorProperty() : Property
      {
         if(!_borderLeftColorProperty)
         {
            _borderLeftColorProperty = Property.NewUintOrEnumProperty("borderLeftColor",BorderColor.TRANSPARENT,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),BorderColor.TRANSPARENT);
         }
         return _borderLeftColorProperty;
      }
      
      public static function get borderRightColorProperty() : Property
      {
         if(!_borderRightColorProperty)
         {
            _borderRightColorProperty = Property.NewUintOrEnumProperty("borderRightColor",BorderColor.TRANSPARENT,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),BorderColor.TRANSPARENT);
         }
         return _borderRightColorProperty;
      }
      
      public static function get borderTopColorProperty() : Property
      {
         if(!_borderTopColorProperty)
         {
            _borderTopColorProperty = Property.NewUintOrEnumProperty("borderTopColor",BorderColor.TRANSPARENT,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),BorderColor.TRANSPARENT);
         }
         return _borderTopColorProperty;
      }
      
      public static function get borderBottomColorProperty() : Property
      {
         if(!_borderBottomColorProperty)
         {
            _borderBottomColorProperty = Property.NewUintOrEnumProperty("borderBottomColor",BorderColor.TRANSPARENT,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),BorderColor.TRANSPARENT);
         }
         return _borderBottomColorProperty;
      }
      
      public static function get borderLeftPriorityProperty() : Property
      {
         if(!_borderLeftPriorityProperty)
         {
            _borderLeftPriorityProperty = Property.NewNumberProperty("borderLeftPriority",0,false,Vector.<String>([Category.TABLE,Category.TABLECELL,Category.TABLECOLUMN,Category.TABLEROW]),-8000,8000);
         }
         return _borderLeftPriorityProperty;
      }
      
      public static function get borderRightPriorityProperty() : Property
      {
         if(!_borderRightPriorityProperty)
         {
            _borderRightPriorityProperty = Property.NewNumberProperty("borderRightPriority",0,false,Vector.<String>([Category.TABLE,Category.TABLECELL,Category.TABLECOLUMN,Category.TABLEROW]),-8000,8000);
         }
         return _borderRightPriorityProperty;
      }
      
      public static function get borderTopPriorityProperty() : Property
      {
         if(!_borderTopPriorityProperty)
         {
            _borderTopPriorityProperty = Property.NewNumberProperty("borderTopPriority",0,false,Vector.<String>([Category.TABLE,Category.TABLECELL,Category.TABLECOLUMN,Category.TABLEROW]),-8000,8000);
         }
         return _borderTopPriorityProperty;
      }
      
      public static function get borderBottomPriorityProperty() : Property
      {
         if(!_borderBottomPriorityProperty)
         {
            _borderBottomPriorityProperty = Property.NewNumberProperty("borderBottomPriority",0,false,Vector.<String>([Category.TABLE,Category.TABLECELL,Category.TABLECOLUMN,Category.TABLEROW]),-8000,8000);
         }
         return _borderBottomPriorityProperty;
      }
      
      public static function get marginLeftProperty() : Property
      {
         if(!_marginLeftProperty)
         {
            _marginLeftProperty = Property.NewNumberProperty("marginLeft",0,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000);
         }
         return _marginLeftProperty;
      }
      
      public static function get marginRightProperty() : Property
      {
         if(!_marginRightProperty)
         {
            _marginRightProperty = Property.NewNumberProperty("marginRight",0,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000);
         }
         return _marginRightProperty;
      }
      
      public static function get marginTopProperty() : Property
      {
         if(!_marginTopProperty)
         {
            _marginTopProperty = Property.NewNumberProperty("marginTop",0,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000);
         }
         return _marginTopProperty;
      }
      
      public static function get marginBottomProperty() : Property
      {
         if(!_marginBottomProperty)
         {
            _marginBottomProperty = Property.NewNumberProperty("marginBottom",0,false,Vector.<String>([Category.CONTAINER,Category.PARAGRAPH]),-8000,8000);
         }
         return _marginBottomProperty;
      }
      
      public static function get cellSpacingProperty() : Property
      {
         if(!_cellSpacingProperty)
         {
            _cellSpacingProperty = Property.NewNumberProperty("cellSpacing",0,false,Vector.<String>([Category.TABLE]),0,1000);
         }
         return _cellSpacingProperty;
      }
      
      public static function get cellPaddingProperty() : Property
      {
         if(!_cellPaddingProperty)
         {
            _cellPaddingProperty = Property.NewNumberOrPercentProperty("cellPadding",0,true,Vector.<String>([Category.TABLE]),0,1000,"0%","100%");
         }
         return _cellPaddingProperty;
      }
      
      public static function get tableWidthProperty() : Property
      {
         if(!_tableWidthProperty)
         {
            _tableWidthProperty = Property.NewNumberOrPercentProperty("tableWidth","100%",false,Vector.<String>([Category.TABLE]),0,8000,"0%","100%");
         }
         return _tableWidthProperty;
      }
      
      public static function get tableColumnWidthProperty() : Property
      {
         if(!_tableColumnWidthProperty)
         {
            _tableColumnWidthProperty = Property.NewNumberOrPercentProperty("tableColumnWidth",0,false,Vector.<String>([Category.TABLECOLUMN]),0,8000,"0%","100%");
         }
         return _tableColumnWidthProperty;
      }
      
      public static function get minCellHeightProperty() : Property
      {
         if(!_minCellHeightProperty)
         {
            _minCellHeightProperty = Property.NewNumberOrEnumProperty("minCellHeight",2,false,Vector.<String>([Category.TABLE,Category.TABLECELL]),2,8000);
         }
         return _minCellHeightProperty;
      }
      
      public static function get maxCellHeightProperty() : Property
      {
         if(!_maxCellHeightProperty)
         {
            _maxCellHeightProperty = Property.NewNumberOrEnumProperty("maxCellHeight",8000,false,Vector.<String>([Category.TABLE,Category.TABLECELL]),2,8000);
         }
         return _maxCellHeightProperty;
      }
      
      public static function get frameProperty() : Property
      {
         if(!_frameProperty)
         {
            _frameProperty = Property.NewEnumStringProperty("frame",TableFrame.VOID,false,Vector.<String>([Category.TABLE]),TableFrame.VOID,TableFrame.ABOVE,TableFrame.BELOW,TableFrame.HSIDES,TableFrame.VSIDES,TableFrame.LHS,TableFrame.RHS,TableFrame.BOX,TableFrame.BORDER);
         }
         return _frameProperty;
      }
      
      public static function get rulesProperty() : Property
      {
         if(!_rulesProperty)
         {
            _rulesProperty = Property.NewEnumStringProperty("rules",TableRules.NONE,false,Vector.<String>([Category.TABLE]),TableRules.NONE,TableRules.GROUPS,TableRules.ROWS,TableRules.COLS,TableRules.ALL);
         }
         return _rulesProperty;
      }
      
      tlf_internal static function get description() : Object
      {
         return _description;
      }
      
      tlf_internal static function get emptyTextLayoutFormat() : ITextLayoutFormat
      {
         if(_emptyTextLayoutFormat == null)
         {
            _emptyTextLayoutFormat = new TextLayoutFormat();
         }
         return _emptyTextLayoutFormat;
      }
      
      public static function isEqual(p1:ITextLayoutFormat, p2:ITextLayoutFormat) : Boolean
      {
         var prop:Property = null;
         if(p1 == null)
         {
            p1 = tlf_internal::emptyTextLayoutFormat;
         }
         if(p2 == null)
         {
            p2 = tlf_internal::emptyTextLayoutFormat;
         }
         if(p1 == p2)
         {
            return true;
         }
         var p1Holder:TextLayoutFormat = p1 as TextLayoutFormat;
         var p2Holder:TextLayoutFormat = p2 as TextLayoutFormat;
         if(p1Holder && p2Holder)
         {
            return Property.equalStyles(p1Holder.getStyles(),p2Holder.getStyles(),TextLayoutFormat.description);
         }
         for each(prop in TextLayoutFormat.description)
         {
            if(!prop.equalHelper(p1[prop.name],p2[prop.name]))
            {
               return false;
            }
         }
         return true;
      }
      
      public static function get defaultFormat() : ITextLayoutFormat
      {
         if(_defaults == null)
         {
            _defaults = new TextLayoutFormat();
            Property.defaultsAllHelper(_description,_defaults);
         }
         return _defaults;
      }
      
      tlf_internal static function resetModifiedNoninheritedStyles(stylesObject:Object) : void
      {
         var format:TextLayoutFormat = stylesObject as TextLayoutFormat;
         if(format)
         {
            format.writableStyles();
            stylesObject = format.getStyles();
         }
         if(stylesObject.columnBreakBefore != undefined && stylesObject.columnBreakBefore != TextLayoutFormat.columnBreakBeforeProperty.defaultValue)
         {
            stylesObject.columnBreakBefore = TextLayoutFormat.columnBreakBeforeProperty.defaultValue;
         }
         if(stylesObject.columnBreakAfter != undefined && stylesObject.columnBreakAfter != TextLayoutFormat.columnBreakAfterProperty.defaultValue)
         {
            stylesObject.columnBreakAfter = TextLayoutFormat.columnBreakAfterProperty.defaultValue;
         }
         if(stylesObject.containerBreakBefore != undefined && stylesObject.containerBreakBefore != TextLayoutFormat.containerBreakBeforeProperty.defaultValue)
         {
            stylesObject.containerBreakBefore = TextLayoutFormat.containerBreakBeforeProperty.defaultValue;
         }
         if(stylesObject.containerBreakAfter != undefined && stylesObject.containerBreakAfter != TextLayoutFormat.containerBreakAfterProperty.defaultValue)
         {
            stylesObject.containerBreakAfter = TextLayoutFormat.containerBreakAfterProperty.defaultValue;
         }
         if(stylesObject.backgroundColor != undefined && stylesObject.backgroundColor != TextLayoutFormat.backgroundColorProperty.defaultValue)
         {
            stylesObject.backgroundColor = TextLayoutFormat.backgroundColorProperty.defaultValue;
         }
         if(stylesObject.backgroundAlpha != undefined && stylesObject.backgroundAlpha != TextLayoutFormat.backgroundAlphaProperty.defaultValue)
         {
            stylesObject.backgroundAlpha = TextLayoutFormat.backgroundAlphaProperty.defaultValue;
         }
         if(stylesObject.columnGap != undefined && stylesObject.columnGap != TextLayoutFormat.columnGapProperty.defaultValue)
         {
            stylesObject.columnGap = TextLayoutFormat.columnGapProperty.defaultValue;
         }
         if(stylesObject.paddingLeft != undefined && stylesObject.paddingLeft != TextLayoutFormat.paddingLeftProperty.defaultValue)
         {
            stylesObject.paddingLeft = TextLayoutFormat.paddingLeftProperty.defaultValue;
         }
         if(stylesObject.paddingTop != undefined && stylesObject.paddingTop != TextLayoutFormat.paddingTopProperty.defaultValue)
         {
            stylesObject.paddingTop = TextLayoutFormat.paddingTopProperty.defaultValue;
         }
         if(stylesObject.paddingRight != undefined && stylesObject.paddingRight != TextLayoutFormat.paddingRightProperty.defaultValue)
         {
            stylesObject.paddingRight = TextLayoutFormat.paddingRightProperty.defaultValue;
         }
         if(stylesObject.paddingBottom != undefined && stylesObject.paddingBottom != TextLayoutFormat.paddingBottomProperty.defaultValue)
         {
            stylesObject.paddingBottom = TextLayoutFormat.paddingBottomProperty.defaultValue;
         }
         if(stylesObject.columnCount != undefined && stylesObject.columnCount != TextLayoutFormat.columnCountProperty.defaultValue)
         {
            stylesObject.columnCount = TextLayoutFormat.columnCountProperty.defaultValue;
         }
         if(stylesObject.columnWidth != undefined && stylesObject.columnWidth != TextLayoutFormat.columnWidthProperty.defaultValue)
         {
            stylesObject.columnWidth = TextLayoutFormat.columnWidthProperty.defaultValue;
         }
         if(stylesObject.verticalAlign != undefined && stylesObject.verticalAlign != TextLayoutFormat.verticalAlignProperty.defaultValue)
         {
            stylesObject.verticalAlign = TextLayoutFormat.verticalAlignProperty.defaultValue;
         }
         if(stylesObject.lineBreak != undefined && stylesObject.lineBreak != TextLayoutFormat.lineBreakProperty.defaultValue)
         {
            stylesObject.lineBreak = TextLayoutFormat.lineBreakProperty.defaultValue;
         }
         if(stylesObject.clearFloats != undefined && stylesObject.clearFloats != TextLayoutFormat.clearFloatsProperty.defaultValue)
         {
            stylesObject.clearFloats = TextLayoutFormat.clearFloatsProperty.defaultValue;
         }
         if(stylesObject.styleName != undefined && stylesObject.styleName != TextLayoutFormat.styleNameProperty.defaultValue)
         {
            stylesObject.styleName = TextLayoutFormat.styleNameProperty.defaultValue;
         }
         if(stylesObject.borderLeftWidth != undefined && stylesObject.borderLeftWidth != TextLayoutFormat.borderLeftWidthProperty.defaultValue)
         {
            stylesObject.borderLeftWidth = TextLayoutFormat.borderLeftWidthProperty.defaultValue;
         }
         if(stylesObject.borderRightWidth != undefined && stylesObject.borderRightWidth != TextLayoutFormat.borderRightWidthProperty.defaultValue)
         {
            stylesObject.borderRightWidth = TextLayoutFormat.borderRightWidthProperty.defaultValue;
         }
         if(stylesObject.borderTopWidth != undefined && stylesObject.borderTopWidth != TextLayoutFormat.borderTopWidthProperty.defaultValue)
         {
            stylesObject.borderTopWidth = TextLayoutFormat.borderTopWidthProperty.defaultValue;
         }
         if(stylesObject.borderBottomWidth != undefined && stylesObject.borderBottomWidth != TextLayoutFormat.borderBottomWidthProperty.defaultValue)
         {
            stylesObject.borderBottomWidth = TextLayoutFormat.borderBottomWidthProperty.defaultValue;
         }
         if(stylesObject.borderLeftColor != undefined && stylesObject.borderLeftColor != TextLayoutFormat.borderLeftColorProperty.defaultValue)
         {
            stylesObject.borderLeftColor = TextLayoutFormat.borderLeftColorProperty.defaultValue;
         }
         if(stylesObject.borderRightColor != undefined && stylesObject.borderRightColor != TextLayoutFormat.borderRightColorProperty.defaultValue)
         {
            stylesObject.borderRightColor = TextLayoutFormat.borderRightColorProperty.defaultValue;
         }
         if(stylesObject.borderTopColor != undefined && stylesObject.borderTopColor != TextLayoutFormat.borderTopColorProperty.defaultValue)
         {
            stylesObject.borderTopColor = TextLayoutFormat.borderTopColorProperty.defaultValue;
         }
         if(stylesObject.borderBottomColor != undefined && stylesObject.borderBottomColor != TextLayoutFormat.borderBottomColorProperty.defaultValue)
         {
            stylesObject.borderBottomColor = TextLayoutFormat.borderBottomColorProperty.defaultValue;
         }
         if(stylesObject.marginLeft != undefined && stylesObject.marginLeft != TextLayoutFormat.marginLeftProperty.defaultValue)
         {
            stylesObject.marginLeft = TextLayoutFormat.marginLeftProperty.defaultValue;
         }
         if(stylesObject.marginRight != undefined && stylesObject.marginRight != TextLayoutFormat.marginRightProperty.defaultValue)
         {
            stylesObject.marginRight = TextLayoutFormat.marginRightProperty.defaultValue;
         }
         if(stylesObject.marginTop != undefined && stylesObject.marginTop != TextLayoutFormat.marginTopProperty.defaultValue)
         {
            stylesObject.marginTop = TextLayoutFormat.marginTopProperty.defaultValue;
         }
         if(stylesObject.marginBottom != undefined && stylesObject.marginBottom != TextLayoutFormat.marginBottomProperty.defaultValue)
         {
            stylesObject.marginBottom = TextLayoutFormat.marginBottomProperty.defaultValue;
         }
         if(stylesObject.cellSpacing != undefined && stylesObject.cellSpacing != TextLayoutFormat.cellSpacingProperty.defaultValue)
         {
            stylesObject.cellSpacing = TextLayoutFormat.cellSpacingProperty.defaultValue;
         }
         if(stylesObject.tableWidth != undefined && stylesObject.tableWidth != TextLayoutFormat.tableWidthProperty.defaultValue)
         {
            stylesObject.tableWidth = TextLayoutFormat.tableWidthProperty.defaultValue;
         }
         if(stylesObject.tableColumnWidth != undefined && stylesObject.tableColumnWidth != TextLayoutFormat.tableColumnWidthProperty.defaultValue)
         {
            stylesObject.tableColumnWidth = TextLayoutFormat.tableColumnWidthProperty.defaultValue;
         }
         if(stylesObject.frame != undefined && stylesObject.frame != TextLayoutFormat.frameProperty.defaultValue)
         {
            stylesObject.frame = TextLayoutFormat.frameProperty.defaultValue;
         }
         if(stylesObject.rules != undefined && stylesObject.rules != TextLayoutFormat.rulesProperty.defaultValue)
         {
            stylesObject.rules = TextLayoutFormat.rulesProperty.defaultValue;
         }
         if(stylesObject.borderBottomPriority != undefined && stylesObject.borderBottomPriority != TextLayoutFormat.borderBottomPriorityProperty.defaultValue)
         {
            stylesObject.borderBottomPriority = TextLayoutFormat.borderBottomPriorityProperty.defaultValue;
         }
         if(stylesObject.borderTopPriority != undefined && stylesObject.borderTopPriority != TextLayoutFormat.borderTopPriorityProperty.defaultValue)
         {
            stylesObject.borderTopPriority = TextLayoutFormat.borderTopPriorityProperty.defaultValue;
         }
         if(stylesObject.borderLeftPriority != undefined && stylesObject.borderLeftPriority != TextLayoutFormat.borderLeftPriorityProperty.defaultValue)
         {
            stylesObject.borderLeftPriority = TextLayoutFormat.borderLeftPriorityProperty.defaultValue;
         }
         if(stylesObject.borderRightPriority != undefined && stylesObject.borderRightPriority != TextLayoutFormat.borderRightPriorityProperty.defaultValue)
         {
            stylesObject.borderRightPriority = TextLayoutFormat.borderRightPriorityProperty.defaultValue;
         }
         if(stylesObject.minCellHeight != undefined && stylesObject.minCellHeight != TextLayoutFormat.minCellHeightProperty.defaultValue)
         {
            stylesObject.minCellHeight = TextLayoutFormat.minCellHeightProperty.defaultValue;
         }
         if(stylesObject.maxCellHeight != undefined && stylesObject.maxCellHeight != TextLayoutFormat.maxCellHeightProperty.defaultValue)
         {
            stylesObject.maxCellHeight = TextLayoutFormat.maxCellHeightProperty.defaultValue;
         }
      }
      
      public static function createTextLayoutFormat(initialValues:Object) : TextLayoutFormat
      {
         var key:* = null;
         var format:ITextLayoutFormat = initialValues as ITextLayoutFormat;
         var rslt:TextLayoutFormat = new TextLayoutFormat(format);
         if(format == null && initialValues)
         {
            for(key in initialValues)
            {
               rslt.setStyle(key,initialValues[key]);
            }
         }
         return rslt;
      }
      
      private function writableStyles() : void
      {
         if(this._sharedStyles)
         {
            this._styles = this._styles == _emptyStyles ? new Object() : Property.createObjectWithPrototype(this._styles);
            this._sharedStyles = false;
         }
      }
      
      tlf_internal function getStyles() : Object
      {
         return this._styles == _emptyStyles ? null : this._styles;
      }
      
      tlf_internal function setStyles(val:Object, shared:Boolean) : void
      {
         if(this._styles != val)
         {
            this._styles = val;
            this._sharedStyles = shared;
         }
      }
      
      tlf_internal function clearStyles() : void
      {
         this._styles = _emptyStyles;
         this._sharedStyles = true;
      }
      
      public function get coreStyles() : Object
      {
         return this._styles == _emptyStyles ? null : Property.shallowCopyInFilter(this._styles,tlf_internal::description);
      }
      
      public function get userStyles() : Object
      {
         return this._styles == _emptyStyles ? null : Property.shallowCopyNotInFilter(this._styles,tlf_internal::description);
      }
      
      public function get styles() : Object
      {
         return this._styles == _emptyStyles ? null : Property.shallowCopy(this._styles);
      }
      
      tlf_internal function setStyleByName(name:String, newValue:*) : void
      {
         this.writableStyles();
         if(newValue !== undefined)
         {
            this._styles[name] = newValue;
         }
         else
         {
            delete this._styles[name];
            if(this._styles[name] !== undefined)
            {
               this._styles = Property.shallowCopy(this._styles);
               delete this._styles[name];
            }
         }
      }
      
      private function setStyleByProperty(styleProp:Property, newValue:*) : void
      {
         var name:String = styleProp.name;
         newValue = styleProp.setHelper(this._styles[name],newValue);
         this.setStyleByName(name,newValue);
      }
      
      public function setStyle(styleProp:String, newValue:*) : void
      {
         if(tlf_internal::description.hasOwnProperty(styleProp))
         {
            this[styleProp] = newValue;
         }
         else
         {
            this.setStyleByName(styleProp,newValue);
         }
      }
      
      public function getStyle(styleProp:String) : *
      {
         return this._styles[styleProp];
      }
      
      public function copy(incoming:ITextLayoutFormat) : void
      {
         var prop:Property = null;
         var val:* = undefined;
         if(this == incoming)
         {
            return;
         }
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            this._styles = holder._styles;
            this._sharedStyles = true;
            holder._sharedStyles = true;
            return;
         }
         this._styles = _emptyStyles;
         this._sharedStyles = true;
         if(incoming)
         {
            for each(prop in TextLayoutFormat.description)
            {
               val = incoming[prop.name];
               if(val !== undefined)
               {
                  this[prop.name] = val;
               }
            }
         }
      }
      
      public function concat(incoming:ITextLayoutFormat) : void
      {
         var prop:Property = null;
         var holderStyles:Object = null;
         var key:* = null;
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            holderStyles = holder._styles;
            for(key in holderStyles)
            {
               prop = tlf_internal::description[key];
               if(prop)
               {
                  this.setStyleByProperty(prop,prop.concatHelper(this._styles[key],holderStyles[key]));
               }
               else
               {
                  this.setStyleByName(key,Property.defaultConcatHelper(this._styles[key],holderStyles[key]));
               }
            }
            return;
         }
         for each(prop in TextLayoutFormat.description)
         {
            this.setStyleByProperty(prop,prop.concatHelper(this._styles[prop.name],incoming[prop.name]));
         }
      }
      
      public function concatInheritOnly(incoming:ITextLayoutFormat) : void
      {
         var prop:Property = null;
         var holderStyles:Object = null;
         var key:* = null;
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            holderStyles = holder._styles;
            for(key in holderStyles)
            {
               prop = tlf_internal::description[key];
               if(prop)
               {
                  this.setStyleByProperty(prop,prop.concatInheritOnlyHelper(this._styles[key],holderStyles[key]));
               }
               else
               {
                  this.setStyleByName(key,Property.defaultConcatHelper(this._styles[key],holderStyles[key]));
               }
            }
            return;
         }
         for each(prop in TextLayoutFormat.description)
         {
            this.setStyleByProperty(prop,prop.concatInheritOnlyHelper(this._styles[prop.name],incoming[prop.name]));
         }
      }
      
      public function apply(incoming:ITextLayoutFormat) : void
      {
         var val:* = undefined;
         var prop:Property = null;
         var holderStyles:Object = null;
         var key:* = null;
         var name:String = null;
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            holderStyles = holder._styles;
            for(key in holderStyles)
            {
               val = holderStyles[key];
               if(val !== undefined)
               {
                  this.setStyle(key,val);
               }
            }
            return;
         }
         for each(prop in TextLayoutFormat.description)
         {
            name = prop.name;
            val = incoming[name];
            if(val !== undefined)
            {
               this.setStyle(name,val);
            }
         }
      }
      
      public function removeMatching(incoming:ITextLayoutFormat) : void
      {
         var prop:Property = null;
         var holderStyles:Object = null;
         var key:* = null;
         if(incoming == null)
         {
            return;
         }
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            holderStyles = holder._styles;
            for(key in holderStyles)
            {
               prop = tlf_internal::description[key];
               if(prop)
               {
                  if(prop.equalHelper(this._styles[key],holderStyles[key]))
                  {
                     this[key] = undefined;
                  }
               }
               else if(this._styles[key] == holderStyles[key])
               {
                  this.setStyle(key,undefined);
               }
            }
            return;
         }
         for each(prop in TextLayoutFormat.description)
         {
            if(prop.equalHelper(this._styles[prop.name],incoming[prop.name]))
            {
               this[prop.name] = undefined;
            }
         }
      }
      
      public function removeClashing(incoming:ITextLayoutFormat) : void
      {
         var prop:Property = null;
         var holderStyles:Object = null;
         var key:* = null;
         if(incoming == null)
         {
            return;
         }
         var holder:TextLayoutFormat = incoming as TextLayoutFormat;
         if(holder)
         {
            holderStyles = holder._styles;
            for(key in holderStyles)
            {
               prop = tlf_internal::description[key];
               if(prop)
               {
                  if(!prop.equalHelper(this._styles[key],holderStyles[key]))
                  {
                     this[key] = undefined;
                  }
               }
               else if(this._styles[key] != holderStyles[key])
               {
                  this.setStyle(key,undefined);
               }
            }
            return;
         }
         for each(prop in TextLayoutFormat.description)
         {
            if(!prop.equalHelper(this._styles[prop.name],incoming[prop.name]))
            {
               this[prop.name] = undefined;
            }
         }
      }
      
      [Inspectable(enumeration="auto,always,inherit")]
      public function get columnBreakBefore() : *
      {
         return this._styles.columnBreakBefore;
      }
      
      public function set columnBreakBefore(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.columnBreakBeforeProperty,value);
      }
      
      [Inspectable(enumeration="auto,always,inherit")]
      public function get columnBreakAfter() : *
      {
         return this._styles.columnBreakAfter;
      }
      
      public function set columnBreakAfter(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.columnBreakAfterProperty,value);
      }
      
      [Inspectable(enumeration="auto,always,inherit")]
      public function get containerBreakBefore() : *
      {
         return this._styles.containerBreakBefore;
      }
      
      public function set containerBreakBefore(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.containerBreakBeforeProperty,value);
      }
      
      [Inspectable(enumeration="auto,always,inherit")]
      public function get containerBreakAfter() : *
      {
         return this._styles.containerBreakAfter;
      }
      
      public function set containerBreakAfter(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.containerBreakAfterProperty,value);
      }
      
      public function get color() : *
      {
         return this._styles.color;
      }
      
      public function set color(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.colorProperty,value);
      }
      
      public function get backgroundColor() : *
      {
         return this._styles.backgroundColor;
      }
      
      public function set backgroundColor(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.backgroundColorProperty,value);
      }
      
      [Inspectable(enumeration="true,false,inherit")]
      public function get lineThrough() : *
      {
         return this._styles.lineThrough;
      }
      
      public function set lineThrough(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.lineThroughProperty,value);
      }
      
      public function get textAlpha() : *
      {
         return this._styles.textAlpha;
      }
      
      public function set textAlpha(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.textAlphaProperty,value);
      }
      
      public function get backgroundAlpha() : *
      {
         return this._styles.backgroundAlpha;
      }
      
      public function set backgroundAlpha(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.backgroundAlphaProperty,value);
      }
      
      public function get fontSize() : *
      {
         return this._styles.fontSize;
      }
      
      public function set fontSize(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.fontSizeProperty,value);
      }
      
      public function get baselineShift() : *
      {
         return this._styles.baselineShift;
      }
      
      public function set baselineShift(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.baselineShiftProperty,value);
      }
      
      public function get trackingLeft() : *
      {
         return this._styles.trackingLeft;
      }
      
      public function set trackingLeft(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.trackingLeftProperty,value);
      }
      
      public function get trackingRight() : *
      {
         return this._styles.trackingRight;
      }
      
      public function set trackingRight(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.trackingRightProperty,value);
      }
      
      public function get lineHeight() : *
      {
         return this._styles.lineHeight;
      }
      
      public function set lineHeight(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.lineHeightProperty,value);
      }
      
      [Inspectable(enumeration="all,any,auto,none,inherit")]
      public function get breakOpportunity() : *
      {
         return this._styles.breakOpportunity;
      }
      
      public function set breakOpportunity(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.breakOpportunityProperty,value);
      }
      
      [Inspectable(enumeration="default,lining,oldStyle,inherit")]
      public function get digitCase() : *
      {
         return this._styles.digitCase;
      }
      
      public function set digitCase(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.digitCaseProperty,value);
      }
      
      [Inspectable(enumeration="default,proportional,tabular,inherit")]
      public function get digitWidth() : *
      {
         return this._styles.digitWidth;
      }
      
      public function set digitWidth(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.digitWidthProperty,value);
      }
      
      [Inspectable(enumeration="auto,roman,ascent,descent,ideographicTop,ideographicCenter,ideographicBottom,inherit")]
      public function get dominantBaseline() : *
      {
         return this._styles.dominantBaseline;
      }
      
      public function set dominantBaseline(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.dominantBaselineProperty,value);
      }
      
      [Inspectable(enumeration="on,off,auto,inherit")]
      public function get kerning() : *
      {
         return this._styles.kerning;
      }
      
      public function set kerning(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.kerningProperty,value);
      }
      
      [Inspectable(enumeration="minimum,common,uncommon,exotic,inherit")]
      public function get ligatureLevel() : *
      {
         return this._styles.ligatureLevel;
      }
      
      public function set ligatureLevel(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.ligatureLevelProperty,value);
      }
      
      [Inspectable(enumeration="roman,ascent,descent,ideographicTop,ideographicCenter,ideographicBottom,useDominantBaseline,inherit")]
      public function get alignmentBaseline() : *
      {
         return this._styles.alignmentBaseline;
      }
      
      public function set alignmentBaseline(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.alignmentBaselineProperty,value);
      }
      
      public function get locale() : *
      {
         return this._styles.locale;
      }
      
      public function set locale(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.localeProperty,value);
      }
      
      [Inspectable(enumeration="default,capsToSmallCaps,uppercase,lowercase,lowercaseToSmallCaps,inherit")]
      public function get typographicCase() : *
      {
         return this._styles.typographicCase;
      }
      
      public function set typographicCase(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.typographicCaseProperty,value);
      }
      
      public function get fontFamily() : *
      {
         return this._styles.fontFamily;
      }
      
      public function set fontFamily(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.fontFamilyProperty,value);
      }
      
      [Inspectable(enumeration="none,underline,inherit")]
      public function get textDecoration() : *
      {
         return this._styles.textDecoration;
      }
      
      public function set textDecoration(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.textDecorationProperty,value);
      }
      
      [Inspectable(enumeration="normal,bold,inherit")]
      public function get fontWeight() : *
      {
         return this._styles.fontWeight;
      }
      
      public function set fontWeight(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.fontWeightProperty,value);
      }
      
      [Inspectable(enumeration="normal,italic,inherit")]
      public function get fontStyle() : *
      {
         return this._styles.fontStyle;
      }
      
      public function set fontStyle(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.fontStyleProperty,value);
      }
      
      [Inspectable(enumeration="preserve,collapse,inherit")]
      public function get whiteSpaceCollapse() : *
      {
         return this._styles.whiteSpaceCollapse;
      }
      
      public function set whiteSpaceCollapse(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.whiteSpaceCollapseProperty,value);
      }
      
      [Inspectable(enumeration="normal,cff,inherit")]
      public function get renderingMode() : *
      {
         return this._styles.renderingMode;
      }
      
      public function set renderingMode(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.renderingModeProperty,value);
      }
      
      [Inspectable(enumeration="none,horizontalStem,inherit")]
      public function get cffHinting() : *
      {
         return this._styles.cffHinting;
      }
      
      public function set cffHinting(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.cffHintingProperty,value);
      }
      
      [Inspectable(enumeration="device,embeddedCFF,inherit")]
      public function get fontLookup() : *
      {
         return this._styles.fontLookup;
      }
      
      public function set fontLookup(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.fontLookupProperty,value);
      }
      
      [Inspectable(enumeration="rotate0,rotate180,rotate270,rotate90,auto,inherit")]
      public function get textRotation() : *
      {
         return this._styles.textRotation;
      }
      
      public function set textRotation(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.textRotationProperty,value);
      }
      
      public function get textIndent() : *
      {
         return this._styles.textIndent;
      }
      
      public function set textIndent(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.textIndentProperty,value);
      }
      
      public function get paragraphStartIndent() : *
      {
         return this._styles.paragraphStartIndent;
      }
      
      public function set paragraphStartIndent(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.paragraphStartIndentProperty,value);
      }
      
      public function get paragraphEndIndent() : *
      {
         return this._styles.paragraphEndIndent;
      }
      
      public function set paragraphEndIndent(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.paragraphEndIndentProperty,value);
      }
      
      public function get paragraphSpaceBefore() : *
      {
         return this._styles.paragraphSpaceBefore;
      }
      
      public function set paragraphSpaceBefore(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.paragraphSpaceBeforeProperty,value);
      }
      
      public function get paragraphSpaceAfter() : *
      {
         return this._styles.paragraphSpaceAfter;
      }
      
      public function set paragraphSpaceAfter(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.paragraphSpaceAfterProperty,value);
      }
      
      [Inspectable(enumeration="left,right,center,justify,start,end,inherit")]
      public function get textAlign() : *
      {
         return this._styles.textAlign;
      }
      
      public function set textAlign(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.textAlignProperty,value);
      }
      
      [Inspectable(enumeration="left,right,center,justify,start,end,inherit")]
      public function get textAlignLast() : *
      {
         return this._styles.textAlignLast;
      }
      
      public function set textAlignLast(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.textAlignLastProperty,value);
      }
      
      [Inspectable(enumeration="interWord,distribute,inherit")]
      public function get textJustify() : *
      {
         return this._styles.textJustify;
      }
      
      public function set textJustify(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.textJustifyProperty,value);
      }
      
      [Inspectable(enumeration="eastAsian,space,auto,inherit")]
      public function get justificationRule() : *
      {
         return this._styles.justificationRule;
      }
      
      public function set justificationRule(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.justificationRuleProperty,value);
      }
      
      [Inspectable(enumeration="prioritizeLeastAdjustment,pushInKinsoku,pushOutOnly,auto,inherit")]
      public function get justificationStyle() : *
      {
         return this._styles.justificationStyle;
      }
      
      public function set justificationStyle(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.justificationStyleProperty,value);
      }
      
      [Inspectable(enumeration="ltr,rtl,inherit")]
      public function get direction() : *
      {
         return this._styles.direction;
      }
      
      public function set direction(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.directionProperty,value);
      }
      
      public function get wordSpacing() : *
      {
         return this._styles.wordSpacing;
      }
      
      public function set wordSpacing(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.wordSpacingProperty,value);
      }
      
      public function get tabStops() : *
      {
         return this._styles.tabStops;
      }
      
      public function set tabStops(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.tabStopsProperty,value);
      }
      
      [Inspectable(enumeration="romanUp,ideographicTopUp,ideographicCenterUp,ideographicTopDown,ideographicCenterDown,approximateTextField,ascentDescentUp,box,auto,inherit")]
      public function get leadingModel() : *
      {
         return this._styles.leadingModel;
      }
      
      public function set leadingModel(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.leadingModelProperty,value);
      }
      
      public function get columnGap() : *
      {
         return this._styles.columnGap;
      }
      
      public function set columnGap(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.columnGapProperty,value);
      }
      
      public function get paddingLeft() : *
      {
         return this._styles.paddingLeft;
      }
      
      public function set paddingLeft(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.paddingLeftProperty,value);
      }
      
      public function get paddingTop() : *
      {
         return this._styles.paddingTop;
      }
      
      public function set paddingTop(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.paddingTopProperty,value);
      }
      
      public function get paddingRight() : *
      {
         return this._styles.paddingRight;
      }
      
      public function set paddingRight(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.paddingRightProperty,value);
      }
      
      public function get paddingBottom() : *
      {
         return this._styles.paddingBottom;
      }
      
      public function set paddingBottom(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.paddingBottomProperty,value);
      }
      
      public function get columnCount() : *
      {
         return this._styles.columnCount;
      }
      
      public function set columnCount(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.columnCountProperty,value);
      }
      
      public function get columnWidth() : *
      {
         return this._styles.columnWidth;
      }
      
      public function set columnWidth(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.columnWidthProperty,value);
      }
      
      public function get firstBaselineOffset() : *
      {
         return this._styles.firstBaselineOffset;
      }
      
      public function set firstBaselineOffset(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.firstBaselineOffsetProperty,value);
      }
      
      [Inspectable(enumeration="top,middle,bottom,justify,inherit")]
      public function get verticalAlign() : *
      {
         return this._styles.verticalAlign;
      }
      
      public function set verticalAlign(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.verticalAlignProperty,value);
      }
      
      [Inspectable(enumeration="rl,tb,inherit")]
      public function get blockProgression() : *
      {
         return this._styles.blockProgression;
      }
      
      public function set blockProgression(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.blockProgressionProperty,value);
      }
      
      [Inspectable(enumeration="explicit,toFit,inherit")]
      public function get lineBreak() : *
      {
         return this._styles.lineBreak;
      }
      
      public function set lineBreak(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.lineBreakProperty,value);
      }
      
      [Inspectable(enumeration="upperAlpha,lowerAlpha,upperRoman,lowerRoman,none,disc,circle,square,box,check,diamond,hyphen,arabicIndic,bengali,decimal,decimalLeadingZero,devanagari,gujarati,gurmukhi,kannada,persian,thai,urdu,cjkEarthlyBranch,cjkHeavenlyStem,hangul,hangulConstant,hiragana,hiraganaIroha,katakana,katakanaIroha,lowerAlpha,lowerGreek,lowerLatin,upperAlpha,upperGreek,upperLatin,inherit")]
      public function get listStyleType() : *
      {
         return this._styles.listStyleType;
      }
      
      public function set listStyleType(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.listStyleTypeProperty,value);
      }
      
      [Inspectable(enumeration="inside,outside,inherit")]
      public function get listStylePosition() : *
      {
         return this._styles.listStylePosition;
      }
      
      public function set listStylePosition(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.listStylePositionProperty,value);
      }
      
      public function get listAutoPadding() : *
      {
         return this._styles.listAutoPadding;
      }
      
      public function set listAutoPadding(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.listAutoPaddingProperty,value);
      }
      
      [Inspectable(enumeration="start,end,left,right,both,none,inherit")]
      public function get clearFloats() : *
      {
         return this._styles.clearFloats;
      }
      
      public function set clearFloats(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.clearFloatsProperty,value);
      }
      
      public function get styleName() : *
      {
         return this._styles.styleName;
      }
      
      public function set styleName(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.styleNameProperty,value);
      }
      
      public function get linkNormalFormat() : *
      {
         return this._styles.linkNormalFormat;
      }
      
      public function set linkNormalFormat(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.linkNormalFormatProperty,value);
      }
      
      public function get linkActiveFormat() : *
      {
         return this._styles.linkActiveFormat;
      }
      
      public function set linkActiveFormat(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.linkActiveFormatProperty,value);
      }
      
      public function get linkHoverFormat() : *
      {
         return this._styles.linkHoverFormat;
      }
      
      public function set linkHoverFormat(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.linkHoverFormatProperty,value);
      }
      
      public function get listMarkerFormat() : *
      {
         return this._styles.listMarkerFormat;
      }
      
      public function set listMarkerFormat(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.listMarkerFormatProperty,value);
      }
      
      public function get borderLeftWidth() : *
      {
         return this._styles.borderLeftWidth;
      }
      
      public function set borderLeftWidth(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderLeftWidthProperty,value);
      }
      
      public function get borderRightWidth() : *
      {
         return this._styles.borderRightWidth;
      }
      
      public function set borderRightWidth(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderRightWidthProperty,value);
      }
      
      public function get borderTopWidth() : *
      {
         return this._styles.borderTopWidth;
      }
      
      public function set borderTopWidth(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderTopWidthProperty,value);
      }
      
      public function get borderBottomWidth() : *
      {
         return this._styles.borderBottomWidth;
      }
      
      public function set borderBottomWidth(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderBottomWidthProperty,value);
      }
      
      public function get borderLeftColor() : *
      {
         return this._styles.borderLeftColor;
      }
      
      public function set borderLeftColor(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderLeftColorProperty,value);
      }
      
      public function get borderRightColor() : *
      {
         return this._styles.borderRightColor;
      }
      
      public function set borderRightColor(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderRightColorProperty,value);
      }
      
      public function get borderTopColor() : *
      {
         return this._styles.borderTopColor;
      }
      
      public function set borderTopColor(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderTopColorProperty,value);
      }
      
      public function get borderBottomColor() : *
      {
         return this._styles.borderBottomColor;
      }
      
      public function set borderBottomColor(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderBottomColorProperty,value);
      }
      
      public function get borderLeftPriority() : *
      {
         return this._styles.borderLeftPriority;
      }
      
      public function set borderLeftPriority(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderLeftPriorityProperty,value);
      }
      
      public function get borderRightPriority() : *
      {
         return this._styles.borderRightPriority;
      }
      
      public function set borderRightPriority(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderRightPriorityProperty,value);
      }
      
      public function get borderTopPriority() : *
      {
         return this._styles.borderTopPriority;
      }
      
      public function set borderTopPriority(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderTopPriorityProperty,value);
      }
      
      public function get borderBottomPriority() : *
      {
         return this._styles.borderBottomPriority;
      }
      
      public function set borderBottomPriority(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.borderBottomPriorityProperty,value);
      }
      
      public function get marginLeft() : *
      {
         return this._styles.marginLeft;
      }
      
      public function set marginLeft(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.marginLeftProperty,value);
      }
      
      public function get marginRight() : *
      {
         return this._styles.marginRight;
      }
      
      public function set marginRight(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.marginRightProperty,value);
      }
      
      public function get marginTop() : *
      {
         return this._styles.marginTop;
      }
      
      public function set marginTop(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.marginTopProperty,value);
      }
      
      public function get marginBottom() : *
      {
         return this._styles.marginBottom;
      }
      
      public function set marginBottom(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.marginBottomProperty,value);
      }
      
      public function get cellSpacing() : *
      {
         return this._styles.cellSpacing;
      }
      
      public function set cellSpacing(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.cellSpacingProperty,value);
      }
      
      public function get cellPadding() : *
      {
         return this._styles.cellPadding;
      }
      
      public function set cellPadding(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.cellPaddingProperty,value);
      }
      
      public function get tableWidth() : *
      {
         return this._styles.tableWidth;
      }
      
      public function set tableWidth(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.tableWidthProperty,value);
      }
      
      public function get tableColumnWidth() : *
      {
         return this._styles.tableColumnWidth;
      }
      
      public function set tableColumnWidth(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.tableColumnWidthProperty,value);
      }
      
      public function get minCellHeight() : *
      {
         return this._styles.minCellHeight;
      }
      
      public function set minCellHeight(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.minCellHeightProperty,value);
      }
      
      public function get maxCellHeight() : *
      {
         return this._styles.maxCellHeight;
      }
      
      public function set maxCellHeight(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.maxCellHeightProperty,value);
      }
      
      [Inspectable(enumeration="void,above,below,hsides,vsides,lhs,rhs,box,border,inherit")]
      public function get frame() : *
      {
         return this._styles.frame;
      }
      
      public function set frame(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.frameProperty,value);
      }
      
      [Inspectable(enumeration="none,groups,rows,cols,all,inherit")]
      public function get rules() : *
      {
         return this._styles.rules;
      }
      
      public function set rules(value:*) : void
      {
         this.setStyleByProperty(TextLayoutFormat.rulesProperty,value);
      }
   }
}
