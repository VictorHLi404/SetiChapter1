/// @description Insert description here
// You can write your code in this editor

struct = script_JSONReader("introStatus.json")
show_debug_message(struct.playedIntro)
struct.playedIntro = "boohoo"
show_debug_message(struct.playedIntro)

var temp = json_stringify(struct, true)
show_debug_message(temp)
script_JSONSaver(temp, "introStatus.json")





