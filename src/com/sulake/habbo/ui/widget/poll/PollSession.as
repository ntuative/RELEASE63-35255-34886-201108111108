package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class PollSession implements IDisposable 
    {

        private var _id:int = -1;
        private var var_5410:PollWidget;
        private var var_5411:IPollDialog;
        private var var_5412:IPollDialog;
        private var var_3779:String = "";
        private var _disposed:Boolean = false;

        public function PollSession(param1:int, param2:PollWidget)
        {
            this._id = param1;
            this.var_5410 = param2;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this.var_5411 != null)
            {
                this.var_5411.dispose();
                this.var_5411 = null;
            };
            if (this.var_5412 != null)
            {
                this.var_5412.dispose();
                this.var_5412 = null;
            };
            this.var_5410 = null;
            this._disposed = true;
        }

        public function showOffer(param1:String):void
        {
            this.hideOffer();
            this.var_5411 = new PollOfferDialog(this._id, param1, this.var_5410);
            this.var_5411.start();
        }

        public function hideOffer():void
        {
            if ((this.var_5411 is PollOfferDialog))
            {
                if (!this.var_5411.disposed)
                {
                    this.var_5411.dispose();
                };
                this.var_5411 = null;
            };
        }

        public function showContent(param1:String, param2:String, param3:Array):void
        {
            this.hideOffer();
            this.hideContent();
            this.var_3779 = param2;
            this.var_5412 = new PollContentDialog(this._id, param1, param3, this.var_5410);
            this.var_5412.start();
        }

        public function hideContent():void
        {
            if ((this.var_5412 is PollContentDialog))
            {
                if (!this.var_5412.disposed)
                {
                    this.var_5412.dispose();
                };
                this.var_5412 = null;
            };
        }

        public function showThanks():void
        {
            this.var_5410.windowManager.alert("${poll_thanks_title}", this.var_3779, 0, function (param1:IAlertDialog, param2:WindowEvent):void
            {
                param1.dispose();
            });
        }


    }
}