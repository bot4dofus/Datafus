package com.ankamagames.dofus.network.types.game.social.application
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class SocialApplicationInformation implements INetworkType
   {
      
      public static const protocolId:uint = 212;
       
      
      public var playerInfo:ApplicationPlayerInformation;
      
      public var applyText:String = "";
      
      public var creationDate:Number = 0;
      
      private var _playerInfotree:FuncTree;
      
      public function SocialApplicationInformation()
      {
         this.playerInfo = new ApplicationPlayerInformation();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 212;
      }
      
      public function initSocialApplicationInformation(playerInfo:ApplicationPlayerInformation = null, applyText:String = "", creationDate:Number = 0) : SocialApplicationInformation
      {
         this.playerInfo = playerInfo;
         this.applyText = applyText;
         this.creationDate = creationDate;
         return this;
      }
      
      public function reset() : void
      {
         this.playerInfo = new ApplicationPlayerInformation();
         this.creationDate = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SocialApplicationInformation(output);
      }
      
      public function serializeAs_SocialApplicationInformation(output:ICustomDataOutput) : void
      {
         this.playerInfo.serializeAs_ApplicationPlayerInformation(output);
         output.writeUTF(this.applyText);
         if(this.creationDate < -9007199254740992 || this.creationDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element creationDate.");
         }
         output.writeDouble(this.creationDate);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SocialApplicationInformation(input);
      }
      
      public function deserializeAs_SocialApplicationInformation(input:ICustomDataInput) : void
      {
         this.playerInfo = new ApplicationPlayerInformation();
         this.playerInfo.deserialize(input);
         this._applyTextFunc(input);
         this._creationDateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SocialApplicationInformation(tree);
      }
      
      public function deserializeAsyncAs_SocialApplicationInformation(tree:FuncTree) : void
      {
         this._playerInfotree = tree.addChild(this._playerInfotreeFunc);
         tree.addChild(this._applyTextFunc);
         tree.addChild(this._creationDateFunc);
      }
      
      private function _playerInfotreeFunc(input:ICustomDataInput) : void
      {
         this.playerInfo = new ApplicationPlayerInformation();
         this.playerInfo.deserializeAsync(this._playerInfotree);
      }
      
      private function _applyTextFunc(input:ICustomDataInput) : void
      {
         this.applyText = input.readUTF();
      }
      
      private function _creationDateFunc(input:ICustomDataInput) : void
      {
         this.creationDate = input.readDouble();
         if(this.creationDate < -9007199254740992 || this.creationDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.creationDate + ") on element of SocialApplicationInformation.creationDate.");
         }
      }
   }
}
