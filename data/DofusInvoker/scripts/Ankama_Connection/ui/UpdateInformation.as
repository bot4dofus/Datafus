package Ankama_Connection.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.logic.game.common.actions.CharacterAutoConnectAction;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.Version;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.filesystem.File;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import mx.collections.ArrayCollection;
   
   public class UpdateInformation
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilsApi:UtilApi;
      
      private var _folderCinematicsUrl:String;
      
      private var _cinematicsUri:String;
      
      private var _currentLanguage:String;
      
      private var _currentMajNumber:String = "2-45";
      
      private var _lastMajNumber:String;
      
      private var _listFiles:ArrayCollection;
      
      private var _loader:URLLoader;
      
      private var _hasCinematic:Boolean = false;
      
      private var _hasTopLeftImage:Boolean;
      
      private var _hasTopRightImage:Boolean;
      
      private var _hasCenterImage:Boolean;
      
      private var _hasBottomLeftImage:Boolean;
      
      private var _hasBottomRightImage:Boolean;
      
      private var _hasBottomCenterImage:Boolean;
      
      private var _cbMajValues:Array;
      
      public var ctr_template:GraphicContainer;
      
      public var cb_maj:ComboBox;
      
      public var tx_bg:Texture;
      
      public var btn_play:ButtonContainer;
      
      public function UpdateInformation()
      {
         this._listFiles = new ArrayCollection();
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var version:Version = this.sysApi.getCurrentVersion();
         this._currentMajNumber = version.major.toString() + "-" + version.minor.toString();
         var updateDirectory:File = new File(this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber);
         if(!updateDirectory.exists)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return;
         }
         this.uiApi.addComponentHook(this.cb_maj,ComponentHookList.ON_SELECT_ITEM);
         this._cbMajValues = this.initMajComboBox();
         this.cb_maj.dataProvider = this._cbMajValues;
         this.cb_maj.dataNameField = this.cb_maj.dataProvider[this.cb_maj.dataProvider.length - 1].name;
         this.cb_maj.value = this.cb_maj.dataProvider[this.cb_maj.dataProvider.length - 1];
         this.cb_maj.visible = true;
         this._currentLanguage = this.sysApi.getCurrentLanguage();
      }
      
      private function selectMajInformation(majNumber:String) : void
      {
         if(this._lastMajNumber == majNumber)
         {
            return;
         }
         this._lastMajNumber = majNumber;
         this.uiApi.unloadUi("subUpdateInformation");
         var dir:* = this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/bg_maj-" + majNumber + ".jpg";
         var updateBg:File = new File(dir);
         if(updateBg.exists)
         {
            this.tx_bg.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + majNumber + "/bg_maj-" + majNumber + ".jpg");
         }
         else
         {
            this.tx_bg.uri = this.uiApi.createUri(this.uiApi.me().getConstant("illusUi") + "login_background.jpg");
         }
         this._folderCinematicsUrl = "https://dofus2.cdn.ankama.com/content/updates_videos/" + majNumber + "/";
         this.getAllFiles();
         this.checkVideoUrl();
      }
      
      private function initMajComboBox() : Array
      {
         var dir:* = this.uiApi.me().getConstant("illus") + "nouveautes_maj";
         var updateDirectory:File = new File(dir);
         var getfiles:Array = updateDirectory.getDirectoryListing();
         var majNumbers:Array = new Array();
         for(var i:int = 0; i < getfiles.length; i++)
         {
            majNumbers.push({
               "label":this.uiApi.getText("ui.maj.majNumber",getfiles[i].name.replace("-",".")),
               "value":getfiles[i].name
            });
         }
         majNumbers.sortOn("label");
         if(majNumbers.length > 5)
         {
            majNumbers.splice(0,majNumbers.length - 5);
         }
         return majNumbers;
      }
      
      private function selectTemplate() : void
      {
         var params:Object = {};
         params.currentMajNumber = this._currentMajNumber;
         params.currentLanguage = this._currentLanguage;
         params.hasCinematic = this._hasCinematic;
         params.cinematicsUri = this._cinematicsUri;
         params.hasBottomCenterImage = this._hasBottomCenterImage;
         if(this._hasBottomLeftImage && this._hasBottomRightImage)
         {
            this.uiApi.loadUiInside(UIEnum.UPDATEINFORMATION_FULL_TEMPLATE,this.ctr_template,"subUpdateInformation",params);
         }
         else
         {
            this.uiApi.loadUiInside(UIEnum.UPDATEINFORMATION_THREE_TEMPLATE,this.ctr_template,"subUpdateInformation",params);
         }
      }
      
      private function getAllFiles() : void
      {
         var dir:String = this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber;
         var updateDirectory:File = new File(dir);
         this.ResetFilesInformation();
         var getfiles:Array = updateDirectory.getDirectoryListing();
         for(var i:int = 0; i < getfiles.length; i++)
         {
            this._listFiles.addItemAt(getfiles[i].nativePath,i);
            this.detectImages(getfiles[i].name);
         }
      }
      
      private function checkVideoUrl() : void
      {
         this._loader = new URLLoader();
         var request:URLRequest = new URLRequest(this.uiApi.me().getConstant("illus") + "nouveautes_maj/" + this._currentMajNumber + "/languages.json");
         this._loader.addEventListener(Event.COMPLETE,this.onComplete);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this._loader.load(request);
      }
      
      private function onComplete(e:Event) : void
      {
         this._loader.removeEventListener(Event.COMPLETE,this.onComplete);
         this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         var loaderComplete:URLLoader = URLLoader(e.currentTarget);
         var language:Object = this.utilsApi.decodeJson(loaderComplete.data);
         if(language.videoLanguage != "none")
         {
            if(language.videoLanguage.indexOf(this._currentLanguage) != -1)
            {
               this._hasCinematic = true;
               this._cinematicsUri = this._folderCinematicsUrl + "Dofus_Trailer_Maj" + this._currentMajNumber + "_" + this._currentLanguage.toUpperCase() + ".mp4";
            }
            else if(language.videoLanguage.indexOf("en") != -1)
            {
               this._hasCinematic = true;
               this._cinematicsUri = this._folderCinematicsUrl + "Dofus_Trailer_Maj" + this._currentMajNumber + "_EN.mp4";
            }
            else
            {
               this._hasCinematic = true;
               this._cinematicsUri = this._folderCinematicsUrl + "Dofus_Trailer_Maj" + this._currentMajNumber + "_FR.mp4";
            }
         }
         else
         {
            this._hasCinematic = false;
         }
         this.selectTemplate();
      }
      
      private function onError(e:Event) : void
      {
         this._loader.removeEventListener(Event.COMPLETE,this.onComplete);
         this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         this.selectTemplate();
      }
      
      private function ResetFilesInformation() : void
      {
         this._listFiles = new ArrayCollection();
         this._hasTopLeftImage = false;
         this._hasTopRightImage = false;
         this._hasCenterImage = false;
         this._hasBottomLeftImage = false;
         this._hasBottomRightImage = false;
         this._hasBottomCenterImage = false;
         this._hasCinematic = false;
      }
      
      private function detectImages(fileName:String) : void
      {
         if(fileName.indexOf("feature_TL") != -1)
         {
            this._hasTopLeftImage = true;
         }
         else if(fileName.indexOf("feature_TR") != -1)
         {
            this._hasTopRightImage = true;
         }
         else if(fileName.indexOf("feature_Center") != -1)
         {
            this._hasCenterImage = true;
         }
         else if(fileName.indexOf("feature_BL") != -1)
         {
            this._hasBottomLeftImage = true;
         }
         else if(fileName.indexOf("feature_BR") != -1)
         {
            this._hasBottomRightImage = true;
         }
         else if(fileName.indexOf("feature_BC") != -1)
         {
            this._hasBottomCenterImage = true;
         }
      }
      
      public function unload() : void
      {
         this.sysApi.setData("updateInformationDisplayed",this._currentMajNumber,DataStoreEnum.BIND_COMPUTER);
         this.sysApi.sendAction(new CharacterAutoConnectAction([]));
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_play:
               if(this.uiApi.getUi("subUpdateInformation").uiClass.videoPlayerSmall)
               {
                  this.uiApi.getUi("subUpdateInformation").uiClass.videoPlayerSmall.stop();
               }
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
      }
      
      public function onSelectItem(target:ComboBox, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.cb_maj)
         {
            this._currentMajNumber = this.cb_maj.dataProvider[target.selectedIndex].value;
            this.cb_maj.value = this.cb_maj.dataProvider[target.selectedIndex].name;
            this.cb_maj.dataNameField = this.cb_maj.dataProvider[target.selectedIndex].name;
            this.selectMajInformation(this._currentMajNumber);
         }
      }
   }
}
