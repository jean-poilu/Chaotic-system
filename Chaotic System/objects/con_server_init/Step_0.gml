if (global.pid && CompletionStatusFromExecutedProcess(global.pid)) {
	FreeExecutedProcessStandardInput(global.pid);
	FreeExecutedProcessStandardOutput(global.pid);
	global.pid = 0;
}