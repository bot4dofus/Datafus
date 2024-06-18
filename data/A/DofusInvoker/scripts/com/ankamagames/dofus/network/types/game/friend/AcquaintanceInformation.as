package com.ankamagames.dofus.network.types.game.friend
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AcquaintanceInformation extends AbstractContactInformations implements INetworkType
   {
      
      public static const protocolId:uint = 1584;
       
      
      public var playerState:uint = 99;
      
      public function AcquaintanceInformation()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1584;
      }
      
      public function initAcquaintanceInformation(accountId:uint = 0, accountTag:AccountTagInformation = null, playerState:uint = 99) : AcquaintanceInformation
      {
         super.initAbstractContactInformations(accountId,accountTag);
         this.playerState = playerState;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerState = 99;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AcquaintanceInformation(output);
      }
      
      public function serializeAs_AcquaintanceInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractContactInformations(output);
         output.writeByte(this.playerState);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AcquaintanceInformation(input);
      }
      
      public function deserializeAs_AcquaintanceInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerStateFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AcquaintanceInformation(tree);
      }
      
      public function deserializeAsyncAs_AcquaintanceInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerStateFunc);
      }
      
      private function _playerStateFunc(input:ICustomDataInput) : void
      {
         this.playerState = input.readByte();
         if(this.playerState < 0)
         {
            throw new Error("Forbidden value (" + this.playerState + ") on element of AcquaintanceInformation.playerState.");
         }
      }
   }
}
