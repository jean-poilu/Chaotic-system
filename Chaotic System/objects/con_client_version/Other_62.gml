if (ds_map_find_value(async_load, "id") == github)
{
    if (ds_map_find_value(async_load, "status") == 0)
        githubInfo = ds_map_find_value(async_load, "result");
    else
        githubInfo = "h";
}
if (githubInfo != "h")
{
    githubInfoMap = json_decode(githubInfo);
    if (githubInfoMap != -1)
        githubLatestVersion = ds_map_find_value(githubInfoMap, "tag_name");
    else
        githubLatestVersion = "ERROR";
}
else
    githubLatestVersion = "ERROR"
if (githubLatestVersion != "ERROR" && githubLatestVersion != undefined)
{
    global.latestVersion = githubLatestVersion;
    if (githubLatestVersion != global.client_version)
        global.modUpToDate = 0;
    else
        global.modUpToDate = 1;
}
else
    global.modUpToDate = -1;