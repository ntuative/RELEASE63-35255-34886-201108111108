package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendData 
    {

        private var _id:int;
        private var _name:String;
        private var var_2938:int;
        private var var_3400:Boolean;
        private var var_3401:Boolean;
        private var var_2994:String;
        private var var_2930:int;
        private var var_3402:String;
        private var var_3403:String;
        private var _realName:String;
        private var var_3404:String;

        public function FriendData(param1:IMessageDataWrapper)
        {
            this._id = param1.readInteger();
            this._name = param1.readString();
            this.var_2938 = param1.readInteger();
            this.var_3400 = param1.readBoolean();
            this.var_3401 = param1.readBoolean();
            this.var_2994 = param1.readString();
            this.var_2930 = param1.readInteger();
            this.var_3402 = param1.readString();
            this.var_3403 = param1.readString();
            this._realName = param1.readString();
            this.var_3404 = param1.readString();
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get name():String
        {
            return (this._name);
        }

        public function get gender():int
        {
            return (this.var_2938);
        }

        public function get online():Boolean
        {
            return (this.var_3400);
        }

        public function get followingAllowed():Boolean
        {
            return (this.var_3401);
        }

        public function get figure():String
        {
            return (this.var_2994);
        }

        public function get categoryId():int
        {
            return (this.var_2930);
        }

        public function get motto():String
        {
            return (this.var_3402);
        }

        public function get lastAccess():String
        {
            return (this.var_3403);
        }

        public function get realName():String
        {
            return (this._realName);
        }

        public function get facebookId():String
        {
            return (this.var_3404);
        }


    }
}