suppressMessages(library(dplyr))
suppressMessages(library(lubridate))

# 判斷 SASWORK 資料夾內部物件

d = file.info(paste0("D:\\SASWORK\\", dir("D:\\SASWORK")))

# 透過資料夾找到 PID 以及非今日的最後修改時間

e = d %>% 
  mutate(dname = rownames(.),
         pid = gsub("_CDC-SASOA_|SASWORK|D|_TD|[:\\]", "", dname)) %>%
  filter(date(d$mtime) != today()) %>%
  select(dname, pid, mtime)

# 空的 dataframe 測試用

# e = data.frame(a = NULL)

# if(nrow(e) != 0){
#   for(a in 1:nrow(e)){
#     tryCatch({
#       # 刪除 PID (處理程序)
#       system2(paste0("taskkill /f /PID ",e$pid[a]))
#     }, warning = function(w) 
#       # 輸出錯誤內容
#       # logging <<- paste0("Warning in : ", conditionMessage(w))
#       NULL
#     )
#     system(paste0("cmd /c rd ",e$dname[a], " /q /s"), intern=TRUE)    
#   }
# }

if(nrow(e) != 0){
  for(a in 1:nrow(e)){
    system(paste0("cmd /c taskkill /f /PID ",e$pid[a]), intern=TRUE)
    system(paste0("cmd /c rd ",e$dname[a], " /q /s"), intern=TRUE)    
  }
}
