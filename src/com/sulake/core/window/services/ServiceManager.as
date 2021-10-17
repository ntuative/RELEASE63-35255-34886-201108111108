package com.sulake.core.window.services
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.DisplayObject;
    import com.sulake.core.window.IWindowContext;

    public class ServiceManager implements IInternalWindowServices, IDisposable 
    {

        private var var_2763:uint;
        private var _root:DisplayObject;
        private var _disposed:Boolean = false;
        private var var_2764:IWindowContext;
        private var var_2765:IMouseDraggingService;
        private var var_2766:IMouseScalingService;
        private var var_2767:IMouseListenerService;
        private var var_2768:IFocusManagerService;
        private var var_2769:IToolTipAgentService;
        private var var_2770:IGestureAgentService;

        public function ServiceManager(param1:IWindowContext, param2:DisplayObject)
        {
            this.var_2763 = 0;
            this._root = param2;
            this.var_2764 = param1;
            this.var_2765 = new WindowMouseDragger(param2);
            this.var_2766 = new WindowMouseScaler(param2);
            this.var_2767 = new WindowMouseListener(param2);
            this.var_2768 = new FocusManager(param2);
            this.var_2769 = new WindowToolTipAgent(param2);
            this.var_2770 = new GestureAgentService();
        }

        public function dispose():void
        {
            if (this.var_2765 != null)
            {
                this.var_2765.dispose();
                this.var_2765 = null;
            };
            if (this.var_2766 != null)
            {
                this.var_2766.dispose();
                this.var_2766 = null;
            };
            if (this.var_2767 != null)
            {
                this.var_2767.dispose();
                this.var_2767 = null;
            };
            if (this.var_2768 != null)
            {
                this.var_2768.dispose();
                this.var_2768 = null;
            };
            if (this.var_2769 != null)
            {
                this.var_2769.dispose();
                this.var_2769 = null;
            };
            if (this.var_2770 != null)
            {
                this.var_2770.dispose();
                this.var_2770 = null;
            };
            this._root = null;
            this.var_2764 = null;
            this._disposed = true;
        }

        public function getMouseDraggingService():IMouseDraggingService
        {
            return (this.var_2765);
        }

        public function getMouseScalingService():IMouseScalingService
        {
            return (this.var_2766);
        }

        public function getMouseListenerService():IMouseListenerService
        {
            return (this.var_2767);
        }

        public function getFocusManagerService():IFocusManagerService
        {
            return (this.var_2768);
        }

        public function getToolTipAgentService():IToolTipAgentService
        {
            return (this.var_2769);
        }

        public function getGestureAgentService():IGestureAgentService
        {
            return (this.var_2770);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }


    }
}