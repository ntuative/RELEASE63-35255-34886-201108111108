package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.SessionParamsMessageParser;

    public class SessionParamsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function SessionParamsMessageEvent(param1:Function)
        {
            super(param1, SessionParamsMessageParser);
        }

        public function get coppa():Boolean
        {
            return ((this.var_334 as SessionParamsMessageParser).coppa);
        }

        public function get voucher():Boolean
        {
            return ((this.var_334 as SessionParamsMessageParser).voucher);
        }

        public function get parentEmailRequired():Boolean
        {
            return ((this.var_334 as SessionParamsMessageParser).parentEmailRequired);
        }

        public function get parentEmailRequiredInReRegistration():Boolean
        {
            return ((this.var_334 as SessionParamsMessageParser).parentEmailRequiredInReRegistration);
        }

        public function get allowDirectEmail():Boolean
        {
            return ((this.var_334 as SessionParamsMessageParser).allowDirectEmail);
        }

        public function get date():String
        {
            return ((this.var_334 as SessionParamsMessageParser).date);
        }

        public function get confPartnerIntegration():Boolean
        {
            return ((this.var_334 as SessionParamsMessageParser).confPartnerIntegration);
        }

        public function get allowProfileEditing():Boolean
        {
            return ((this.var_334 as SessionParamsMessageParser).allowProfileEditing);
        }

        public function get tracking_header():String
        {
            return ((this.var_334 as SessionParamsMessageParser).tracking_header);
        }

        public function get tutorialEnabled():Boolean
        {
            return ((this.var_334 as SessionParamsMessageParser).tutorialEnabled);
        }


    }
}