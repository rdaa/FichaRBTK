extends CanvasLayer

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db #database object
var db_name = "res://DataStore/database" #Path to db

func _ready():
	db = SQLite.new()
	db.path = db_name
	commitDataToDB()
	readFromDB()
	pass

func _on_Button_pressed():
	$HTTPRequest.request("https://docs.google.com/spreadsheets/d/1l1s_D9BWHwa4eAcQyH4QhlHXULrRcGDLa7-e4EsW8g0/pubhtml?alt=json")
#https://docs.google.com/spreadsheets/d/e/2PACX-1vSUtiN66KeB0Fe5EPMEaH6xDUaBnx3bEJ4p-iy9pv5hrmEtawTo6TREFgceLp__oUXR8jGMD2YfebLQ/pubhtml
func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	print(response_code)
	print(result)
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)


func commitDataToDB():
	db.open_db()
	var tableName = "PlayerInfo"
	var dict : Dictionary = Dictionary()
	dict["Name"] = "this is a test user"
	dict["Score"] = 5000
	db.insert_row(tableName, dict)
	
func readFromDB():
	db.open_db()
	var tableName = "PlayerInfo"
	db.query("select * from " + tableName + ";")
	for i in range(0, db.query_result.size()):
		print("Query result: ", db.query_result[i]["Name"], db.query_result[i]["Score"])
