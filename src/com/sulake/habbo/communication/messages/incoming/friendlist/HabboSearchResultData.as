package com.sulake.habbo.communication.messages.incoming.friendlist
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboSearchResultData 
    {

        private var var_3408:int;
        private var var_3409:String;
        private var var_3410:String;
        private var var_3411:Boolean;
        private var var_3412:Boolean;
        private var var_3413:int;
        private var var_3414:String;
        private var var_3415:String;
        private var _realName:String;

        public function HabboSearchResultData(param1:IMessageDataWrapper)
        {
            this.var_3408 = param1.readInteger();
            this.var_3409 = param1.readString();
            this.var_3410 = param1.readString();
            this.var_3411 = param1.readBoolean();
            this.var_3412 = param1.readBoolean();
            param1.readString();
            this.var_3413 = param1.readInteger();
            this.var_3414 = param1.readString();
            this.var_3415 = param1.readString();
            this._realName = param1.readString();
        }

        public function get avatarId():int
        {
            return (this.var_3408);
        }

        public function get avatarName():String
        {
            return (this.var_3409);
        }

        public function get avatarMotto():String
        {
            return (this.var_3410);
        }

        public function get isAvatarOnline():Boolean
        {
            return (this.var_3411);
        }

        public function get canFollow():Boolean
        {
            return (this.var_3412);
        }

        public function get avatarGender():int
        {
            return (this.var_3413);
        }

        public function get avatarFigure():String
        {
            return (this.var_3414);
        }

        public function get lastOnlineDate():String
        {
            return (this.var_3415);
        }

        public function get realName():String
        {
            return (this._realName);
        }


    }
}