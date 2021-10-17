package com.sulake.habbo.catalog.recycler
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.recycler.RecyclerFinishedMessageEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class RecyclerLogic implements IRecycler 
    {

        public static const var_808:int = 5;
        private static const var_809:int = 0;
        private static const var_810:int = 1;
        private static const var_811:int = 2;

        private var var_3183:int = 0;
        private var var_3184:int;
        private var var_3185:Array = new Array();
        private var _catalog:IHabboCatalog;
        private var _windowManager:IHabboWindowManager;
        private var _view:IRecyclerVisualization;
        private var var_3181:Array;

        public function RecyclerLogic(param1:IHabboCatalog, param2:IHabboWindowManager)
        {
            this._catalog = param1;
            this._windowManager = param2;
        }

        private function get statusActive():Boolean
        {
            return (!(this.var_3183 == var_809));
        }

        private function get systemActive():Boolean
        {
            return (!(this.var_3184 == RecyclerStatusMessageEvent.var_666));
        }

        private function get ready():Boolean
        {
            return ((this.active) && (this.var_3183 == var_810));
        }

        public function get active():Boolean
        {
            return ((this.statusActive) && (this.systemActive));
        }

        public function dispose():void
        {
            this.var_3185 = null;
            this._catalog = null;
        }

        public function init(param1:IRecyclerVisualization=null):void
        {
            this.var_3183 = var_811;
            this.var_3185 = new Array(var_808);
            if (param1 == null)
            {
                return;
            };
            this._view = param1;
            this._catalog.getRecyclerStatus();
        }

        public function activate():void
        {
            if (this.systemActive)
            {
                this.var_3183 = var_810;
            };
        }

        public function cancel():void
        {
            this._catalog.setupInventoryForRecycler(false);
            var _loc1_:int;
            while (_loc1_ < var_808)
            {
                this.releaseSlot(_loc1_);
                _loc1_++;
            };
            this.var_3183 = var_809;
        }

        public function empty():void
        {
            var _loc1_:int;
            while (_loc1_ < var_808)
            {
                this.releaseSlot(_loc1_);
                _loc1_++;
            };
            this.updateRecyclerSlots();
            this.updateRecyclerButton();
        }

        public function setSystemStatus(param1:int, param2:int):void
        {
            this.var_3184 = param1;
            if (!this.systemActive)
            {
                return;
            };
            switch (this.var_3184)
            {
                case RecyclerStatusMessageEvent.var_665:
                    this.var_3183 = var_810;
                    if (((this._view == null) || (this._view.disposed)))
                    {
                        return;
                    };
                    this._view.displayNormalView();
                    this._catalog.setupInventoryForRecycler(true);
                    this.verifyRoomSessionStatus();
                    this.updateRecyclerSlots();
                    this.updateRecyclerButton();
                    return;
                case RecyclerStatusMessageEvent.var_666:
                    if (((this._view == null) || (this._view.disposed)))
                    {
                        return;
                    };
                    this._view.displayDisabledView();
                    this._catalog.setupInventoryForRecycler(false);
                    return;
                case RecyclerStatusMessageEvent.var_667:
                    if (((this._view == null) || (this._view.disposed)))
                    {
                        return;
                    };
                    this._view.displayTimeOutView(param2);
                    this._catalog.setupInventoryForRecycler(false);
                    return;
            };
        }

        public function setFinished(status:int, prizeId:int):void
        {
            if (!this.statusActive)
            {
                return;
            };
            this.var_3183 = var_810;
            if (!this.systemActive)
            {
                return;
            };
            switch (status)
            {
                case RecyclerFinishedMessageEvent.var_112:
                    if (this._view != null)
                    {
                        this._view.displayFinishedView();
                    };
                    break;
                case RecyclerFinishedMessageEvent.var_557:
                    Logger.log("* Recycler finished with FAILURE");
                    this._windowManager.alert("${generic.alert.title}", "${recycler.info.closed}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                    {
                        param1.dispose();
                    });
                    if (this._view != null)
                    {
                        this._view.displayDisabledView();
                    };
                    break;
            };
            this._catalog.setupInventoryForRecycler(false);
        }

        public function getSlotContent(param1:int):FurniSlotItem
        {
            if (this.var_3185 == null)
            {
                return (null);
            };
            if (param1 >= this.var_3185.length)
            {
                return (null);
            };
            return (this.var_3185[param1]);
        }

        public function placeObjectAtSlot(slotId:int, id:int, category:int, typeId:int, xxxExtra:String):void
        {
            var oldObjectData:FurniSlotItem;
            var newSlotId:int;
            if (!this.ready)
            {
                return;
            };
            if (this.var_3185.length > 0)
            {
                oldObjectData = this.var_3185[0];
                newSlotId = 0;
                while (((!(oldObjectData == null)) && (newSlotId < var_808)))
                {
                    oldObjectData = this.var_3185[newSlotId];
                    if (oldObjectData != null)
                    {
                        newSlotId = (newSlotId + 1);
                    };
                };
                if (oldObjectData == null)
                {
                    slotId = newSlotId;
                }
                else
                {
                    return;
                };
            };
            var itemId:int = this._catalog.requestInventoryFurniToRecycler();
            if (itemId == 0)
            {
                this._windowManager.alert("${generic.alert.title}", "${recycler.alert.non.recyclable}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                {
                    param1.dispose();
                });
                return;
            };
            this.var_3185[slotId] = new FurniSlotItem(itemId, category, typeId, xxxExtra);
            this.updateRecyclerSlots();
            this.updateRecyclerButton();
        }

        public function releaseSlot(param1:int):void
        {
            if (!this.ready)
            {
                return;
            };
            if (this.var_3185[param1] == null)
            {
                return;
            };
            if (!this._catalog.returnInventoryFurniFromRecycler(this.var_3185[param1].id))
            {
                return;
            };
            this.var_3185[param1] = null;
            this.updateRecyclerSlots();
            this.updateRecyclerButton();
        }

        public function executeRecycler():void
        {
            var _loc3_:FurniSlotItem;
            if (!this.isReadyToRecycle())
            {
                return;
            };
            this.var_3183 = var_811;
            this.updateRecyclerButton();
            var _loc1_:Array = new Array();
            var _loc2_:int;
            while (_loc2_ < this.var_3185.length)
            {
                _loc3_ = this.var_3185[_loc2_];
                if (_loc3_ == null)
                {
                    return;
                };
                _loc1_.push(_loc3_.id);
                _loc2_++;
            };
            this._catalog.sendRecycleItems(_loc1_);
            this._view.displayProcessingView();
        }

        public function isReadyToRecycle():Boolean
        {
            if (((!(this.ready)) || (!(this._catalog.privateRoomSessionActive))))
            {
                return (false);
            };
            if (this.isTradingActive())
            {
                this._windowManager.alert("${generic.alert.title}", "${recycler.alert.trading}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                {
                    param1.dispose();
                });
                return (false);
            };
            return (this.isPoolFull());
        }

        public function setRoomSessionActive(param1:Boolean):void
        {
            if (param1 == false)
            {
                this.empty();
                this.verifyRoomSessionStatus();
            };
            this.updateRecyclerButton();
        }

        private function verifyRoomSessionStatus():void
        {
            if (((!(this._catalog.privateRoomSessionActive)) && (this.ready)))
            {
                this._windowManager.alert("${generic.alert.title}", "${recycler.alert.privateroom}", 0, function (param1:IAlertDialog, param2:WindowEvent):void
                {
                    param1.dispose();
                });
            };
        }

        private function updateRecyclerSlots():void
        {
            if (((this._view == null) || (!(this.statusActive))))
            {
                return;
            };
            this._view.updateSlots();
        }

        private function updateRecyclerButton():void
        {
            if (((this._view == null) || (!(this.statusActive))))
            {
                return;
            };
            this._view.updateRecycleButton(this.isReadyToRecycle());
        }

        private function isPoolFull():Boolean
        {
            if (this.var_3185 == null)
            {
                return (false);
            };
            if (this.var_3185.length < var_808)
            {
                return (false);
            };
            var _loc1_:int;
            while (_loc1_ < this.var_3185.length)
            {
                if (this.var_3185[_loc1_] == null)
                {
                    return (false);
                };
                _loc1_++;
            };
            return (true);
        }

        private function isTradingActive():Boolean
        {
            return (this._catalog.tradingActive);
        }

        public function storePrizeTable(param1:Array):void
        {
            var _loc3_:PrizeLevelContainer;
            this.var_3181 = new Array();
            var _loc2_:int;
            while (_loc2_ < param1.length)
            {
                _loc3_ = new PrizeLevelContainer(param1[_loc2_], this._catalog);
                this.var_3181.push(_loc3_);
                _loc2_++;
            };
        }

        public function getPrizeTable():Array
        {
            if (this.var_3181 == null)
            {
                this._catalog.getRecyclerPrizes();
                return (null);
            };
            return (this.var_3181);
        }


    }
}