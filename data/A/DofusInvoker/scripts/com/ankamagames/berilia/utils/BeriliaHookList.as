package com.ankamagames.berilia.utils
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class BeriliaHookList
   {
      
      public static const MouseClick:String = "MouseClick";
      
      public static const MouseMiddleClick:String = "MouseMiddleClick";
      
      public static const MouseShiftClick:String = "MouseShiftClick";
      
      public static const MouseCtrlClick:String = "MouseCtrlClick";
      
      public static const MouseAltClick:String = "MouseAltClick";
      
      public static const MouseCtrlDoubleClick:String = "MouseCtrlDoubleClick";
      
      public static const MouseAltDoubleClick:String = "MouseAltDoubleClick";
      
      public static const PostMouseClick:String = "PostMouseClick";
      
      public static const KeyUp:String = "KeyUp";
      
      public static const KeyDown:String = "KeyDown";
      
      public static const FocusChange:String = "FocusChange";
      
      public static const DropStart:String = "DropStart";
      
      public static const DropEnd:String = "DropEnd";
      
      public static const KeyboardShortcut:String = "KeyboardShortcut";
      
      public static const ShortcutUpdate:String = "ShortcutUpdate";
      
      public static const LoadingFinished:String = "LoadingFinished";
      
      public static const TextureLoadFailed:String = "TextureLoadFailed";
      
      public static const SlotDropedOnBerilia:String = "SlotDropedOnBerilia";
      
      public static const SlotDropedOnWorld:String = "SlotDropedOnWorld";
      
      public static const SlotDropedNorBeriliaNorWorld:String = "SlotDropedNorBeriliaNorWorld";
      
      public static const UiLoaded:String = "UiLoaded";
      
      public static const ChatHyperlink:String = "ChatHyperlink";
      
      public static const ChatRollOverLink:String = "ChatRollOverLink";
      
      public static const UiLoading:String = "UiLoading";
      
      public static const UiUnloading:String = "UiUnloading";
      
      public static const UiUnloaded:String = "UiUnloaded";
      
      public static const WindowResize:String = "WindowResize";
      
      public static const SlideComplete:String = "SlideComplete";
      
      public static const ThemeInstallationProgress:String = "ThemeInstallationProgress";
      
      public static const StrataUpdate:String = "StrataUpdate";
      
      public static const LevelUpStatsTutorial:String = "LevelUpStatsTutorial";
      
      public static const CloseLevelUpUiTutorial:String = "CloseLevelUpUiTutorial";
       
      
      public function BeriliaHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(MouseClick);
         Hook.createHook(MouseMiddleClick);
         Hook.createHook(MouseShiftClick);
         Hook.createHook(MouseCtrlClick);
         Hook.createHook(MouseAltClick);
         Hook.createHook(MouseCtrlDoubleClick);
         Hook.createHook(MouseAltDoubleClick);
         Hook.createHook(PostMouseClick);
         Hook.createHook(KeyUp);
         Hook.createHook(KeyDown);
         Hook.createHook(FocusChange);
         Hook.createHook(DropStart);
         Hook.createHook(DropEnd);
         Hook.createHook(KeyboardShortcut);
         Hook.createHook(ShortcutUpdate);
         Hook.createHook(LoadingFinished);
         Hook.createHook(TextureLoadFailed);
         Hook.createHook(SlotDropedOnBerilia);
         Hook.createHook(SlotDropedOnWorld);
         Hook.createHook(SlotDropedNorBeriliaNorWorld);
         Hook.createHook(UiLoaded);
         Hook.createHook(ChatHyperlink);
         Hook.createHook(ChatRollOverLink);
         Hook.createHook(UiLoading);
         Hook.createHook(UiUnloading);
         Hook.createHook(UiUnloaded);
         Hook.createHook(WindowResize);
         Hook.createHook(SlideComplete);
         Hook.createHook(ThemeInstallationProgress);
         Hook.createHook(StrataUpdate);
         Hook.createHook(LevelUpStatsTutorial);
         Hook.createHook(CloseLevelUpUiTutorial);
      }
   }
}
