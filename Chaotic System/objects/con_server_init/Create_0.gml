global.pid = 0;
// see first room creation code of game.yyz project for how to make the game stay on 
// top of launcher. game.yyz is in included files / data files in this project file.
EnvironmentSetVariable("OWNER_WINDOW_ID", string(int64(window_handle())));

if (os_type == os_windows) {
	if (!global.pid) {
		global.pid = ProcessExecuteAsync("\"" + working_directory + "server\\server.exe\"");
	}
} else if (os_type == os_linux) {
	if (!file_exists(game_save_id + "server.AppImage")) {
		file_copy(working_directory + "server/server.AppImage", game_save_id + "server.AppImage");
		var tmp = ProcessExecute("chmod u+x \"" + game_save_id + "server.AppImage\"");
		FreeExecutedProcessStandardInput(tmp);
		FreeExecutedProcessStandardOutput(tmp);
	}
	if (!global.pid) {
		global.pid = ProcessExecuteAsync("\"" + game_save_id + "server.AppImage\"");
	}
}