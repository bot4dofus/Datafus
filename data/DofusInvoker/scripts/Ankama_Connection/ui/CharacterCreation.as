package Ankama_Connection.ui
{
   import Ankama_Common.Common;
   import Ankama_Connection.Connection;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ColorPicker;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.components.VideoPlayer;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.datacenter.breeds.BreedRole;
   import com.ankamagames.dofus.datacenter.breeds.BreedRoleByBreed;
   import com.ankamagames.dofus.datacenter.breeds.Head;
   import com.ankamagames.dofus.datacenter.communication.NamingRule;
   import com.ankamagames.dofus.datacenter.optionalFeatures.CustomModeBreedSpell;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.LookTypeSoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterCreationAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterDeselectionAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterNameSuggestionRequestAction;
   import com.ankamagames.dofus.logic.game.approach.actions.CharacterRemodelSelectionAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.modules.utils.SpellTooltipSettings;
   import com.ankamagames.dofus.network.enums.CharacterCreationResultEnum;
   import com.ankamagames.dofus.uiApi.ColorApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.MountApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   
   public class CharacterCreation
   {
      
      public static const COLOR_GENERATION_METHODE_NUMBER:int = 3;
      
      private static const TYPE_CREATE:String = "create";
      
      private static const TYPE_REBREED:String = "rebreed";
      
      private static const TYPE_RELOOK:String = "relook";
      
      private static const TYPE_RECOLOR:String = "recolor";
      
      private static const TYPE_RENAME:String = "rename";
      
      private static const TYPE_REGENDER:String = "regender";
      
      private static const MAX_CLASS_SPELLS:uint = 3;
       
      
      public var output:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="MountApi")]
      public var mountApi:MountApi;
      
      [Api(name="ColorApi")]
      public var colorApi:ColorApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      private var _namingRule:NamingRule;
      
      private var _nameArrayByBreedAndGender:Array;
      
      private var _activeModules:Array;
      
      private var _mandatoryModules:Array;
      
      private var _assetsUri:String;
      
      private var _cinematicsUri:String;
      
      private var _currentPage:int = -1;
      
      private var _bRequestCreation:Boolean = false;
      
      private var _creationValidated:Boolean = false;
      
      private var _aColors:Array;
      
      private var _aColorsBase:Object;
      
      private var _colorsArrayByBreedAndGender:Array;
      
      private var _look:TiphonEntityLook;
      
      private var _equipmentSkinsStr:String = "";
      
      private var _gender:int;
      
      private var _breed:int;
      
      private var _name:String;
      
      private var _head:int;
      
      private var _headArrayByBreedAndGender:Array;
      
      private var _direction:int = 3;
      
      private var _initialGender:int;
      
      private var _initialBreed:int;
      
      private var _initialName:String;
      
      private var _initialHead:int;
      
      private var _initialColors:Array;
      
      private var _aBreeds:Array;
      
      private var _aHeads:Array;
      
      private var _aRoles:Array;
      
      private var _aRolesByBreedId:Array;
      
      private var _maxBreedRoles:Number;
      
      private var _componentsList:Dictionary;
      
      private var _breedIndex:int;
      
      private var _aTx_color:Array;
      
      private var _selectedSlot:uint;
      
      private var _overSlot:uint;
      
      private var _frameCount:uint = 0;
      
      private var _currentLook:String;
      
      private var _randomLookColors:Array;
      
      private var _randomColorEntityDisplayers:Array;
      
      private var _randomColorPage:int = -1;
      
      private var _randomInitialized:Boolean = false;
      
      private var _videoSmallIsPlaying:Boolean = false;
      
      private var _videoFullIsPlaying:Boolean = false;
      
      private var _complexityTextures:Array;
      
      private var _createdEasyCharactersBreeds:Vector.<int>;
      
      private var _numEasyBreeds:uint;
      
      private var _lastInputText:String;
      
      private var _skipChange:Boolean;
      
      private var _limitedActiveAndPassiveSpellsActivated:Boolean = false;
      
      public var lbl_screen_title:Label;
      
      public var tx_illuBg:Texture;
      
      public var lbl_breed:Label;
      
      public var lbl_breedSubtitle:Label;
      
      public var tx_breedSymbol:Texture;
      
      public var ed_chara:EntityDisplayer;
      
      public var btn_leftArrow:ButtonContainer;
      
      public var btn_rightArrow:ButtonContainer;
      
      public var btn_showEquipment:ButtonContainer;
      
      public var ctn_left:GraphicContainer;
      
      public var tx_border_frame_ctn_left:Texture;
      
      public var tx_background_ctn_left:Texture;
      
      public var ctr_breedChoice:GraphicContainer;
      
      public var ctr_arrowsBreedChoice:GraphicContainer;
      
      public var lbl_breedComplexity:Label;
      
      public var ctr_stars:GraphicContainer;
      
      public var tx_breedComplexity_0:Texture;
      
      public var tx_breedComplexity_1:Texture;
      
      public var tx_breedComplexity_2:Texture;
      
      public var btn_breedInfo:ButtonContainer;
      
      public var videoPlayerSmall:VideoPlayer;
      
      public var tx_videoPlayerSmallPlay:Texture;
      
      public var tx_videoPlayerFullPlay:Texture;
      
      public var tx_videoPlayerSmallExpand:Texture;
      
      public var ctr_roleItem0:GraphicContainer;
      
      public var tx_role0:Texture;
      
      public var lbl_roleTitle0:Label;
      
      public var lbl_role0:Label;
      
      public var ctr_roleItem1:GraphicContainer;
      
      public var tx_role1:Texture;
      
      public var lbl_roleTitle1:Label;
      
      public var lbl_role1:Label;
      
      public var ctr_roleItem2:GraphicContainer;
      
      public var tx_role2:Texture;
      
      public var lbl_roleTitle2:Label;
      
      public var lbl_role2:Label;
      
      public var btn_breedSex0:ButtonContainer;
      
      public var btn_breedSex1:ButtonContainer;
      
      public var gd_breed:Grid;
      
      public var btn_left:ButtonContainer;
      
      public var btn_right:ButtonContainer;
      
      public var ctr_breedInfos:GraphicContainer;
      
      public var blk_videoPassiveAndActiveMode:GraphicContainer;
      
      public var tx_separator:Texture;
      
      public var ctr_video:GraphicContainer;
      
      public var lbl_title_ctr_breedInfos:Label;
      
      public var texta_breedInfo:TextArea;
      
      public var gd_breedAllRoles:Grid;
      
      public var gd_spells:Grid;
      
      public var btn_close_ctr_breedInfos:ButtonContainer;
      
      public var ctr_breedCustomization:GraphicContainer;
      
      public var ctr_breedPresentation:GraphicContainer;
      
      public var ctr_breedPresentationForPassiveAndActiveMode:GraphicContainer;
      
      public var btn_customSex0:ButtonContainer;
      
      public var btn_customSex1:ButtonContainer;
      
      public var gd_heads:Grid;
      
      public var btn_color0:ButtonContainer;
      
      public var btn_color1:ButtonContainer;
      
      public var btn_color2:ButtonContainer;
      
      public var btn_color3:ButtonContainer;
      
      public var btn_color4:ButtonContainer;
      
      public var btn_reinitColor0:ButtonContainer;
      
      public var btn_reinitColor1:ButtonContainer;
      
      public var btn_reinitColor2:ButtonContainer;
      
      public var btn_reinitColor3:ButtonContainer;
      
      public var btn_reinitColor4:ButtonContainer;
      
      public var tx_color0:Texture;
      
      public var tx_color1:Texture;
      
      public var tx_color2:Texture;
      
      public var tx_color3:Texture;
      
      public var tx_color4:Texture;
      
      public var tx_colorDisabled0:Texture;
      
      public var tx_colorDisabled1:Texture;
      
      public var tx_colorDisabled2:Texture;
      
      public var tx_colorDisabled3:Texture;
      
      public var tx_colorDisabled4:Texture;
      
      public var cp_colorPk:ColorPicker;
      
      public var btn_reinitColor:ButtonContainer;
      
      public var btn_generateColor:ButtonContainer;
      
      public var tx_name:TextureBitmap;
      
      public var input_name:Input;
      
      public var tx_nameRules:Texture;
      
      public var btn_generateName:ButtonContainer;
      
      public var btn_reinitName:ButtonContainer;
      
      public var ctr_hexaColor:GraphicContainer;
      
      public var inp_hexaValue:Input;
      
      public var btn_hexaOk:ButtonContainer;
      
      public var btn_next:ButtonContainer;
      
      public var ctr_btnPrevious:GraphicContainer;
      
      public var btn_previous:ButtonContainer;
      
      public var btn_lbl_btn_next:Label;
      
      public var ctr_videoPlayerFull:GraphicContainer;
      
      public var videoPlayerFull:VideoPlayer;
      
      public var tx_closeVideo:Texture;
      
      public var tx_spellSeparatorForPassiveAndActiveMode:Texture;
      
      public var lbl_activeSpellsForPassiveAndActiveMode:Label;
      
      public var lbl_passiveSpellForPassiveAndActiveMode:Label;
      
      public var slot_passiveSpellForPassiveAndActiveMode:Slot;
      
      public var blk_spellsBlockForPassiveAndActiveMode:GraphicContainer;
      
      public var ctr_activeSpellsForPassiveAndActiveMode:GraphicContainer;
      
      public var ctr_passiveSpellForPassiveAndActiveMode:GraphicContainer;
      
      public var slot_activeSpellForPassiveAndActiveMode_0:Slot;
      
      public var slot_activeSpellForPassiveAndActiveMode_1:Slot;
      
      public var slot_activeSpellForPassiveAndActiveMode_2:Slot;
      
      public var tx_passiveSpellForPassiveAndActiveMode:Texture;
      
      public function CharacterCreation()
      {
         this._nameArrayByBreedAndGender = [];
         this._activeModules = [];
         this._mandatoryModules = [];
         this._colorsArrayByBreedAndGender = [];
         this._headArrayByBreedAndGender = [];
         this._componentsList = new Dictionary(true);
         this._randomLookColors = [];
         this._randomColorEntityDisplayers = [];
         this._createdEasyCharactersBreeds = new Vector.<int>(0);
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var role:BreedRole = null;
         var value:int = 0;
         var breed:Breed = null;
         var head:Head = null;
         var colorI:* = undefined;
         var char:* = undefined;
         var rbb:BreedRoleByBreed = null;
         var character:Object = null;
         var ic:int = 0;
         var colorInt:int = 0;
         var index:int = 0;
         var breedData:Breed = null;
         var breedGenderHeads:Array = null;
         var breedInfo:Breed = null;
         var currentHead:Head = null;
         var lookStrParts:Array = null;
         var lookSkins:Array = null;
         var currentHeadSkins:Array = null;
         var defaultLook:String = null;
         var defaultLookSkins:Array = null;
         var skinStr:String = null;
         var recommendedBreeds:Array = null;
         var b:Breed = null;
         var breedtemp:int = 0;
         var stateText:String = null;
         var stateParams:Array = null;
         this._limitedActiveAndPassiveSpellsActivated = this.configApi.isFeatureWithKeywordEnabled("character.spell.breed.limitedActiveAndPassiveSpells");
         this.ctr_breedInfos.visible = false;
         this.ctr_hexaColor.visible = false;
         this.texta_breedInfo.hideScroll = true;
         this.btn_leftArrow.soundId = SoundEnum.SCROLL_DOWN;
         this.btn_rightArrow.soundId = SoundEnum.SCROLL_UP;
         this.btn_breedSex0.soundId = SoundEnum.CHECKBOX_UNCHECKED;
         this.btn_breedSex1.soundId = SoundEnum.CHECKBOX_CHECKED;
         this.btn_customSex0.soundId = SoundEnum.CHECKBOX_UNCHECKED;
         this.btn_customSex1.soundId = SoundEnum.CHECKBOX_CHECKED;
         this.btn_breedInfo.soundId = SoundEnum.SPEC_BUTTON;
         this.btn_previous.soundId = SoundEnum.CANCEL_BUTTON;
         this.btn_close_ctr_breedInfos.soundId = SoundEnum.CANCEL_BUTTON;
         this.btn_showEquipment.visible = false;
         this.sysApi.addHook(HookList.CharacterCreationResult,this.onCharacterCreationResult);
         this.sysApi.addHook(HookList.CharacterNameSuggestioned,this.onCharacterNameSuggestioned);
         this.sysApi.addHook(HookList.CharacterImpossibleSelection,this.onCharacterImpossibleSelection);
         this.sysApi.addHook(BeriliaHookList.FocusChange,this.onFocusChange);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.tx_nameRules,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_nameRules,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_showEquipment,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_showEquipment,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_generateColor,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_generateColor,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_generateName,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_generateName,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_reinitName,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_reinitName,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_breedComplexity_0,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_breedComplexity_0,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_breedComplexity_1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_breedComplexity_1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_breedComplexity_2,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_breedComplexity_2,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ed_chara,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ed_chara,ComponentHookList.ON_ENTITY_READY);
         this.uiApi.addComponentHook(this.input_name,"onChange");
         this.uiApi.addComponentHook(this.input_name,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_videoPlayerSmallExpand,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_videoPlayerSmallExpand,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_videoPlayerSmallExpand,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_closeVideo,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_closeVideo,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_closeVideo,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.videoPlayerFull,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.videoPlayerSmall,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_left,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_right,ComponentHookList.ON_RELEASE);
         this._complexityTextures = [];
         this._complexityTextures.push(this.tx_breedComplexity_0);
         this._complexityTextures.push(this.tx_breedComplexity_1);
         this._complexityTextures.push(this.tx_breedComplexity_2);
         this.tx_videoPlayerSmallExpand.handCursor = true;
         this.tx_closeVideo.handCursor = true;
         this.videoPlayerSmall.mute = true;
         if(params && params[0] is Array && params[1] is Array)
         {
            this._activeModules = params[0];
            this._mandatoryModules = params[1];
         }
         else
         {
            this._activeModules.push(TYPE_CREATE);
         }
         if(params && params.length > 3 && params[3])
         {
            for each(char in params[3])
            {
               if(char.breed.complexity == 1 && this._createdEasyCharactersBreeds.indexOf(char.breed.id) == -1)
               {
                  this._createdEasyCharactersBreeds.push(char.breed.id);
               }
            }
         }
         this._assetsUri = this.uiApi.me().getConstant("breed_uri");
         this._cinematicsUri = this.sysApi.getConfigEntry("config.gfx.path.cinematic");
         this.btn_generateName.y = 8;
         this.btn_generateName.x = 345;
         if(this.sysApi.getPlayerManager().hasRights)
         {
            this._namingRule = this.sysApi.getCurrentServer().community.namingRuleAdmin;
         }
         else
         {
            this._namingRule = this.sysApi.getCurrentServer().community.namingRulePlayerName;
         }
         this.input_name.maxChars = this._namingRule.maxLength;
         this._aTx_color = new Array(this.tx_color0,this.tx_color1,this.tx_color2,this.tx_color3,this.tx_color4);
         this._aColors = new Array(-1,-1,-1,-1,-1);
         this._aColorsBase = [-1,-1,-1,-1,-1];
         this._initialColors = new Array(-1,-1,-1,-1,-1);
         this._aRoles = [];
         for each(role in this.dataApi.getBreedRoles())
         {
            this._aRoles[role.id] = role;
         }
         this._aBreeds = [];
         this._aRolesByBreedId = [];
         this._maxBreedRoles = 0;
         for each(breed in this.dataApi.getBreeds())
         {
            if(breed.complexity == 1)
            {
               ++this._numEasyBreeds;
            }
            if((Math.pow(2,breed.id - 1) & Connection.BREEDS_VISIBLE) > 0)
            {
               this._aBreeds.push(breed);
               this._aRolesByBreedId[breed.id] = [];
               for each(rbb in breed.breedRoles)
               {
                  if(this._maxBreedRoles < rbb.value)
                  {
                     this._maxBreedRoles = rbb.value;
                  }
                  this._aRolesByBreedId[breed.id][rbb.roleId] = {
                     "id":rbb.roleId,
                     "name":this._aRoles[rbb.roleId].name,
                     "color":this._aRoles[rbb.roleId].color,
                     "value":rbb.value,
                     "description":rbb.description,
                     "assetId":this._aRoles[rbb.roleId].assetId,
                     "order":rbb.order
                  };
               }
            }
         }
         this._aBreeds.sortOn(["complexity","sortIndex"],[Array.NUMERIC,Array.NUMERIC]);
         this.gd_breed.dataProvider = this._aBreeds;
         this.videoPlayerSmall.filters = [new GlowFilter(this.sysApi.getConfigEntry("colors.text.glow.light"),1,12,12,1)];
         this._aHeads = [];
         for each(head in this.dataApi.getHeads())
         {
            this._aHeads.push(head);
         }
         if(params && params[2])
         {
            character = params[2];
            this._gender = int(character.gender);
            this._breed = character.breed;
            this._name = character.name;
            this._head = character.cosmeticId;
            this._initialGender = int(character.gender);
            this._initialBreed = character.breed;
            this._initialName = character.name;
            this._initialHead = character.cosmeticId;
            this.input_name.text = this._name;
            if(!this._nameArrayByBreedAndGender[this._breed])
            {
               this._nameArrayByBreedAndGender[this._breed] = [];
            }
            this._nameArrayByBreedAndGender[this._breed][this._gender] = this._name;
            ic = 0;
            for each(colorInt in character.colors)
            {
               this._aColors[ic] = colorInt;
               this._initialColors[ic] = colorInt;
               ic++;
            }
            if(!this._colorsArrayByBreedAndGender[this._breed])
            {
               this._colorsArrayByBreedAndGender[this._breed] = [];
            }
            this._colorsArrayByBreedAndGender[this._breed][this._gender] = this._aColors;
            this._look = this.mountApi.getRiderEntityLook(character.entityLook);
            this.ed_chara.clearSubEntities = false;
            index = 0;
            for each(breedData in this._aBreeds)
            {
               if(breedData.id == this._breed)
               {
                  this._breedIndex = index;
                  break;
               }
               index++;
            }
            this.gd_breed.selectedIndex = this._breedIndex;
            breedGenderHeads = [];
            for each(head in this._aHeads)
            {
               if(head.breed == this._breed && head.gender == this._gender)
               {
                  breedGenderHeads.push(head);
               }
            }
            breedGenderHeads.sortOn("order",Array.NUMERIC);
            this.gd_heads.dataProvider = breedGenderHeads;
            this.getHeadFromLook();
            index = 0;
            for each(head in this.gd_heads.dataProvider)
            {
               if(head.id == this._head)
               {
                  this.gd_heads.selectedIndex = index;
                  break;
               }
               index++;
            }
            if(!this._headArrayByBreedAndGender[this._breed])
            {
               this._headArrayByBreedAndGender[this._breed] = [];
            }
            this._headArrayByBreedAndGender[this._breed][this._gender] = this._head;
            if(this._look.getBone() != 1)
            {
               this._look = null;
               this.btn_showEquipment.softDisabled = true;
               this.btn_showEquipment.selected = false;
            }
            else
            {
               this.btn_showEquipment.selected = true;
               breedInfo = this._aBreeds[this._breedIndex];
               currentHead = this.dataApi.getHead(this._head);
               lookStrParts = this._look.toString().split("|");
               lookSkins = lookStrParts[1].split(",");
               currentHeadSkins = currentHead.skins.split(",");
               if(this._gender == 0)
               {
                  defaultLook = breedInfo.maleLook;
               }
               else
               {
                  defaultLook = breedInfo.femaleLook;
               }
               defaultLookSkins = defaultLook.split("|")[1].split(",");
               for each(skinStr in lookSkins)
               {
                  if(defaultLookSkins.indexOf(skinStr) == -1 && currentHeadSkins.indexOf(skinStr) == -1)
                  {
                     this._equipmentSkinsStr += skinStr + ",";
                  }
               }
               if(this._equipmentSkinsStr != "")
               {
                  this._equipmentSkinsStr = this._equipmentSkinsStr.slice(0,this._equipmentSkinsStr.length - 1);
               }
            }
         }
         else
         {
            this._gender = Math.round(Math.random());
            recommendedBreeds = [];
            if(this._createdEasyCharactersBreeds.length == this._numEasyBreeds)
            {
               for each(b in this._aBreeds)
               {
                  if(b.complexity > 1)
                  {
                     recommendedBreeds.push(b.id);
                  }
               }
            }
            else
            {
               for each(b in this._aBreeds)
               {
                  if(b.complexity == 1 && this._createdEasyCharactersBreeds.indexOf(b.id) == -1)
                  {
                     recommendedBreeds.push(b.id);
                  }
               }
            }
            breedtemp = -1;
            if(Connection.BREEDS_AVAILABLE > 0)
            {
               do
               {
                  breedtemp = Math.floor(Math.random() * this._aBreeds.length);
               }
               while(recommendedBreeds.indexOf(this._aBreeds[breedtemp].id) == -1 || (Math.pow(2,this._aBreeds[breedtemp].id - 1) & Connection.BREEDS_AVAILABLE) <= 0);
               
               this.gd_breed.selectedIndex = breedtemp;
               stateText = this.sysApi.getData("characterCreationState");
               if(stateText && stateText.length)
               {
                  stateParams = stateText.split("_");
                  if(recommendedBreeds.indexOf(int(stateParams[1])) != -1)
                  {
                     stateParams[1] = this._aBreeds[breedtemp].id;
                     this.sysApi.setData("characterCreationState",stateParams.join("_"));
                  }
               }
            }
            else
            {
               this.gd_breed.selectedIndex = -1;
            }
            this.gd_heads.selectedIndex = 0;
         }
         if(this._activeModules.indexOf(TYPE_CREATE) != -1)
         {
            this.input_name.textfield.addEventListener(TextEvent.TEXT_INPUT,this.onInput);
            if(!this.reloadPreviousUiState())
            {
               this.displayPage(0);
            }
            this.updateInputName();
         }
         else
         {
            if(this._activeModules.indexOf(TYPE_REBREED) != -1)
            {
               this.displayPage(0);
            }
            else
            {
               this.displayPage(1);
            }
            if(this._activeModules.indexOf(TYPE_RECOLOR) != -1 || this._activeModules.indexOf(TYPE_RELOOK) != -1 || this._activeModules.indexOf(TYPE_REBREED) != -1)
            {
               this.btn_showEquipment.visible = true;
            }
            if(this._activeModules.indexOf(TYPE_RENAME) != -1)
            {
               this.input_name.textfield.addEventListener(TextEvent.TEXT_INPUT,this.onInput);
            }
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.charcrea.characterModificationWarning"),[this.uiApi.getText("ui.common.ok")]);
         }
         for(colorI in this._aColors)
         {
            if(this._aTx_color[colorI])
            {
               this.changeColor(this._aTx_color[colorI],this._aColors[colorI]);
            }
         }
         this.uiApi.setRadioGroupSelectedItem("colorGroup",this.btn_color0,this.uiApi.me());
         this.switchMode();
         this.updateRolesAndVideoPosition();
         if(this._limitedActiveAndPassiveSpellsActivated)
         {
            this.lbl_breed.x = 150;
            this.lbl_breed.y = 25;
            this.ctr_stars.visible = false;
            this.lbl_breedComplexity.visible = false;
            this.lbl_breedSubtitle.visible = false;
         }
         else
         {
            this.ctr_stars.x = this.lbl_breedComplexity.x + this.lbl_breedComplexity.textWidth + 15;
            this.lbl_breed.x = 150;
            this.lbl_breed.y = 0;
            this.lbl_breedSubtitle.visible = true;
         }
      }
      
      public function setCharacterUIForPassiveAndActiveMode() : void
      {
         var border:DisplayObject = (this.ctn_left.getChildAt(0) as DisplayObjectContainer).getChildByName("tx_border_frame_ctn_left");
         var background:DisplayObject = (this.ctn_left.getChildAt(0) as DisplayObjectContainer).getChildByName("tx_background_ctn_left");
         this.ctn_left.y = 300;
         if(this.ctn_left.height != 333)
         {
            this.ctn_left.height = 333;
         }
         if(border && border.height != 333)
         {
            border.height = 333;
         }
         if(background && background.height != 290)
         {
            background.height = 290;
         }
         this.ctr_btnPrevious.y = -447;
      }
      
      public function setCharacterUI() : void
      {
         var border:DisplayObject = (this.ctn_left.getChildAt(0) as DisplayObjectContainer).getChildByName("tx_border_frame_ctn_left");
         var background:DisplayObject = (this.ctn_left.getChildAt(0) as DisplayObjectContainer).getChildByName("tx_background_ctn_left");
         this.ctn_left.y = 100;
         if(this.ctn_left.height != 780)
         {
            this.ctn_left.height = 780;
         }
         if(border && border.height != 780)
         {
            border.height = 780;
         }
         if(background && background.height != 736)
         {
            background.height = 736;
         }
         this.ctr_btnPrevious.y = 0;
      }
      
      public function unload() : void
      {
         this.sysApi.removeEventListener(this.onEnterFrame);
         this.saveCharacterModifications();
         this.input_name.textfield.removeEventListener(TextEvent.TEXT_INPUT,this.onInput);
         this.videoPlayerSmall.stop();
         this.videoPlayerFull.stop();
      }
      
      private function saveCharacterModifications() : void
      {
         var creationStateText:* = null;
         var breedH:* = undefined;
         var breedN:* = undefined;
         var breedC:* = undefined;
         var genderH:* = undefined;
         var genderN:* = undefined;
         var genderC:* = undefined;
         var colorC:* = undefined;
         if(this._activeModules.indexOf(TYPE_CREATE) != -1)
         {
            if(!this._creationValidated)
            {
               creationStateText = this._currentPage + "_" + this._breed + "_" + this._gender + "_";
               for(breedH in this._headArrayByBreedAndGender)
               {
                  creationStateText += breedH;
                  for(genderH in this._headArrayByBreedAndGender[breedH])
                  {
                     creationStateText += "$" + genderH;
                     creationStateText += "#" + this._headArrayByBreedAndGender[breedH][genderH];
                  }
                  creationStateText += "§";
               }
               creationStateText += "_";
               for(breedN in this._nameArrayByBreedAndGender)
               {
                  creationStateText += breedN;
                  for(genderN in this._nameArrayByBreedAndGender[breedN])
                  {
                     creationStateText += "$" + genderN;
                     creationStateText += "#" + this._nameArrayByBreedAndGender[breedN][genderN];
                  }
                  creationStateText += "§";
               }
               creationStateText += "_";
               for(breedC in this._colorsArrayByBreedAndGender)
               {
                  creationStateText += breedC;
                  for(genderC in this._colorsArrayByBreedAndGender[breedC])
                  {
                     creationStateText += "$" + genderC;
                     for each(colorC in this._colorsArrayByBreedAndGender[breedC][genderC])
                     {
                        creationStateText += "#" + colorC;
                     }
                  }
                  creationStateText += "§";
               }
               this.sysApi.setData("characterCreationState",creationStateText);
            }
            else
            {
               this.sysApi.setData("characterCreationState","");
            }
         }
      }
      
      private function reloadPreviousUiState() : Boolean
      {
         var breedIndexH:* = undefined;
         var breedIndexN:* = undefined;
         var breedIndexC:* = undefined;
         var breedIndex:int = 0;
         var i:* = undefined;
         var genderIndexH:* = undefined;
         var genderIndexN:* = undefined;
         var genderIndex:* = undefined;
         var colorsIndex:int = 0;
         var stateText:String = this.sysApi.getData("characterCreationState");
         if(!stateText || stateText == "")
         {
            return false;
         }
         var params:Array = stateText.split("_");
         var page:int = Math.max(params[0],0);
         var breed:int = params[1];
         var gender:int = params[2];
         var headBreed:Array = (params[3] as String).split("§");
         var headGender:Array = [];
         var heads:Array = [];
         var nameBreed:Array = (params[4] as String).split("§");
         var nameGender:Array = [];
         var names:Array = [];
         var colorsBreed:Array = (params[5] as String).split("§");
         var colorsGender:Array = [];
         var colors:Array = [];
         this.displayPage(page);
         if(this._gender != gender)
         {
            this._gender = gender;
         }
         for(breedIndexH in headBreed)
         {
            if(headBreed[breedIndexH] != "")
            {
               headGender = (headBreed[breedIndexH] as String).split("$");
               this._headArrayByBreedAndGender[int(headGender[0])] = [];
               for(genderIndexH in headGender)
               {
                  heads = (headGender[genderIndexH] as String).split("#");
                  this._headArrayByBreedAndGender[int(headGender[0])][int(heads[0])] = int(heads[1]);
                  this._head = int(heads[1]);
               }
            }
         }
         for(breedIndexN in nameBreed)
         {
            if(nameBreed[breedIndexN] != "")
            {
               nameGender = (nameBreed[breedIndexN] as String).split("$");
               this._nameArrayByBreedAndGender[int(nameGender[0])] = [];
               for(genderIndexN in nameGender)
               {
                  names = (nameGender[genderIndexN] as String).split("#");
                  this._nameArrayByBreedAndGender[int(nameGender[0])][int(names[0])] = names[1];
                  this._name = names[1];
               }
            }
         }
         for(breedIndexC in colorsBreed)
         {
            if(colorsBreed[breedIndexC] != "")
            {
               colorsGender = (colorsBreed[breedIndexC] as String).split("$");
               this._colorsArrayByBreedAndGender[int(colorsGender[0])] = [];
               for(genderIndex in colorsGender)
               {
                  colors = (colorsGender[genderIndex] as String).split("#");
                  this._colorsArrayByBreedAndGender[int(colorsGender[0])][int(colors[0])] = [];
                  for(colorsIndex = 1; colorsIndex < colors.length; colorsIndex++)
                  {
                     (this._colorsArrayByBreedAndGender[int(colorsGender[0])][int(colors[0])] as Array).push(int(colors[colorsIndex]));
                  }
               }
            }
         }
         breedIndex = -1;
         for(i in this.gd_breed.dataProvider)
         {
            if(this.gd_breed.dataProvider[i].id == breed)
            {
               breedIndex = i;
               break;
            }
         }
         if(breedIndex > -1)
         {
            this.gd_breed.selectedIndex = breedIndex;
            this._breedIndex = i;
            this._aColors = this.getBreedGenderColors();
         }
         return true;
      }
      
      private function updateInputName() : void
      {
         if(this._nameArrayByBreedAndGender[this._breed] && this._nameArrayByBreedAndGender[this._breed][this._gender])
         {
            this.input_name.text = this._nameArrayByBreedAndGender[this._breed][this._gender];
         }
         else
         {
            this.input_name.text = this.uiApi.getText("ui.charcrea.titleRename");
         }
      }
      
      private function getBreedGenderColors() : Array
      {
         if(this._colorsArrayByBreedAndGender[this._breed] && this._colorsArrayByBreedAndGender[this._breed][this._gender] && this._colorsArrayByBreedAndGender[this._breed][this._gender].length > 0)
         {
            return this._colorsArrayByBreedAndGender[this._breed][this._gender];
         }
         return [-1,-1,-1,-1,-1];
      }
      
      private function displayPage(index:int) : void
      {
         var colorIndex:* = undefined;
         if(index == this._currentPage)
         {
            return;
         }
         this.ctn_left.visible = true;
         if(index == 0)
         {
            if(this._limitedActiveAndPassiveSpellsActivated)
            {
               this.setCharacterUIForPassiveAndActiveMode();
            }
            else
            {
               this.setCharacterUI();
            }
            for(colorIndex in this._aColorsBase)
            {
               if(this._aColors[colorIndex] == this._aColorsBase[colorIndex])
               {
                  this.resetColor(colorIndex);
               }
            }
            this.btn_lbl_btn_next.text = this.uiApi.getText("ui.charcrea.selectClass");
            this.ctr_breedChoice.visible = true;
            this.ctr_arrowsBreedChoice.visible = true;
            this.ctr_breedCustomization.visible = false;
            this.ctr_breedPresentation.visible = !this._limitedActiveAndPassiveSpellsActivated;
            this.ctr_breedPresentationForPassiveAndActiveMode.visible = this._limitedActiveAndPassiveSpellsActivated;
            if(this._limitedActiveAndPassiveSpellsActivated)
            {
               this.setCharacterUIForPassiveAndActiveMode();
            }
            this.blk_videoPassiveAndActiveMode.visible = !this._limitedActiveAndPassiveSpellsActivated;
            this.tx_separator.visible = !this._limitedActiveAndPassiveSpellsActivated;
            this.ctr_video.visible = !this._limitedActiveAndPassiveSpellsActivated;
            if(this.ctr_video.visible)
            {
               this.videoPlayerSmall.play();
               this.videoPlayerSmall.resume();
               this._videoSmallIsPlaying = true;
               this._videoFullIsPlaying = true;
            }
            this.lbl_screen_title.text = this.uiApi.getText("ui.charcrea.choseClass");
            if(Connection.getInstance().charactersCount == 0)
            {
               this.ctr_btnPrevious.visible = false;
            }
            else
            {
               this.ctr_btnPrevious.visible = true;
            }
         }
         else
         {
            this.setCharacterUI();
            for(colorIndex in this._aColorsBase)
            {
               if(this._aColors[colorIndex] == -1)
               {
                  this._aColors[colorIndex] = this._aColorsBase[colorIndex];
               }
            }
            this.closeBreedInfo();
            this.btn_lbl_btn_next.text = this.uiApi.getText("ui.common.play");
            this.ctr_breedChoice.visible = false;
            this.ctr_arrowsBreedChoice.visible = false;
            this.ctr_breedCustomization.visible = true;
            this.ctr_breedPresentation.visible = false;
            this.ctr_breedPresentationForPassiveAndActiveMode.visible = false;
            this.ctr_video.visible = false;
            this.lbl_screen_title.text = this.uiApi.getText("ui.charcrea.personalized");
            this.ctr_videoPlayerFull.visible = false;
            this.videoPlayerSmall.pause();
            this.videoPlayerFull.pause();
            this._videoSmallIsPlaying = false;
            this._videoFullIsPlaying = false;
            if(this._activeModules.indexOf(TYPE_REGENDER) == -1 && this._activeModules.indexOf(TYPE_REBREED) == -1)
            {
               this.updateInputName();
            }
            this.ctr_btnPrevious.visible = true;
         }
         this.tx_videoPlayerSmallPlay.visible = false;
         this.tx_videoPlayerFullPlay.visible = false;
         this._currentPage = index;
      }
      
      private function switchMode() : void
      {
         if(this._activeModules.indexOf(TYPE_CREATE) != -1)
         {
            return;
         }
         this.gd_breed.disabled = true;
         this.btn_breedInfo.disabled = true;
         this.btn_breedSex0.disabled = true;
         this.btn_customSex0.disabled = true;
         this.btn_breedSex1.disabled = true;
         this.btn_customSex1.disabled = true;
         this.btn_color0.disabled = true;
         this.btn_color1.disabled = true;
         this.btn_color2.disabled = true;
         this.btn_color3.disabled = true;
         this.btn_color4.disabled = true;
         this.tx_colorDisabled0.visible = true;
         this.tx_colorDisabled1.visible = true;
         this.tx_colorDisabled2.visible = true;
         this.tx_colorDisabled3.visible = true;
         this.tx_colorDisabled4.visible = true;
         this.btn_reinitColor0.visible = false;
         this.btn_reinitColor1.visible = false;
         this.btn_reinitColor2.visible = false;
         this.btn_reinitColor3.visible = false;
         this.btn_reinitColor4.visible = false;
         this.cp_colorPk.disabled = true;
         this.btn_reinitColor.disabled = true;
         this.btn_generateColor.disabled = true;
         this.gd_heads.disabled = true;
         this.input_name.disabled = true;
         this.tx_name.disabled = true;
         this.btn_generateName.disabled = true;
         this.btn_reinitName.visible = false;
         this.btn_showEquipment.visible = false;
         if(this._activeModules.indexOf(TYPE_RENAME) != -1)
         {
            this.input_name.width = 288;
            this.input_name.disabled = false;
            this.tx_name.disabled = false;
            this.btn_generateName.disabled = false;
            this.btn_generateName.x = 316;
            this.btn_reinitName.visible = true;
         }
         if(this._activeModules.indexOf(TYPE_RELOOK) != -1)
         {
            this.gd_heads.disabled = false;
            this.btn_showEquipment.visible = true;
         }
         if(this._activeModules.indexOf(TYPE_RECOLOR) != -1)
         {
            this.btn_color0.disabled = false;
            this.btn_color1.disabled = false;
            this.btn_color2.disabled = false;
            this.btn_color3.disabled = false;
            this.btn_color4.disabled = false;
            this.tx_colorDisabled0.visible = false;
            this.tx_colorDisabled1.visible = false;
            this.tx_colorDisabled2.visible = false;
            this.tx_colorDisabled3.visible = false;
            this.tx_colorDisabled4.visible = false;
            this.btn_reinitColor0.visible = true;
            this.btn_reinitColor1.visible = true;
            this.btn_reinitColor2.visible = true;
            this.btn_reinitColor3.visible = true;
            this.btn_reinitColor4.visible = true;
            this.cp_colorPk.disabled = false;
            this.btn_reinitColor.disabled = false;
            this.btn_generateColor.disabled = false;
            this.btn_showEquipment.visible = true;
         }
         if(this._activeModules.indexOf(TYPE_REBREED) != -1)
         {
            this.gd_breed.disabled = false;
            this.btn_breedInfo.disabled = false;
            this.btn_showEquipment.visible = true;
         }
         if(this._activeModules.indexOf(TYPE_REGENDER) != -1)
         {
            this.btn_breedSex0.disabled = false;
            this.btn_customSex0.disabled = false;
            this.btn_breedSex1.disabled = false;
            this.btn_customSex1.disabled = false;
            this.btn_showEquipment.visible = true;
         }
      }
      
      private function displayCharacter() : void
      {
         var colorChanged:Boolean = false;
         var colorIndex:* = undefined;
         var currentHead:Head = null;
         var hexaColor:String = null;
         var lookStr:String = "";
         var artworkLookStr:* = "";
         if(this._activeModules.indexOf(TYPE_CREATE) != -1)
         {
            for(colorIndex in this._aColorsBase)
            {
               if(this._aColors[colorIndex] != this._aColorsBase[colorIndex])
               {
                  colorChanged = true;
                  break;
               }
            }
            if(!colorChanged)
            {
               this._aColors = [-1,-1,-1,-1,-1];
            }
         }
         var breedInfo:Breed = this._aBreeds[this._breedIndex];
         if(this._gender == 0)
         {
            lookStr = breedInfo.maleLook;
            artworkLookStr = "{" + breedInfo.maleArtwork + "}";
            this._aColorsBase = breedInfo.maleColors;
         }
         else
         {
            lookStr = breedInfo.femaleLook;
            artworkLookStr = "{" + breedInfo.femaleArtwork + "}";
            this._aColorsBase = breedInfo.femaleColors;
         }
         var colorStr:String = "";
         for(colorIndex in this._aColors)
         {
            if(this._aColors[colorIndex] != -1)
            {
               hexaColor = this._aColors[colorIndex].toString(16);
            }
            else if(this._aColorsBase && this._aColorsBase.length > colorIndex)
            {
               hexaColor = this._aColorsBase[colorIndex].toString(16);
               this.changeColor(this["tx_color" + colorIndex],this._aColorsBase[colorIndex]);
            }
            else
            {
               hexaColor = (Math.random() * 16777215).toString(16);
            }
            colorStr += colorIndex + 1 + "=#" + hexaColor + ",";
         }
         colorStr = colorStr.substring(0,colorStr.length - 1);
         currentHead = this.dataApi.getHead(this._head);
         if(currentHead && currentHead.skins && currentHead.skins != "0")
         {
            lookStr = lookStr.replace("||","," + currentHead.skins + "||");
         }
         lookStr = lookStr.replace("||","|" + colorStr + "|");
         artworkLookStr = artworkLookStr.replace("}","||" + colorStr + "}");
         if(!this.btn_showEquipment.disabled && !this.btn_showEquipment.softDisabled && this.btn_showEquipment.visible)
         {
            this.displayEquipment(lookStr);
         }
         else
         {
            this.ed_chara.look = this.sysApi.getEntityLookFromString(lookStr);
         }
         this.updateDirection(this._direction);
         this._currentLook = lookStr;
         this.tx_illuBg.uri = this.uiApi.createUri(this._assetsUri + "bg_" + this._breed + "" + this._gender + ".jpg");
      }
      
      private function colorizeCharacter() : void
      {
         var color:* = undefined;
         var hasChangedColors:Boolean = false;
         for(color in this._aColors)
         {
            if(this._aColors[color] != -1)
            {
               this.ed_chara.setColor(color + 1,this._aColors[color]);
               hasChangedColors = true;
            }
            else if(this._aColorsBase.length > color)
            {
               this.ed_chara.setColor(color + 1,this._aColorsBase[color]);
            }
         }
         if(hasChangedColors)
         {
            if(!this._colorsArrayByBreedAndGender[this._breed])
            {
               this._colorsArrayByBreedAndGender[this._breed] = [];
            }
            this._colorsArrayByBreedAndGender[this._breed][this._gender] = this._aColors;
            this.saveCharacterModifications();
         }
      }
      
      private function generateColors() : void
      {
         var generatedColor:Array = null;
         var i:int = 0;
         var tempArray:Array = null;
         var limit:int = 0;
         var j:int = 0;
         var x:int = 0;
         var y:int = 0;
         var slide:int = 0;
         switch(this._breed)
         {
            case 12:
               y = Math.random() * 750 + 250;
               if(y > 750)
               {
                  x = Math.random() * 1000;
               }
               else
               {
                  x = Math.random() * 90 + 50;
               }
               slide = Math.random() * 100;
               break;
            case 6:
               x = Math.random() * 140 + 25;
               y = Math.random() * 700 + 200;
               slide = Math.random() * 80 + 10;
               break;
            default:
               x = Math.random() * 90 + 50;
               y = Math.random() * 650 + 250;
               slide = Math.random() * 80 + 10;
         }
         var color:uint = this.getColorByXYSlideX(x,y,slide);
         var pageArray:Array = [];
         for(i = 0; i <= COLOR_GENERATION_METHODE_NUMBER; i++)
         {
            tempArray = [];
            tempArray[0] = color;
            generatedColor = this.colorApi.generateColorList(i);
            limit = Math.min(4,generatedColor.length);
            for(j = 0; j < limit; j++)
            {
               tempArray[j + 1] = generatedColor[j];
            }
            pageArray.push(tempArray);
         }
         this._randomLookColors.push(pageArray);
         this._randomColorPage = this._randomLookColors.length - 1;
         this.updateRandomColorLook();
      }
      
      private function changeRandomPage(pageNumber:int) : void
      {
         if(pageNumber == 99)
         {
            pageNumber = 0;
         }
         else if(pageNumber == -1)
         {
            pageNumber = 99;
         }
         this._randomColorPage = pageNumber;
         this._randomLookColors.length = 0;
         this.generateColors();
      }
      
      private function getHeadFromLook() : void
      {
         var head:Head = null;
         var lookStrParts:Array = this._look.toString().split("|");
         for each(head in this._aHeads)
         {
            if(head.breed == this._breed && head.gender == this._gender)
            {
               if(lookStrParts[1] && lookStrParts[1].indexOf(head.skins) != -1)
               {
                  if(this._activeModules.indexOf(TYPE_CREATE) != -1 || this._activeModules.indexOf(TYPE_RELOOK) != -1)
                  {
                     this._head = head.id;
                  }
                  if(!this._headArrayByBreedAndGender[this._breed])
                  {
                     this._headArrayByBreedAndGender[this._breed] = [];
                  }
                  this._headArrayByBreedAndGender[this._breed][this._gender] = this._head;
                  return;
               }
            }
         }
      }
      
      public function updateBreed(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(!this._componentsList[componentsRef.ctr_breed.name])
         {
            this.uiApi.addComponentHook(componentsRef.ctr_breed,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.ctr_breed,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.ctr_breed.name] = data;
         if(data)
         {
            if(data.id < 10)
            {
               componentsRef.tx_breed.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "vignettingMiniCharacter/" + "mini_" + data.id + "_" + this._gender + ".png");
            }
            else
            {
               componentsRef.tx_breed.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "vignettingMiniCharacter/" + "mini_" + data.id + "_" + this._gender + ".png");
            }
            if(selected)
            {
               componentsRef.tx_selected.visible = true;
               componentsRef.tx_selected_arrow.visible = true;
            }
            else
            {
               componentsRef.tx_selected.visible = false;
               componentsRef.tx_selected_arrow.visible = false;
            }
            if(Connection.BREEDS_AVAILABLE > 0 && (Math.pow(2,data.id - 1) & Connection.BREEDS_AVAILABLE) > 0 && data.id != this._initialBreed)
            {
               componentsRef.tx_grey.visible = false;
            }
            else
            {
               componentsRef.tx_grey.visible = true;
            }
         }
         else
         {
            componentsRef.tx_selected_arrow.visible = false;
         }
      }
      
      public function updateHead(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(!this._componentsList[componentsRef.btn_head.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_head,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.btn_head,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.btn_head.name] = data;
         if(data)
         {
            componentsRef.tx_head.uri = this.uiApi.createUri(this.uiApi.me().getConstant("heads_uri") + data.assetId + ".png");
            componentsRef.tx_hselected.visible = selected;
         }
      }
      
      public function updateInfoRole(data:*, componentsRef:*, selected:Boolean) : void
      {
         var percent:Number = NaN;
         if(!this._componentsList[componentsRef.lbl_role.name])
         {
            this.uiApi.addComponentHook(componentsRef.lbl_role,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.lbl_role,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.lbl_role.name] = data;
         if(data)
         {
            componentsRef.lbl_role.text = data.name;
            componentsRef.tx_roleSmall.uri = this.uiApi.createUri(this.uiApi.me().getConstant("breed_uri") + "icon_caracteristics/role_" + data.assetId + ".png");
            percent = data.value / this._maxBreedRoles;
            if(percent > 1)
            {
               percent = 1;
            }
            componentsRef.pb_progressBar.barColor = data.color;
            componentsRef.pb_progressBar.value = percent;
         }
      }
      
      public function updatePreviewLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(!this._componentsList[componentsRef.btn_randomLook.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_randomLook,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.btn_randomLook,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.btn_randomLook.name] = data;
         if(data && this._randomColorEntityDisplayers.length <= 6)
         {
            this._randomColorEntityDisplayers.push(componentsRef.ed_charPreview);
         }
      }
      
      private function displayComplexity(value:int) : void
      {
         var uriGreen:Uri = this.uiApi.createUri(this.uiApi.me().getConstant("star_green_uri"));
         var uriBlack:Uri = this.uiApi.createUri(this.uiApi.me().getConstant("star_black_uri"));
         for(var index:int = 0; index < this._complexityTextures.length; index++)
         {
            this._complexityTextures[index].uri = value <= index ? uriBlack : uriGreen;
         }
      }
      
      private function displayBreedWithPassiveAndActiveModeSpells() : void
      {
         var index:uint = 0;
         var fileName:* = null;
         var minX:int = 0;
         var currentActiveSpellSlot:Slot = null;
         var maxSize:int = 0;
         var maxX:int = 0;
         var containerWidth:int = 0;
         if(this._currentPage === 0)
         {
            this.setCharacterUIForPassiveAndActiveMode();
         }
         else
         {
            this.setCharacterUI();
         }
         this.ctr_breedPresentation.visible = false;
         this.ctr_video.x = 5;
         this.ctr_video.y = 287;
         this.tx_breedSymbol.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "symbol_" + this._breed + ".png");
         this.updateGender(this._gender);
         if(!this._aBreeds[this._breedIndex])
         {
            this.lbl_breed.text = "?";
            this.texta_breedInfo.text = "?";
            this.lbl_title_ctr_breedInfos.text = "?";
         }
         else
         {
            this.lbl_breed.text = (this._aBreeds[this._breedIndex].shortName as String).toLocaleUpperCase();
            if(this.lbl_breed.textWidth + 10 > this.lbl_breed.width)
            {
               this.lbl_breed.cssClass = "whitebigboldshadow";
            }
            else
            {
               this.lbl_breed.cssClass = "whitehugeboldshadow";
            }
            this.lbl_title_ctr_breedInfos.text = this._aBreeds[this._breedIndex].longName;
            this.lbl_title_ctr_breedInfos.forceUppercase = true;
            this.texta_breedInfo.text = this._aBreeds[this._breedIndex].description;
         }
         if(!this._limitedActiveAndPassiveSpellsActivated)
         {
            fileName = this._cinematicsUri + "class_" + this._aBreeds[this._breedIndex].id + ".mp4";
            this.videoPlayerSmall.flv = fileName;
            this.videoPlayerFull.flv = fileName;
            if(this.ctr_videoPlayerFull.visible)
            {
               this.videoPlayerFull.play();
               this._videoFullIsPlaying = true;
               this.tx_videoPlayerFullPlay.visible = false;
               this.videoPlayerSmall.play();
               this.videoPlayerSmall.pause();
            }
            else
            {
               this.videoPlayerSmall.play();
               this._videoSmallIsPlaying = true;
               this.tx_videoPlayerSmallPlay.visible = false;
            }
         }
         this.lbl_passiveSpellForPassiveAndActiveMode.fullWidth();
         this.lbl_passiveSpellForPassiveAndActiveMode.width += 5;
         this.lbl_activeSpellsForPassiveAndActiveMode.fullWidth();
         this.lbl_activeSpellsForPassiveAndActiveMode.width += 5;
         this.uiApi.removeComponentHook(this.slot_passiveSpellForPassiveAndActiveMode,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(this.slot_passiveSpellForPassiveAndActiveMode,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(this.slot_activeSpellForPassiveAndActiveMode_0,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(this.slot_activeSpellForPassiveAndActiveMode_0,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(this.slot_activeSpellForPassiveAndActiveMode_1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(this.slot_activeSpellForPassiveAndActiveMode_1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.removeComponentHook(this.slot_activeSpellForPassiveAndActiveMode_2,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.removeComponentHook(this.slot_activeSpellForPassiveAndActiveMode_2,ComponentHookList.ON_ROLL_OUT);
         var breedSpells:Array = this.playerApi.getCustomModeBreedSpellList(this._breed);
         if(breedSpells === null)
         {
            breedSpells = [];
         }
         var currentCustomModeBreedSpell:CustomModeBreedSpell = null;
         var currentSpellWrapper:SpellWrapper = null;
         var activeSpells:Array = [];
         var passiveSpell:SpellWrapper = null;
         for(index = 0; index < breedSpells.length; index++)
         {
            currentCustomModeBreedSpell = breedSpells[index];
            if(currentCustomModeBreedSpell !== null)
            {
               currentSpellWrapper = this.dataApi.getSpellWrapper(currentCustomModeBreedSpell.id);
               if(currentSpellWrapper !== null)
               {
                  if(currentCustomModeBreedSpell.isInitialSpell && !currentCustomModeBreedSpell.isHidden)
                  {
                     passiveSpell = currentSpellWrapper;
                  }
                  else if(!currentCustomModeBreedSpell.isHidden)
                  {
                     activeSpells.push(currentSpellWrapper);
                  }
               }
            }
         }
         var isPassiveSpell:* = passiveSpell !== null;
         var areActiveSpells:* = activeSpells.length > 0;
         if(isPassiveSpell)
         {
            this.ctr_passiveSpellForPassiveAndActiveMode.visible = true;
            this.slot_passiveSpellForPassiveAndActiveMode.data = passiveSpell;
            if(areActiveSpells)
            {
               this.lbl_passiveSpellForPassiveAndActiveMode.x = this.blk_spellsBlockForPassiveAndActiveMode.x + (this.tx_spellSeparatorForPassiveAndActiveMode.x - this.blk_spellsBlockForPassiveAndActiveMode.x) / 2 - this.lbl_passiveSpellForPassiveAndActiveMode.width / 2;
               this.slot_passiveSpellForPassiveAndActiveMode.x = this.blk_spellsBlockForPassiveAndActiveMode.x + (this.tx_spellSeparatorForPassiveAndActiveMode.x - this.blk_spellsBlockForPassiveAndActiveMode.x) / 2 - this.slot_passiveSpellForPassiveAndActiveMode.width / 2;
               this.tx_passiveSpellForPassiveAndActiveMode.x = this.blk_spellsBlockForPassiveAndActiveMode.x + (this.tx_spellSeparatorForPassiveAndActiveMode.x - this.blk_spellsBlockForPassiveAndActiveMode.x) / 2 - this.tx_passiveSpellForPassiveAndActiveMode.width / 2;
               this.lbl_activeSpellsForPassiveAndActiveMode.x = this.tx_spellSeparatorForPassiveAndActiveMode.x + this.tx_spellSeparatorForPassiveAndActiveMode.width + (this.blk_spellsBlockForPassiveAndActiveMode.x + this.blk_spellsBlockForPassiveAndActiveMode.width - this.tx_spellSeparatorForPassiveAndActiveMode.x) / 2 - this.lbl_activeSpellsForPassiveAndActiveMode.width / 2;
            }
            else
            {
               this.lbl_passiveSpellForPassiveAndActiveMode.x = this.blk_spellsBlockForPassiveAndActiveMode.x + this.blk_spellsBlockForPassiveAndActiveMode.width / 2 - this.lbl_passiveSpellForPassiveAndActiveMode.width / 2;
               this.slot_passiveSpellForPassiveAndActiveMode.x = this.blk_spellsBlockForPassiveAndActiveMode.x + this.blk_spellsBlockForPassiveAndActiveMode.width / 2 - this.slot_passiveSpellForPassiveAndActiveMode.width / 2;
               this.tx_passiveSpellForPassiveAndActiveMode.x = this.blk_spellsBlockForPassiveAndActiveMode.x + this.blk_spellsBlockForPassiveAndActiveMode.width / 2 - this.tx_passiveSpellForPassiveAndActiveMode.width / 2;
            }
            this.uiApi.addComponentHook(this.slot_passiveSpellForPassiveAndActiveMode,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.slot_passiveSpellForPassiveAndActiveMode,ComponentHookList.ON_ROLL_OUT);
            this._componentsList[this.slot_passiveSpellForPassiveAndActiveMode.name] = passiveSpell;
         }
         else
         {
            this.ctr_passiveSpellForPassiveAndActiveMode.visible = false;
            this.lbl_activeSpellsForPassiveAndActiveMode.x = this.blk_spellsBlockForPassiveAndActiveMode.x + this.blk_spellsBlockForPassiveAndActiveMode.width / 2 - this.lbl_activeSpellsForPassiveAndActiveMode.width / 2;
         }
         if(areActiveSpells)
         {
            this.ctr_activeSpellsForPassiveAndActiveMode.visible = true;
            this.tx_spellSeparatorForPassiveAndActiveMode.visible = true;
            this.lbl_activeSpellsForPassiveAndActiveMode.visible = true;
            this.ctr_activeSpellsForPassiveAndActiveMode.visible = true;
            minX = this.slot_activeSpellForPassiveAndActiveMode_0.x;
            currentActiveSpellSlot = null;
            maxSize = Math.min(activeSpells.length,MAX_CLASS_SPELLS);
            if(maxSize > 0)
            {
               for(index = 0; index < maxSize; index++)
               {
                  currentActiveSpellSlot = this["slot_activeSpellForPassiveAndActiveMode_" + index];
                  if(currentActiveSpellSlot !== null)
                  {
                     currentActiveSpellSlot.parent.visible = true;
                     currentActiveSpellSlot.data = activeSpells[index];
                     this.uiApi.addComponentHook(currentActiveSpellSlot,ComponentHookList.ON_ROLL_OVER);
                     this.uiApi.addComponentHook(currentActiveSpellSlot,ComponentHookList.ON_ROLL_OUT);
                     this._componentsList[currentActiveSpellSlot.name] = activeSpells[index];
                  }
               }
               maxX = currentActiveSpellSlot.x + currentActiveSpellSlot.width;
               containerWidth = maxX - minX;
               if(isPassiveSpell)
               {
                  this.tx_spellSeparatorForPassiveAndActiveMode.visible = true;
                  this.ctr_activeSpellsForPassiveAndActiveMode.x = this.tx_spellSeparatorForPassiveAndActiveMode.x + this.tx_spellSeparatorForPassiveAndActiveMode.width + (this.blk_spellsBlockForPassiveAndActiveMode.x + this.blk_spellsBlockForPassiveAndActiveMode.width - this.tx_spellSeparatorForPassiveAndActiveMode.x) / 2 - containerWidth / 2;
               }
               else
               {
                  this.ctr_activeSpellsForPassiveAndActiveMode.x = this.blk_spellsBlockForPassiveAndActiveMode.x + this.blk_spellsBlockForPassiveAndActiveMode.width / 2 - containerWidth / 2;
                  this.tx_spellSeparatorForPassiveAndActiveMode.visible = false;
               }
               for(index = maxSize; index < MAX_CLASS_SPELLS; index++)
               {
                  currentActiveSpellSlot = this["slot_activeSpellForPassiveAndActiveMode_" + index];
                  if(currentActiveSpellSlot !== null)
                  {
                     currentActiveSpellSlot.parent.visible = false;
                  }
               }
            }
         }
         else
         {
            this.tx_spellSeparatorForPassiveAndActiveMode.visible = false;
            this.lbl_activeSpellsForPassiveAndActiveMode.visible = false;
            this.ctr_activeSpellsForPassiveAndActiveMode.visible = false;
         }
      }
      
      private function displayBreed() : void
      {
         var brbb:Object = null;
         var i:int = 0;
         var spells:Array = null;
         var id:* = undefined;
         var fileName:* = null;
         this.ctr_video.x = 5;
         this.ctr_video.y = 470;
         this.ctr_breedPresentation.visible = !this._limitedActiveAndPassiveSpellsActivated && this._currentPage == 0;
         this.ctr_breedPresentationForPassiveAndActiveMode.visible = false;
         this.tx_breedSymbol.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "symbol_" + this._breed + ".png");
         var sortedRoles:Array = [];
         var allRoles:Array = [];
         for each(brbb in this._aRolesByBreedId[this._breed])
         {
            if(brbb.order > 0)
            {
               sortedRoles.push(brbb);
            }
            allRoles.push(brbb);
         }
         sortedRoles.sortOn("order",Array.NUMERIC);
         for(i = 0; i < 3; i++)
         {
            this["tx_role" + i].uri = this.uiApi.createUri(this.uiApi.me().getConstant("breed_uri") + "icon_caracteristics/role_" + sortedRoles[i].assetId + ".png");
            this["lbl_roleTitle" + i].text = (sortedRoles[i].name as String).toLocaleUpperCase();
            this["lbl_role" + i].text = sortedRoles[i].description;
         }
         this.updateRolesAndVideoPosition();
         this.gd_breedAllRoles.dataProvider = allRoles;
         this.updateGender(this._gender);
         if(!this._aBreeds[this._breedIndex])
         {
            this.lbl_breed.text = "?";
            this.lbl_breedSubtitle.text = "?";
            this.texta_breedInfo.text = "?";
            this.lbl_title_ctr_breedInfos.text = "?";
            this.displayComplexity(0);
         }
         else
         {
            this.lbl_breed.text = (this._aBreeds[this._breedIndex].shortName as String).toLocaleUpperCase();
            if(this.lbl_breed.textWidth + 10 > this.lbl_breed.width)
            {
               this.lbl_breed.cssClass = "whitebigboldshadow";
            }
            else
            {
               this.lbl_breed.cssClass = "whitehugeboldshadow";
            }
            this.lbl_breedSubtitle.text = this._aBreeds[this._breedIndex].gameplayDescription;
            this.displayComplexity(this._aBreeds[this._breedIndex].complexity);
            this.lbl_title_ctr_breedInfos.text = this._aBreeds[this._breedIndex].longName;
            this.lbl_title_ctr_breedInfos.forceUppercase = true;
            this.texta_breedInfo.text = this._aBreeds[this._breedIndex].description;
            spells = [];
            for each(id in this._aBreeds[this._breedIndex].breedSpellsId)
            {
               spells.push(this.dataApi.getSpellWrapper(id));
            }
            this.gd_spells.dataProvider = spells;
         }
         if(!this._limitedActiveAndPassiveSpellsActivated)
         {
            fileName = this._cinematicsUri + "class_" + this._aBreeds[this._breedIndex].id + ".mp4";
            this.videoPlayerSmall.flv = fileName;
            this.videoPlayerFull.flv = fileName;
            if(this.ctr_videoPlayerFull.visible)
            {
               this.videoPlayerFull.play();
               this._videoFullIsPlaying = true;
               this.tx_videoPlayerFullPlay.visible = false;
               this.videoPlayerSmall.play();
               this.videoPlayerSmall.pause();
            }
            else
            {
               this.videoPlayerSmall.play();
               this._videoSmallIsPlaying = true;
               this.tx_videoPlayerSmallPlay.visible = false;
            }
         }
      }
      
      private function updateRolesAndVideoPosition() : void
      {
         this.uiApi.me().render();
      }
      
      private function updateGender(nGender:int, force:Boolean = false) : void
      {
         var head:Head = null;
         var tx_color_counter:uint = 0;
         if(force || nGender == 0 && !this.btn_breedSex0.selected && !this.btn_customSex0.selected || nGender == 1 && !this.btn_breedSex1.selected && !this.btn_customSex1.selected)
         {
            this._gender = nGender;
            if(nGender == 0)
            {
               this.uiApi.setRadioGroupSelectedItem("genderGroupBreed",this.btn_breedSex0,this.uiApi.me());
               this.uiApi.setRadioGroupSelectedItem("genderGroupCustom",this.btn_customSex0,this.uiApi.me());
            }
            else
            {
               this.uiApi.setRadioGroupSelectedItem("genderGroupBreed",this.btn_breedSex1,this.uiApi.me());
               this.uiApi.setRadioGroupSelectedItem("genderGroupCustom",this.btn_customSex1,this.uiApi.me());
            }
            this.gd_breed.dataProvider = this._aBreeds;
         }
         if(this._activeModules.indexOf(TYPE_REGENDER) == -1 && this._activeModules.indexOf(TYPE_REBREED) == -1)
         {
            this._aColors = this.getBreedGenderColors();
            if(this._aColors)
            {
               for(tx_color_counter = 0; tx_color_counter < 5; tx_color_counter++)
               {
                  this.changeColor(this["tx_color" + tx_color_counter],this._aColors[tx_color_counter]);
               }
            }
            this.updateInputName();
         }
         var breedGenderHeads:Array = [];
         var i:int = 0;
         var headIndex:int = 0;
         for each(head in this._aHeads)
         {
            if(head.breed == this._breed && head.gender == this._gender)
            {
               breedGenderHeads.push(head);
               if(this._headArrayByBreedAndGender[this._breed] && (this._headArrayByBreedAndGender[this._breed][this._gender] && (this._headArrayByBreedAndGender[this._breed][this._gender] > 0 && head.id == this._headArrayByBreedAndGender[this._breed][this._gender])))
               {
                  headIndex = i;
               }
               i++;
            }
         }
         if(breedGenderHeads.length > 0)
         {
            breedGenderHeads.sortOn("order",Array.NUMERIC);
            this._head = breedGenderHeads[headIndex].id;
            this.gd_heads.dataProvider = breedGenderHeads;
            this.gd_heads.silent = true;
            this.gd_heads.selectedIndex = headIndex;
            this.gd_heads.silent = false;
         }
         this.displayCharacter();
         this.cp_colorPk.color = this._aColors[this._selectedSlot] == -1 ? uint(this._aColorsBase[this._selectedSlot]) : uint(this._aColors[this._selectedSlot]);
      }
      
      private function createCharacter() : void
      {
         var reason:String = null;
         var remodelErrorText:String = null;
         var ic:int = 0;
         var nbSimilarColors:int = 0;
         var colorInt:int = 0;
         var vectColors:Vector.<int> = null;
         var c:int = 0;
         if(Connection.BREEDS_AVAILABLE == 0)
         {
            return;
         }
         var nameError:uint = 0;
         if(this._activeModules.indexOf(TYPE_CREATE) != -1 || this._activeModules.indexOf(TYPE_RENAME) != -1)
         {
            this._name = this.input_name.text;
            nameError = this.verifName();
         }
         if(!this._name || this._name == "" || this._name == this.uiApi.getText("ui.charcrea.titleRename"))
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.charcrea.choseName"),[this.uiApi.getText("ui.common.ok")]);
            this._bRequestCreation = false;
            this.btn_next.disabled = false;
            return;
         }
         if(nameError > 0)
         {
            reason = this.uiApi.getText("ui.popup.charcrea.invalidName") + "\n\n" + this.uiApi.getText("ui.charcrea.invalidNameReason" + nameError);
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),reason,[this.uiApi.getText("ui.common.ok")]);
            this._bRequestCreation = false;
            this.btn_next.disabled = false;
            return;
         }
         if(this._activeModules.indexOf(TYPE_CREATE) == -1)
         {
            remodelErrorText = "";
            if(this._mandatoryModules.indexOf(TYPE_RENAME) != -1 && this._name == this._initialName)
            {
               remodelErrorText = this.uiApi.getText("ui.charcrea.mandatoryName");
            }
            if(this._mandatoryModules.indexOf(TYPE_RECOLOR) != -1)
            {
               ic = 0;
               nbSimilarColors = 0;
               for each(colorInt in this._aColors)
               {
                  if(this._aColors[ic] == this._initialColors[ic])
                  {
                     nbSimilarColors++;
                  }
                  ic++;
               }
               if(nbSimilarColors == ic)
               {
                  remodelErrorText = this.uiApi.getText("ui.charcrea.mandatoryColors");
               }
            }
            if(this._mandatoryModules.indexOf(TYPE_RELOOK) != -1 && this._head == this._initialHead)
            {
               remodelErrorText = this.uiApi.getText("ui.charcrea.mandatoryHead");
            }
            if(this._mandatoryModules.indexOf(TYPE_REGENDER) != -1 && this._gender == this._initialGender)
            {
               remodelErrorText = this.uiApi.getText("ui.charcrea.mandatoryGender");
            }
            if(this._mandatoryModules.indexOf(TYPE_REBREED) != -1 && this._breed == this._initialBreed)
            {
               remodelErrorText = this.uiApi.getText("ui.charcrea.mandatoryBreed");
            }
            if(remodelErrorText != "")
            {
               reason = this.uiApi.getText("ui.charcrea.invalidNameReason" + nameError);
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),remodelErrorText,[this.uiApi.getText("ui.common.ok")]);
               this._bRequestCreation = false;
               this.btn_next.disabled = false;
               return;
            }
         }
         Connection.waitingForCharactersList = true;
         this.lockCreation();
         if(this._activeModules.indexOf(TYPE_CREATE) != -1)
         {
            this.sysApi.sendAction(new CharacterCreationAction([this._name,this._breed,this._gender != 0,this._aColors,this._head]));
         }
         else
         {
            vectColors = new Vector.<int>();
            for each(c in this._aColors)
            {
               vectColors.push(c);
            }
            this.sysApi.sendAction(new CharacterRemodelSelectionAction([0,this._gender != 0,this._breed,this._head,this._name,vectColors]));
         }
      }
      
      private function changeColor(obj:Object, color:Number = 16777215) : void
      {
         var t:ColorTransform = null;
         if(color != -1)
         {
            t = new ColorTransform();
            t.color = color;
            obj.transform.colorTransform = t;
            obj.visible = true;
            this.ed_chara.setColor(this._aColors.indexOf(color),this._aColors[color]);
         }
         else
         {
            obj.visible = false;
            this.ed_chara.resetColor(color + 1);
         }
      }
      
      private function wheelChara(sens:int) : void
      {
         var dir:int = (this._direction + sens + 8) % 8;
         this.updateDirection(dir);
      }
      
      private function resetColor(colorIndex:int = -1) : void
      {
         var entry:* = undefined;
         var i:* = undefined;
         var isCleared:Boolean = false;
         var colorCheck:int = 0;
         if(colorIndex == -1)
         {
            for(i in this._aTx_color)
            {
               this._aColors[i] = -1;
               this.changeColor(this._aTx_color[i],this._aColorsBase[i]);
            }
            this.cp_colorPk.color = this._aColorsBase[this._selectedSlot];
            if(this._colorsArrayByBreedAndGender[this._breed] && this._colorsArrayByBreedAndGender[this._breed][this._gender])
            {
               delete this._colorsArrayByBreedAndGender[this._breed][this._gender];
               if(!this._colorsArrayByBreedAndGender[this._breed][0] && !this._colorsArrayByBreedAndGender[this._breed][1])
               {
                  delete this._colorsArrayByBreedAndGender[this._breed];
               }
            }
         }
         else
         {
            this._aColors[colorIndex] = -1;
            this.changeColor(this._aTx_color[colorIndex],this._aColorsBase[colorIndex]);
            if(this._selectedSlot == colorIndex)
            {
               this.cp_colorPk.color = this._aColorsBase[this._selectedSlot];
            }
            if(this._colorsArrayByBreedAndGender[this._breed] && this._colorsArrayByBreedAndGender[this._breed][this._gender])
            {
               (this._colorsArrayByBreedAndGender[this._breed][this._gender] as Array)[colorIndex] = -1;
               isCleared = true;
               for each(colorCheck in this._colorsArrayByBreedAndGender[this._breed][this._gender])
               {
                  if(colorCheck != -1)
                  {
                     isCleared = false;
                  }
               }
               if(isCleared)
               {
                  delete this._colorsArrayByBreedAndGender[this._breed][this._gender];
               }
            }
         }
         var empty:Boolean = true;
         var _loc7_:int = 0;
         var _loc8_:* = this._colorsArrayByBreedAndGender;
         for each(entry in _loc8_)
         {
            empty = false;
         }
         if(empty)
         {
            this._colorsArrayByBreedAndGender = [];
         }
         this.colorizeCharacter();
         this.saveCharacterModifications();
      }
      
      private function verifName() : uint
      {
         if(this._name.length < this._namingRule.minLength)
         {
            this.sysApi.log(8,this._name + " trop court");
            return 1;
         }
         if(this._name.length > this._namingRule.maxLength)
         {
            this.sysApi.log(8,this._name + " trop long");
            return 1;
         }
         if(this._name.charAt(this._name.length - 1) == "-")
         {
            return 8;
         }
         if(this._name == this._initialName)
         {
            return 0;
         }
         var regexp:RegExp = new RegExp(this._namingRule.regexp,"g");
         if(!regexp.test(this._name))
         {
            this.sysApi.log(8,this._name + " ne respecte pas les regles : " + this._namingRule.regexp);
            return 2;
         }
         return 0;
      }
      
      private function pickColor(index:uint) : void
      {
         var position:int = 0;
         var colorIndex:* = undefined;
         this._selectedSlot = index;
         if(this.uiApi.keyIsDown(16))
         {
            if(this._aColors[index] != -1)
            {
               this.inp_hexaValue.text = this._aColors[index].toString(16);
            }
            else
            {
               this.inp_hexaValue.text = "";
            }
            this.ctr_hexaColor.visible = true;
            this.inp_hexaValue.focus();
            position = this.inp_hexaValue.text.length;
            this.inp_hexaValue.setSelection(position,position);
         }
         else
         {
            this.cp_colorPk.color = this._aColors[index] == -1 ? uint(this._aColorsBase[index]) : uint(this._aColors[index]);
            for(colorIndex in this._aColorsBase)
            {
               if(this._aColors[colorIndex] == this._aColorsBase[colorIndex])
               {
                  this._aColors[colorIndex] = -1;
               }
            }
         }
      }
      
      private function updateDirection(direction:int) : void
      {
         var e:EntityDisplayer = null;
         if(direction % 2 == 0 && this.ed_chara.animation == "AnimAttaque0")
         {
            this._direction = (direction + 1) % 8;
         }
         else
         {
            this._direction = direction;
         }
         this.ed_chara.direction = this._direction;
         for each(e in this._randomColorEntityDisplayers)
         {
            e.direction = this._direction;
         }
      }
      
      private function updateRandomColorLook() : void
      {
         this._aColors = this._randomLookColors[this._randomColorPage][0].concat();
         for(var i:int = 0; i < this._aTx_color.length; i++)
         {
            this.changeColor(this._aTx_color[i],this._aColors[i]);
         }
         this.colorizeCharacter();
      }
      
      private function displayEquipment(lookStr:String = "") : void
      {
         var i:int = 0;
         var skinsWithoutEquipment:String = null;
         if(this._equipmentSkinsStr == "")
         {
            if(lookStr != "")
            {
               this.ed_chara.look = lookStr;
            }
            return;
         }
         var look:String = lookStr != "" ? lookStr : this.ed_chara.look.toString();
         var lookStrParts:Array = look.split("|");
         if(this.btn_showEquipment.selected)
         {
            if(lookStrParts[1].indexOf(this._equipmentSkinsStr) != -1)
            {
               return;
            }
            look = lookStrParts[0] + "|" + lookStrParts[1] + "," + this._equipmentSkinsStr;
            for(i = 2; i < lookStrParts.length; i++)
            {
               look += "|" + lookStrParts[i];
            }
         }
         else
         {
            skinsWithoutEquipment = lookStrParts[1].toString().replace("," + this._equipmentSkinsStr,"");
            look = lookStrParts[0] + "|" + skinsWithoutEquipment;
            for(i = 2; i < lookStrParts.length; i++)
            {
               look += "|" + lookStrParts[i];
            }
         }
         this.ed_chara.look = look;
      }
      
      public function lockCreation() : void
      {
         this.btn_next.disabled = true;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var color:uint = 0;
         switch(target)
         {
            case this.btn_generateName:
               if(!this._bRequestCreation)
               {
                  this.sysApi.sendAction(new CharacterNameSuggestionRequestAction([]));
               }
               break;
            case this.btn_reinitName:
               if(!this._bRequestCreation)
               {
                  this.input_name.text = this._initialName;
               }
               break;
            case this.btn_generateColor:
               if(this._randomLookColors.length < 100)
               {
                  this.generateColors();
               }
               else
               {
                  this.changeRandomPage(0);
               }
               if(this._aColors[this._selectedSlot] != -1)
               {
                  this.cp_colorPk.color = this._aColors[this._selectedSlot];
               }
               break;
            case this.btn_reinitColor:
               this.resetColor();
               if(this._aColors[this._selectedSlot] != -1)
               {
                  this.cp_colorPk.color = this._aColors[this._selectedSlot];
               }
               break;
            case this.btn_leftArrow:
               this.wheelChara(-1);
               break;
            case this.btn_rightArrow:
               this.wheelChara(1);
               break;
            case this.btn_breedSex0:
            case this.btn_customSex0:
               if(this._gender != 0)
               {
                  this._direction = 3;
                  this.updateGender(0,true);
               }
               break;
            case this.btn_breedSex1:
            case this.btn_customSex1:
               if(this._gender != 1)
               {
                  this._direction = 3;
                  this.updateGender(1,true);
               }
               break;
            case this.tx_closeVideo:
               this.ctr_videoPlayerFull.visible = false;
               if(this._videoSmallIsPlaying)
               {
                  this.videoPlayerSmall.resume();
               }
               this.videoPlayerFull.pause();
               this.soundApi.fadeBusVolume(0,1,0);
               break;
            case this.tx_videoPlayerSmallExpand:
               this.videoPlayerSmall.pause();
               this.videoPlayerFull.resume();
               this.videoPlayerFull.play();
               this._videoFullIsPlaying = true;
               this.tx_videoPlayerFullPlay.visible = false;
               this.ctr_videoPlayerFull.visible = true;
               this.soundApi.fadeBusVolume(0,0,0);
               break;
            case this.videoPlayerSmall:
               if(this.ctr_videoPlayerFull.visible)
               {
                  return;
               }
               if(this._videoSmallIsPlaying)
               {
                  this.videoPlayerSmall.pause();
               }
               else
               {
                  this.videoPlayerSmall.resume();
               }
               this._videoSmallIsPlaying = !this._videoSmallIsPlaying;
               this.tx_videoPlayerSmallPlay.visible = !this._videoSmallIsPlaying;
               break;
            case this.videoPlayerFull:
               if(this._videoFullIsPlaying)
               {
                  this.videoPlayerFull.pause();
               }
               else
               {
                  this.videoPlayerFull.resume();
               }
               this._videoFullIsPlaying = !this._videoFullIsPlaying;
               this.tx_videoPlayerFullPlay.visible = !this._videoFullIsPlaying;
               break;
            case this.btn_color0:
               this.pickColor(0);
               break;
            case this.btn_color1:
               this.pickColor(1);
               break;
            case this.btn_color2:
               this.pickColor(2);
               break;
            case this.btn_color3:
               this.pickColor(3);
               break;
            case this.btn_color4:
               this.pickColor(4);
               break;
            case this.btn_reinitColor0:
               this.resetColor(0);
               break;
            case this.btn_reinitColor1:
               this.resetColor(1);
               break;
            case this.btn_reinitColor2:
               this.resetColor(2);
               break;
            case this.btn_reinitColor3:
               this.resetColor(3);
               break;
            case this.btn_reinitColor4:
               this.resetColor(4);
               break;
            case this.btn_hexaOk:
               color = int("0x" + this.inp_hexaValue.text);
               this.onColorChange(new Object(),color);
               this.cp_colorPk.color = color;
               this.saveCharacterModifications();
               break;
            case this.btn_breedInfo:
               this.ctr_breedInfos.visible = !this.ctr_breedInfos.visible;
               break;
            case this.btn_close_ctr_breedInfos:
               this.closeBreedInfo();
               break;
            case this.btn_previous:
               this.soundApi.fadeBusVolume(0,1,0);
               if(this._currentPage == 1)
               {
                  this.displayPage(0);
               }
               else
               {
                  this.sysApi.sendAction(new CharacterDeselectionAction([]));
                  Connection.getInstance().openPreviousUi();
               }
               break;
            case this.btn_next:
               this.soundApi.fadeBusVolume(0,1,0);
               if(this._currentPage == 0)
               {
                  this.displayPage(1);
                  if(this._aColors[this._selectedSlot] != -1)
                  {
                     this.cp_colorPk.color = this._aColors[this._selectedSlot];
                  }
               }
               else if(!this._bRequestCreation)
               {
                  this._bRequestCreation = true;
                  this.createCharacter();
               }
               break;
            case this.btn_showEquipment:
               this.displayEquipment();
               this.onRollOver(target);
               break;
            case this.btn_left:
               --this._breedIndex;
               if(this._breedIndex < 0)
               {
                  this._breedIndex = this.gd_breed.dataProvider.length - 1;
               }
               this.gd_breed.selectedIndex = this._breedIndex;
               break;
            case this.btn_right:
               this._breedIndex = (this._breedIndex + 1) % this.gd_breed.dataProvider.length;
               this.gd_breed.selectedIndex = this._breedIndex;
               break;
            case this.input_name:
               if(this.uiApi.getText("ui.charcrea.titleRename") == this.input_name.text)
               {
                  this.input_name.text = "";
               }
         }
         if(target != this.input_name && this.input_name && this.input_name.text.length == 0)
         {
            this.input_name.text = this.uiApi.getText("ui.charcrea.titleRename");
         }
      }
      
      public function onFocusChange(pTarget:Object) : void
      {
         if(pTarget && pTarget != this.input_name && this.input_name.text.length <= 0)
         {
            this.input_name.text = this.uiApi.getText("ui.charcrea.titleRename");
         }
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_leftArrow:
               this.wheelChara(-1);
               break;
            case this.btn_rightArrow:
               this.wheelChara(1);
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var numBreed:int = 0;
         var textkey:String = null;
         var breed:Breed = null;
         if(selectMethod != GridItemSelectMethodEnum.AUTO)
         {
            if(target == this.gd_breed)
            {
               this._breedIndex = this.gd_breed.selectedIndex;
               this._direction = 3;
               breed = this._aBreeds[this._breedIndex];
               if(!breed)
               {
                  return;
               }
               numBreed = breed.id;
               if(this._activeModules.indexOf(TYPE_CREATE) == -1 || Connection.BREEDS_AVAILABLE > 0 && (Math.pow(2,numBreed - 1) & Connection.BREEDS_AVAILABLE) > 0)
               {
                  if(numBreed)
                  {
                     this._breed = numBreed;
                     if(this._activeModules.indexOf(TYPE_REGENDER) == -1 && this._activeModules.indexOf(TYPE_REBREED) == -1)
                     {
                        this._aColors = this.getBreedGenderColors();
                     }
                     if(this._limitedActiveAndPassiveSpellsActivated)
                     {
                        this.displayBreedWithPassiveAndActiveModeSpells();
                     }
                     else
                     {
                        this.displayBreed();
                     }
                  }
               }
               else
               {
                  textkey = "ui.charcrea.breedNotAvailable";
                  if(numBreed == DataEnum.BREED_PANDAWA || numBreed == DataEnum.BREED_ROGUE || numBreed == DataEnum.BREED_MASQUERAIDER)
                  {
                     textkey += "." + numBreed;
                  }
                  this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText(textkey),[this.uiApi.getText("ui.common.ok")],null,null,null,null,false,true);
                  this.gd_breed.selectedIndex = 0;
               }
            }
            else if(target == this.gd_heads)
            {
               this._head = this.gd_heads.selectedItem.id;
               if(!this._headArrayByBreedAndGender[this._breed])
               {
                  this._headArrayByBreedAndGender[this._breed] = [];
               }
               this._headArrayByBreedAndGender[this._breed][this._gender] = this._head;
               this.saveCharacterModifications();
               this.displayCharacter();
            }
         }
      }
      
      public function onEntityReady(target:Object) : void
      {
         var i:int = 0;
         if(!this._randomInitialized)
         {
            for(i = 0; i < this._randomColorEntityDisplayers.length; i++)
            {
               this._randomColorEntityDisplayers[i].direction = this._direction;
               this._randomColorEntityDisplayers[i].look = this.ed_chara.look;
            }
            this._randomInitialized = true;
         }
         else if(this._activeModules.indexOf(TYPE_RECOLOR) != -1)
         {
            this.colorizeCharacter();
         }
      }
      
      public function onItemRollOver(target:Grid, item:GridItem) : void
      {
         var settings:Object = null;
         var spellTooltipSettings:SpellTooltipSettings = null;
         var setting:String = null;
         var objVariables:Vector.<String> = null;
         if(item.data)
         {
            settings = {};
            spellTooltipSettings = this.sysApi.getData("spellTooltipSettings",DataStoreEnum.BIND_ACCOUNT);
            objVariables = this.sysApi.getObjectVariables(spellTooltipSettings);
            for each(setting in objVariables)
            {
               settings[setting] = spellTooltipSettings[setting];
            }
            settings.unPinnable = true;
            settings.isCharacterCreation = true;
            settings.footerText = "";
            this.uiApi.showTooltip(item.data,item.container,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,0,0,null,null,settings);
         }
      }
      
      public function onItemRollOut(target:Grid, item:GridItem) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var spellWrapper:SpellWrapper = null;
         var breedData:Breed = null;
         switch(target)
         {
            case this.tx_nameRules:
               text = this.uiApi.getText("ui.charcrea.nameRules.tooltip");
               break;
            case this.btn_generateColor:
               text = this.uiApi.getText("ui.charcrea.generateColors");
               break;
            case this.btn_generateName:
               text = this.uiApi.getText("ui.charcrea.generateName");
               break;
            case this.btn_reinitName:
               text = this.uiApi.getText("ui.common.reset");
               break;
            case this.btn_breedSex0:
            case this.btn_customSex0:
               text = this.uiApi.getText("ui.tooltip.male");
               break;
            case this.btn_breedSex1:
            case this.btn_customSex1:
               text = this.uiApi.getText("ui.tooltip.female");
               break;
            case this.tx_videoPlayerSmallExpand:
               text = this.uiApi.getText("ui.charcrea.enlargeYourVideo");
               this.tx_videoPlayerSmallExpand.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_expand_video_over.png");
               break;
            case this.tx_closeVideo:
               this.tx_closeVideo.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_cross_white_over.png");
               break;
            case this.btn_color0:
               this._overSlot = 0;
               this.sysApi.addEventListener(this.onEnterFrame,"time");
               break;
            case this.btn_color1:
               this._overSlot = 1;
               this.sysApi.addEventListener(this.onEnterFrame,"time");
               break;
            case this.btn_color2:
               this._overSlot = 2;
               this.sysApi.addEventListener(this.onEnterFrame,"time");
               break;
            case this.btn_color3:
               this._overSlot = 3;
               this.sysApi.addEventListener(this.onEnterFrame,"time");
               break;
            case this.btn_color4:
               this._overSlot = 4;
               this.sysApi.addEventListener(this.onEnterFrame,"time");
               break;
            case this.btn_showEquipment:
               if(this.btn_showEquipment.selected)
               {
                  text = this.uiApi.getText("ui.charcrea.hideStuff");
               }
               else if(this.btn_showEquipment.softDisabled)
               {
                  text = this.uiApi.getText("ui.charcrea.cannotshowstuff");
               }
               else
               {
                  text = this.uiApi.getText("ui.charcrea.showStuff");
               }
               break;
            case this.slot_passiveSpellForPassiveAndActiveMode:
            case this.slot_activeSpellForPassiveAndActiveMode_0:
            case this.slot_activeSpellForPassiveAndActiveMode_1:
            case this.slot_activeSpellForPassiveAndActiveMode_2:
               spellWrapper = this._componentsList[target.name];
               if(spellWrapper === null)
               {
                  return;
               }
               this.uiApi.showTooltip(spellWrapper,target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPRIGHT,0,null,null,{
                  "isTheoretical":this.sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus"),
                  "footer":false
               },null,false);
               break;
            default:
               if(target.name.indexOf("btn_head") != -1)
               {
                  if(this._componentsList[target.name])
                  {
                     text = this.uiApi.getText("ui.charcrea.face") + " " + this._componentsList[target.name].label;
                  }
               }
               if(target.name.indexOf("ctr_breed") != -1)
               {
                  breedData = this._componentsList[target.name] as Breed;
                  if(breedData)
                  {
                     text = "<b>" + breedData.shortName + "</b>" + this.uiApi.getText("ui.common.colon") + breedData.gameplayDescription;
                     if(Connection.BREEDS_AVAILABLE <= 0 || (Math.pow(2,breedData.id - 1) & Connection.BREEDS_AVAILABLE) <= 0 || breedData.id == this._initialBreed)
                     {
                        text += "\n<i>" + this.uiApi.getText("ui.item.averageprice.unavailable") + "</i>";
                     }
                  }
               }
               else if(target.name.indexOf("lbl_role") != -1)
               {
                  if(this._componentsList[target.name])
                  {
                     text = this._aRoles[this._componentsList[target.name].id].description;
                  }
               }
               else if(target.name.indexOf("btn_randomLook") != -1)
               {
                  if(this._componentsList[target.name])
                  {
                     text = this.uiApi.getText("ui.charcrea.clickCharToColor");
                  }
               }
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onColorChange(target:Object, fixedColor:int = -1) : void
      {
         var color:uint = 0;
         if(!this.ctr_hexaColor.visible || fixedColor == -1)
         {
            color = this.cp_colorPk.color;
         }
         else
         {
            color = fixedColor;
         }
         this.ctr_hexaColor.visible = false;
         var selectedItem:Object = this.uiApi.getRadioGroupSelectedItem("colorGroup",this.uiApi.me());
         switch(selectedItem.name)
         {
            case this.btn_color0.name:
               this._aColors[0] = color;
               this.changeColor(this.tx_color0,color);
               break;
            case this.btn_color1.name:
               this._aColors[1] = color;
               this.changeColor(this.tx_color1,color);
               break;
            case this.btn_color2.name:
               this._aColors[2] = color;
               this.changeColor(this.tx_color2,color);
               break;
            case this.btn_color3.name:
               this._aColors[3] = color;
               this.changeColor(this.tx_color3,color);
               break;
            case this.btn_color4.name:
               this._aColors[4] = color;
               this.changeColor(this.tx_color4,color);
         }
         this.colorizeCharacter();
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
         this.sysApi.removeEventListener(this.onEnterFrame);
         if(target == this.btn_color0 || target == this.btn_color1 || target == this.btn_color2 || target == this.btn_color3 || target == this.btn_color4)
         {
            if(this._aColors[this._overSlot] != -1)
            {
               this.ed_chara.setColor(this._overSlot + 1,this._aColors[this._overSlot]);
            }
            else
            {
               this.ed_chara.setColor(this._overSlot + 1,this._aColorsBase[this._overSlot]);
            }
         }
         switch(target)
         {
            case this.tx_videoPlayerSmallExpand:
               this.tx_videoPlayerSmallExpand.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_expand_video.png");
               break;
            case this.tx_closeVideo:
               this.tx_closeVideo.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_cross_white.png");
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var color:uint = 0;
         switch(s)
         {
            case "validUi":
               if(this.ctr_hexaColor.visible)
               {
                  color = int("0x" + this.inp_hexaValue.text);
                  this.onColorChange({},color);
                  this.cp_colorPk.color = color;
                  this.saveCharacterModifications();
               }
               else if(!this._bRequestCreation && this._currentPage == 1)
               {
                  this._bRequestCreation = true;
                  this.createCharacter();
               }
               return true;
            case "closeUi":
               if(this.ctr_hexaColor.visible)
               {
                  this.ctr_hexaColor.visible = false;
                  return true;
               }
               break;
         }
         return false;
      }
      
      public function onCharacterCreationResult(result:int) : void
      {
         if(result > 0)
         {
            this._creationValidated = false;
            switch(result)
            {
               case CharacterCreationResultEnum.ERR_INVALID_NAME:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.invalidName"),[this.uiApi.getText("ui.common.ok")]);
                  break;
               case CharacterCreationResultEnum.ERR_NAME_ALREADY_EXISTS:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.nameAlreadyExist"),[this.uiApi.getText("ui.common.ok")]);
                  this.sysApi.log(16,"Ce nom existe deja.");
                  break;
               case CharacterCreationResultEnum.ERR_NOT_ALLOWED:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.notSubscriber"),[this.uiApi.getText("ui.common.ok")]);
                  this.sysApi.log(16,"Seuls les abonnés peuvent jouer cette classe de personnage.");
                  break;
               case CharacterCreationResultEnum.ERR_TOO_MANY_CHARACTERS:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.tooManyCharacters"),[this.uiApi.getText("ui.common.ok")]);
                  this.sysApi.log(16,"Vous avez deja trop de personnages");
                  break;
               case CharacterCreationResultEnum.ERR_NO_REASON:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.noReason"),[this.uiApi.getText("ui.common.ok")]);
                  this.sysApi.log(16,"Echec sans raison");
                  break;
               case CharacterCreationResultEnum.ERR_RESTRICED_ZONE:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.charSel.deletionErrorUnsecureMode"),[this.uiApi.getText("ui.common.ok")]);
                  this.sysApi.log(16,"Vous ne pouvez pas créer de personnage en mode Unsecure");
                  break;
               case CharacterCreationResultEnum.ERR_INCONSISTENT_COMMUNITY:
                  this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.popup.charcrea.wrongCommunity"),[this.uiApi.getText("ui.common.ok")]);
                  this.sysApi.log(16,"La communauté de votre compte ne vous permet pas de créér de personnage sur ce serveur.");
            }
            this.btn_next.disabled = false;
            this.btn_generateName.disabled = false;
            this._bRequestCreation = false;
         }
         else
         {
            this._creationValidated = true;
            this.soundApi.playLookSound(this._currentLook,LookTypeSoundEnum.CHARACTER_SELECTION);
            Connection.TUTORIAL_SELECTION = true;
            this.btn_next.disabled = true;
            this.btn_generateName.disabled = true;
         }
      }
      
      public function onCharacterImpossibleSelection(pCharacterId:Number) : void
      {
         this._bRequestCreation = false;
         this.btn_next.disabled = false;
         this.btn_generateName.disabled = false;
         this.modCommon.openPopup(this.uiApi.getText("ui.popup.impossible_action"),this.uiApi.getText("ui.common.cantSelectThisCharacter"),[this.uiApi.getText("ui.common.ok")]);
      }
      
      public function onCharacterNameSuggestioned(characterName:String) : void
      {
         this.input_name.text = characterName;
      }
      
      public function onInput(te:TextEvent) : void
      {
         if(this.input_name.text.length == 1)
         {
            this.input_name.text = this.input_name.text.toLocaleUpperCase();
         }
      }
      
      public function onChange(target:Object) : void
      {
         var startIndex:int = 0;
         var numChars:int = 0;
         var i:int = 0;
         var lastCharacter:String = null;
         var regexp:RegExp = null;
         if(this._skipChange)
         {
            this._skipChange = false;
            return;
         }
         if(this.input_name.text.charAt(0).toLocaleUpperCase() != this.input_name.text.charAt(0))
         {
            this.input_name.text = this.input_name.text.charAt(0).toLocaleUpperCase() + this.input_name.text.charAt(1).toLocaleLowerCase() + this.input_name.text.substr(2);
         }
         if(this.input_name.text.length > 0 && this.input_name.text != this.uiApi.getText("ui.charcrea.titleRename"))
         {
            if(this._namingRule.id == 1 || this._namingRule.id == 3)
            {
               startIndex = Math.max(0,!!this._lastInputText ? Number(this.input_name.textfield.caretIndex - Math.abs(this.input_name.text.length - this._lastInputText.length)) : Number(0));
               numChars = Math.abs(this.input_name.text.length - (!!this._lastInputText ? this._lastInputText.length : 0));
               for(i = startIndex; i < startIndex + numChars; i++)
               {
                  lastCharacter = this.input_name.text.charAt(i);
                  if(lastCharacter == "")
                  {
                     break;
                  }
                  regexp = i > 1 ? new RegExp(/[A-Za-zА-ЯЁа-яё\-]/) : new RegExp(/[A-Za-zА-ЯЁа-яё]/);
                  if(!regexp.test(lastCharacter) || this.utilApi.noAccent(lastCharacter) != lastCharacter || lastCharacter == " " || i > 0 && lastCharacter.toLowerCase() != lastCharacter && this.input_name.text.charAt(i - 1) != "-" || this.input_name.text.length > 1 && lastCharacter == "-" && (this.input_name.text.charAt(i - 1) == "-" || this.input_name.text.charAt(i + 1) == "-") || this.input_name.text.length > 2 && lastCharacter == "-" && this.input_name.text.substr(0,i).indexOf("-") != this.input_name.text.substr(0,i).lastIndexOf("-") || new RegExp(/([A-Za-zА-ЯЁа-яё])\1{2}/i).test(this.input_name.text))
                  {
                     this._skipChange = true;
                     if(i == 0)
                     {
                        this.input_name.text = this.input_name.text.substr(numChars);
                     }
                     else if(i == this.input_name.length - numChars)
                     {
                        this.input_name.text = this.input_name.text.substr(0,i);
                     }
                     else
                     {
                        this.input_name.text = this.input_name.text.substr(0,i) + this.input_name.text.substr(i + numChars);
                     }
                     this.input_name.textfield.setSelection(startIndex,startIndex);
                     return;
                  }
               }
               if(this._lastInputText && this._lastInputText.length > this.input_name.text.length && this._lastInputText.charAt(startIndex + 1) == "-" && this._lastInputText.charAt(startIndex + 2).toLowerCase() != this._lastInputText.charAt(startIndex + 2))
               {
                  this.input_name.text = this.input_name.text.substr(0,startIndex + 1) + this.input_name.text.charAt(startIndex + 1).toLowerCase() + this.input_name.text.substr(startIndex + 2);
               }
            }
            if(!this._nameArrayByBreedAndGender[this._breed])
            {
               this._nameArrayByBreedAndGender[this._breed] = [];
            }
            this._nameArrayByBreedAndGender[this._breed][this._gender] = this.input_name.text;
         }
         else if(this._nameArrayByBreedAndGender[this._breed] && this._nameArrayByBreedAndGender[this._breed][this._gender])
         {
            delete this._nameArrayByBreedAndGender[this._breed][this._gender];
         }
         this.saveCharacterModifications();
         this._lastInputText = this.input_name.text;
      }
      
      public function onEnterFrame(e:Event) : void
      {
         ++this._frameCount;
         if(this._frameCount > 4)
         {
            this.ed_chara.setColor(this._overSlot + 1,16759552);
            this._frameCount = 0;
         }
         else if(this._frameCount > 2)
         {
            this.ed_chara.setColor(this._overSlot + 1,16776960);
         }
      }
      
      private function closeBreedInfo() : void
      {
         this.texta_breedInfo.visible = true;
         this.gd_spells.visible = true;
         this.ctr_breedInfos.visible = false;
         this.uiApi.hideTooltip();
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      private function getColorByXYSlideX(x:Number, y:Number, slideY:Number) : uint
      {
         var r1:Number = NaN;
         var g1:Number = NaN;
         var b1:Number = NaN;
         var r2:Number = NaN;
         var g2:Number = NaN;
         var b2:Number = NaN;
         var nGradientColor:uint = this.getGradientColor(x,y);
         var colorPoint:Number = 255 - slideY / 100 * 510;
         var color:uint = 0;
         r1 = (nGradientColor & 16711680) >> 16;
         g1 = (nGradientColor & 65280) >> 8;
         b1 = nGradientColor & 255;
         if(colorPoint >= 0)
         {
            r2 = colorPoint * (255 - r1) / 255 + r1;
            g2 = colorPoint * (255 - g1) / 255 + g1;
            b2 = colorPoint * (255 - b1) / 255 + b1;
         }
         else
         {
            colorPoint *= -1;
            r2 = Math.round(r1 - r1 * colorPoint / 255);
            g2 = Math.round(g1 - g1 * colorPoint / 255);
            b2 = Math.round(b1 - b1 * colorPoint / 255);
         }
         return uint(Math.round((r2 << 16) + (g2 << 8) + b2));
      }
      
      private function getGradientColor(x:Number, y:Number) : uint
      {
         var colorPoint1:Number = NaN;
         var colorPoint2:Number = NaN;
         var r1:Number = NaN;
         var g1:Number = NaN;
         var b1:Number = NaN;
         var r2:Number = NaN;
         var g2:Number = NaN;
         var b2:Number = NaN;
         var c1:Number = NaN;
         var c2:Number = NaN;
         var r:Number = NaN;
         var g:Number = NaN;
         var b:Number = NaN;
         var gradientColor:uint = 0;
         var aColorsHue:Array = [16711680,16776960,65280,65535,255,16711935,16711680];
         var aRatiosHue:Array = [0,1 * 255 / 6,2 * 255 / 6,3 * 255 / 6,4 * 255 / 6,5 * 255 / 6,255];
         var gradientWidth:Number = 1000;
         var gradientHeight:Number = 1000;
         if(x >= gradientWidth)
         {
            x = gradientWidth - 1;
         }
         colorPoint1 = x / gradientWidth;
         var i:Number = Math.floor(colorPoint1 * (aRatiosHue.length - 1));
         colorPoint1 *= 255;
         colorPoint2 = 255 - (aRatiosHue[i + 1] - colorPoint1) / (aRatiosHue[i + 1] - aRatiosHue[i]) * 255;
         c1 = aColorsHue[i];
         c2 = aColorsHue[i + 1];
         r1 = c1 & 16711680;
         g1 = c1 & 65280;
         b1 = c1 & 255;
         r2 = c2 & 16711680;
         g2 = c2 & 65280;
         b2 = c2 & 255;
         if(r1 != r2)
         {
            r = Math.round(r1 > r2 ? Number(255 - colorPoint2) : Number(colorPoint2));
         }
         else
         {
            r = r1 >> 16;
         }
         if(g1 != g2)
         {
            g = Math.round(g1 > g2 ? Number(255 - colorPoint2) : Number(colorPoint2));
         }
         else
         {
            g = g1 >> 8;
         }
         if(b1 != b2)
         {
            b = Math.round(b1 > b2 ? Number(255 - colorPoint2) : Number(colorPoint2));
         }
         else
         {
            b = b1;
         }
         colorPoint1 = y / gradientHeight * 255;
         r += (127 - r) * colorPoint1 / 255;
         g += (127 - g) * colorPoint1 / 255;
         b += (127 - b) * colorPoint1 / 255;
         return uint(Math.round((r << 16) + (g << 8) + b));
      }
   }
}
