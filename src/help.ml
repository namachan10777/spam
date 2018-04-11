let init_dscr = "Initialize SPAM state."
let list_dscr = "Display the list of available packages."
let show_dscr = "Display information about specific packages."
let install_dscr = "Install a list of packages."
let remove_dscr = "Remove a list of packages."
let update_dscr = "Update the list of available packages."
let upgrade_dscr = "Upgrade the installed package to latest version."
let switch_dscr = "Manage multiple environments."
let pin_dscr = "Pin a given package to specific source"


let show_init_help () = print_endline begin
	"init\n"^
	"\n"^
	"usage:\n"^
	"    spam init\n"^
	"description\n"^
	(Printf.sprintf "    %s\n" init_dscr) end

let show_list_help () = print_endline begin
	"list\n"^
	"\n"^
	"usage:\n"^
	"    spam list\n"^
	"description\n"^
	(Printf.sprintf "    %s\n" list_dscr) end

let show_show_help () = print_endline begin
	"show\n"^
	"\n"^
	"usage:\n"^
	"    spam list PACKAGES...\n"^
	"PACKAGES:\n"^
	"    list of packages name.\n"^
	"description\n"^
	(Printf.sprintf "    %s\n" show_dscr) end

let show_install_help () = print_endline begin
	"install\n"^
	"\n"^
	"usage:\n"^
	"    spam install [-y|--yes] PACKAGES...\n"^
	"PACKAGES:\n"^
	"    list of packages name.\n"^
	"-y --yes\n"^
	" Disable interactive mode and answer yes to all questions that would otherwise be asked to the user.\n"^
	"description\n"^
	(Printf.sprintf "    %s\n" install_dscr) end

let show_remove_help () = print_endline begin
	"remove\n"^
	"\n"^
	"usage:\n"^
	"    spam remove [-y|--yes] PACKAGES...\n"^
	"PACKAGES:\n"^
	"    list of packages name.\n"^
	"-y --yes\n"^
	" Disable interactive mode and answer yes to all questions that would otherwise be asked to the user.\n"^
	"description\n"^
	(Printf.sprintf "    %s\n" remove_dscr) end

let show_update_help () = print_endline begin
	"remove\n"^
	"\n"^
	"usage:\n"^
	"    spam update\n"^
	"description\n"^
	(Printf.sprintf "    %s\n" update_dscr) end

let show_upgrade_help () = print_endline begin
	"upgrade\n"^
	"\n"^
	"usage:\n"^
	"    spam upgrade [-y|--yes]\n"^
	"-y --yes\n"^
	" Disable interactive mode and answer yes to all questions that would otherwise be asked to the user.\n"^
	"description\n"^
	(Printf.sprintf "    %s\n" upgrade_dscr) end

let show_switch_help () = print_endline begin
	"switch\n"^
	"\n"^
	"usage:\n"^
	"    spam switch ENVNAME \n"^
	"ENVNAME:\n"^
	"    Environment name. Default environment is 'default'\n"^
	"description\n"^
	(Printf.sprintf "    %s\n" switch_dscr) end

let show_pin_help () = print_endline begin
	"pin\n"^
	"\n"^
	"usage:\n"^
	"    spam pin PACKAGE [PATH]\n"^
	"PACKAGE:\n"^
	"    Package name.\n"^
	"PATH:\n"^
	"    Package source repository path\n"^
	"description\n"^
	(Printf.sprintf "    %s\n" pin_dscr) end

let show_help () = print_endline begin
	"usage: spam [--version]\n"^
	"            [--help]\n"^
	"            <command> [<args>]\n"^
	"spam commands are\n"^
	(Printf.sprintf "    init     %s\n" init_dscr)^
	(Printf.sprintf "    list     %s\n" list_dscr)^
	(Printf.sprintf "    show     %s\n" show_dscr)^
	(Printf.sprintf "    install  %s\n" install_dscr)^
	(Printf.sprintf "    remove   %s\n" remove_dscr)^
	(Printf.sprintf "    update   %s\n" update_dscr)^
	(Printf.sprintf "    upgrade  %s\n" upgrade_dscr)^
	(Printf.sprintf "    switch   %s\n" switch_dscr)^
	(Printf.sprintf "    pin      %s\n" pin_dscr)^
	(Printf.sprintf "See 'spam help <command>' for more information on a specific command.\n%s" pin_dscr) end

let show_subcommand_help = function
	| "init" ->
		show_init_help()
	| "list" ->
		show_list_help()
	| "show" ->
		show_show_help()
	| "install" ->
		show_init_help()
	| "remove" ->
		show_remove_help()
	| "update" ->
		show_update_help()
	| "upgrade" ->
		show_upgrade_help()
	| "switch" ->
		show_switch_help()
	| "pin" ->
		show_pin_help()
	| "help" ->
		show_help()
	| cmd ->
		print_endline (Printf.sprintf "invalid command name %s\n" cmd)
