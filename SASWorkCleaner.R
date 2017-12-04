suppressMessages(library(dplyr))
suppressMessages(library(lubridate))

# �P�_ SASWORK ��Ƨ���������

d = file.info(paste0("D:\\SASWORK\\", dir("D:\\SASWORK")))

# �z�L��Ƨ���� PID �H�ΫD���骺�̫�ק�ɶ�

e = d %>% 
  mutate(dname = rownames(.),
         pid = gsub("_CDC-SASOA_|SASWORK|D|_TD|[:\\]", "", dname)) %>%
  filter(date(d$mtime) != today()) %>%
  select(dname, pid, mtime)

# �Ū� dataframe ���ե�

# e = data.frame(a = NULL)

# if(nrow(e) != 0){
#   for(a in 1:nrow(e)){
#     tryCatch({
#       # �R�� PID (�B�z�{��)
#       system2(paste0("taskkill /f /PID ",e$pid[a]))
#     }, warning = function(w) 
#       # ��X���~���e
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