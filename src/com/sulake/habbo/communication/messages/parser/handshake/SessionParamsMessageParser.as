package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SessionParamsMessageParser implements IMessageParser 
    {

        protected var var_3678:Boolean;
        protected var var_3679:Boolean;
        protected var var_3680:String;
        protected var var_3681:Boolean;
        protected var var_3682:Boolean;
        protected var var_3683:Boolean;
        protected var _confPartnerIntegration:Boolean;
        protected var var_3684:Boolean;
        protected var var_3685:String;
        protected var var_3686:Boolean;


        public function flush():Boolean
        {
            this.var_3678 = false;
            this.var_3679 = false;
            this.var_3680 = "";
            this.var_3681 = false;
            this.var_3682 = false;
            this.var_3683 = false;
            this._confPartnerIntegration = false;
            this.var_3684 = false;
            this.var_3685 = "";
            this.var_3686 = false;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:String;
            var _loc7_:String;
            var _loc2_:int = param1.readInteger();
            Logger.log((("[Parser.SessionParams] Got " + _loc2_) + " pairs"));
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = param1.readInteger();
                Logger.log(("[Parser.SessionParams] Got id: " + _loc4_));
                switch (_loc4_)
                {
                    case 0:
                        _loc5_ = param1.readInteger();
                        this.var_3678 = (_loc5_ > 0);
                        break;
                    case 1:
                        _loc5_ = param1.readInteger();
                        this.var_3679 = (_loc5_ > 0);
                        break;
                    case 2:
                        _loc5_ = param1.readInteger();
                        this.var_3681 = (_loc5_ > 0);
                        break;
                    case 3:
                        _loc5_ = param1.readInteger();
                        this.var_3682 = (_loc5_ > 0);
                        break;
                    case 4:
                        _loc5_ = param1.readInteger();
                        this.var_3683 = (_loc5_ > 0);
                        break;
                    case 5:
                        _loc6_ = param1.readString();
                        break;
                    case 6:
                        _loc5_ = param1.readInteger();
                        break;
                    case 7:
                        _loc5_ = param1.readInteger();
                        break;
                    case 8:
                        _loc7_ = param1.readString();
                        break;
                    case 9:
                        _loc5_ = param1.readInteger();
                        break;
                    default:
                        Logger.log(("Unknown id: " + _loc4_));
                };
                _loc3_++;
            };
            return (true);
        }

        public function get coppa():Boolean
        {
            return (this.var_3678);
        }

        public function get voucher():Boolean
        {
            return (this.var_3679);
        }

        public function get parentEmailRequired():Boolean
        {
            return (this.var_3681);
        }

        public function get parentEmailRequiredInReRegistration():Boolean
        {
            return (this.var_3682);
        }

        public function get allowDirectEmail():Boolean
        {
            return (this.var_3683);
        }

        public function get date():String
        {
            return (this.var_3680);
        }

        public function get confPartnerIntegration():Boolean
        {
            return (this._confPartnerIntegration);
        }

        public function get allowProfileEditing():Boolean
        {
            return (this.var_3684);
        }

        public function get tracking_header():String
        {
            return (this.var_3685);
        }

        public function get tutorialEnabled():Boolean
        {
            return (this.var_3686);
        }


    }
}