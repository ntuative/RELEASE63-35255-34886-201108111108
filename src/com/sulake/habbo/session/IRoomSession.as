package com.sulake.habbo.session
{
    public interface IRoomSession 
    {

        function get roomId():int;
        function get roomCategory():int;
        function get roomResources():String;
        function get state():String;
        function start():Boolean;
        function sendChatMessage(param1:String):void;
        function sendChangeMottoMessage(param1:String):void;
        function sendShoutMessage(param1:String):void;
        function sendWhisperMessage(param1:String, param2:String):void;
        function sendChatTypingMessage(param1:Boolean):void;
        function sendWaveMessage():void;
        function sendSignMessage(param1:int):void;
        function sendDanceMessage(param1:int):void;
        function sendCreditFurniRedeemMessage(param1:int):void;
        function sendPresentOpenMessage(param1:int):void;
        function sendOpenPetPackageMessage(param1:int, param2:String):void;
        function sendViralFurniFoundMessage():void;
        function sendRoomDimmerGetPresetsMessage():void;
        function sendRoomDimmerSavePresetMessage(param1:int, param2:int, param3:uint, param4:int, param5:Boolean):void;
        function sendRoomDimmerChangeStateMessage():void;
        function sendConversionPoint(param1:String, param2:String, param3:String, param4:String=null, param5:int=0):void;
        function sendVote(param1:int):void;
        function sendPollStartMessage(param1:int):void;
        function sendPollRejectMessage(param1:int):void;
        function sendPollAnswerMessage(param1:int, param2:int, param3:Array):void;
        function kickUser(param1:int):void;
        function banUser(param1:int):void;
        function assignRights(param1:int):void;
        function removeRights(param1:int):void;
        function letUserIn(param1:String, param2:Boolean):void;
        function pickUpPet(param1:int):void;
        function requestPetCommands(param1:int):void;
        function quit():void;
        function kickBot(param1:int):void;
        function changeQueue(param1:int):void;
        function sendUpdateClothingChangeFurniture(param1:int, param2:String, param3:String):void;
        function sendGetUserNotifications():void;
        function receivedChatWithTrackingId(param1:int):void;
        function get isRoomOwner():Boolean;
        function set isRoomOwner(param1:Boolean):void;
        function get isRoomController():Boolean;
        function set isRoomController(param1:Boolean):void;
        function get isTradingRoom():Boolean;
        function get isPrivateRoom():Boolean;
        function set isTradingRoom(param1:Boolean):void;
        function get userDataManager():IUserDataManager;
        function get isSpectatorMode():Boolean;
        function set isSpectatorMode(param1:Boolean):void;
        function get arePetsAllowed():Boolean;
        function set arePetsAllowed(param1:Boolean):void;

    }
}