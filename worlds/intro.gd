extends Control

var texts = [
	"2045",
	"Dunia telah mendekati ajalnya",
	"dikarenakan manusia merusak tempat tinggalnya sendiri",
	"mereka membuang sampah, limbah dan polusi tanpa memikirkan akibatnya",
	"sekarang mereka mendapati apa yang telah mereka perbuat",
	"makhluk hidup mulai punah",
	"langit tidak terlihat biru lagi.",
	"tidak ada jalan kembali",
	"namun, seorang remaja bernama Alul bersikeras",
	"ia memegang secercah harapan dan ingin terus berjuang",
	"untuk mengembalikan dunia yang sudah tidak layak ini"
]

func _ready():
	$Black/Label.text = ""
	
	for i in texts:
		$Black/Label.percent_visible = 0
		$Black/Label.text = i
		
		while $Black/Label.percent_visible < 1:
			$Black/Label.visible_characters += 1
			yield(get_tree().create_timer(0.02), "timeout")
		
		yield(get_tree().create_timer(0.5), "timeout")
	
	while $Black/Label.percent_visible > 0:
		$Black/Label.visible_characters -= 1
		yield(get_tree().create_timer(0.05), "timeout")
	
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://worlds/world.tscn")
