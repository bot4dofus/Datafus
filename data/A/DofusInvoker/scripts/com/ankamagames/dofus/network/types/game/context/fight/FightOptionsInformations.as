package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightOptionsInformations implements INetworkType
   {
      
      public static const protocolId:uint = 2952;
       
      
      public var isSecret:Boolean = false;
      
      public var isRestrictedToPartyOnly:Boolean = false;
      
      public var isClosed:Boolean = false;
      
      public var isAskingForHelp:Boolean = false;
      
      public function FightOptionsInformations()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2952;
      }
      
      public function initFightOptionsInformations(isSecret:Boolean = false, isRestrictedToPartyOnly:Boolean = false, isClosed:Boolean = false, isAskingForHelp:Boolean = false) : FightOptionsInformations
      {
         this.isSecret = isSecret;
         this.isRestrictedToPartyOnly = isRestrictedToPartyOnly;
         this.isClosed = isClosed;
         this.isAskingForHelp = isAskingForHelp;
         return this;
      }
      
      public function reset() : void
      {
         this.isSecret = false;
         this.isRestrictedToPartyOnly = false;
         this.isClosed = false;
         this.isAskingForHelp = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightOptionsInformations(output);
      }
      
      public function serializeAs_FightOptionsInformations(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.isSecret);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.isRestrictedToPartyOnly);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.isClosed);
         _box0 = BooleanByteWrapper.setFlag(_box0,3,this.isAskingForHelp);
         output.writeByte(_box0);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightOptionsInformations(input);
      }
      
      public function deserializeAs_FightOptionsInformations(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightOptionsInformations(tree);
      }
      
      public function deserializeAsyncAs_FightOptionsInformations(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.isSecret = BooleanByteWrapper.getFlag(_box0,0);
         this.isRestrictedToPartyOnly = BooleanByteWrapper.getFlag(_box0,1);
         this.isClosed = BooleanByteWrapper.getFlag(_box0,2);
         this.isAskingForHelp = BooleanByteWrapper.getFlag(_box0,3);
      }
   }
}
