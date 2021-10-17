package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.incoming.moderation.OffenceCategoryData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorInitData implements IDisposable 
    {

        private var var_3750:Array;
        private var var_3752:Array;
        private var _issues:Array;
        private var var_3751:Array;
        private var var_3753:Boolean;
        private var var_3754:Boolean;
        private var var_3755:Boolean;
        private var var_3756:Boolean;
        private var var_3757:Boolean;
        private var var_3758:Boolean;
        private var var_3759:Boolean;
        private var _disposed:Boolean;

        public function ModeratorInitData(param1:IMessageDataWrapper)
        {
            var _loc2_:IssueInfoMessageParser = new IssueInfoMessageParser();
            this._issues = [];
            this.var_3750 = [];
            this.var_3752 = [];
            this.var_3751 = [];
            var _loc3_:int = param1.readInteger();
            var _loc4_:int;
            while (_loc4_ < _loc3_)
            {
                if (_loc2_.parse(param1))
                {
                    this._issues.push(_loc2_.issueData);
                };
                _loc4_++;
            };
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_)
            {
                this.var_3750.push(param1.readString());
                _loc4_++;
            };
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_)
            {
                this.var_3751.push(new OffenceCategoryData(param1));
                _loc4_++;
            };
            this.var_3753 = param1.readBoolean();
            this.var_3754 = param1.readBoolean();
            this.var_3755 = param1.readBoolean();
            this.var_3756 = param1.readBoolean();
            this.var_3757 = param1.readBoolean();
            this.var_3758 = param1.readBoolean();
            this.var_3759 = param1.readBoolean();
            _loc3_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc3_)
            {
                this.var_3752.push(param1.readString());
                _loc4_++;
            };
        }

        public function dispose():void
        {
            var _loc1_:OffenceCategoryData;
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            this.var_3750 = null;
            this.var_3752 = null;
            this._issues = null;
            for each (_loc1_ in this.var_3751)
            {
                _loc1_.dispose();
            };
            this.var_3751 = null;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get messageTemplates():Array
        {
            return (this.var_3750);
        }

        public function get roomMessageTemplates():Array
        {
            return (this.var_3752);
        }

        public function get issues():Array
        {
            return (this._issues);
        }

        public function get offenceCategories():Array
        {
            return (this.var_3751);
        }

        public function get cfhPermission():Boolean
        {
            return (this.var_3753);
        }

        public function get chatlogsPermission():Boolean
        {
            return (this.var_3754);
        }

        public function get alertPermission():Boolean
        {
            return (this.var_3755);
        }

        public function get kickPermission():Boolean
        {
            return (this.var_3756);
        }

        public function get banPermission():Boolean
        {
            return (this.var_3757);
        }

        public function get roomAlertPermission():Boolean
        {
            return (this.var_3758);
        }

        public function get roomKickPermission():Boolean
        {
            return (this.var_3759);
        }


    }
}