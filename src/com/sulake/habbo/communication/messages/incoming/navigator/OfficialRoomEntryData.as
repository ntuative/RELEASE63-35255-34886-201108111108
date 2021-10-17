package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OfficialRoomEntryData implements IDisposable 
    {

        public static const var_1911:int = 1;
        public static const var_953:int = 2;
        public static const var_954:int = 3;
        public static const var_952:int = 4;

        private var _index:int;
        private var var_3485:String;
        private var var_3486:String;
        private var var_3487:Boolean;
        private var var_3488:String;
        private var var_3489:String;
        private var var_3490:int;
        private var var_3466:int;
        private var _type:int;
        private var var_3491:String;
        private var var_3492:GuestRoomData;
        private var var_3493:PublicRoomData;
        private var _open:Boolean;
        private var _disposed:Boolean;

        public function OfficialRoomEntryData(param1:IMessageDataWrapper)
        {
            this._index = param1.readInteger();
            this.var_3485 = param1.readString();
            this.var_3486 = param1.readString();
            this.var_3487 = (param1.readInteger() == 1);
            this.var_3488 = param1.readString();
            this.var_3489 = param1.readString();
            this.var_3490 = param1.readInteger();
            this.var_3466 = param1.readInteger();
            this._type = param1.readInteger();
            if (this._type == var_1911)
            {
                this.var_3491 = param1.readString();
            }
            else
            {
                if (this._type == var_954)
                {
                    this.var_3493 = new PublicRoomData(param1);
                }
                else
                {
                    if (this._type == var_953)
                    {
                        this.var_3492 = new GuestRoomData(param1);
                    }
                    else
                    {
                        this._open = param1.readBoolean();
                    };
                };
            };
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this.var_3492 != null)
            {
                this.var_3492.dispose();
                this.var_3492 = null;
            };
            if (this.var_3493 != null)
            {
                this.var_3493.dispose();
                this.var_3493 = null;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get index():int
        {
            return (this._index);
        }

        public function get popupCaption():String
        {
            return (this.var_3485);
        }

        public function get popupDesc():String
        {
            return (this.var_3486);
        }

        public function get showDetails():Boolean
        {
            return (this.var_3487);
        }

        public function get picText():String
        {
            return (this.var_3488);
        }

        public function get picRef():String
        {
            return (this.var_3489);
        }

        public function get folderId():int
        {
            return (this.var_3490);
        }

        public function get tag():String
        {
            return (this.var_3491);
        }

        public function get userCount():int
        {
            return (this.var_3466);
        }

        public function get guestRoomData():GuestRoomData
        {
            return (this.var_3492);
        }

        public function get publicRoomData():PublicRoomData
        {
            return (this.var_3493);
        }

        public function get open():Boolean
        {
            return (this._open);
        }

        public function toggleOpen():void
        {
            this._open = (!(this._open));
        }

        public function get maxUsers():int
        {
            if (this.type == var_1911)
            {
                return (0);
            };
            if (this.type == var_953)
            {
                return (this.var_3492.maxUserCount);
            };
            if (this.type == var_954)
            {
                return (this.var_3493.maxUsers);
            };
            return (0);
        }


    }
}