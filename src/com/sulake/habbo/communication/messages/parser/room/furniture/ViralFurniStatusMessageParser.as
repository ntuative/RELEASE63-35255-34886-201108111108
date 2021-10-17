package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ViralFurniStatusMessageParser implements IMessageParser 
    {

        private var var_3826:String;
        private var var_1678:int;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var var_3827:int = 0;
        private var var_2549:int;
        private var _shareId:String;
        private var var_3824:String;


        public function get campaignID():String
        {
            return (this.var_3826);
        }

        public function get objectId():int
        {
            return (this.var_1678);
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

        public function get itemCategory():int
        {
            return (this.var_3827);
        }

        public function get shareId():String
        {
            return (this._shareId);
        }

        public function get status():int
        {
            return (this.var_2549);
        }

        public function get firstClickUserName():String
        {
            return (this.var_3824);
        }

        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3826 = param1.readString();
            this.var_1678 = param1.readInteger();
            this.var_2549 = param1.readInteger();
            this._shareId = param1.readString();
            this.var_3824 = param1.readString();
            this.var_3827 = param1.readInteger();
            return (true);
        }


    }
}