if status is-interactive
    # Commands to run in interactive sessions can go here
end



function fish_greeting
	echo (set_color purple)"Gami to Furras!!!" (set_color normal)
	#echo "Fish says Trans rights!"
	#echo (set_color blue) '█' (set_color pink) '█' (set_color white) '█'
end

starship init fish | source
