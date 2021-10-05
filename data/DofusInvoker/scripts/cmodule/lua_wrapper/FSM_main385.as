package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   
   public final class FSM_main385 extends Machine
   {
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public function FSM_main385()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM_main385 = null;
         _loc1_ = new FSM_main385();
         gstate.gworker = _loc1_;
      }
      
      override public final function work() : void
      {
         switch(state)
         {
            case 0:
               mstate.esp -= 4;
               si32(mstate.ebp,mstate.esp);
               mstate.ebp = mstate.esp;
               mstate.esp -= 0;
               this.i0 = __2E_str4134;
               mstate.esp -= 8;
               this.i1 = 0;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 1;
               mstate.esp -= 4;
               mstate.funcs[_AS3_NSGetS]();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,_Number_class);
               mstate.esp -= 8;
               this.i0 = __2E_str5135;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 2;
               mstate.esp -= 4;
               mstate.funcs[_AS3_NSGetS]();
               return;
            case 2:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,_int_class);
               mstate.esp -= 8;
               this.i0 = __2E_str6136;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 3;
               mstate.esp -= 4;
               mstate.funcs[_AS3_NSGetS]();
               return;
            case 3:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,_String_class);
               mstate.esp -= 8;
               this.i0 = __2E_str7137;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 4;
               mstate.esp -= 4;
               mstate.funcs[_AS3_NSGetS]();
               return;
            case 4:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,_Boolean_class);
               mstate.esp -= 4;
               this.i0 = __2E_str8138;
               si32(this.i0,mstate.esp);
               state = 5;
               mstate.esp -= 4;
               mstate.funcs[_AS3_String]();
               return;
            case 5:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               mstate.esp -= 8;
               this.i2 = __2E_str9139;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 6;
               mstate.esp -= 4;
               mstate.funcs[_AS3_NSGetS]();
               return;
            case 6:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,_getQualifiedClassName_method);
               mstate.esp -= 8;
               this.i0 = __2E_str10140;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               state = 7;
               mstate.esp -= 4;
               mstate.funcs[_AS3_NSGetS]();
               return;
            case 7:
               this.i0 = mstate.eax;
               mstate.esp += 8;
               si32(this.i0,_Array_class);
               mstate.esp -= 4;
               this.i0 = __2E_str45;
               si32(this.i0,mstate.esp);
               state = 8;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Object]();
               return;
            case 8:
               this.i0 = mstate.eax;
               mstate.esp += 4;
               si32(this.i0,_gg_lib);
               mstate.esp -= 8;
               this.i2 = _thunk_luaInitializeState;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 9;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Function]();
               return;
            case 9:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i3 = __2E_str19118;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 10;
               mstate.esp -= 4;
               mstate.funcs[_AS3_SetS]();
               return;
            case 10:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 11;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 11:
               mstate.esp += 4;
               this.i0 = li32(_gg_lib);
               mstate.esp -= 8;
               this.i2 = _thunk_luaClose;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 12;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Function]();
               return;
            case 12:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i3 = __2E_str20119;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 13;
               mstate.esp -= 4;
               mstate.funcs[_AS3_SetS]();
               return;
            case 13:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 14;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 14:
               mstate.esp += 4;
               this.i0 = li32(_gg_lib);
               mstate.esp -= 8;
               this.i2 = _thunk_doFile;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 15;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Function]();
               return;
            case 15:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i3 = __2E_str21120;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 16;
               mstate.esp -= 4;
               mstate.funcs[_AS3_SetS]();
               return;
            case 16:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 17;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 17:
               mstate.esp += 4;
               this.i0 = li32(_gg_lib);
               mstate.esp -= 8;
               this.i2 = _thunk_doFileAsync;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 18;
               mstate.esp -= 4;
               mstate.funcs[_AS3_FunctionAsync]();
               return;
            case 18:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i3 = __2E_str22121;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 19;
               mstate.esp -= 4;
               mstate.funcs[_AS3_SetS]();
               return;
            case 19:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 20;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 20:
               mstate.esp += 4;
               this.i0 = li32(_gg_lib);
               mstate.esp -= 8;
               this.i2 = _thunk_luaDoString;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 21;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Function]();
               return;
            case 21:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i3 = __2E_str23122;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 22;
               mstate.esp -= 4;
               mstate.funcs[_AS3_SetS]();
               return;
            case 22:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 23;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 23:
               mstate.esp += 4;
               this.i0 = li32(_gg_lib);
               mstate.esp -= 8;
               this.i2 = _thunk_luaDoStringAsync;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 24;
               mstate.esp -= 4;
               mstate.funcs[_AS3_FunctionAsync]();
               return;
            case 24:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i3 = __2E_str24123;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 25;
               mstate.esp -= 4;
               mstate.funcs[_AS3_SetS]();
               return;
            case 25:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 26;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 26:
               mstate.esp += 4;
               this.i0 = li32(_gg_lib);
               mstate.esp -= 8;
               this.i2 = _thunk_setGlobal;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 27;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Function]();
               return;
            case 27:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i3 = __2E_str25124;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 28;
               mstate.esp -= 4;
               mstate.funcs[_AS3_SetS]();
               return;
            case 28:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 29;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 29:
               mstate.esp += 4;
               this.i0 = li32(_gg_lib);
               mstate.esp -= 8;
               this.i2 = _thunk_setGlobalLuaValue;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 30;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Function]();
               return;
            case 30:
               this.i2 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i3 = __2E_str26125;
               si32(this.i0,mstate.esp);
               si32(this.i3,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               state = 31;
               mstate.esp -= 4;
               mstate.funcs[_AS3_SetS]();
               return;
            case 31:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 4;
               si32(this.i2,mstate.esp);
               state = 32;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 32:
               mstate.esp += 4;
               this.i0 = li32(_gg_lib);
               mstate.esp -= 8;
               this.i2 = _thunk_callGlobal;
               si32(this.i1,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               state = 33;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Function]();
               return;
            case 33:
               this.i1 = mstate.eax;
               mstate.esp += 8;
               mstate.esp -= 12;
               this.i2 = __2E_str27126;
               si32(this.i0,mstate.esp);
               si32(this.i2,mstate.esp + 4);
               si32(this.i1,mstate.esp + 8);
               state = 34;
               mstate.esp -= 4;
               mstate.funcs[_AS3_SetS]();
               return;
            case 34:
               this.i0 = mstate.eax;
               mstate.esp += 12;
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               state = 35;
               mstate.esp -= 4;
               mstate.funcs[_AS3_Release]();
               return;
            case 35:
               mstate.esp += 4;
               this.i1 = li32(_gg_lib);
               this.i2 = 1;
               this.i0 = this.i2;
               state = 36;
               break;
            case 36:
               break;
            default:
               throw "Invalid state in _main385";
         }
         if(this.i0)
         {
            this.i0 = 0;
            throw new AlchemyLibInit(this.i1);
         }
         mstate.eax = this.i2;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
