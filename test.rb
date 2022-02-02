require 'fileutils'

# excel_to_c "KCERT_2050_V2.16.xlsm"
# 
FileUtils.cd(Dir.pwd)
system("excel_to_c KCERT_2050_V2.16.xlsm")
# Dir.pwd

