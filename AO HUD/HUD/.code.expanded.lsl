init ()
{
	//load notecard
	llOwnerSay("loading notecard");
}

default
{
	on_rez(integer start_param)
	{
		llResetScript();
	}
	state_entry()
	{
		llRequestPermissions(llGetOwner() , PERMISSION_OVERRIDE_ANIMATIONS |  PERMISSION_TRIGGER_ANIMATION);
	}
	run_time_permissions(integer perm)
    {
        if (perm & (PERMISSION_TRIGGER_ANIMATION | PERMISSION_OVERRIDE_ANIMATIONS))
        {
            init();
        }
    }
}