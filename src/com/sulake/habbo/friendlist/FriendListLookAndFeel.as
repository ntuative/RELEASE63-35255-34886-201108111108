package com.sulake.habbo.friendlist
{
    import com.sulake.habbo.friendlist.domain.FriendListTab;

    public class FriendListLookAndFeel 
    {


        public function getSelectedEntryBgColor():uint
        {
            return (4282169599);
        }

        public function getFriendTextColor(param1:Boolean):uint
        {
            return ((param1) ? 0xFFFFFFFF : 0xFF000000);
        }

        public function getTabFooterTextColor(param1:Boolean):uint
        {
            return ((param1) ? 4293848814 : 4289900703);
        }

        public function getRowShadingColor(param1:int, param2:Boolean):uint
        {
            if (param1 == FriendListTab.var_535)
            {
                return ((param2) ? 0xFFFFFFFF : 4293848814);
            };
            if (param1 == FriendListTab.var_536)
            {
                return ((param2) ? 0xFFFFFFFF : 4293848814);
            };
            return ((param2) ? 4290164406 : 4288651167);
        }

        public function getTabTextColor(param1:Boolean, param2:int):uint
        {
            if (param1)
            {
                return (0xFFFFFFFF);
            };
            if (param2 == FriendListTab.var_535)
            {
                return (0xFF000000);
            };
            if (param2 == FriendListTab.var_536)
            {
                return (4294375158);
            };
            return (4293914607);
        }

        public function getTabBgColor(param1:int):uint
        {
            if (param1 == FriendListTab.var_535)
            {
                return (0xFFFFFFFF);
            };
            if (param1 == FriendListTab.var_536)
            {
                return (0xFFFFFFFF);
            };
            return (4290164406);
        }


    }
}