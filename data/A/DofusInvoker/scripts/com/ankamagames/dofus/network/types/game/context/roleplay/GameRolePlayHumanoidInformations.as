package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayHumanoidInformations extends GameRolePlayNamedActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 206;
       
      
      public var humanoidInfo:HumanInformations;
      
      public var accountId:uint = 0;
      
      private var _humanoidInfotree:FuncTree;
      
      public function GameRolePlayHumanoidInformations()
      {
         this.humanoidInfo = new HumanInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 206;
      }
      
      public function initGameRolePlayHumanoidInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, name:String = "", humanoidInfo:HumanInformations = null, accountId:uint = 0) : GameRolePlayHumanoidInformations
      {
         super.initGameRolePlayNamedActorInformations(contextualId,disposition,look,name);
         this.humanoidInfo = humanoidInfo;
         this.accountId = accountId;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.humanoidInfo = new HumanInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayHumanoidInformations(output);
      }
      
      public function serializeAs_GameRolePlayHumanoidInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayNamedActorInformations(output);
         output.writeShort(this.humanoidInfo.getTypeId());
         this.humanoidInfo.serialize(output);
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element accountId.");
         }
         output.writeInt(this.accountId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayHumanoidInformations(input);
      }
      
      public function deserializeAs_GameRolePlayHumanoidInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.humanoidInfo = ProtocolTypeManager.getInstance(HumanInformations,_id1);
         this.humanoidInfo.deserialize(input);
         this._accountIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayHumanoidInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayHumanoidInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._humanoidInfotree = tree.addChild(this._humanoidInfotreeFunc);
         tree.addChild(this._accountIdFunc);
      }
      
      private function _humanoidInfotreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.humanoidInfo = ProtocolTypeManager.getInstance(HumanInformations,_id);
         this.humanoidInfo.deserializeAsync(this._humanoidInfotree);
      }
      
      private function _accountIdFunc(input:ICustomDataInput) : void
      {
         this.accountId = input.readInt();
         if(this.accountId < 0)
         {
            throw new Error("Forbidden value (" + this.accountId + ") on element of GameRolePlayHumanoidInformations.accountId.");
         }
      }
   }
}
