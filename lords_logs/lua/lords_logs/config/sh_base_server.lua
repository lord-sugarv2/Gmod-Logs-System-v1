LLogs.SetServerConfig("ServerName", "Server Name", "Just put what your server is called.", "Lord Sugar", "STRING")
LLogs.SetServerConfig("MenuTitle", "Menu Title", "The title of the logs addon.", "%s' Logger", "STRING")
LLogs.SetServerConfig("ConsolePrint", "Server Console Prints", "Should we print all logs to the server console?", true, "BOOL")
LLogs.SetServerConfig("UTCTime", "Use UTC Time", "True: UTC | False: Local Time", true, "BOOL")
LLogs.SetServerConfig("Database", "Database", "sqlite / none", "sqlite", "STRING")
LLogs.SetServerConfig("ChatCommand", "Chat Command", "Chat command to open logs", "/logs", "STRING")
LLogs.SetServerConfig("ResultsPerPage", "Results Per Page", "How many results are on the logging page", 50, "NUMBER")
