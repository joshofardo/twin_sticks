//get rid of bullet if we havent shot it yet
if instance_exists( bulletinst ) && bulletinst.state == 0
{
	bulletinst.destroy = true;
}




