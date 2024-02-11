if screen_pause() {exit;};

if createdDamageObjects == false
{
	//create an object to damage the player
	damageInst = instance_create_depth(x, y, 0, odamageplayer);
	with(damageInst)
	{
		damage = other.damage;
		mask_index = other.sprite_index;
		image_xscale = other.image_xscale;
		image_yscale = other.image_yscale;
	}	
	//set created variable to true so we dont make a million damage objects
	createdDamageObjects = true;
	
}

//get rid of the damage objects once they are done 
if floor(image_index) >= 2
{
	//destroy
	if instance_exists(damageInst)
	{
		instance_destroy(damageInst);
	}
}



