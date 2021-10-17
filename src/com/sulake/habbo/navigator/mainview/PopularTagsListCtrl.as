package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.navigator.TagRenderer;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularTagData;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.core.window.enum.*;

    public class PopularTagsListCtrl implements IViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var var_2578:IWindowContainer;
        private var var_2632:IItemListWindow;
        private var var_4307:int;
        private var var_4257:TagRenderer;

        public function PopularTagsListCtrl(param1:HabboNavigator):void
        {
            this._navigator = param1;
            this.var_4257 = new TagRenderer(this._navigator);
        }

        public function dispose():void
        {
            if (this.var_4257)
            {
                this.var_4257.dispose();
                this.var_4257 = null;
            };
        }

        public function set content(param1:IWindowContainer):void
        {
            this.var_2578 = param1;
            this.var_2632 = IItemListWindow(this.var_2578.findChildByName("item_list"));
        }

        public function get content():IWindowContainer
        {
            return (this.var_2578);
        }

        public function refresh():void
        {
            var _loc4_:PopularTagData;
            var _loc1_:Array = this._navigator.data.popularTags.tags;
            var _loc2_:IWindowContainer = IWindowContainer(this.var_2632.getListItemAt(0));
            if (_loc2_ == null)
            {
                _loc2_ = IWindowContainer(this._navigator.getXmlWindow("grs_popular_tag_row"));
                this.var_2632.addListItem(_loc2_);
            };
            Util.hideChildren(_loc2_);
            var _loc3_:int;
            while (_loc3_ < this._navigator.data.popularTags.tags.length)
            {
                _loc4_ = this._navigator.data.popularTags.tags[_loc3_];
                this.var_4257.refreshTag(_loc2_, _loc3_, _loc4_.tagName);
                _loc3_++;
            };
            Util.layoutChildrenInArea(_loc2_, _loc2_.width, 18, 3);
            _loc2_.height = Util.getLowestPoint(_loc2_);
            this.var_2578.findChildByName("no_tags_found").visible = (_loc1_.length < 1);
        }

        private function refreshTagName(param1:IWindowContainer, param2:PopularTagData):void
        {
            var _loc3_:String = "txt";
            var _loc4_:ITextWindow = ITextWindow(param1.findChildByName(_loc3_));
            if (param2 == null)
            {
                return;
            };
            _loc4_.visible = true;
            _loc4_.text = param2.tagName;
        }


    }
}