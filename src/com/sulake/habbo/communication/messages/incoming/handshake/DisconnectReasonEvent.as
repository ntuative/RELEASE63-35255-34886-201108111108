package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.DisconnectReasonParser;

    public class DisconnectReasonEvent extends MessageEvent implements IMessageEvent 
    {

        public static const var_1771:int = 0;
        public static const var_1772:int = 1;
        public static const var_1773:int = 2;
        public static const var_1774:int = 3;
        public static const var_1775:int = 4;
        public static const var_1776:int = 5;
        public static const var_1777:int = 10;
        public static const var_1778:int = 11;
        public static const var_1779:int = 12;
        public static const var_1780:int = 13;
        public static const var_1781:int = 16;
        public static const var_1782:int = 17;
        public static const var_1783:int = 18;
        public static const var_1784:int = 19;
        public static const var_1785:int = 20;
        public static const var_1786:int = 22;
        public static const var_1787:int = 23;
        public static const var_1788:int = 24;
        public static const var_1789:int = 25;
        public static const var_1790:int = 26;
        public static const var_1791:int = 27;
        public static const var_1792:int = 28;
        public static const var_1793:int = 29;
        public static const var_1794:int = 100;
        public static const var_1795:int = 101;
        public static const var_1796:int = 102;
        public static const var_1797:int = 103;
        public static const var_1798:int = 104;
        public static const var_1799:int = 105;
        public static const var_1800:int = 106;
        public static const var_1801:int = 107;
        public static const var_1802:int = 108;
        public static const var_1803:int = 109;
        public static const var_1804:int = 110;
        public static const var_1805:int = 111;
        public static const var_1806:int = 112;
        public static const var_1807:int = 113;
        public static const var_1808:int = 114;
        public static const var_1809:int = 115;
        public static const var_1810:int = 116;
        public static const var_1811:int = 117;
        public static const var_1812:int = 118;
        public static const var_1813:int = 119;

        public function DisconnectReasonEvent(param1:Function)
        {
            super(param1, DisconnectReasonParser);
        }

        public function get reason():int
        {
            return ((this.var_334 as DisconnectReasonParser).reason);
        }

        public function get reasonString():String
        {
            switch (this.reason)
            {
                case var_1772:
                case var_1777:
                    return ("banned");
                case var_1773:
                    return ("concurrentlogin");
                default:
                    return ("logout");
            };
        }


    }
}