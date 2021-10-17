package com.sulake.habbo.communication.messages.outgoing.tracking
{
    import com.sulake.core.communication.messages.IMessageComposer;

    public class PerformanceLogMessageComposer implements IMessageComposer 
    {

        private var var_2614:int = 0;
        private var var_3624:String = "";
        private var var_3625:String = "";
        private var var_3626:String = "";
        private var var_3627:String = "";
        private var var_3628:int = 0;
        private var var_3629:int = 0;
        private var var_3630:int = 0;
        private var var_3631:int = 0;
        private var var_3632:int = 0;
        private var var_3633:int = 0;

        public function PerformanceLogMessageComposer(param1:int, param2:String, param3:String, param4:String, param5:String, param6:Boolean, param7:int, param8:int, param9:int, param10:int, param11:int)
        {
            this.var_2614 = param1;
            this.var_3624 = param2;
            this.var_3625 = param3;
            this.var_3626 = param4;
            this.var_3627 = param5;
            if (param6)
            {
                this.var_3628 = 1;
            }
            else
            {
                this.var_3628 = 0;
            };
            this.var_3629 = param7;
            this.var_3630 = param8;
            this.var_3631 = param9;
            this.var_3632 = param10;
            this.var_3633 = param11;
        }

        public function dispose():void
        {
        }

        public function getMessageArray():Array
        {
            return ([this.var_2614, this.var_3624, this.var_3625, this.var_3626, this.var_3627, this.var_3628, this.var_3629, this.var_3630, this.var_3631, this.var_3632, this.var_3633]);
        }


    }
}