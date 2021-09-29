package cmodule.lua_wrapper
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   
   public final class FSM___monetary_load_locale extends Machine
   {
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 0;
       
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public function FSM___monetary_load_locale()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:FSM___monetary_load_locale = null;
         _loc1_ = new FSM___monetary_load_locale();
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
               this.i0 = __monetary_using_locale;
               mstate.esp -= 28;
               this.i1 = li32(mstate.ebp + 8);
               this.i2 = __monetary_locale_buf;
               this.i3 = __2E_str19158;
               this.i4 = __monetary_locale;
               this.i5 = 15;
               this.i6 = 21;
               si32(this.i1,mstate.esp);
               si32(this.i0,mstate.esp + 4);
               si32(this.i2,mstate.esp + 8);
               si32(this.i3,mstate.esp + 12);
               si32(this.i6,mstate.esp + 16);
               si32(this.i5,mstate.esp + 20);
               si32(this.i4,mstate.esp + 24);
               state = 1;
               mstate.esp -= 4;
               FSM___part_load_locale.start();
               return;
            case 1:
               this.i0 = mstate.eax;
               mstate.esp += 28;
               if(this.i0 != -1)
               {
                  this.i1 = 0;
                  si8(this.i1,___mlocale_changed_2E_b);
                  if(this.i0 == 0)
                  {
                     this.i1 = li32(__monetary_locale + 16);
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     mstate.esp -= 4;
                     FSM___fix_locale_grouping_str.start();
                  }
                  break;
               }
               break;
            case 2:
               this.i1 = mstate.eax;
               mstate.esp += 4;
               si32(this.i1,__monetary_locale + 16);
               this.i1 = li32(__monetary_locale + 28);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               mstate.esp -= 4;
               FSM_strtol.start();
            case 3:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i2 = this.i2 == -1 ? 127 : int(this.i2);
               si8(this.i2,this.i1);
               this.i1 = li32(__monetary_locale + 32);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               mstate.esp -= 4;
               FSM_strtol.start();
            case 4:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i2 = this.i2 == -1 ? 127 : int(this.i2);
               si8(this.i2,this.i1);
               this.i1 = li32(__monetary_locale + 36);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               mstate.esp -= 4;
               FSM_strtol.start();
            case 5:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i2 = this.i2 == -1 ? 127 : int(this.i2);
               si8(this.i2,this.i1);
               this.i1 = li32(__monetary_locale + 40);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               mstate.esp -= 4;
               FSM_strtol.start();
            case 6:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i2 = this.i2 == -1 ? 127 : int(this.i2);
               si8(this.i2,this.i1);
               this.i1 = li32(__monetary_locale + 44);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               mstate.esp -= 4;
               FSM_strtol.start();
            case 7:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i2 = this.i2 == -1 ? 127 : int(this.i2);
               si8(this.i2,this.i1);
               this.i1 = li32(__monetary_locale + 48);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               mstate.esp -= 4;
               FSM_strtol.start();
            case 8:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i2 = this.i2 == -1 ? 127 : int(this.i2);
               si8(this.i2,this.i1);
               this.i1 = li32(__monetary_locale + 52);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               mstate.esp -= 4;
               FSM_strtol.start();
            case 9:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i2 = this.i2 == -1 ? 127 : int(this.i2);
               si8(this.i2,this.i1);
               this.i1 = li32(__monetary_locale + 56);
               mstate.esp -= 4;
               si32(this.i1,mstate.esp);
               mstate.esp -= 4;
               FSM_strtol.start();
            case 10:
               this.i2 = mstate.eax;
               mstate.esp += 4;
               this.i2 = this.i2 == -1 ? 127 : int(this.i2);
               si8(this.i2,this.i1);
               this.i1 = li32(__monetary_locale + 60);
               if(this.i1 == 0)
               {
                  this.i1 = li32(__monetary_locale + 36);
                  si32(this.i1,__monetary_locale + 60);
                  this.i1 = li32(__monetary_locale + 64);
                  if(this.i1 != 0)
                  {
                     addr660:
                     mstate.esp -= 4;
                     si32(this.i1,mstate.esp);
                     mstate.esp -= 4;
                     FSM_strtol.start();
                     this.i2 = mstate.eax;
                     mstate.esp += 4;
                     this.i2 = this.i2 == -1 ? 127 : int(this.i2);
                     si8(this.i2,this.i1);
                     this.i1 = li32(__monetary_locale + 68);
                     if(this.i1 != 0)
                     {
                        addr806:
                        mstate.esp -= 4;
                        si32(this.i1,mstate.esp);
                        mstate.esp -= 4;
                        FSM_strtol.start();
                        this.i2 = mstate.eax;
                        mstate.esp += 4;
                        this.i2 = this.i2 == -1 ? 127 : int(this.i2);
                        si8(this.i2,this.i1);
                        this.i1 = li32(__monetary_locale + 72);
                        if(this.i1 != 0)
                        {
                           addr893:
                           mstate.esp -= 4;
                           si32(this.i1,mstate.esp);
                           mstate.esp -= 4;
                           FSM_strtol.start();
                           addr913:
                           this.i2 = mstate.eax;
                           mstate.esp += 4;
                           this.i2 = this.i2 == -1 ? 127 : int(this.i2);
                           si8(this.i2,this.i1);
                           this.i1 = li32(__monetary_locale + 76);
                           if(this.i1 != 0)
                           {
                              addr980:
                              mstate.esp -= 4;
                              si32(this.i1,mstate.esp);
                              mstate.esp -= 4;
                              FSM_strtol.start();
                              this.i2 = mstate.eax;
                              mstate.esp += 4;
                              this.i2 = this.i2 == -1 ? 127 : int(this.i2);
                              si8(this.i2,this.i1);
                              this.i1 = li32(__monetary_locale + 80);
                              if(this.i1 != 0)
                              {
                                 addr1067:
                                 mstate.esp -= 4;
                                 si32(this.i1,mstate.esp);
                                 mstate.esp -= 4;
                                 FSM_strtol.start();
                                 this.i2 = mstate.eax;
                                 mstate.esp += 4;
                                 this.i2 = this.i2 == -1 ? 127 : int(this.i2);
                                 si8(this.i2,this.i1);
                                 break;
                              }
                           }
                           else
                           {
                              addr1040:
                              this.i1 = li32(__monetary_locale + 52);
                              si32(this.i1,__monetary_locale + 76);
                              this.i1 = li32(__monetary_locale + 80);
                              if(this.i1 != 0)
                              {
                                 §§goto(addr1067);
                              }
                           }
                           addr1144:
                           this.i1 = li32(__monetary_locale + 56);
                           si32(this.i1,__monetary_locale + 80);
                           break;
                        }
                        addr953:
                        this.i1 = li32(__monetary_locale + 48);
                        si32(this.i1,__monetary_locale + 72);
                        this.i1 = li32(__monetary_locale + 76);
                        if(this.i1 != 0)
                        {
                           §§goto(addr980);
                        }
                        else
                        {
                           §§goto(addr1040);
                        }
                        §§goto(addr1040);
                     }
                     else
                     {
                        addr866:
                        this.i1 = li32(__monetary_locale + 40);
                        si32(this.i1,__monetary_locale + 68);
                        this.i1 = li32(__monetary_locale + 72);
                        if(this.i1 != 0)
                        {
                           §§goto(addr893);
                        }
                        else
                        {
                           §§goto(addr953);
                        }
                     }
                     §§goto(addr953);
                  }
                  else
                  {
                     addr779:
                     this.i1 = li32(__monetary_locale + 44);
                     si32(this.i1,__monetary_locale + 64);
                     this.i1 = li32(__monetary_locale + 68);
                     if(this.i1 != 0)
                     {
                        §§goto(addr806);
                     }
                     else
                     {
                        §§goto(addr866);
                     }
                  }
                  §§goto(addr866);
               }
               else
               {
                  mstate.esp -= 4;
                  si32(this.i1,mstate.esp);
                  mstate.esp -= 4;
                  FSM_strtol.start();
                  addr740:
                  this.i2 = mstate.eax;
                  mstate.esp += 4;
                  this.i2 = this.i2 == -1 ? 127 : int(this.i2);
                  si8(this.i2,this.i1);
                  this.i1 = li32(__monetary_locale + 64);
                  if(this.i1 != 0)
                  {
                     §§goto(addr660);
                  }
                  else
                  {
                     §§goto(addr779);
                  }
               }
               §§goto(addr779);
            case 12:
               §§goto(addr740);
            case 11:
               §§goto(addr660);
            case 13:
               §§goto(addr806);
            case 14:
               §§goto(addr913);
            case 15:
               §§goto(addr980);
            case 16:
               §§goto(addr1067);
            default:
               throw "Invalid state in ___monetary_load_locale";
         }
         mstate.eax = this.i0;
         mstate.esp = mstate.ebp;
         mstate.ebp = li32(mstate.esp);
         mstate.esp += 4;
         mstate.esp += 4;
         mstate.gworker = caller;
      }
   }
}
