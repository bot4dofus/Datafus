package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayMountInformations extends GameRolePlayNamedActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 7627;
       
      
      public var ownerName:String = "";
      
      public var level:uint = 0;
      
      public function GameRolePlayMountInformations()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 7627;
      }
      
      public function initGameRolePlayMountInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, name:String = "", ownerName:String = "", level:uint = 0) : GameRolePlayMountInformations
      {
         super.initGameRolePlayNamedActorInformations(contextualId,disposition,look,name);
         this.ownerName = ownerName;
         this.level = level;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.ownerName = "";
         this.level = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayMountInformations(output);
      }
      
      public function serializeAs_GameRolePlayMountInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayNamedActorInformations(output);
         output.writeUTF(this.ownerName);
         if(this.level < 0 || this.level > 255)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         output.writeByte(this.level);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayMountInformations(input);
      }
      
      public function deserializeAs_GameRolePlayMountInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._ownerNameFunc(input);
         this._levelFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayMountInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayMountInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._ownerNameFunc);
         tree.addChild(this._levelFunc);
      }
      
      private function _ownerNameFunc(input:ICustomDataInput) : void
      {
         this.ownerName = input.readUTF();
      }
      
      private function _levelFunc(input:ICustomDataInput) : void
      {
         this.level = input.readUnsignedByte();
         if(this.level < 0 || this.level > 255)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of GameRolePlayMountInformations.level.");
         }
      }
   }
}
