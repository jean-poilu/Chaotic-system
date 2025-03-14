global.client_version = "v0.02a";
global.modUpToDate = -1;
global.latestVersion = global.client_version

github = http_get("https://api.github.com/repos/jean-poilu/Chaotic-system/releases/latest");
githubInfo = "";
githubInfoMap = ds_map_create();
githubLatestVersion = "ERROR";